let
  makeKeyMap = m: k: e: d:
    {
      mode = m;
      key = k;
      effect = e;
      docstring = d;
    };
in
[
  # Readline
  (makeKeyMap "insert" "<c-b>" "<left>" null)
  (makeKeyMap "insert" "<c-f>" "<right>" null)
  (makeKeyMap "insert" "<c-a>" "<esc>I" null)
  (makeKeyMap "insert" "<c-e>" "<end>" null)
  (makeKeyMap "insert" "<a-b>" "<esc>b;i" null)
  (makeKeyMap "insert" "<a-f>" "<esc>w;i" null)
  (makeKeyMap "insert" "<c-d>" "<esc>c" null)
  (makeKeyMap "insert" "<c-k>" "<esc><a-l>c" null)
  (makeKeyMap "insert" "<c-y>" "<esc>Pa" null)
  (makeKeyMap "insert" "<c-w>" "<esc>bc" null)
  (makeKeyMap "prompt" "<c-b>" "<left>" null)
  (makeKeyMap "prompt" "<c-f>" "<right>" null)
  (makeKeyMap "prompt" "<c-a>" "<home>" null)
  (makeKeyMap "prompt" "<c-e>" "<end>" null)

  (makeKeyMap "user" "w" ":w<ret>" "save buffer")
  (makeKeyMap "user" "b" ":b " "switch buffer")
  (makeKeyMap "user" "c" ":comment-line<ret>" "comment selected lines")

  # Git binds
  (makeKeyMap "user" "g" ":enter-user-mode git<ret>" "git mode")
  (makeKeyMap "git" "s" ":git status<ret>" "show status")
  (makeKeyMap "git" "c" ":git commit<ret>" "commit staged changes")
  (makeKeyMap "git" "d" ":git diff<ret>" "show diff")
  (makeKeyMap "git" "l" ":git log<ret>" "show log")

  # LSP binds
  (makeKeyMap "user" "l" ":enter-user-mode lsp<ret>" "LSP mode")
  (makeKeyMap "user" "i" ":lsp-inlay-hints-enable window<ret>" "enable inlay hints")
  (makeKeyMap "user" "I" ":lsp-inlay-hints-disable window<ret>" "disable inlay hints")
  (makeKeyMap "insert" "<tab>" "<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>" "select next snippet placeholder")
  (makeKeyMap "object" "a" "<a-;>lsp-object<ret>" "LSP any symbol")
  (makeKeyMap "object" "f" "<a-;>lsp-object Function Method<ret>" "LSP function or method")
  (makeKeyMap "object" "o" "<a-;>lsp-object Struct Class Interface<ret>" "LSP class, struct, or interface")
  (makeKeyMap "object" "d" "<a-;>lsp-diagnostic-object --include-warnings<ret>" "LSP warnings and errors")
  (makeKeyMap "object" "D" "<a-;>lsp-diagnostic-object<ret>" "LSP errors")

  # GDB binds
  (makeKeyMap "user" "d" ":enter-user-mode gdb<ret>" "GDB mode")
  (makeKeyMap "gdb" "d" ":enter-user-mode -lock gdb<ret>" "lock GDB mode")
  (makeKeyMap "gdb" "c" ":gdb-session-new " "start a new gdb session")
  (makeKeyMap "gdb" "r" ":rr-session-new<ret>" "start a new rr session")
  (makeKeyMap "gdb" "n" ":gdb-next<ret>" "step over")
  (makeKeyMap "gdb" "e" ":gdb-finish<ret>" "step out")
  (makeKeyMap "gdb" "i" ":gdb-step<ret>" "step in")
  (makeKeyMap "gdb" "j" ":gdb-jump-to-location<ret>" "jump to current program counter")
  (makeKeyMap "gdb" "b" ":gdb-toggle-breakpoint<ret>" "toggle breakpoint at cursor location")
  (makeKeyMap "gdb" "p" ":gdb-print<ret>" "print value of expression in selection")
  (makeKeyMap "gdb" "s" ":gdb-backtrace<ret>" "show backtrace/callstack")

  # System clipboard binds
  (makeKeyMap "user" "y" "<a-|> wl-copy<ret>" "copy selection to system clipboard")
  (makeKeyMap "user" "p" "! wl-paste -n<ret>" "paste from system clipboard")

  # fzf binds
  (makeKeyMap "user" "f" ":require-module fzf; fzf-mode<ret>" "fzf mode")

  # mirror binds
  (makeKeyMap "user" "s" ":enter-user-mode mirror<ret>" "mirror mode")
  (makeKeyMap "user" "S" ":enter-user-mode -lock mirror<ret>" "mirror mode (lock)")

  # TODO: Add keybind for visually wrapping text (addhl buffer/ wrap -word -indent -width 100)

  # harpoon binds
  (makeKeyMap "user" "h" ":enter-user-mode harpoon<ret>" "harpoon mode")
  (makeKeyMap "harpoon" "a" ":harpoon-add<ret>" "add buffer to harpoon list")
  (makeKeyMap "harpoon" "e" ":harpoon-show-list<ret>" "edit the harpoon list")
  (makeKeyMap "normal" "<c-a-n>" ":harpoon-nav 1<ret>" "switch to buffer 1")
  (makeKeyMap "normal" "<c-a-e>" ":harpoon-nav 2<ret>" "switch to buffer 2")
  (makeKeyMap "normal" "<c-a-o>" ":harpoon-nav 3<ret>" "switch to buffer 3")

  # Terminals implementing the kitty keyboard protocol can choose to distinguish between c-[ and esc, so we need to rebind it.
  (makeKeyMap "insert" "<c-[>" "<esc>" "")
  (makeKeyMap "menu" "<c-[>" "<esc>" "")
  (makeKeyMap "prompt" "<c-[>" "<esc>" "")
]

