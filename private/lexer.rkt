#lang racket
(require brag/support)
(require br-parser-tools/lex)

(define my-lexer
  (lexer-src-pos
   ["\n" (void)]
   [(eof) (void)]
   [(repetition 1 +inf.0 alphabetic)
    (token 'STRING lexeme)]
   [(repetition 1 +inf.0 numeric)
    (token 'INTEGER lexeme)]
   ["."
    (token "." lexeme)]
   [whitespace
    (token 'WHITESPACE lexeme #:skip? #t)]))

(define (make-tokenizer ip)
    (port-count-lines! ip)
    (define (next-token) (my-lexer ip))
    next-token)

(define (tokenize str) (apply-tokenizer make-tokenizer str))

(provide tokenize)
