#include "plugin.h"

#include <dirent.h>
#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

void *plugin_handle = NULL;

static void *_get_binary_func_internal(const plugin_element *restrict elem);

int load_plugin(const char *plugin_name) {
  int ret = 0;
  char fname[COMMON_TEXT_SIZE] = {0};

  getcwd(fname, COMMON_TEXT_SIZE);

  if (plugin_name == NULL)
    ret = -1;
  else {
    strcat(fname, "/system/");
    strcat(fname, plugin_name);
    strcat(fname, ".plug");

    if (is_plugin_already_loaded(fname)) {
      printf("%s already loaded\n", fname);
      ret = -1;
    } else {
      ret = load_plugin_internal(fname);
    }
  }

  return ret;
}

// *function if success, NULL is error
static void *_get_binary_func_internal(const plugin_element *restrict elem) {
  void *func = NULL;
  char exec_path[COMMON_TEXT_SIZE] = {0};
  strcpy(exec_path, start_exec_dir);
  strcat(exec_path, "/");
  strcat(exec_path, elem->descriptor.exec);
  plugin_handle = dlopen(exec_path, RTLD_NOW | RTLD_DEEPBIND);
  if (plugin_handle == NULL) {
    printf("dlopen error: %s\n", dlerror());
    return NULL;
  }

  func = dlsym(plugin_handle, elem->descriptor.command);
  if (func == NULL) {
    printf("cannot open %s.\n", elem->descriptor.command);
    return NULL;
  }

  return func;
}

void *get_binary_function(const char *fname) {
  plugin_element *elem = NULL;
  void *func = NULL;

  elem = find_element_by_command(fname);
  if (elem == NULL) {
    printf("cannot find \"%s\"\n", fname);
    return NULL;
  }

  if ((func = _get_binary_func_internal(elem)) == NULL) {
    printf("error while loading \"%s\"\n", fname);
  }

  return func;
}

plugin_element *find_element_by_command(const char *command) {
  u_int cur_pos = get_current_list_pos();
  for (u_int i = 0; i < cur_pos; ++i) {
    if (strcmp(plugin_list[i].descriptor.command, command) == 0) {
      return &plugin_list[i];
    }
  }
  return NULL;
}

bool is_elem_binary(const plugin_element *elem) {
  return strcmp(elem->descriptor.type, ELEM_BINARY) == 0;
}

bool is_elem_script(const plugin_element *elem) {
  return strcmp(elem->descriptor.type, ELEM_SCRIPT) == 0;
}

bool is_plugin_command(const char *command) {
  if (find_element_by_command(command) == NULL) {
    return false;
  }
  return true;
}

bool is_plugin_already_loaded(const char *plugin_name) {
  u_int cur_pos = get_current_list_pos();
  for (u_int i = 0; i < cur_pos; ++i) {
    if (strcmp(plugin_list[i].plugin_name, plugin_name) == 0) {
      return true;
    }
  }
  return false;
}
