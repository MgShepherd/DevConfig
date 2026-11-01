;; -*- lexical-binding: t; -*-

;; Change the directory of the custom file so changes don't fill this file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Basic emacs settings
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil :font "Jetbrains Mono" :height 160)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Setup package manager
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; evil mode (VIM style keybindings)
(setq evil-want-keybinding nil)
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

;; theme
(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi-tinted :no-confirm-loading))

;; better icons
(use-package nerd-icons :ensure t)
(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; vertico for minibuffer completions
(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)))

;; marginalia for better descriptions in the minibuffer
(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

;; orderless for better searching in buffers
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

;; corfu for inline buffer completions
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :bind (:map corfu-map
              ("C-n" . corfu-next)
              ("C-p" . corfu-previous)))

;; lsp (eglot)
(use-package go-mode
  :ensure t)

(use-package eglot
  :hook ((c-mode go-mode) . eglot-ensure))

;; show documentation for item at point
(defun my/eldoc-snapshot ()
  "Show a static copy of the current ElDoc documentation."
  (let ((source (eldoc-doc-buffer))
        (buf (get-buffer-create "*eldoc snapshot*")))
    (with-current-buffer buf
      (special-mode)
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert-buffer-substring source)
        (goto-char (point-min))))
    (display-buffer buf)))

(defun my/lookup-doc ()
  "Show documentation for the thing at point."
  (interactive)
  (cond
   ;; C, Go, etc. via the language server
   ((and (fboundp 'eglot-managed-p) (eglot-managed-p))
    (my/eldoc-snapshot))
   ;; Elisp: use Emacs's built-in help
   ((derived-mode-p 'emacs-lisp-mode 'lisp-interaction-mode)
    (if-let* ((sym (symbol-at-point)))
        (describe-symbol sym)
      (user-error "No symbol at point")))
   ;; Everything else: man pages
   (t (call-interactively #'man))))

(defun my/doc-window ()
  "Return a visible window showing a documentation buffer, or nil."
  (seq-find
   (lambda (win)
     (with-current-buffer (window-buffer win)
       (or (derived-mode-p 'help-mode 'Man-mode)
           (string-match-p "\\*eldoc" (buffer-name)))))
   (window-list)))

(defun my/lookup-doc-toggle ()
  "Close the documentation window if visible, otherwise show docs at point."
  (interactive)
  (if-let* ((win (my/doc-window)))
      (quit-window nil win)
    (my/lookup-doc)))

;; format on save
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)))

;; consult for better project navigation
(use-package consult
  :ensure t
  :bind (("C-x b"   . consult-buffer)
         ("C-x p b" . consult-project-buffer)
         ("C-x p g" . consult-ripgrep)
         ("M-s l"   . consult-line)
         ("M-g i"   . consult-imenu)
         ("M-g g"   . consult-goto-line))
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(defun my/show-line-diagnostics ()
  "Show Flymake diagnostics for the current line."
  (interactive)
  (if-let* ((diags (flymake-diagnostics (line-beginning-position)
                                        (line-end-position))))
      (message "%s" (mapconcat #'flymake-diagnostic-text diags "\n"))
    (message "No diagnostics on this line")))

;; magit for git management
(use-package magit
  :ensure t)

;; general for keybinds
(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")

  (general-define-key
 :states '(normal motion)
 :keymaps 'override
 "K" #'my/lookup-doc-toggle)

  (my/leader
    "ff" #'project-find-file
    "fs" #'consult-ripgrep
    "d" #'my/show-line-diagnostics
    "e" #'find-file
    "b" #'consult-buffer
    "g" #'magit-status))

;; compile for better compilation buffer output
(use-package compile
  :ensure nil
  :hook (compilation-filter . ansi-color-compilation-filter)
  :custom
  (compilation-scroll-output t))

;; Add local MGS mode to path (will not work for other machines)
(add-to-list 'load-path (expand-file-name "~/Documents/Language/mgs-mode"))
(require 'mgs-mode)
