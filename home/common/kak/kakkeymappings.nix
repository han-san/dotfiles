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
  (makeKeyMap "normal" "m" "h" null)
  (makeKeyMap "normal" "n" "j" null)
  (makeKeyMap "normal" "e" "k" null)
  (makeKeyMap "normal" "i" "l" null)
  (makeKeyMap "normal" "k" "n" null)
  (makeKeyMap "normal" "h" "m" null)
  (makeKeyMap "normal" "l" "u" null)
  (makeKeyMap "normal" "j" "e" null)
  (makeKeyMap "normal" "u" "i" null)
  (makeKeyMap "normal" "M" "H" null)
  (makeKeyMap "normal" "N" "J" null)
  (makeKeyMap "normal" "E" "K" null)
  (makeKeyMap "normal" "I" "L" null)
  (makeKeyMap "normal" "K" "N" null)
  (makeKeyMap "normal" "H" "M" null)
  (makeKeyMap "normal" "L" "U" null)
  (makeKeyMap "normal" "J" "E" null)
  (makeKeyMap "normal" "U" "I" null)
  (makeKeyMap "normal" "<a-m>" "<a-h>" null)
  (makeKeyMap "normal" "<a-n>" "<a-j>" null)
  (makeKeyMap "normal" "<a-e>" "<a-k>" null)
  (makeKeyMap "normal" "<a-i>" "<a-l>" null)
  (makeKeyMap "normal" "<a-k>" "<a-n>" null)
  (makeKeyMap "normal" "<a-h>" "<a-m>" null)
  (makeKeyMap "normal" "<a-l>" "<a-u>" null)
  (makeKeyMap "normal" "<a-j>" "<a-e>" null)
  (makeKeyMap "normal" "<a-u>" "<a-i>" null)
  (makeKeyMap "normal" "<a-M>" "<a-H>" null)
  (makeKeyMap "normal" "<a-N>" "<a-J>" null)
  (makeKeyMap "normal" "<a-E>" "<a-K>" null)
  (makeKeyMap "normal" "<a-I>" "<a-L>" null)
  (makeKeyMap "normal" "<a-K>" "<a-N>" null)
  (makeKeyMap "normal" "<a-H>" "<a-M>" null)
  (makeKeyMap "normal" "<a-L>" "<a-U>" null)
  (makeKeyMap "normal" "<a-J>" "<a-E>" null)
  (makeKeyMap "normal" "<a-U>" "<a-I>" null)
  (makeKeyMap "normal" "<c-n>" "<c-j>" null) # c-n is unbound, c-j is move forward in changes history.
  (makeKeyMap "normal" "<c-e>" "<c-k>" null) # c-e is unbound, c-k is move backward in changes history.
  (makeKeyMap "normal" "<c-k>" "<c-n>" null) # c-k is move backward in changes history(x), c-n is unbound.
  (makeKeyMap "normal" "<c-j>" "<c-e>" null) # c-j is move forward in changes history(x), c-e is unbound.
  (makeKeyMap "normal" "<c-a-m>" "<c-a-h>" null)
  (makeKeyMap "normal" "<c-a-n>" "<c-a-j>" null)
  (makeKeyMap "normal" "<c-a-e>" "<c-a-k>" null)
  (makeKeyMap "normal" "<c-a-i>" "<c-a-l>" null)
  (makeKeyMap "normal" "<c-a-k>" "<c-a-n>" null)
  (makeKeyMap "normal" "<c-a-h>" "<c-a-m>" null)
  (makeKeyMap "normal" "<c-a-l>" "<c-a-u>" null)
  (makeKeyMap "normal" "<c-a-j>" "<c-a-e>" null)
  (makeKeyMap "normal" "<c-a-u>" "<c-a-i>" null)
  (makeKeyMap "normal" "<c-a-M>" "<c-a-H>" null)
  (makeKeyMap "normal" "<c-a-N>" "<c-a-J>" null)
  (makeKeyMap "normal" "<c-a-E>" "<c-a-K>" null)
  (makeKeyMap "normal" "<c-a-I>" "<c-a-L>" null)
  (makeKeyMap "normal" "<c-a-K>" "<c-a-N>" null)
  (makeKeyMap "normal" "<c-a-H>" "<c-a-M>" null)
  (makeKeyMap "normal" "<c-a-L>" "<c-a-U>" null)
  (makeKeyMap "normal" "<c-a-J>" "<c-a-E>" null)
  (makeKeyMap "normal" "<c-a-U>" "<c-a-I>" null)
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
  (makeKeyMap "goto" "n" "j" "buffer bottom")
  (makeKeyMap "goto" "e" "k" "buffer top")
  (makeKeyMap "goto" "i" "l" "line end")
  (makeKeyMap "goto" "m" "i" "line begin")
  (makeKeyMap "goto" "j" "e" "buffer end")
  (makeKeyMap "goto" "u" "i" "line non-blank start")
  (makeKeyMap "view" "n" "j" "scroll down")
  (makeKeyMap "view" "e" "k" "scroll up")
  (makeKeyMap "view" "i" "l" "scroll right")
  (makeKeyMap "user" "w" ":w<ret>" "save buffer")
  (makeKeyMap "user" "b" ":b " "switch buffer")
  (makeKeyMap "user" "m" ":make<ret>" "make")
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

