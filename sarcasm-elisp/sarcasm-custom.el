;; Custom settings -- Guillaume Papin
;; usage:
;;
;;     (setq custom-file (concat *sarcasm-directory*
;;                               "sarcasm-custom.el"))
;;     (load custom-file)
;;
;; Note: This file shouldn't be tracked for changes, changes made to
;; safe-variables and co isn't interesting to be committed. To ignore local
;; changes to the file the following command can be entered:
;;
;;      git update-index --assume-unchanged sarcasm-elisp/sarcasm-custom.el
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "firebrick" "lime green" "yellow2" "DodgerBlue2" "deep pink" "cornflower blue" "white"])
 '(c-doc-comment-style (quote ((java-mode . javadoc) (pike-mode . autodoc))))
 '(garak-alert-methods (quote (:notify))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo-common ((t (:underline t))))
 '(company-preview ((t (:inherit shadow))))
 '(company-preview-common ((t (:inherit company-preview :underline t))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "SteelBlue3"))))
 '(company-scrollbar-fg ((t (:background "DeepSkyBlue4"))))
 '(company-template-field ((t (:background "DeepSkyBlue3" :foreground "black"))))
 '(company-tooltip ((t (:background "LightSteelBlue1" :foreground "dark slate gray"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "slate gray"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :underline t))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :underline t))))
 '(company-tooltip-mouse ((t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "LightSteelBlue3"))))
 '(magit-diff-del ((t (:inherit diff-removed :background "gray20" :foreground "red3"))) t))

