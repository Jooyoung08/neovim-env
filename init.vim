"Neovim 기본 설정

"View 설정
set number			"라인 번호
set showmatch		"브라켓 맞춤 표시
set wrap			"자동 줄바꿈
syntax on			"구문 강조

"Search 설정
set hlsearch		"검색 HL
set incsearch		"실시간 검색 위치 표시
set ignorecase		"검색, 대소문자 구분 안함
set magic			"메타 문자 검색시 '\' 생략

"Indent 설정
set smartindent		"자동 들여쓰기
set autoindent		"smartindent 사용시 들여쓰기 상속
set smarttab		"tab->space
set tabstop=4		"tab의 공백 수
set shiftwidth=4	"자동 들여쓰기의 공백 수

"기타 설정
set fileencodings=utf8,euc-kr	"파일 인코딩
set termguicolors				"TrueColor

"Plug-in 시작
call plug#begin(stdpath('data') . '/plugged')

"상태창 정보 표시 및 스타일
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/edge'

"Vim indent guide
Plug 'nathanaelkane/vim-indent-guides'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Git
Plug 'tpope/vim-fugitive'

"주석 처리
Plug 'tpope/vim-commentary'

"NERDTree
Plug 'preservim/nerdtree'
"NERDTree-git
Plug 'Xuyuanp/nerdtree-git-plugin'

"Neovim 자동완성
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"Plug-in 설정
"Color Scheme - sainnhe EDGE
let g:edge_style='aura'			"default, aura, neon
let g:edge_better_performance=1
let g:edge_menu_selection_background='blue'	"blue, green, purple

"모든 설정 후 colorscheme edge 입력
colorscheme edge

"vim-airline-theme 설정
let g:airline_theme='edge'		"테마 

"vim-airline 설정
set laststatus=2				"상태 줄 항상 표시
let g:airline_powerline_fonts=1 "Powerline Font 사용
"vim-airline extensions load
let g:airline_extensions = ['branch', 'coc']
"Extension 기능 활성화
let g:airline#extensions#branch#enabled = 1		
let g:airline#extensions#coc#enabled = 1
"옵션 설정
let g:airline#extensions#coc#show_coc_status = 1

"vim indent guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

"vim-commentary manual
"gcc : 현재 라인 주석 처리
"gcap: 현재 문단 주석 처리

"NERDTree
"NERDTree Open
nnoremap <C-n> :NERDTreeToggle<CR>			"너드트리토글 단축키
"NERDTree Find
nnoremap <C-f> :NERDTreeFind<CR>
"NERDTree Mapping
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

"Coc 자동완성
"Extension 확인 및 자동 설치
let g:coc_global_extensions = ['coc-json', 'coc-rust-analyzer', 'coc-pyright', 'coc-clangd', 'coc-marketplace']
"Control+j,k로 자동완성 리스트 이동
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "" 
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : ""
"Control+h로 자동완성 선택
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#insert() : ""
inoremap <silent><expr> <C-l> coc#pum#visible() ? coc#refresh() : coc#start() 

"nvim-treesitter 설정
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" 
  ensure_installed = { "c", "cmake", "cpp", "python", "lua", "json", "vim", "bash" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = { },

    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
