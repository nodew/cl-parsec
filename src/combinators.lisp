(in-package :cl-parsec)

;; Parser a = Parser { String -> [(a, String)]
;; (defun parser (a)
;;   (lambda (string)
;;     ...
;;     '(a, string)))


(defun unit (a)
  "unit :: a -> Parser a"
  (lambda (str)
    (list (cons a str))))

(defun item ()
  (lambda (str)
    (let ((c (aref str 0))
          (cs (subseq str 1)))
      (list (cons c cs)))))


(defun bind (p f)
  (lambda (str)
    (destructuring-bind
        ((a . rest))
        (parse p str)
      (let ((p2 (f a)))
        '(,p2 ,rest)))))
