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
    {"list", "ll", "show loaded plugins"},
    {"plugins_all", "pla", "view all plugins, located in plugins dir"},
    {"load", "l", "load plugin from plugins dir"},
    {"run_order_list", "rol", "run command from order list"},
    {"show_order_list", "sol", "show order list"},
    {"set_column_args", "sca", "set args one by one"},
    {"set_line_args", "sla",
     "set args in one row after function/script call devided by space "
     "(default)"},
    {"view_config", "vc", "view shell global configuration"},
    {"history", "hist", "view command history"},
    {"quit", "q", "exit program"}};

char *generate_help_string();

#endif // TEXT_CREATION_H
