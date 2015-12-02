(require 'popup)


                                        ;(defvar popup nil)

(setq process-command "/Users/tyan/.emacs.d/site-lisp/emacs-translate/app")

(defvar process-name "*translate-process*")

(defvar output-buf-name "*translate-output*")

(defun emacs-translate ()
  (interactive)
  (if (use-region-p)
      (let ((content (buffer-substring
                      (region-beginning)
                      (region-end)))
            (outputbuf (get-buffer-create output-buf-name)))
        (progn
          (with-current-buffer outputbuf (erase-buffer))
          (call-process process-command nil output-buf-name nil content)
          (popup-tip (with-current-buffer outputbuf
                       (buffer-string))
                     :margin 3)
          (kill-buffer output-buf)
          (let ((readed-event (read-event)))

            ;;todo
            ;;拦截输入事件 替换文本
            
            ;;(message (type-of readed-event))
            ;; (if (pcase 'return  readed-event)
            ;;     (message "Matched")
            ;;   (push readed-event unread-command-events))
            )
          ))
    (message "Please select a region!")))



(message "Welcome! Emacs Translate!")


;; (defun delete-translate-popup ()
;;   (interactive)
;;   (when popup
;;     (popup-delete popup)
;;     (setq popup nil)))



(provide 'emacs-translate)




