(in-package :cl-parsec)

(defmethod get-first ((l list))
  (car l))

(defmethod get-first ((s string))
  (aref s 0))

(defmethod get-rest ((l list))
  (cdr l))

(defmethod get-rest ((s string))
  (subseq s 1))

(defun parse (parser input)
  "Parser a -> (a, string)"
  (funcall parser input))
