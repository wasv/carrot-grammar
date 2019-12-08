#lang racket
(require brag/support)
(require br-parser-tools/lex)
(require "grammar.rkt")

(define my-lexer
  (lexer-src-pos
   [(eof) (void)]
   [(repetition 1 +inf.0 (union "\n" "."))
    (token 'EOS 'EOS)]
   [(repetition 1 +inf.0 alphabetic)
    (token 'STRING lexeme)]
   [(repetition 1 +inf.0 numeric)
    (token 'INTEGER lexeme)]
   [(repetition 1 +inf.0 whitespace)
    (token 'WHITESPACE 'WHITESPACE)]))

(define (make-tokenizer ip)
    (port-count-lines! ip)
    (define (next-token) (my-lexer ip))
    next-token)

(define (interpret str) (parse-to-datum (apply-tokenizer make-tokenizer str)))

(provide interpret)

(module+ main
    (require readline)
    (let loop ()
      (begin
        (println (interpret (current-input-port)))
        (loop)
       )))
