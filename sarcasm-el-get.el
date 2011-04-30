;; el-get packages and config -- Guillaume Papin
;; usage:
;; (require 'sarcasm-el-get)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get/"))
(require 'el-get)

(add-to-list 'el-get-recipe-path
             (concat (file-name-as-directory sarcasm-load-path)
                     "sarcasm-recipes"))

(setq el-get-sources
      '(el-get
        magit               ;control git from Emacs
        xcscope xcscope+    ;CScope stuff
        rainbow-mode        ;display string color colored
        lua-mode            ;Lua-Mode in Emacs 24 is too old
        flymake-lua         ;flymake for Lua
        htmlize             ;for Org-Mode HTML export of source code
        folding             ;folding plugin
        rinari              ;Rinari Is Not A Ruby IDE
        haml-mode           ;Alternative to ERB
        sass-mode           ;Alternative to CSS
        yaml-mode           ;YAML Ain't Markup Language

        (:name autopair
               :after (lambda ()
                        (autopair-global-mode 1)
                        )
               )

        ;; Ruby/HTML files
        (:name rhtml-mode
               :after (lambda ()
                        (rinari-launch)
                        )
               )

        ;; M-x with IDO
        (:name smex
               :after (lambda ()
                        (global-set-key (kbd "M-x") 'smex)
                        (global-set-key (kbd "M-X") 'smex-major-mode-commands)
                        ;; This is your old M-x.
                        (global-set-key (kbd "C-c M-x") 'execute-extended-command)
                        )
               )

        (:name iedit
               :after (lambda ()
                        (global-set-key (kbd "C-;") 'iedit-mode)
                        (define-key isearch-mode-map (kbd "C-;") 'iedit-mode)
                        (setq iedit-occurrence-face isearch-face)
                        )
               )

        (:name zencoding-mode
               ;; https://github.com/rooney/zencoding
               ;; http://www.emacswiki.org/emacs/ZenCoding
               :after (lambda ()
                        (add-hook 'sgml-mode-hook 'zencoding-mode) ;auto-start on any markup modes
                        ))

        (:name offlineimap              ;OfflineIMAP inside Emacs
               :after (add-hook 'gnus-before-startup-hook 'offlineimap)
               )

        ;; Move buffer with C-S-<arrow key>
        (:name buffer-move
               :features buffer-move
               :after (lambda ()
                        (global-set-key (kbd "<C-S-up>")     'buf-move-up)
                        (global-set-key (kbd "<C-S-down>")   'buf-move-down)
                        (global-set-key (kbd "<C-S-left>")   'buf-move-left)
                        (global-set-key (kbd "<C-S-right>")  'buf-move-right)
                        )
               )

        (:name switch-window
               ;; re-define `C-x o' to `switch-window' because
               ;; it doesn't work the first time...
               :after (lambda ()
                        (global-set-key (kbd "C-x o") 'switch-window)
                        )
               )

        (:name yasnippet
               :type svn
               :url "http://yasnippet.googlecode.com/svn/trunk/"
               ;; El-get default rule compile *.el, but with
               ;; yasnippet-debug.el it failed. In the Rakefile the
               ;; correct task seems to be 'rake compile'
               :build ("rake compile")
               :features yasnippet
               ;; :post-init (lambda ()
               :after (lambda ()
                        ;; from here: https://github.com/blastura/dot-emacs/blob/master/init.el
                        ;; (add-hook 'yas/after-exit-snippet-hook
                        ;;           '(lambda ()
                        ;;              (indent-region yas/snippet-beg
                        ;;                             yas/snippet-end)))

                        ;; After el-get/yasnippet, personal snippets takes priority
                        (setq yas/snippet-dirs (cons (concat el-get-dir "yasnippet/snippets")
                                                     '("~/.emacs.d/snippets")))

                        ;; Map `yas/load-directory' to every element
                        (mapc 'yas/load-directory yas/snippet-dirs)

                        ;; Fix the promp on X, the default was ugly.
                        (require 'dropdown-list)
                        (setq yas/prompt-functions '(yas/dropdown-prompt
                                                     yas/ido-prompt
                                                     yas/completing-prompt
                                                     yas/no-prompt))
                        ))

        (:name autocomplete
               :type git
               :url "http://github.com/m2ym/auto-complete.git"
               :load-path "."
               :post-init (lambda ()
                            (require 'auto-complete)
                            (add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
                            (require 'auto-complete-config)
                            (ac-config-default)
                            ;; Too many words in buffers...
                            ;; (setq-default ac-sources
                            ;;               (remq 'ac-source-words-in-same-mode-buffers ac-sources)

                            ;; Enable auto-completion with tab in Org-Mode
                            ;; http://permalink.gmane.org/gmane.emacs.orgmode/37064
                            (define-key ac-complete-mode-map [tab] 'ac-expand)
                            )
               )

        (:name auto-complete-extension
               :type emacswiki)

        (:name auto-complete-clang
               :type git
               :url "https://github.com/brianjcj/auto-complete-clang.git"
               :features auto-complete-clang)
        ))

;; Initialize el-get packages
(el-get)

;; "Addons" to the YASnippet config and auto-complete

;; Function found here: http://www.emacswiki.org/emacs/tagging.el
(defun convert-mode-name-to-hook (mode-name)
  "Converts a mode name into the symbol for its hook"
  (intern (concat (symbol-name mode-name) "-hook")))

;; Enable yasnippet mode and auto-complete on few programming modes
(defun sarcasm-enable-ac-and-yas ()
  "Enable `auto-complete' and `yasnippet'. Also add snippet names
in auto-complete sources."
  (yas/minor-mode-on)
  (auto-complete-mode)
  (setq ac-sources (append ac-sources '(ac-source-yasnippet)))
  ;; This is certainly not the good place for that...but for the
  ;; moment it's ok
  (setq show-trailing-whitespace t)
  )

(mapc (lambda (mode)
        (add-hook (convert-mode-name-to-hook mode) 'sarcasm-enable-ac-and-yas))
      '(c-mode c++-mode emacs-lisp-mode lisp-mode lua-mode
               sh-mode org-mode perl-mode css-mode html-mode
               nxml-mode python-mode ruby-mode snippet-mode))

(provide 'sarcasm-el-get)
