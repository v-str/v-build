#include "order.h"

#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "bin_exec.h"
#include "column_args_parser.h"
#include "io.h"
#include "line_args_parser.h"
#include "plugin.h"
#include "plugin_parser.h"
#include "script_exec.h"

#define ORDER_LIST "/order.list"

static char _order_list_path[COMMON_TEXT_SIZE] = {0};
static bool _ready_to_exec = false;
static char _command[COMMON_TEXT_SIZE] = {0};
static plugin_element *_element = NULL;

static void execute() {
  bool is_args_ok = fill_line_args(_element);

  if (is_args_ok) {
    if (is_elem_binary(_element)) {
      exec_bin(_element);
    } else if (is_elem_script(_element)) {
      exec_script(_element);
    }
  }

  reset_user_args();
}

static void just_show() {
  printf("\t%s, < args: %s >\n", _element->descriptor.command,
         _element->descriptor.args);
}

static void _parse_order_list(bool is_exec_mode) {
  FILE *pf = fopen(_order_list_path, "r");
  char *line = malloc(COMMON_TEXT_SIZE);
  size_t n = COMMON_TEXT_SIZE;
  ssize_t read = 0;

  if (pf == NULL) {
    print_info_msg(
        ERROR_MSG,
        "function: _parse_order_list, order list path error, is it exist?",
        YES);
    free(line);
    return;
  }

  print_info_msg(COMPLETE, "order list found", YES);

  while ((read = getline(&line, &n, pf)) != -1) {

    if (line[0] == '#' || line[0] == '\n') {
      continue;
    }

    if (strncmp(line, P_BEGIN, strlen(P_BEGIN)) == 0) {
      _ready_to_exec = true;
      continue;
    }

    if (_ready_to_exec) {

      if (strncmp(line, P_END, strlen(P_END)) == 0) {
        _ready_to_exec = false;
        continue;
      }

      char temp[COMMON_TEXT_SIZE] = {0};

      strcpy(temp, line);
      temp[strcspn(temp, "\n")] = 0;

      char *temp_cmd = get_command_from_line(temp);
      strcpy(_command, temp_cmd);

      if ((_element = find_element_by_command(_command)) == NULL) {
        char temp[COMMON_TEXT_SIZE] = "cannot find command \"";
        strcat(temp, _command);
        strcat(temp, "\"");
        strcat(temp, " in order list");
        print_info_msg(ERROR_MSG, temp, YES);
        break;
      } else {
        if (is_exec_mode) {
          execute();
        } else {
          just_show();
        }
      }
    }
  }

  free(line);
}

void exec_order_list(bool is_exec_mode) {
  char file_path[COMMON_TEXT_SIZE] = {0};

  if (g_conf.is_line_args == false) {
    print_info_msg(ERROR_MSG, "cannot run order list in sca mode", YES);
    return;
  }

  strcpy(file_path, getenv("V_BUILD_SYSTEM"));
  if (file_path == NULL) {
    print_info_msg(ERROR_MSG, "env variable V_BUILD_SYSTEM not found", YES);
    return;
  } else {
    strcat(file_path, ORDER_LIST);
    strcpy(_order_list_path, file_path);
    _parse_order_list(is_exec_mode);
  }
}
