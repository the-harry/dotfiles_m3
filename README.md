# Dotfiles M3

## Pre-Reqs

#### Mac M3 chips

* Homebrew:

Follow the instructions on brew.sh if you don't have it installed yet.

## Install

Run follow command:

```
sh -c "`curl -fSs https://raw.githubusercontent.com/the-harry/dotfiles_m3/master/install.sh`"
```

Type your password to change your default shell to `zsh`

## After install

Edit other env vars that depends on tokens like GitHub, 1pass, etc... After that just source it again:

`source ~/.dotfiles_m3/zshrc`

## Docs

[Vim Key Mapping](Vim.md)

[Tmux Key Mapping](Tmux.md)

#### It's easy to make your customizations

Place your customizations in the following files:

* .aliases.local
* .secrets
* .zshrc.local
* .vimrc.local
* .zshenv.local
* .plugin.vim.local
* .tmux.conf.local
* .gitconfig.local
