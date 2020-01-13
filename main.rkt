#lang racket/base

(module+ test
  (require rackunit))

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>

;; Code here

(require "private/lexer.rkt")

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (check-equal? (+ 2 2) 4))

(module+ main
    (require readline)
    (require buzzr)
    (define ADDRESS "tcp://localhost:1883")
    (define CLIENTID "ExampleClient")
    (define TOPIC "topic")
    (with-handlers ([exn:fail? (lambda (exn)
                                    (println exn)
                                   )])
      (define client (buzzr:check (buzzr:client-create ADDRESS CLIENTID)))
      (define conn_opts (buzzr:connect-options-create))

      (buzzr:check (buzzr:client-connect client conn_opts))
      (buzzr:check (buzzr:subscribe client TOPIC 0))

      (let loop ()
        (begin
          (define message (buzzr:check (buzzr:receive client -1)))
          (println (interpret (bytes->string/utf-8 (cadr message)))))
          (loop)
         )
      (buzzr:check (buzzr:client-disconnect client))
    ))
