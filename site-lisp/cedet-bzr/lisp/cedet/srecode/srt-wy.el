;;; srt-wy.el --- Generated parser support file

;; Copyright (C) 2005, 2007, 2008, 2009, 2010, 2013 Eric M. Ludlam

;; Author: Farzad Bekran <farzad@lenovo>
;; Created: 2015-11-25 16:47:05+0330
;; Keywords: syntax
;; X-RCS: $Id$

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; PLEASE DO NOT MANUALLY EDIT THIS FILE!  It is automatically
;; generated from the grammar file srt.wy.

;;; History:
;;

;;; Code:

(require 'semantic/lex)
(eval-when-compile (require 'semantic/bovine))

;;; Prologue
;;

;;; Declarations
;;
(defconst srecode-template-wy--keyword-table
  (semantic-lex-make-keyword-table
   '(("set" . SET)
     ("show" . SHOW)
     ("macro" . MACRO)
     ("context" . CONTEXT)
     ("template" . TEMPLATE)
     ("sectiondictionary" . SECTIONDICTIONARY)
     ("section" . SECTION)
     ("end" . END)
     ("prompt" . PROMPT)
     ("default" . DEFAULT)
     ("defaultmacro" . DEFAULTMACRO)
     ("read" . READ)
     ("bind" . BIND))
   '(("bind" summary "bind \"<letter>\"")
     ("read" summary "prompt <symbol> \"Describe Symbol: \" [default[macro] <lispsym>|\"valuetext\"] [read <lispsym>]")
     ("defaultmacro" summary "prompt <symbol> \"Describe Symbol: \" [default[macro] <lispsym>|\"valuetext\"] [read <lispsym>]")
     ("default" summary "prompt <symbol> \"Describe Symbol: \" [default[macro] <lispsym>|\"valuetext\"] [read <lispsym>]")
     ("prompt" summary "prompt <symbol> \"Describe Symbol: \" [default[macro] <lispsym>|\"valuetext\"] [read <lispsym>]")
     ("end" summary "section ... end")
     ("section" summary "section <name>\\n <dictionary entries>\\n end")
     ("sectiondictionary" summary "sectiondictionary <name>\\n <dictionary entries>")
     ("template" summary "template <name>\\n <template definition>")
     ("context" summary "context <name>")
     ("macro" summary "... macro \"string\" ...")
     ("show" summary "show <name>   ; to show a section")
     ("set" summary "set <name> <value>")))
  "Table of language keywords.")

(defconst srecode-template-wy--token-table
  (semantic-lex-make-type-table
   '(("number"
      (number))
     ("string"
      (string))
     ("symbol"
      (symbol))
     ("property"
      (property))
     ("separator"
      (TEMPLATE_BLOCK . "^----"))
     ("newline"
      (newline)))
   '(("number" :declared t)
     ("string" :declared t)
     ("symbol" :declared t)
     ("property" syntax ":\\(\\w\\|\\s_\\)*")
     ("property" :declared t)
     ("newline" :declared t)
     ("punctuation" syntax "\\s.+")
     ("punctuation" :declared t)
     ("keyword" :declared t)))
  "Table of lexical tokens.")

(defconst srecode-template-wy--parse-table
  (progn
    (eval-when-compile
      (require 'semantic/wisent/comp))
    (wisent-compile-grammar
     '((SET SHOW MACRO CONTEXT TEMPLATE SECTIONDICTIONARY SECTION END PROMPT DEFAULT DEFAULTMACRO READ BIND newline TEMPLATE_BLOCK property symbol string number)
       nil
       (template_file
	((newline)
	 nil)
	((context))
	((prompt))
	((variable))
	((template)))
       (context
	((CONTEXT symbol newline)
	 (wisent-raw-tag
	  (semantic-tag $2 'context))))
       (prompt
	((PROMPT symbol string opt-default-fcn opt-read-fcn newline)
	 (wisent-raw-tag
	  (semantic-tag $2 'prompt :text
			(read $3)
			:default $4 :read $5))))
       (opt-default-fcn
	((DEFAULT symbol)
	 (progn
	   (read $2)))
	((DEFAULT string)
	 (progn
	   (read $2)))
	((DEFAULTMACRO string)
	 (progn
	   (cons 'macro
		 (read $2))))
	(nil nil))
       (opt-read-fcn
	((READ symbol)
	 (progn
	   (read $2)))
	(nil nil))
       (variable
	((SET symbol insertable-string-list newline)
	 (wisent-raw-tag
	  (semantic-tag-new-variable $2 nil $3)))
	((SET symbol number newline)
	 (wisent-raw-tag
	  (semantic-tag-new-variable $2 nil
				     (list $3))))
	((SHOW symbol newline)
	 (wisent-raw-tag
	  (semantic-tag-new-variable $2 nil t))))
       (insertable-string-list
	((insertable-string)
	 (list $1))
	((insertable-string-list insertable-string)
	 (append $1
		 (list $2))))
       (insertable-string
	((string)
	 (read $1))
	((MACRO string)
	 (cons 'macro
	       (read $2))))
       (template
	((TEMPLATE templatename opt-dynamic-arguments newline opt-string section-dictionary-list TEMPLATE_BLOCK newline opt-bind)
	 (wisent-raw-tag
	  (semantic-tag-new-function $2 nil $3 :documentation $5 :code $7 :dictionaries $6 :binding $9))))
       (templatename
	((symbol))
	((PROMPT))
	((CONTEXT))
	((TEMPLATE))
	((DEFAULT))
	((MACRO))
	((DEFAULTMACRO))
	((READ))
	((SET)))
       (opt-dynamic-arguments
	((property opt-dynamic-arguments)
	 (cons $1 $2))
	(nil nil))
       (opt-string
	((string newline)
	 (read $1))
	(nil nil))
       (section-dictionary-list
	(nil nil)
	((section-dictionary-list flat-section-dictionary)
	 (append $1
		 (list $2)))
	((section-dictionary-list section-dictionary)
	 (append $1
		 (list $2))))
       (flat-section-dictionary
	((SECTIONDICTIONARY string newline flat-dictionary-entry-list)
	 (cons
	  (read $2)
	  $4)))
       (flat-dictionary-entry-list
	(nil nil)
	((flat-dictionary-entry-list flat-dictionary-entry)
	 (append $1 $2)))
       (flat-dictionary-entry
	((variable)
	 (wisent-cook-tag $1)))
       (section-dictionary
	((SECTION string newline dictionary-entry-list END newline)
	 (cons
	  (read $2)
	  $4)))
       (dictionary-entry-list
	(nil nil)
	((dictionary-entry-list dictionary-entry)
	 (append $1 $2)))
       (dictionary-entry
	((variable)
	 (wisent-cook-tag $1))
	((section-dictionary)
	 (list $1)))
       (opt-bind
	((BIND string newline)
	 (read $2))
	(nil nil)))
     '(template_file)))
  "Parser table.")

(defun srecode-template-wy--install-parser ()
  "Setup the Semantic Parser."
  (semantic-install-function-overrides
   '((parse-stream . wisent-parse-stream)))
  (setq semantic-parser-name "LALR"
	semantic--parse-table srecode-template-wy--parse-table
	semantic-debug-parser-source "srt.wy"
	semantic-flex-keywords-obarray srecode-template-wy--keyword-table
	semantic-lex-types-obarray srecode-template-wy--token-table)
  ;; Collect unmatched syntax lexical tokens
  (semantic-make-local-hook 'wisent-discarding-token-functions)
  (add-hook 'wisent-discarding-token-functions
	    'wisent-collect-unmatched-syntax nil t))


;;; Analyzers
;;
(define-lex-string-type-analyzer srecode-template-wy--<punctuation>-string-analyzer
  "string analyzer for <punctuation> tokens."
  "\\s.+"
  nil
  'punctuation)

(define-lex-regex-type-analyzer srecode-template-wy--<symbol>-regexp-analyzer
  "regexp analyzer for <symbol> tokens."
  "\\(\\sw\\|\\s_\\)+"
  nil
  'symbol)

(define-lex-regex-type-analyzer srecode-template-wy--<number>-regexp-analyzer
  "regexp analyzer for <number> tokens."
  semantic-lex-number-expression
  nil
  'number)

(define-lex-sexp-type-analyzer srecode-template-wy--<string>-sexp-analyzer
  "sexp analyzer for <string> tokens."
  "\\s\""
  'string)

(define-lex-keyword-type-analyzer srecode-template-wy--<keyword>-keyword-analyzer
  "keyword analyzer for <keyword> tokens."
  "\\(\\sw\\|\\s_\\)+")

(define-lex-regex-type-analyzer srecode-template-wy--<property>-regexp-analyzer
  "regexp analyzer for <property> tokens."
  ":\\(\\w\\|\\s_\\)*"
  nil
  'property)


;;; Epilogue
;;
(define-lex-simple-regex-analyzer srecode-template-property-analyzer
  "Detect and create a dynamic argument properties."
  ":\\(\\w\\|\\s_\\)*" 'property 0)

(define-lex-regex-analyzer srecode-template-separator-block
  "Detect and create a template quote block."
  "^----\n"
  (semantic-lex-push-token
   (semantic-lex-token
    'TEMPLATE_BLOCK
    (match-end 0)
    (semantic-lex-unterminated-syntax-protection 'TEMPLATE_BLOCK
      (goto-char (match-end 0))
      (re-search-forward "^----$")
      (match-beginning 0))))
  (setq semantic-lex-end-point (point)))


(define-lex wisent-srecode-template-lexer
  "Lexical analyzer that handles SRecode Template buffers.
It ignores whitespace, newlines and comments."
  semantic-lex-newline
  semantic-lex-ignore-whitespace
  semantic-lex-ignore-newline
  semantic-lex-ignore-comments
  srecode-template-separator-block
  srecode-template-wy--<keyword>-keyword-analyzer
  srecode-template-property-analyzer
  srecode-template-wy--<number>-regexp-analyzer
  srecode-template-wy--<symbol>-regexp-analyzer
  srecode-template-wy--<string>-sexp-analyzer
  srecode-template-wy--<punctuation>-string-analyzer
  semantic-lex-default-action
  )

(provide 'srecode/srt-wy)

;;; srt-wy.el ends here
