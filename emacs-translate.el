(require 'popup)

(defvar process-command
  (expand-file-name "site-lisp/emacs-translate/app" user-emacs-directory))


(defvar process-name "*translate-process*")

(defvar output-buf-name "*translate-output*")

(setq emacs-translate-register nil)

(defun baidu-translate ()
  (interactive)
  (if (use-region-p)
      (let ((content (buffer-substring
                      (region-beginning)
                      (region-end)))
            (outputbuf (get-buffer-create output-buf-name)))
        (progn
          (with-current-buffer outputbuf (erase-buffer))
          (call-process process-command nil output-buf-name nil content)
          (setq emacs-translate-register (with-current-buffer outputbuf
                                           (buffer-string)))
          (popup-tip (with-current-buffer outputbuf
                       (buffer-string))
                     :margin 3)
          (kill-buffer output-buf)
          
          ;; (let ((readed-event (read-event)))
          ;;   ;; TODO
          ;;   ;;拦截输入事件 替换文本
          ;;   ;;(message (type-of readed-event))
          ;;   ;; (if (pcase 'return  readed-event)
          ;;   ;;     (message "Matched")
          ;;   ;;   (push readed-event unread-command-events))
          ;;   )
          ))
    (message "Please select a region!")))


(defun baidu-translate-command (text)
  (interactive (list (read-shell-command
                      "Please input: ")))
  (let ((outputbuf (get-buffer-create output-buf-name)))
    (progn
      (with-current-buffer outputbuf (erase-buffer))
      (call-process process-command nil output-buf-name nil text)
      (setq emacs-translate-register (with-current-buffer outputbuf
                                       (buffer-string)))
      (popup-tip (with-current-buffer outputbuf
                   (buffer-string))
                 :margin 3)
      (kill-buffer output-buf)
      ))
  )

(defun yank-translate-result ()
  (interactive)
  (if emacs-translate-register
      (insert emacs-translate-register)
    (message "Have not translation result.")))


(message "Welcome! Emacs Translate!")

;; (defun delete-translate-popup ()
;;   (interactive)
;;   (when popup
;;     (popup-delete popup)
;;     (setq popup nil)))




(provide 'emacs-translate)




