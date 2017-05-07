(in-package :cl-parsec)

(defun satisfy (test)
  (>>= #'item #'(lambda (c)
                  (if (funcall test c)
                      (unit c)
                      (unit "")))))

(defun is-digit (c)
  (let ((i (char-int c)))
    (and (>= i 48)
         (<= i 57))))

(defun is-space (c)
  (member c '(#\space #\return #\linefeed #\tab)))

(defmacro def/satisfy (name args &body body)
  `(defun ,name ,args
     (satisfy #'(lambda (c)
                  ,@body))))

(def/satisfy ?char (c1)
  (char= c c1))

(def/satisfy ?one-of (lst)
  (member c lst))

(def/satisfy ?none-of (lst)
  (not (member c lst)))

(def/satisfy ?any-char ()
  (declare (ignore c))
  t)

(def/satisfy ?digit ()
  (is-digit c))

(def/satisfy ?space ()
  (char= #\space c))
