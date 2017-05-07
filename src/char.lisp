(in-package :cl-parsec)

(defun char ()
  (satisfy ('=char)))

(defun satisfy (test)
  (lambda (input)
    (let ((c (first-input input)))
      (if (test c)
          (rest-input input)))))
