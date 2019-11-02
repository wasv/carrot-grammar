#lang racket
(require readline)
(require "grammar.rkt")
(require "lexer.rkt")
(require brag/support)
(parse (tokenize (current-input-port)))
