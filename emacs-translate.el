(require 'popup)


(defvar popup nil)

(defun emacs-translate ()
  (interactive)
  (setq popup (popup-create (point) 10 10))
  (popup-set-list popup '("hello" "world"))
  (popup-draw popup)
  (popup-hide popup))


(Message "Welcome! Emacs Translate!")


(provide 'emacs-translate)






