(in-package :cl-parsec)

;; Parser a = Parser { String -> [(a, String)]

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
                       (...)))))
   which look like
   (mdo (bind-value monad-a)
        (_ monad-b))
     (...)"
  (if (null binds)
      `(unit (progn ,@body))
      (let* ((bind (car binds))
             (rest (cdr binds))
             (var (car bind))
             (m (cadr bind)))
        (if (eql var '_)
            `(>> ,m (mdo ,rest ,@body))
            `(>>= ,m #'(lambda (,var)
                         (mdo ,rest ,@body)))))))

(defun many (p)
  "many :: Parser a -> Parser [a]"
  #'(lambda (s)
      (catch 'end
        (multiple-value-bind (v rest) (parse p s)
          (if (null v)
              (throw 'end (values nil s))
              (multiple-value-bind (v1 rest1) (parse (many p) rest)
                (values (cons v1 v) rest1)))))))

(defun skip-many (p)
  (lambda (s)
    (multiple-value-bind (v rest) (parse p s)
      (declare (ignore v))
      rest)))
