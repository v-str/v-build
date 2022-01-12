#ifndef TEXT_CREATION_H
#define TEXT_CREATION_H

#include "text_global.h"

// commands list:
typedef struct cmd_bunch {
  char *full_name;
  char *short_name;
  char *desc;
} cmd_bunch;

static const cmd_bunch help_cmds[] = {
    {"help", "h", "help message"},
    {"clear", "c", "clear screen"},
    {"plugins", "p", "view all plugins, located in plugins dir"},
    {"load", "l", "load plugin from plugins dir"},
    {"set_column_args", "sca", "set args one by one"},
    {"set_line_args", "sla", "set args in one row after call function/script"},
    {"quit", "q", "exit program"}};

char *generate_help_string();

#endif // TEXT_CREATION_H
