(in-package :cl-parsec)

(defgeneric input-empty-p (input)
  (:method ((input string)) (zerop (length input))))

(defgeneric input-first (input)
  (:method ((input string)) (aref input 0)))

(defgeneric input-rest (input)
  (:method ((input string))
    (multiple-value-bind (s displacement)
        (array-displacement input)
      (make-array (1- (length input))
                  :displaced-to (or s input)
                  :displaced-index-offset (1+ displacement)
                  :element-type (array-element-type input)))))
