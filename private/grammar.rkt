#lang brag
/msg: sent*
sent: word+ /eos?
eos: EOS WHITESPACE? EOS?
word: /WHITESPACE? (STRING|INTEGER) /WHITESPACE?
