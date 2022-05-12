#include "navigation.h"

#include <dirent.h>
#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

extern char **environ;

void ls(const char *path) {
  char lscmd[1024] = {0};
  strcpy(lscmd, "ls ");
  strcat(lscmd, "-lah --color=auto ");
  strcat(lscmd, path);

  system(lscmd);
}

void pwd() { system("pwd"); }

void cd(const char *path) {
  if ((chdir(path)) != 0) {
    printf("%s\n", strerror(errno));
  }
}

void createdir(const char *path) {
  if ((mkdir(path, 0700)) != 0) {
    printf("%s\n", strerror(errno));
  }
}

void removenode(const char *path) {
  char dir[1024] = {0};
  strcpy(dir, "sudo rm -rf ");
  strcat(dir, path);

  system(dir);
}

void createfile(const char *path) {
  char file[1024] = {0};
  strcpy(file, "touch ");
  strcat(file, path);

  system(file);
}

void edit(const char *path) {
  char command[1024] = {0};
  size_t i = 0;
  while (environ[i]) {
    if ((strncmp(environ[i], "EDITOR", 6)) == 0) {
      strcpy(command, environ[i] + 7);
      break;
    }
    ++i;
  }
  strcat(command, " ");
  strcat(command, path);

  system(command);
}

void renamenode(const char *old_name, const char *new_name) {
  char command[1024] = {0};

  strcpy(command, "mv ");
  strcat(command, old_name);
  strcat(command, " ");
  strcat(command, new_name);

  system(command);
}

void viewfile(const char *path) {
  char command[1024] = {0};

  strcpy(command, "cat ");
  strcat(command, path);

  system(command);
}

void invoke_script(const char *path) {
  char command[1024] = {0};
  strcpy(command, "sh ");
  strcat(command, path);
  system(command);
}

void invoke_bin(const char *path) { system(path); }
