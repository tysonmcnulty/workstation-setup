#!/usr/bin/env zsh

# programs
brew install asdf
brew install kejadlen/git-together/git-together
brew install intellij-idea
brew install spotify
brew install textmate

# node
if [ ! command -v node ]; then
asdf plugin add nodejs
NODEJS_VERSION=$(asdf latest nodejs 18)
asdf install nodejs "${NODEJS_VERSION}"
asdf global nodejs "${NODEJS_VERSION}"
fi

# poetry/python
if [ ! command -v python3 ]; then
brew install openssl readline sqlite3 xz zlib tcl-tk
asdf plugin add poetry
POETRY_VERSION=$(asdf latest poetry)
asdf install poetry "${POETRY_VERSION}"
asdf global poetry "${POETRY_VERSION}"

asdf plugin add python
PYTHON_VERSION=$(asdf latest python 3)
asdf install python "${PYTHON_VERSION}"
asdf global python "${PYTHON_VERSION}"
fi

# java
if [ ! command -v java ]; then
asdf plugin add java
if [ ! -f ~/.asdfrc ]; then cat > ~/.asdfrc <<EOF
java_macos_integration_enable = yes
EOF
fi
JAVA_VERSION=$(asdf latest java temurin-17)
asdf install java "${JAVA_VERSION}"
asdf global java "${JAVA_VERSION}"
fi

# git-together
if [ ! -f ~/.git-together ]; then
touch ~/.git-together
git config --file ~/.git-together --add git-together.authors.tm 'Tyson McNulty; tyson.mcnulty@gmail.com'
git config --global --add include.path ~/.git-together
fi

echo "
Manual one-time steps

- In a shell with oh-my-zsh active:

mkdir -p \$ZSH_CUSTOM/plugins/poetry
poetry completions zsh > \$ZSH_CUSTOM/plugins/poetry/_poetry

- Recommended ~/.zshrc looks like this:

#zsh
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(asdf git poetry)
source \$ZSH/oh-my-zsh.sh

#java
source ~/.asdf/plugins/java/set-java-home.zsh

#direnv
eval "$(direnv hook zsh)"

#git-together
compdef git-together=git
"
