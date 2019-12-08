#lang racket
(require brag/support)
(require br-parser-tools/lex)
(require "grammar.rkt")

(define my-lexer
  (lexer-src-pos
   [(eof) (void)]
   [(union "\n" ".") (token 'EOS 'EOS)]
   [(repetition 1 +inf.0 alphabetic)
    (token 'STRING lexeme)]
   [(repetition 1 +inf.0 numeric)
    (token 'INTEGER lexeme)]
   [whitespace
    (token 'WHITESPACE lexeme #:skip? #t)]))

(define (make-tokenizer ip)
    (port-count-lines! ip)
    (define (next-token) (my-lexer ip))
    next-token)

(define (interpret str) (parse-to-datum (apply-tokenizer make-tokenizer str)))

(provide interpret)
