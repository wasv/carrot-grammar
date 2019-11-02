#lang racket
(require brag/support)
(require br-parser-tools/lex)

(define (tokenize ip)
    (port-count-lines! ip)
    (define my-lexer
      (lexer-src-pos
       [(repetition 1 +inf.0 numeric)
        (token 'INTEGER (string->number lexeme))]
       [(repetition 1 +inf.0 upper-case)
        (token 'STRING lexeme)]
       ["b"
        (token 'STRING " ")]
       [";"
        (token ";" lexeme)]
       [whitespace
        (token 'WHITESPACE lexeme #:skip? #t)]
       [(eof)
        (void)]))
    (define (next-token) (my-lexer ip))
    next-token)

(provide tokenize)
