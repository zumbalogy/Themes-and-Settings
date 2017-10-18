(setq load-path (cons "~/emacs" load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun save-all ()
  (interactive)
  (when (buffer-modified-p)
    (save-some-buffers t)))

(add-hook 'focus-out-hook 'save-all)
;; (add-hook 'kill-buffer-query-functions 'save-all) ; this seems to prevent killing
;; unless there are changes, or something like that.

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; TODO: make it so it does not kill whitespace on current line
;; (unless closing buffer/file, i guess)
;; also make it kill the buffer for real (and save) when i say kill the buffer

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-command-error-function (data context caller)
  "Ignore the buffer-read-only signal; pass the rest to the default handler."
   (when (not (eq (car data) 'text-read-only))
     (command-error-default-function data context caller)))


(setq command-error-function #'my-command-error-function)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq column-number-mode t)

(setq-default cursor-type 'bar)

(set-face-attribute 'default nil :height 130)

(setq-default indent-tabs-mode nil)

;; (show-paren-mode 1) 'package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(when (>= emacs-major-version 24)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(load-theme 'atom-one-dark t)

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t)   ; if nil, bold is universally disabled
(setq doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; Enable custom neotree theme
;;(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
;;(setq doom-neotree-enable-file-icons nil)
;;(setq doom-neotree-enable-folder-icons nil)
;;(setq doom-neotree-enable-chevron-icons nil)
;;(setq doom-neotree-file-icons nil)

;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
   (interactive)
   ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))

(add-hook 'auto-save-hook 'my-desktop-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'minibuffer-line)

;; ;; (setq minibuffer-line-format '((:eval
;; ;; 				(let ((time-string (format-time-string "%l:%M %b %d %a"))
;; ;; 				      (let ((end-string (concat time-string)))
;; ;; 					(let ((padding (make-string (- (frame-text-cols) (string-width end-string) ?))))
;; ;;                                    (concat padding end-string))))))))


;; (defun strip-text-properties (txt)
;;   (set-text-properties 0 (length txt) nil txt)
;;   txt)

;; (setq minibuffer-line-format
;;       '((:eval
;; 	 (let ((time-string (format-time-string "%s"))
;; 	       (mode-string (format-mode-line mode-line-format)))
;; 	   (let ((end-string (concat time-string mode-string)))
;; 	     (let ((padding (make-string (- (frame-text-cols) (string-width end-string)) ? )))
;; 	       (concat padding end-string)))))))


;; (minibuffer-line-mode)

;; TODO: put mode line stuff in the echo area maybe, and hide mode line.
;; (make sure to still indicate active buffer somehow)
;; maybe scoll bars and just the line number would save space at the bottom mode line


;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: comment and uncomment block/s-exp via control slash.
;; autosave before quit
;; also, copy, paste, undo, redo, move line up/down one, select all
;; equvalent of atom control shift, insert new line below current one and put cursor on it. dont break current line
;; control-d (or such) to select current word/thing and
;;     control-d while something is selected to also select next occcurence, w/ mutli cursor
;; multiple cursors
;; cider
;; autocomplete/tab-complete in editor?
;; better scrolling (smooth scrolling didnt work)
;; repl/terminal/etc in emacs
;; scroll up for history (in repl, in echo area maybe, etc)
;; send to terminal?
;; learn org mode
;; better orginize .emacs
;; emacs git integration (git porcelin?)
;;   atom shows what lines are uncommited in git, which is maybe useful. maybe i could toggle to show dif or something
;; better git repo support for emacs configs
;;   (.emacs should just link to ~/emacs/ and ~/emacs/.emacs and ~/emacs/ should be git repo, im guessing)
;; learn/get better find and find/replace (find in folder/repo/etc) (dired? helm?)
;; learn/get better file/project navigation (neotree?) (control-k in atom?)
;; fuzzy find stuff (helm?)
;; better toggle though buffers and frames. (but mostly frames)
;; tweak timeouts on echo area messages and all that
;; filter some messages (or tweak them) that go in echo area
;;    (https://www.emacswiki.org/emacs/EchoArea)


;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; variable for the timer object
;; (defvar idle-timer-cookbook-timer 1xxzx)

;; ;; callback function
;; (defun idle-timer-cookbook-callback ()
;;   (message "I have been called (%s)" (current-time-string)))

;; ;; start functions
;; (defun idle-timer-cookbook-run-once ()
;;   (interactive)
;;   (when (timerp idle-timer-cookbook-timer)
;;     (cancel-timer idle-timer-cookbook-timer))
;;   (setq idle-timer-cookbook-timer
;;           (run-with-idle-timer 1 nil #'idle-timer-cookbook-callback)))

;; (defun idle-timer-cookbook-start ()
;;   (interactive)
;;   (when (timerp idle-timer-cookbook-timer)
;;     (cancel-timer idle-timer-cookbook-timer))
;;   (setq idle-timer-cookbook-timer
;;           (run-with-timer 1 1 #'idle-timer-cookbook-callback)))

;; ;; stop function
;; (defun idle-timer-cookbook-stop ()
;;   (interactive)
;;   (when (timerp idle-timer-cookbook-timer)
;;     (cancel-timer idle-timer-cookbook-timer))
;;   (setq idle-timer-cookbook-timer nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'symon)

(defvar my-mode-line-format
  '("%e"
    mode-line-front-space
    mode-line-mule-info
    mode-line-client
    mode-line-modified
    mode-line-remote
    mode-line-frame-identification
    mode-line-buffer-identification
    mode-line-position
    (vc-mode vc-mode)
    mode-line-modes
    mode-line-misc-info
    mode-line-end-spaces))

(define-symon-monitor symon-mode-line
  :display (propertize (format-mode-line my-mode-line-format)))

(setq symon-delay 0)
(setq symon-history-size 10)

(setq symon-monitors '(symon-mode-line))

(setq-default mode-line-format nil)

(symon-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-current-buffer " *Echo Area 0*" (face-remap-add-relative 'default :background "#222"))
(with-current-buffer " *Echo Area 1*" (face-remap-add-relative 'default :background "#222"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fringe-mode 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: look into window-divider-mode
;; https://emacs.stackexchange.com/questions/29873/whats-this-line-between-the-modeline-and-the-echo-area
