#ifndef IO_H
#define IO_H

#include "plugin.h"
#include "v_build_global.h"

// default io funcs
extern void (*greetings)();
extern void (*print_help)();
extern void (*print_msg)();
extern void (*print_fmt_msg)();
extern void (*print_info_msg)();
extern int (*ask_yes_no)();
extern bool (*is_help_command)();
extern char *(*get_shell_input)();
extern char *(*get_input)();

void load_io();

#endif // IO_H
