#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "os_global.h"
#include "text_processor.h"

bool is_command_exist(const char *p) {
  for (size_t i = 0; i < SHELL_CMD_COUNT; ++i) {
    if (strcmp(p, cmds[i].full_name) != 0) {
      if (strcmp(p, cmds[i].short_name) != 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
  return true;
}

// release the string after use
char *get_command_from_user() {
  char user_command[USER_COMMAND_LEN];
  printf(OS_COLOR_GREEN SHELL_NAME OS_NO_COLOR);
  scanf("%s", user_command);
  return strdup(user_command);
}

void print_help_msg(const struct cmd_triplet *instance) {
  char string[256];

  strcpy(string, "\t\t");
  strcpy(string, OS_COLOR_YELLOW);
  strcpy(string, instance->full_name);
  strcpy(string, ", ");
  strcpy(string, instance->short_name);
  strcpy(string, " - ");
  strcpy(string, instance->desc);
  strcpy(string, "\n");

  printf("%s", string);
}

void error_msg(const char *msg) {
  char string[256];

  strcpy(string, OS_COLOR_RED);
  strcat(string, "Error: ");
  strcat(string, msg);
  strcat(string, OS_NO_COLOR);
  strcat(string, "\n\0");

  write_msg(string);
}

void write_msg(const char *msg) {
  size_t msg_len = strlen(msg);

  for (size_t i = 0; i < msg_len; ++i) {
    putchar(msg[i]);
    fflush(stdout);
    usleep(SLEEP_MSEC);
  }
}
