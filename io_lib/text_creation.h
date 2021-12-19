#ifndef TEXT_CREATION_H
#define TEXT_CREATION_H

#include "text_global.h"

#define SIMPLE 0
#define COMPOSITE 1

// commands list:
typedef struct cmd_bunch {
  char *full_name;
  char *short_name;
  char *desc;
  int property; // property holds whether composite or simple value
} cmd_bunch;

static const cmd_bunch help_cmds[] = {{"help", "h", "help message", SIMPLE},
                                      {"clear", "c", "clear screen", SIMPLE},
                                      {"quit", "q", "exit program", SIMPLE},
                                      {"empty", "empty", "empty", SIMPLE},
                                      {"empty", "empty", "empty", SIMPLE},
                                      {"empty", "empty", "empty", SIMPLE}};

char *generate_help_string();

#endif // TEXT_CREATION_H
