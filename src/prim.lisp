(in-package :cl-parsec)

(defun parse (parser state)
  "parse :: Parser a -> state -> (a, nextState)"
  (funcall parser state))

(defun run-parser (parser s)
  (let ((state (initial-parse-state s)))
    (handler-case
        (parse parser state)
      (parsec-error () '()))))
