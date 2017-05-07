(in-package :cl-parsec)

;; Parser a = Parser { String -> [(a, String)]
;; (defun parser (a)
;;   (lambda (string)
;;     ...
;;     (a string)))


(defun unit (a)
  "unit :: a -> Parser a"
  #'(lambda (s)
    (values a s)))

(defun item (s)
  "item :: String -> (Char, String)"
  (let ((c (get-first s))
        (cs (get-rest s)))
    (values c cs)))


(defun bind (p f)
  "bind :: Parser a -> (a -> Parser b) -> Parser b"
  #'(lambda (s)
    (multiple-value-bind (a rest) (parse p s)
      (multiple-value-bind (a1 rest1) (parse (funcall f a) rest)
        (values a1 rest1)))))

(defun >>= (p f)
  "alias for bind"
  (bind p f))

(defun >> (pa pb)
  ">> :: Parser a -> Parser b -> Parser b"
  #'(lambda (s)
    (parse (bind pa #'(lambda (_)
                        (declare (ignore _))
                        pb))
           s)))


(defmacro mdo (binds &body body)
  "(>= ma (lambda (a)
             (>= mb (lambda (b)
                       (...)))))"
  (if (null binds)
      `(funcall #'(lambda () ,@body))
      (let* ((bind (car binds))
             (rest (cdr binds))
             (var (car bind))
             (m (cadr bind)))
        (format t "~a ~a ~a" m var bind)
        (if (eql var '_)
            `(>> ,m (mdo ,rest ,@body))
            `(>>= ,m #'(lambda (,var)
                         (mdo ,rest ,@body)))))))
