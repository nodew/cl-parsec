(in-package :cl-parsec)

(define-condition parsec-error (error)
  ((pos :initarg :pos
        :reader parse-error-pos)
   (msg :initarg :msg
        :reader parse-error-msg)))

(define-condition eof-error (parsec-error) ())

(define-condition bof-error (parsec-error) ())

(define-condition unexpected (parsec-error)
  ((wanted :initarg :wanted
           :reader unexpected-wanted)
   (got :initarg :got
        :reader unexpected-got)))

(define-condition many-unconsumed (parsec-error) ())

(define-condition no-choices-success (parsec-error) ())

(define-condition do-not-satisfy (parsec-error)
  ((token :initarg :token
          :reader do-not-satisfy-token)
   (test :initarg :test
         :reader do-not-satisfy-test)))
