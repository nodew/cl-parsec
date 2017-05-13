(in-package :cl-parsec)

(defun satisfy (test)
  "satisfy :: (Char -> Bool) -> Parser a"
  (>>= #'item #'(lambda (c)
                  (if (null (funcall test c))
                      (zero)
                      (unit c)))))

(defmacro def/satisfy (name args &body body)
  `(defun ,name ,args
     (satisfy #'(lambda (c)
                  ,@body))))

(def/satisfy ch (c1)
  (char= c c1))

(def/satisfy one-of (lst)
  (member c lst))

(def/satisfy none-of (lst)
  (not (member c lst)))

(def/satisfy any-char ()
  (declare (ignore c))
  t)

(defun tab ()
  (ch #\Tab))

(defun newline ()
  (ch #\Newline))

(def/satisfy digit ()
  "satisfy 0-9"
  (char-digit-p c))

(def/satisfy oct-digit ()
  "satisfy 0-7"
  (char-oct-digit-p c))

(def/satisfy hex-digit ()
  "satisfy 0-9, a-f, A-F"
  (char-hex-digit-p c))

(def/satisfy ?space ()
  (char-space-p c))

(def/satisfy letter ()
  (char-alpha-p c))

(def/satisfy upper-case ()
  (char-upper-p c))

(def/satisfy lower-case ()
  (char-lower-p c))

(defun spaces ()
  (skip-many (?space)))
