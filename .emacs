;;
;; Are we running XEmacs or Emacs?
;;
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))


;;
;; The next lines enable UTF-8 charset
;;
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")


;;
;; Look & Feel
;;
(auto-compression-mode t)
(blink-cursor-mode nil)
(setq visible-bell t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq require-final-newline t)
(setq inhibit-startup-message t)
(setq-default kill-whole-line t)
(setq next-line-add-newlines nil)
(setq-default transient-mark-mode t)
(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)
(cond (window-system
	(mwheel-install)
	(cond ((not running-xemacs) (mouse-wheel-mode 1)))
	(set-frame-width (selected-frame) 80)
	(set-frame-height (selected-frame) 25)
	))
(cond ((not running-xemacs) (tool-bar-mode nil)))
(setq frame-title-format
	(list
	(getenv "USER") ":" invocation-name "@" (getenv "HOSTNAME") ":%b")
	)
;(setq display-time-day-and-date t)
;(setq display-time-24hr-format t)
;(setq display-time-mail-file t)
;(display-time)


;;
;; Colors
;;
(cond ((not running-xemacs)
	(global-font-lock-mode t)
	(set-face-background 'fringe "gray")
	(set-face-foreground 'fringe "black")
	))
(font-lock-mode t)
(cond (window-system
	(cond ((not running-xemacs) (set-cursor-color "red")))
	(set-face-background 'default "wheat")
	(set-face-foreground 'default "black")
	))
(setq font-lock-use-colors t)
(setq font-lock-use-fonts nil)
(setq font-lock-use-maximal-decoration t)


;;
;; Development
;;
(setq fill-column 78)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq compilation-scroll-output t)
(setq compilation-window-height 15)
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cj" 'next-error)
(global-set-key "\r"    'newline-and-indent)
(global-set-key "\C-ci" 'c-indent-line-or-region)
(global-set-key "\C-cw" 'delete-trailing-whitespace)
(global-set-key (read-kbd-macro "<delete>") 'delete-char)
(global-set-key "\C-cm" (lambda () (interactive) (manual-entry (current-word))))
(if (featurep 'xemacs)
	(progn
		; XEmacs
		(paren-set-mode 'sexp)
	)
		; GNU Emacs
		(show-paren-mode t)
		(which-function-mode t)
)


;;
;; Force modes based on extension
;;
(setq auto-mode-alist (append
	'(
	("\\.cxx$"  . c++-mode)
	("\\.h$"    . c++-mode)
	("\\.idl$"  . c++-mode)
	) auto-mode-alist))


;;
;; Linux kernel C style
;;
(defconst linux-c-mode
	'(
	(c-mode)
	) "C mode with adjusted defaults for use with the Linux kernel." )
(defun linux-c-mode-hook
	()
	(interactive)
	(c-set-style "K&R")
	(setq tab-width 8)
	(setq indent-tabs-mode t)
	(setq c-basic-offset 8)
	)
(add-hook 'c-mode-hook 'linux-c-mode-hook)
(c-add-style "linux" linux-c-mode)


;;
;; Custom C++ style
;;
(defconst custom-cc-mode
	'(
	(c-set-style "k&r")
	(c-basic-offset			. 4)
	(c-comment-only-line-offset	. 0)
	(c-offsets-alist .
		(
		(arglist-close		. 0)
		(topmost-intro		. 0)
		(topmost-intro-cont	. 0)
		(substatement		. +)
		(substatement-open	. 0)
		)
	)
	) "Custom C++ mode." )
(defun custom-cc-mode-hook
	()
	(c-set-style "custom-cc")
	(setq tab-width	8)
	(setq indent-tabs-mode nil)
	(setq compile-command "make")
	)
(add-hook 'c++-mode-hook 'custom-cc-mode-hook)
(add-hook 'idl-mode-hook 'custom-cc-mode-hook)
(c-add-style "custom-cc" custom-cc-mode)


;;
;; Miscellaneous
;;
(custom-set-variables
	'(load-home-init-file t t)
	)
(custom-set-faces)


;;
;; Redefine the Home/End keys to (nearly) the same as Visual Studio behaviour
;;
(global-set-key [home] 'My-smart-home)
(global-set-key [end]  'My-smart-end)
(defun My-smart-home
	()
	"Odd home to beginning of line, even home to beginning of text/code."
	(interactive)
	(if (and (eq last-command 'My-smart-home)
		(/= (line-beginning-position) (point)))
	(beginning-of-line)
	(beginning-of-line-text))
	)
(defun My-smart-end
	()
	"Odd end to end of line, even end to begin of text/code."
	(interactive)
	(if (and (eq last-command 'My-smart-end)
		(= (line-end-position) (point)))
	(end-of-line-text)
	(end-of-line))
	)
(defun end-of-line-text
	()
	"Move to end of current line and skip comments and trailing space.
	Require `font-lock'."
	(interactive)
	(end-of-line)
	(let ((bol (line-beginning-position)))
		(unless (eq font-lock-comment-face (get-text-property bol 'face))
		(while (and (/= bol (point))
			(eq font-lock-comment-face
			(get-text-property (point) 'face)))
		(backward-char 1))
	(unless (= (point) bol)
		(forward-char 1) (skip-chars-backward " \t\n"))))
	)

;;
;; Switch to next/prev buffer in cyclic order with C-c<right>/C-c<left>
;;
(global-set-key [?\C-c right] 'next-buf)
(global-set-key [?\C-c left]  'prev-buf)
(unless (fboundp 'next-buf)
	(defun next-buf ()
	"Switch to the next buffer in cyclic order."
	(interactive)
	(let ((buffer (current-buffer)))
		(switch-to-buffer (other-buffer buffer))
		(bury-buffer buffer)))
	)
(unless (fboundp 'prev-buf)
	(defun prev-buf ()
	"Switch to the previous buffer in cyclic order."
	(interactive)
	(let ((list (nreverse (buffer-list)))
		found)
		(while (and (not found) list)
		(let ((buffer (car list)))
			(if (and (not (get-buffer-window buffer))
			(not (string-match "\\` " (buffer-name buffer))))
			(setq found buffer)))
		(setq list (cdr list)))
	(switch-to-buffer found)))
	)
