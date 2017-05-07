(in-package :cl-parsec)

(defclass pos ()
  ((column :accessor get-column
           :initform 0)
   (line :accessor get-line
         :initform 0)))

(defparameter *pos* (make-instance 'pos))

(defun get-position ()
  (values (get-column *pos*) (get-line *pos*)))

(defun update-position (&key column line)
  (progn
    (if (numberp column)
        (setf (get-column *pos*) column))
    (if (numberp line)
        (setf (get-line *pos*) line))))

(defun update-line ()
  (let ((l (get-line *pos*)))
    (update-position :column 0 :line (1+ l))))

(defun update-column ()
  (let ((col (get-column *pos*)))
    (update-position :column (1+ col))))
