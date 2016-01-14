;; Editors
; file
(setq make-backup-files nil)  ; no backup
(setq auto-save-default nil)  ; no auto-save
(setq vc-follow-symlinks t)  ; auto follow symbolic links

; file content
(setq-default indent-tabs-mode nil)  ; disable tab
(electric-pair-mode 1)  ; pairing brackets
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

; line number
(global-linum-mode t)  ; show line number
(setq linum-format "%4d ")
(set-face-background 'linum "black")
(set-face-foreground 'linum "#3F3F3F")
(setq frame-background-mode 'dark)


;; company
(setq company-idle-delay 0)  ; autocomplete delay
(setq company-minimum-prefix-length 2)

;; pbcopy
(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(global-set-key (kbd "C-c c") 'pbcopy)
(global-set-key (kbd "C-c v") 'pbpaste)
(global-set-key (kbd "C-c x") 'pbcut)

;; el-get
; el-get is smooth is osx
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

; auto installing pacakge, sometimes sudo required
(el-get-install 'markdown-mode)
(el-get-install 'web-mode)
(el-get-install 'company-mode)  ; replace auto-complete
(el-get-install 'anaconda-mode)
(el-get-install 'company-anaconda)
(el-get-install 'multiple-cursors)
(el-get-install 'smex)
(el-get-install 'expand-region)
(el-get-install 'helm)
(el-get-install 'haskell-mode)
(el-get-install 'neotree)
(el-get-install 'js2-mode)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'python-mode-hook 'anaconda-mode
  (lambda ()
    (setq-local company-backends '((company-anaconda)))))

(with-eval-after-load 'company  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; jedi:setup, replaced by anaconda-mode
; (add-hook 'python-mode-hook 'jedi:setup)
; (setq jedi:complete-on-dot t)
; (setq jedi:get-in-function-call-delay 10)

(when (eq system-type 'darwin) ;; mac specific settings

)

;; Keybindings
; move cursor multiple lines
(global-set-key (kbd "M-n")
  (lambda () (interactive) (next-line 7)))
(global-set-key (kbd "M-p")
  (lambda () (interactive) (previous-line 7)))
(global-set-key (kbd "C-m") 'newline-and-indent)  ; indentation

(global-set-key (kbd "C-M-l") 'mc/edit-lines)  ; C-S combo does not work in osx

;; smex
(global-set-key (kbd "M-x") 'smex)  ; $ chmod 777 ~/.emacs.d/smex-items
(global-set-key (kbd "M-X") 'smex-major-mode-commands) ; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; org-mode
; for *.org
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))  ; new line

;; helm
(require 'helm-config)
(global-set-key (kbd "M-h") 'helm-M-x)  ; upper case

;; neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(put 'upcase-region 'disabled nil)  ; C-x C-u


;; expand-region
(require 'expand-region)
(global-set-key (kbd "M-+") 'er/expand-region)
(global-set-key (kbd "M-_") 'er/contract-region)
