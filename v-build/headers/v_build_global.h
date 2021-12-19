#ifndef V_BUILD_GLOBAL_H
#define V_BUILD_GLOBAL_H

#include <stdlib.h>

// colors for output
#define OS_COLOR_RED "\x1B[31m"
#define OS_COLOR_GREEN "\x1B[32m"
#define OS_COLOR_YELLOW "\x1B[33m"
#define OS_COLOR_BLUE "\x1B[34m"
#define OS_NO_COLOR "\x1B[0m"

#define YES 1
#define NO 0

#define SHELL_TITILE OS_COLOR_GREEN SHELL_NAME OS_NO_COLOR

// msg titles
#define INFO_MSG OS_COLOR_BLUE "info: " OS_NO_COLOR
#define ERROR_MSG OS_COLOR_RED "err: " OS_NO_COLOR
#define COMPLETE OS_COLOR_GREEN "complete: " OS_NO_COLOR
#define QUESTION OS_COLOR_YELLOW "question: " OS_NO_COLOR
#define AUTOLOAD OS_COLOR_YELLOW "autoload: " OS_NO_COLOR

#define RUN_SHELL_LOOP for (;;)

// main definitions
#define COMMON_TEXT_SIZE 256
#define PLUGIN_LIST_SIZE 256

// main config
#define IO_INDEX 0
#define IO_PLUGIN_NAME "io"

typedef void (*void_func)();
typedef char *(*char_func)();

#endif // V_BUILD_GLOBAL_H
