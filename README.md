# Neovim 네오빔

## 환경

Rocky Linux 9

## 설치

### 사전 설치

```
sudo dnf install git nodejs
```

### Neovim 설치

```
sudo dnf install neovim
```

## 설정 파일

네오빔의 설정파일은 아래 경로에 다음과 같이 저장한다.

```
~/.config/nvim/init.vim
```

또는 해당 파일을 심볼릭 링크로 연결한다.

```
ln -s init.vim ~/.config/nvim/init.vim
```

해당 디렉토리가 없는 경우 생성후 위 명령어를 실행한다.

```
mkdir ~/.config/nvim
```

## 사용

터미널을 열고, 다음의 명령어를 실행한다.

```
nvim
```

**vi**로 실행하기 위해서는 다음과 같이 설정한다.

```
cd
vi ~/.bashrc
```

다음 줄을 추가한다.

```
alias vi='nvim'
```

---

## 플러그인 vim-plug

neovim 에서도 vim-plug를 설치하여 확장기능을 사용할 수 있다.

아래 깃허브 저장소를 참고

[vim-plug github 저장소](https://github.com/junegunn/vim-plug)

### vim-plug 설치 (for Neovim)

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### 플러그인 추가

플러그인은 **init.vim** 파일에서 추가할 수 있다.

추가 방법은 간략히 다음과 같다.

```
Plug '플러그인 저장소'
```

### 플러그인 설치

nvim을 열고, 다음의 명령어를 실행한다.

```
:PlugInstall
```

### vim-plug 장소

Rocky Linux의 경우 아래 경로에 Plug 들이 설치된다.

```
cd
ls .local/share/nvim/plugged
```

### 특정 plug 삭제

특정한 플러그를 삭제하고 싶을때는 다음과 같은 과정을 거친다.

#### Plug 삭제

```
cd ~/.local/share/nvim/plugged
rm -rf 삭제하려는플러그
```

#### init.vim

삭제 하려는 플러그를 주석처리 하거나 지운다.

```
#Plug '삭제하려는플러그'
```

### vim-plug 명령어

2024.03 현재

| Command	| Description |
| --- | --- |
| PlugInstall [name ...] [#threads]	| Install plugins |
| PlugUpdate [name ...] [#threads]	| Install or update plugins |
| PlugClean[!]	| Remove unlisted plugins (bang version will clean without prompt) |
| PlugUpgrade	| Upgrade vim-plug itself |
| PlugStatus	| Check the status of plugins |
| PlugDiff	| Examine changes from the previous update and the pending changes |
| PlugSnapshot[!] [output path]	| Generate script for restoring the current snapshot of the plugins |

---

## CoC for autocompletion

[CoC github 저장소](https://github.com/neoclide/coc.nvim)

### Plugin

```
" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Or build from source code by using npm
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
```

