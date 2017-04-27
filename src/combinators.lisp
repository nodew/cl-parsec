(in-package :cl-parsec)

(defun seq (parser-a parser-b)
  (lambda (input)
    (destructuring-bind ((result-a . input-a)) (funcall parser-a input)
      (destructuring-bind ((result-b . input-b)) (funcall parser-b input-a)
        (cons (cons result-a result-b)
              input-b)))))
