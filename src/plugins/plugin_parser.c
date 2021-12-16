#include "plugin_parser.h"

#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "text_processing.h"

static u_int pos = 0;
static bool ready_to_read = false;

int _read_plugin(const char *restrict plugin_path);

bool _is_eq(const char *line, const char *cmp);

void _parse_line(const char *line, plugin *tp, int count, ...);

size_t _get_offset(int value);

plugin plugin_list[PLUGIN_LIST_SIZE];

int load_plugin(const char *plugin_path) {
  int ret = 0;
  if (plugin_path == NULL)
    ret = -1;
  else {
    ret = _read_plugin(plugin_path);
  }

  return ret;
}

int _read_plugin(const char *restrict plugin_path) {
  FILE *pf = fopen(plugin_path, "r");
  char *line = malloc(COMMON_TEXT_SIZE);
  size_t n;
  ssize_t read;
  plugin pl = {0};

  if (pf == NULL) {
    char err[COMMON_TEXT_SIZE] = " _read_plugin, ";
    strcat(err, strerror(errno));
    print_info_msg(ERROR_MSG, err, YES);
    return -1;
  }

  while ((read = getline(&line, &n, pf)) != -1) {
    if (line[0] == '#' || line[0] == '\n')
      continue;

    if (_is_eq(line, P_BEGIN)) {
      ready_to_read = true;
      continue;
    }

    if (ready_to_read) {
      _parse_line(line, &pl, 6, P_NAME, P_TYPE, P_ALIAS, P_DIR, P_EXEC, P_DESC);
    }

    if (_is_eq(line, P_END)) {
      ready_to_read = false;
      memcpy(&plugin_list[pos], &pl, sizeof(pl));
      memset(&pl, 0, sizeof(pl));
      pos++;
    }
  }

  free(line);
  return 0;
}

bool _is_eq(const char *line, const char *cmp) {
  return strncmp(line, cmp, strlen(cmp)) == 0;
}

void _parse_line(const char *line, plugin *tp, int count, ...) {

  char temp[COMMON_TEXT_SIZE];

  va_list arg_list;
  va_start(arg_list, count);

  for (int i = 0; i < count; ++i) {

    char *str = va_arg(arg_list, char *);

    if (strncmp(line, str, strlen(str)) == 0) {
      strcpy(temp, line + (strlen(str)));
      temp[strcspn(temp, "\n")] = 0;

      char *base = (char *)tp;
      char *offs = base + _get_offset(i);

      strcpy(offs, temp);
    }
  }
}

size_t _get_offset(int value) {
  if (value == 0)
    return offsetof(plugin, plugin_name);
  if (value == 1)
    return offsetof(plugin, type);
  if (value == 2)
    return offsetof(plugin, alias);
  if (value == 3)
    return offsetof(plugin, dir);
  if (value == 4)
    return offsetof(plugin, exec);
  if (value == 5)
    return offsetof(plugin, desc);
  return 0;
}
