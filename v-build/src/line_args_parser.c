#include "line_args_parser.h"

#include <ctype.h>
#include <stdio.h>

#include "io.h"
#include "string.h"

char _cmd_internal[COMMON_TEXT_SIZE] = {0};

static size_t _len = 0;
static char _base_line[COMMON_TEXT_SIZE] = {0};
static char _raw_args[COMMON_TEXT_SIZE] = {0};
static char _final_args[ARGS_COUNT][COMMON_TEXT_SIZE];

static void _reset_internal_values() {
  memset(_cmd_internal, '\0', COMMON_TEXT_SIZE);
  memset(_base_line, '\0', COMMON_TEXT_SIZE);
  memset(_raw_args, '\0', COMMON_TEXT_SIZE);
  memset(_final_args, '\0', ARGS_COUNT * COMMON_TEXT_SIZE);
}

static void _remove_begin_spaces() {
  size_t i = 0;
  char temp[COMMON_TEXT_SIZE] = {0};

  for (i = 0; i < strlen(_raw_args); ++i) {

    if (isspace(_raw_args[i])) {
      continue;
    }
    break;
  }

  strcpy(temp, _raw_args + i);
  strcpy(_raw_args, temp);
}

static bool _is_parse_line_ok() {
  char *ptr = NULL;
  size_t idx = 0;

  _remove_begin_spaces();

  ptr = strtok(_raw_args, " ");

  while (ptr != NULL) {
    if (idx < _cmd_arg_counter) {
      strcpy(_final_args[idx], ptr);
      ++idx;
    } else {
      print_info_msg(ERROR_MSG, "invalid argument count", YES);
      return false;
    }

    ptr = strtok(NULL, " ");
  }
  return true;
}

char *get_command_from_line(const char *cmd_line) {
  size_t cmd_len = strlen(cmd_line);
  const char *delim = " ";

  _reset_internal_values();

  strcpy(_base_line, cmd_line);
  _len = strcspn(_base_line, delim);

  strncpy(_cmd_internal, _base_line, _len);

  if (_len != cmd_len) {
    strcpy(_raw_args, _base_line + _len);
  }

  return _cmd_internal;
}

bool fill_line_args(const plugin_element *restrict elem) {
  if (is_func_has_args(elem)) {
    parse_etalon_args(elem->descriptor.args);

    if (_is_parse_line_ok()) {
      for (size_t i = 0; i < _cmd_arg_counter; ++i) {
        strcpy(user_input_args[i], _final_args[i]);
      }
      return is_args_ok();
    } else {
      return false;
    }
  }

  return true;
}

bool is_parse_line_ok() { return _is_parse_line_ok(); }

char *get_line_arg(size_t idx) { return _final_args[idx]; }
