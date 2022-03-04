#include "autoload.h"

#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "plugin.h"
#include "v_build_global.h"

char start_exec_dir[COMMON_TEXT_SIZE] = {0};

static bool _is_eq(const char *line, const char *cmp);
static bool _ready_to_load = false;

void autoload_plugins() {

  getcwd(start_exec_dir, COMMON_TEXT_SIZE);

  char autoload_path[COMMON_TEXT_SIZE] = {0};

  strcpy(autoload_path, start_exec_dir);
  strcat(autoload_path, "/");
  strcat(autoload_path, AUTOLOAD_FILE);

  FILE *pf = fopen(autoload_path, "r");
  char *line = malloc(COMMON_TEXT_SIZE);
  strcpy(line, "nothing");
  size_t n = COMMON_TEXT_SIZE;
  ssize_t read = 0;

  if (pf == NULL) {
    char err[COMMON_TEXT_SIZE] = " file autoload.config, ";
    strcat(err, strerror(errno));
    printf("error: %s\n", err);
    free(line);
    return;
  }

  while ((read = getline(&line, &n, pf)) != -1) {
    if (line[0] == '#' || line[0] == '\n')
      continue;

    if (_is_eq(line, P_BEGIN)) {
      _ready_to_load = true;
      continue;
    }

    if (_ready_to_load) {
      // char
      if (_is_eq(line, P_END)) {
        _ready_to_load = false;
        continue;
      }
      char plugin_name[COMMON_TEXT_SIZE];
      strcpy(plugin_name, line);
      plugin_name[strcspn(plugin_name, "\n")] = 0;

      if (load_plugin(plugin_name) == -1) {
        printf("%s: plugin loading error, exit.\n", plugin_name);
        exit(EXIT_FAILURE);
      }
    }
  }

  fclose(pf);
  free(line);
}

static bool _is_eq(const char *line, const char *cmp) {
  return strncmp(line, cmp, strlen(cmp)) == 0;
}
