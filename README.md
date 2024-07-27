# Neovim 네오빔

## 환경

Rocky Linux 9

## 설치

### 사전 설치 (Node.js)

```
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 20

# verifies the right Node.js version is in the environment
node -v # should print `v20.16.0`

# verifies the right npm version is in the environment
npm -v # should print `10.8.1`
```

### Neovim 설치

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

.bashrc 파일에 다음을 추가한다.

```
export PATH="$PATH:/opt/nvim-linux64/bin"
```

## 설정 파일

네오빔의 설정파일은 아래 경로에 다음과 같이 저장한다.

```
mkdir ~/.config/nvim
~/.config/nvim/init.vim
```

## 사용

터미널을 열고, 다음의 명령어를 실행한다.

```
nvim
```

Neovim을 **vi**로 실행하기 위해서는 다음과 같이 설정한다.

```
cd
vi ~/.bashrc
```

다음 줄을 추가한다.

```
alias vi='nvim'
```

---

## NeoVIM 추가 기능

### 플러그인 vim-plug

neovim 에서도 vim-plug를 설치하여 확장기능을 사용할 수 있다.

아래 깃허브 저장소를 참고

[vim-plug github 저장소](https://github.com/junegunn/vim-plug)

#### vim-plug 설치 (for Neovim)

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

#### 플러그인 추가

플러그인은 **init.vim** 파일에서 추가할 수 있다.

추가 방법은 간략히 다음과 같다.

```
call plug#begin(stdpath('data') . '/plugged')

Plug '플러그인 저장소'

call plug#end()
```

#### 플러그인 설치

nvim을 열고, 다음의 명령어를 실행한다.

```
:PlugInstall
```

#### vim-plug 장소

Rocky Linux의 경우 아래 경로에 Plug 들이 설치된다.

```
ls .local/share/nvim/plugged
```

#### Plug 삭제

특정한 플러그를 삭제하고 싶을때는 다음과 같은 과정을 거친다.

```
cd ~/.local/share/nvim/plugged
rm -rf 삭제하려는플러그
```

init.vim 파일에서 삭제 하려는 플러그를 주석처리 하거나 지운다.

```
#Plug '삭제하려는플러그'
```

#### vim-plug 명령어

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

### CoC for autocompletion

기존 vim에서 코드 자동완성 기능을 사용하기 위해 [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) 플러그인을 사용하였다.

해당 플러그인의 성능이 나쁘지는 않지만, LSP를 지원하는 CoC 플러그인을 사용하기로 결정하였다.

#### LSP (Language Server Protocol)

편집기(editor) 또는 IDE(Integrated Development Environment)에서 코드 자동완성, 오류검사, 정의로 이동 등의 기능을 제공하는데, 기존에는 개발 도구의 종류와 언어에 따라 별도의 프로그램을 구현해야 했다. 이에 개발 도구와 언어 서버와의 통신을 표준화하여 "다양한 도구에 언어 기능을 노출하는 데 유용한 프레임워크를 제공" 하기 위해 [LSP](https://learn.microsoft.com/ko-kr/visualstudio/extensibility/language-server-protocol?view=vs-2022)가 등장하였다.

#### CoC (Conquer of Completion)

[CoC github 저장소](https://github.com/neoclide/coc.nvim)

#### Plugin 설치

Vim-plug로 간단하게 설치할 수 있다.

init.vim 파일에 다음과 같이 추가한다.

```
" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

nvim을 열고
```
:PlugInstall
```

#### Example

##### C++ 자동완성

nvim을 열고

```
:CocInstall coc-clangd
```

coc-clangd가 clangd의 서버를 찾지 못하면
nvim을 실행하여 다음과 같이 해당 서버를 설치한다.

```
:CocCommand clangd.install
```

#### ROOT 자동완성

[ROOT: analyzing petabytes of data, scientifically](https://root.cern/)

ROOT 자동완성을 직접 지원하는 플러그인은 없기 때문에 다음과 같은 방법을 사용하였다.

우선 ROOT의 include 디렉토리를 찾는다.

(ROOT의 설치 방법에 따라 위치가 다르므로 확인이 필요하다.)

다만 헤더파일 중 하나를 검색하여 해당 경로를 찾을 수 있다.

(locate 명령어를 사용하기 위해서는 mlocate 패키지가 설치되어 있어야 한다.)

```
updatedb

locate TFile.h

cd /PATH/TO/ROOT/include
```

CoC 관련 디렉토리의 경로를 확인하고

include 디렉토리 하위 파일들을 해당 디렉토리로 복사한다.

```
cp -r /PATH/TO/ROOT/include/* ~/.config/coc/extensions/coc-clangd-data/install/17.0.3/clangd_17.0.3/lib/clang/17/include/
```

---

### GitHub Copilot

[GitHub Copilot](https://copilot.github.com/)

GitHub Copilot을 neovim에서도 사용할 수 있다.

이를 위해 다음과 같이 설정한다.

#### 전제 조건

1. GitHub Copilot Individual 이상의 서비스 구독.
2. Vim/Neovim 9.0.0185/0.6 이상의 버전.
3. Node.js 18 이상의 버전.

#### 설정

Terminal을 열고 다음의 명령어를 실행한다.

```
git clone https://github.com/github/copilot.vim \
   ~/.config/nvim/pack/github/start/copilot.vim
```

다음으로 nvim을 열고, 다음의 명령어를 실행한다.

```
:Copilot setup
```

이를 실행하면 8자리의 코드가 생성되는데, 이를 복사하고 enter를 누른다.

자동으로 웹브라우저가 열리면서 GitHub Copilot의 인증 페이지가 열린다.

복사한 8자리 코드를 입력하고, 인증을 완료한다.

이후 다시 nvim을 열고, 다음의 명령어를 실행한다.

```
:Copilot enable
```

이제 GitHub Copilot을 사용할 수 있다.
