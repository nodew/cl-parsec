(in-package :cl-parsec)

(defun make-empty-string ()
  (make-array 0 :element-type 'character
                :adjustable t
                :fill-pointer 0
                :initial-contents ""))

(defun make-string-from-list (lst)
  (make-array (length lst) :element-type 'character
                           :initial-contents lst))
