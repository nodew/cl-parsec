(in-package :cl-parsec)

(defmacro def/parser (name args &body body)
  "Parser a :: state -> (a, nextState)"
  `(defun ,name ,args
      #'(lambda () ,body)))

(defun parse (parser state)
  "parse :: Parser a -> state -> (a, nextState)"
  (funcall parser state))

(defun run-parser (parser s)
  (let ((state (initial-parse-state s)))
    (handler-case
        (parse parser state)
      ())))
