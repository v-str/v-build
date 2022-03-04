#include "column_args_parser.h"

#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "io.h"
#include "shell_helper.h"

char user_args_etalon[ARGS_COUNT][COMMON_TEXT_SIZE] = {0};
char user_input_args[ARGS_COUNT][COMMON_TEXT_SIZE] = {0};
size_t _cmd_arg_counter = 0;
bool _is_input_correct = false;
bool _is_has_args = false;
bool _is_args_ok = false;

//                      INNER

void _print_pre_input_text(const char *arg_type) {
  char text[COMMON_TEXT_SIZE] = "arg ";
  strcat(text, arg_type);
  strcat(text, ": ");
  print_msg(text, 0);
}

//                      END

bool get_column_args(const plugin_element *restrict elem) {

  if (elem == NULL) {
    print_info_msg(ERROR_MSG, "Strange behaviour, command not found", YES);
    return false;
  }

  if (is_func_has_args(elem)) {

    const char *str = elem->descriptor.args;

    // get etalon func args and place them into user_args_etalon
    parse_etalon_args(str);

    get_user_func_column_args();

    return is_args_ok();

  } else {
    // run without args
    return true;
  }
}

void parse_etalon_args(const char *elem_args) {
  char copy[COMMON_TEXT_SIZE];
  strcpy(copy, elem_args);
  char delim[] = ",";
  char *p = NULL;

  p = strtok(copy, delim);

  // find all args
  while (p != NULL) {
    strcpy(user_args_etalon[_cmd_arg_counter], p);
    p = strtok(NULL, delim);
    _cmd_arg_counter++;
  }

  // remove whitespaces in args, if any exists
  for (size_t i = 0; i < _cmd_arg_counter; ++i) {
    char temp[COMMON_TEXT_SIZE] = {0};
    strcpy(temp, user_args_etalon[i]);
    size_t spnz = strspn(temp, " ");
    strcpy(user_args_etalon[i], temp + spnz);
  }
}

bool is_func_has_args(const plugin_element *elem) {
  _is_has_args = strcmp(elem->descriptor.args, NO_ARGS) != 0;
  return _is_has_args;
}

void get_user_func_column_args() {
  char arg_type_text[COMMON_TEXT_SIZE] = {0};

  if (_cmd_arg_counter == 0)
    return;

  for (size_t i = 0; i < _cmd_arg_counter; ++i) {

    _print_pre_input_text(user_args_etalon[i]);

    char *arg_value = get_input(arg_type_text);
    strcpy(user_input_args[i], arg_value);

    memset(arg_type_text, 0, sizeof(arg_type_text));
    free(arg_value);
  }
}

bool is_args_ok() {

  for (size_t i = 0; i < _cmd_arg_counter; ++i) {

    if (is_empty_arg(user_input_args[i])) {
      print_incorrect_expected_values(i, user_args_etalon[i],
                                      user_input_args[i]);
      _is_args_ok = false;
      break;
    }

    if (is_arg_int(i)) {
      if (!is_arg_digits(user_input_args[i])) {
        print_incorrect_expected_values(i, user_args_etalon[i],
                                        user_input_args[i]);
        _is_args_ok = false;
        break;
      }
    }

    if (is_arg_bool(i)) {
      if (!is_entered_arg_is_bool(user_input_args[i])) {
        print_incorrect_expected_values(i, user_args_etalon[i],
                                        user_input_args[i]);
        _is_args_ok = false;
        break;
      }
    }
    _is_args_ok = true;
  }

  return _is_args_ok;
}

bool is_arg_digits(const char *entered) {

  for (size_t j = 0; j < strlen(entered); ++j) {
    if (isdigit(entered[j]) == 0) {
      return false;
    }
  }

  return true;
}

bool is_empty_arg(const char *entered) {
  return _is_has_args && (strlen(entered) == 0);
}

void reset_user_args() {
  // reset input data
  memset(user_args_etalon, 0, sizeof(user_args_etalon));
  memset(user_input_args, 0, sizeof(user_input_args));
  _is_has_args = false;
  _cmd_arg_counter = 0;
  _is_args_ok = false;
}

bool is_entered_arg_is_bool(const char *entered) {
  bool is_true = (strcmp(entered, "true") == 0) ||
                 (strcmp(entered, "TRUE") == 0) || (strcmp(entered, "1") == 0);

  bool is_false = (strcmp(entered, "false") == 0) ||
                  (strcmp(entered, "FALSE") == 0) ||
                  (strcmp(entered, "0") == 0);

  return is_true || is_false;
}

bool is_arg_charp(size_t idx) {
  return strcmp(user_args_etalon[idx], IS_VALUE_CHAR_P) == 0;
}

bool is_arg_int(size_t idx) {
  return strcmp(user_args_etalon[idx], IS_VALUE_INT) == 0;
}

bool is_arg_bool(size_t idx) {
  return strcmp(user_args_etalon[idx], IS_VALUE_BOOL) == 0;
}

bool is_func_ret_void(const plugin_element *elem) {
  return strcmp(elem->descriptor.ret_val, IS_VALUE_VOID) == 0;
}

bool is_func_ret_int(const plugin_element *elem) {
  return strcmp(elem->descriptor.ret_val, IS_VALUE_INT) == 0;
}

bool is_func_ret_charp(const plugin_element *elem) {
  return strcmp(elem->descriptor.ret_val, IS_VALUE_CHAR_P) == 0;
}

bool is_func_ret_bool(const plugin_element *elem) {
  return strcmp(elem->descriptor.ret_val, IS_VALUE_BOOL) == 0;
}
