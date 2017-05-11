(in-package :cl-parsec)

(defclass source-pos ()
  ((name :accessor get-source-name
         :initform ""
         :initarg :name)
   (column :accessor get-source-column
           :initform 0
           :initarg :column)
   (line :accessor get-source-line
         :initform 0
         :initarg :line)))

(defun new-pos (name column line)
  (make-instance 'source-pos :name name
                             :column column
                             :line line))
(defun initial-pos (name)
  (new-pos name 1 1))

(defmethod inc-source-column ((p source-pos) (n number))
  (let ((name (get-source-name p))
        (col (get-source-column p))
        (line (get-source-line p)))
    (new-pos name (+ col n) line)))


(defmethod inc-source-line ((p source-pos) (n number))
  (let ((name (get-source-name p))
        (col (get-source-column p))
        (line (get-source-line p)))
    (new-pos name col (+ line n))))

(defmethod update-source-pos ((p source-pos) (c character))
  (case c (#\newline (inc-source-line p 1))
        (#\tab (inc-source-column p 8))
        (otherwise (inc-source-column p 1))))
