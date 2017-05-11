(in-package :cl-parsec)

(defstruct parse-stream
  (stream "" :type simple-array)
  (len 0 :type number))

(defun new-parse-stream (s)
  (let ((len (length s)))
    (make-parse-stream :stream (make-array len :element-type 'character
                                               :initial-contents s)
                       :len len)))

(defclass parse-state ()
  ((stream :accessor get-parse-stream
           :type parse-stream
           :initarg :stream)
   (pos :accessor get-source-pos
        :type source-pos
        :initarg :pos)
   (index :accessor get-parse-index
          :type number
          :initarg :index
          :initform 0)))

(defun new-parse-state (stream pos index)
  (make-instance 'parse-state :stream stream
                              :pos pos
                              :index index))

(defun initial-parse-state (s)
  (new-parse-state (new-parse-stream s) (initial-pos "") 0))


(defun next-state (oldstate))
