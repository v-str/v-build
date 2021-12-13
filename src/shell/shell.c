#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// work with files
#include <fcntl.h>

#include "os_global.h"
#include "sce.h"
#include "shell.h"
#include "text_processing.h"

void run_shell() {
  RUN_SHELL_LOOP {
    char *command = get_command_from_user(SHELL_TITILE);

    if (is_command_exist(command)) {
      try_to_exec(command);
    } else {
      print_info_msg(ERROR_MSG, INVALID_COMMAND, YES);
    }
    free(command);
  }
}

// the command exist in command list
void try_to_exec(const char *command) {
  if (is_command_simple(command)) {
    run_sc(command);
  }
}

void check_config() {
  if (open(CONFIG_FILE, O_RDWR) == -1) {
    print_info_msg(INFO_MSG, "main config file do not exist.", YES);
    if (ask_yes_no("do you want to create it?") == YES) {
      // create config file
    } else {
      print_info_msg(INFO_MSG, "entering to shell.", YES);
    }
  }
}
