#lang racket
(require brag/support)
(require br-parser-tools/lex)

(define (tokenize ip)
    (port-count-lines! ip)
    (define my-lexer
      (lexer-src-pos
       [(repetition 1 +inf.0 alphabetic)
        (token 'STRING lexeme)]
       [(repetition 1 +inf.0 numeric)
        (token 'INTEGER lexeme)]
       ["."
        (token "." lexeme)]
       [whitespace
        (token 'WHITESPACE lexeme #:skip? #t)]
       [(eof)
        (void)]))
    (define (next-token) (my-lexer ip))
    next-token)

(provide tokenize)
