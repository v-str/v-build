#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "text_global.h"
#include "text_processing.h"

bool is_command_exist(const char *cmd) {
  size_t cmd_count = sizeof(help_cmds) / sizeof(help_cmds[0]);
  bool res = false;
  for (size_t i = 0; i < cmd_count; ++i) {
    if (strcmp(cmd, help_cmds[i].full_name) != 0) {
      if (strcmp(cmd, help_cmds[i].short_name) == 0) {
        res = true;
      }
    } else {
      res = true;
    }
  }
  return res;
}

// release the string after use ( free )
char *get_command_from_user() {
  char user_command[USER_COMMAND_LEN];
  printf("%s", SHELL_TITILE);

  // printf("shell: ");

  // check for the CTRL-D
  if (fgets(user_command, USER_COMMAND_LEN, stdin) == NULL) {
    printf("\n");
    EXIT(EXIT_SUCCESS);
  }

  // remove new line symbol '\n' and place 0
  user_command[strcspn(user_command, "\n")] = 0;
  return strdup(user_command);
}

void print_help_msg() {
  char *help_text = generate_help_string();
  print_msg(help_text, SLEEP_MSEC_HELP);
  free(help_text);
}

void print_msg(const char *msg, size_t sleep_msec) {
  size_t msg_len = strlen(msg);

  for (size_t i = 0; i < msg_len; ++i) {
    putchar(msg[i]);
    fflush(stdout);
    usleep(sleep_msec);
  }
}

bool is_command_simple(const char *cmd) {
  size_t i = find_command(cmd);
  return help_cmds[i].property == SIMPLE;
}

size_t find_command(const char *cmd) {
  size_t res = -1;
  size_t cmd_count = sizeof(help_cmds) / sizeof(help_cmds[0]);

  for (size_t i = 0; i < cmd_count; ++i) {
    if (strcmp(cmd, help_cmds[i].full_name) == 0 ||
        strcmp(cmd, help_cmds[i].short_name) == 0) {
      res = i;
      break;
    }
  }
  return res;
}

void print_info_msg(const char *title, const char *msg, int newline_symbol) {
  char string[MSG_LENGTH];
  memset(string, 0, MSG_LENGTH);

  strcat(string, title);
  strcat(string, msg);

  if (newline_symbol == YES) {
    strcat(string, "\n");
  }

  print_msg(string, SLEEP_MSEC_COMMON);
}

int ask_yes_no(const char *question_text) {
  bool answer_received = 0;
  char *yes_no = " (yes/no): ";
  char question[strlen(question_text) + strlen(yes_no)];
  strcpy(question, question_text);
  strcat(question, yes_no);
  int answer = NO;
  while (!answer_received) {
    print_info_msg(QUESTION, question, NO);
    char *user_string = get_command_from_user("");
    if (strcmp(user_string, "Y") == 0 || strcmp(user_string, "y") == 0 ||
        strcmp(user_string, "YES") == 0 || strcmp(user_string, "yes") == 0) {
      answer_received = true;
      answer = YES;
    } else if (strcmp(user_string, "N") == 0 || strcmp(user_string, "n") == 0 ||
               strcmp(user_string, "NO") == 0 ||
               strcmp(user_string, "no") == 0) {
      answer_received = true;
    } else {
      print_info_msg(ERROR_MSG, YES_NO_INCORRECT_INPUT, YES);
    }
  }
  return answer;
}