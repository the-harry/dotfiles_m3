# Dotfiles M2

## Source of inspiration

This project is a fork from [my old dotfile](https://github.com/the-harry/dotfiles).

## Pre-Reqs

#### Mac M2 chips

* Homebrew:

Follow the instructions on brew.sh if you don't have it installed yet.

## Install

Run follow command:

```
sh -c "`curl -fSs https://raw.githubusercontent.com/the-harry/dotfiles_m2/master/install.sh`"
```

Type your password to change your default shell to `zsh`

## After install

* Go into Sys Pref > Network > Advanced > Proxies > Automatic Proxy Configuration and copy and paste the full address here in `~/.dotfiles_m2/zshrc`:

`export HTTP_PROXY=http://proxy.server.com:portnumber`

Also edit other variables that depends on tokens like GitHub, 1pass, etc... After that just source it again:

`source ~/.dotfiles_m2/zshrc`

* Manually download tunnelBrick VPN.

* Clone [smartaws](git clone git@github.com:smartpension/trekkie-toolkit.git) and [install it](https://github.com/smartpension/trekkie-toolkit/tree/main/aws#smart-aws)

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
