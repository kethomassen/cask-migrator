# cask-migrator

Simple shell script to help migrate manually installed mac applications to Homebrew's cask.

## Why?

Once managing your applications via cask you can update them all with a single command. 
Additionally, you can then export your Brewfile and automate the installation of your GUI apps (i.e. in your dotfiles).

## How to use

Simply run
```
./cask-migrator.sh
```
and it will try to find the cask version of your applications and install them.

## Options

```
Options
  -f          Don't ask for confirmation for each application (Probably a bad idea).
  -r          Permanently remove old applications. By default just moves to trash
  -d [dir]    Search directory for .app files. Default: /Applications
  -id [dir]   Install directory for cask. Default: /Applications
  -h          Print this help message and exit.
```
