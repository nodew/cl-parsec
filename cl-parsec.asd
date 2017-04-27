#-asdf (error "ASDF3 is rquired")

(asdf:defsystem :cl-parsec
  :description "cl-parsec, a parser-combinator"
  :author "Joe Wang"
  :licence "MIT"
  :source-path "src"
  :components ((:file "package")
               (:file "combinators")
               (:file "parsers")))
