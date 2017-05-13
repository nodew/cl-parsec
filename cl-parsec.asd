#-asdf (error "ASDF3 is rquired")

(defsystem :cl-parsec
  :version "0.1.0"
  :description "cl-parsec, a parser-combinator"
  :author "Joe Wang"
  :licence "MIT"
  :depends-on (#:cl-unicode)
  :components
  ((
    :module :src
    :components ((:file "package")
                 (:file "unicode")
                 (:file "error")
                 (:file "state")
                 (:file "utils")
                 (:file "pos")
                 (:file "prim")
                 (:file "combinators")
                 (:file "char")))))
