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

(defmethod get-current-char (state parse-state)
  (let* ((ps (get-parse-stream state))
         (index (get-parse-index state))
         (pos (get-source-pos state))
         (pss (parse-stream-stream ps))
         (len (parse-stream-len ps)))
    (if (> index len)
        (error 'eof-error :pos pos)
        (aref pss index))))

(defmethod get-next-state (oldstate parse-state)
  (let* ((ps (get-parse-stream oldstate))
         (index (get-parse-index oldstate))
         (pos (get-source-pos oldstate))
         (pss (parse-stream-stream ps))
         (c (aref pss index)))
    (new-parse-state ps (update-source-pos pos c) (1+ index))))
