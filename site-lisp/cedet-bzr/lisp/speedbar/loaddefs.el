;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "rpm" "rpm.el" (22101 46087 420844 0))
;;; Generated autoloads from rpm.el

(autoload 'rpm "rpm" "\
Red Hat Package Management in Emacs.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "sb-info" "sb-info.el" (22101 46087 420844
;;;;;;  0))
;;; Generated autoloads from sb-info.el

(autoload 'Info-speedbar-browser "sb-info" "\
Initialize speedbar to display an info node browser.
This will add a speedbar major display mode.

\(fn)" t nil)

(autoload 'Info-speedbar-buttons "sb-info" "\
Create a speedbar display to help navigation in an Info file.
BUFFER is the buffer speedbar is requesting buttons for.

\(fn BUFFER)" nil nil)

(eval-after-load "info" '(require 'sb-info))

;;;***

;;;### (autoloads nil "sb-rmail" "sb-rmail.el" (22101 46087 420844
;;;;;;  0))
;;; Generated autoloads from sb-rmail.el

(autoload 'rmail-speedbar-buttons "sb-rmail" "\
Create buttons for BUFFER containing rmail messages.
Click on the address under Reply to: to reply to this person.
Under Folders: Click a name to read it, or on the <M> to move the
current message into that RMAIL folder.

\(fn BUFFER)" nil nil)

;;;***

;;;### (autoloads nil nil ("sb-ant.el" "sb-html.el" "sb-texinfo.el")
;;;;;;  (22101 46276 445427 681000))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
