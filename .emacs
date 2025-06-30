(setq custom-file "~/.emacs.custom.el")
(add-to-list 'default-frame-alist `(font . "Iosevka-20"))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode)

(ido-mode 1)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(setq display-line-numbers-type 'relative)

(load-theme 'zenburn t)

(require 'magit)
(keymap-global-set "C-c a" #'magit-status)

(c-mode)

(defun counsel-git-grep-at-point()
 (interactive)
 (let ((term (thing-at-point 'symbol t))) (counsel-git-grep term)))

(ivy-mode)
(keymap-global-set "M-x" #'counsel-M-x)
(keymap-global-set "C-c g" #'counsel-git-grep)
(keymap-global-set "C-c f" #'counsel-git)
(keymap-global-set "C-c c" #'counsel-compile)
(keymap-global-set "C-c r" #'counsel-git-grep-at-point)
(keymap-global-set "C-s" #'swiper-isearch)
(keymap-global-set "C-x C-f" #'counsel-find-file)
(setq counsel-find-file-ignore-regexp
      (regexp-opt '("#" "~")))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(require 'clang-format)
(setq clang-format-style 'file)
(add-hook 'c-mode-hook #'clang-format-on-save-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-c m") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(global-set-key (kbd "C-0")         'beginning-of-buffer)
(global-set-key (kbd "C-1")         'end-of-buffer)
