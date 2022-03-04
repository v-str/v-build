#ifndef TEXT_PROCESSING_H
#define TEXT_PROCESSING_H

#include <stdbool.h>

#include "text_creation.h"
#include "text_global.h"

char final_str[USER_COMMAND_LEN] = {};

void greetings();
void print_help_msg();

void print_msg(const char *msg, size_t sleep_msec);
void print_fmt_msg(int width, const char *msg);
void print_info_msg(const char *title, const char *msg, int newline_symbol);

// 1 - answer YES, 0 - NO
int ask_yes_no(const char *question_text);

bool is_help_command(const char *cmd);

char *get_shell_input();
char *get_input(const char *input);

#endif // TEXT_PROCESSING_H
