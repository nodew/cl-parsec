(in-package :cl-parsec)

;; Parser a = Parser { String -> [(a, State)]}

(defun unit (a)
  "unit :: a -> Parser a"
  #'(lambda (s)
    (values a s)))

(defun zero ()
  (constantly nil))

(defun item (s)
  "item :: String -> (Char, State)"
  (let ((c (get-current-char s))
        (cs (get-next-state s)))
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
      (multiple-value-bind (v rest) (parse p s)
        (if (null v)
            (values '() s)
            (multiple-value-bind (v1 rest1) (parse (many p) rest)
              (values (cons v v1) rest1))))))

(defun skip-many (p)
  #'(lambda (s)
    (multiple-value-bind (v rest) (parse (many p) s)
      (declare (ignore v))
      (values nil rest))))

(defun many-till (p end)
  #'(lambda (s)
      (multiple-value-bind (v rest) (parse end s)
        (declare (ignore rest))
        (if v
            (values '() s)
            (multiple-value-bind (v1 rest1) (parse p s)
              (if v1
                  (multiple-value-bind (v2 rest2) (parse (many-till p end) rest1)
                    (values (cons v1 v2) rest2))
                  (error 'many-unconsumed)))))))
