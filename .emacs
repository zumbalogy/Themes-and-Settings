(defun save-all ()
  (interactive)
  (when (buffer-modified-p)
    (save-some-buffers t)))

(add-hook 'focus-out-hook 'save-all)
(add-hook 'kill-buffer-query-functions 'save-all)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

