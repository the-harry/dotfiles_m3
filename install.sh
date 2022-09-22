#!/bin/sh

zsh-syntax-highlighting_install() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
}

asdf_install() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 3.0.3
  asdf global ruby 3.0.3
}

ruby_install() {
  asdf plugin add nodejs
  # bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 12.16.1
  asdf global nodejs 12.16.1

  curl -o- -L https://yarnpkg.com/install.sh | bash -s && source ~/.zshrc && yarn -v
  source ~/.zshrc && yarn -v
}

setup_git_account() {
  git config --global core.editor vim

  read -p 'Git username: ' gituser
  git config --global user.name $gituser

  read -p 'Git e-email: ' gitmail
  git config --global user.email $gitmail
}

if [ ! -d "$HOME/.dotfiles_m2" ]
then
  echo "Installing Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - nodejs"

  case "$(uname -s)" in
    Darwin )
      echo "  - vim (macvim)"
      echo "  - atom (mac)"

      zsh-syntax-highlighting_install
      asdf_install
      ruby_install
      node_install
      ;;
    Linux)
      echo 'You are using a Linux machine which is not recommended to use with our' \
           ' dotfiles.'
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      echo 'You can clone our repository and try install it manually.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/the-harry/dotfiles_m2.git "$HOME/.dotfiles_m2"
  cd "$HOME/.dotfiles_m2"

  setup_git_account

  rake install
else
  echo "Whoops... You already have these dotfiles installed."
fi
