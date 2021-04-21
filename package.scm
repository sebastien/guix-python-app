;; # GUIX Python Packaging Tutorial
;;
;; This document shows how to package a simply Python app (an
;; HTTP server) using Guix and ship it as a reproducible container. This
;; source code is annotated so that any aspect I struggled with has
;; more detail.
;; --
;; Any Guix package is a Scheme source file, and as a result we need to
;; import modules in which symbols are defined.
(use-modules
  (guix packages)
  (guix download)
  ;; In our case, we're packaging a Python app so we'll need to include
  ;; the Python build system.
  ;; SEE:
  ;; SEE: https://github.com/wwood/guix/blob/master/guix/build-system/python.scm
  (guix build-system python)
  ;; We're using the `python-pytz` module, which is defined in
  ;; `(gnu packages time)`.
  (gnu packages time)
  ;; We're using the `python-aiohttp` module, which depends on `python-web`.
  ;; If you try to build the package without that line, the builder will
  ;; give you a hint: `hint: Did you forget `(use-modules (gnu packages python-web))'?`, which
  ;; is quite helpful.
  (gnu packages python-web)
  (guix licenses))
;; On a side note, if you look at Guix's manual section on [Defining
;; Packages](https://guix.gnu.org/manual/en/html_node/Defining-Packages.html),
;; you'll

(define-public guix-python-app
  (package
    (name "guix-python-app")
    (version "0.0")

  ;;
  ;; Dependencies are declared as part of the `propagated-inputs`, the backquote
  ;; is used to define a list, and the comma to evalute. In the lines below, this
  ;; means `python-pytz` and `python-aiohttp` need to be defined -- they're
  ;; actually imported from `(gnu packages time) and `(gnu packages python-web)`.
  (propagated-inputs
    `(
      ("python-pytz" ,python-pytz)
      ("python-aiohttp" ,python-aiohttp)
      )
    )


  ;; NOTE: It's possible to include the source locally, but note that you
  ;; can only use absolute paths.
  (source (getcwd))

  ;; The alternative is to generate a tarball, for instance using `python setup.py sdist`
  ;; and then compute the hash.
  ;; (source (origin
  ;;           (method url-fetch)
  ;;           (uri (string-append "./dist/guix-python-app-0.0.0.tar.gz"))
  ;;           ;; Compute the hash with `guix hash ./dist/guix-python-app-0.0.0.tar.gz`
  ;;           (sha256 (base32 "1w92a7kd4j41c8fng4lin9q4yipbl3qd3vnnrdhqjisgv6lbq2jh"))))

    (build-system python-build-system)
    (synopsis "A simple Python webapp packaged as a container using Guix")
    (description #false)
    (home-page "https://www.github.com/sebastien/guix-python-app")

  ;; I"m giving an example of using a custom license string, which is useful
  ;; if you're using a custom license or proprietary code.
  (license "MIT License")))

guix-python-app
