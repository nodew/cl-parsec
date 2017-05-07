(in-package :cl-parsec)

(defun parse (parser input)
  "Parser a -> (a, string)"
  (funcall parser input))
