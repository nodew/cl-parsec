#-asdf (error "ASDF3 is rquired")

(defsystem :cl-parsec
  :description "cl-parsec, a parser-combinator"
  :author "Joe Wang"
  :licence "MIT"
  :source-path "src"
  :components ((:file "package")
               (:file "utils")
               (:file "parsec")
               (:file "combinators")
               (:file "primitive")))
