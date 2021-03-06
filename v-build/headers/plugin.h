#ifndef PLUGIN_H
#define PLUGIN_H

#include <stdbool.h>

#include "plugin_parser.h"
#include "v_build_global.h"

// 0 if success, -1 if error
int load_plugin(const char *restrict plugin_name);

// *function if success, NULL if error
void *get_binary_function(const char *restrict fname);

bool is_plugin_already_loaded(const char *plugin_name);
plugin_element *find_element_by_command(const char *restrict command);

bool is_plugin_command(const char *restrict command);
bool is_elem_binary(const plugin_element *restrict elem);
bool is_elem_script(const plugin_element *restrict elem);

#endif // PLUGIN_H
