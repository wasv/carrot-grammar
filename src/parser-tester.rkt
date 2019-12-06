#lang racket
(require readline)
(require brag/support)
(require "grammar.rkt")
(require "lexer.rkt")
(parse (tokenize (current-input-port)))
