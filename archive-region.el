;;;; archive-region.el --- 
;; $Id: archive-region.el,v 1.1 2010-04-09 12:51:53 rubikitch Exp $

;; Copyright (C) 2010  rubikitch

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: languages
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/archive-region.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; 

;;; Commands:
;;
;; Below are complete command list:
;;
;;
;;; Customizable Options:
;;
;; Below are customizable option list:
;;

;;; Installation:
;;
;; Put archive-region.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'archive-region)
;;
;; No need more.

;;; Customize:
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET archive-region RET
;;


;;; History:

;; $Log: archive-region.el,v $
;; Revision 1.1  2010-04-09 12:51:53  rubikitch
;; Initial revision
;;

;;; Code:

(defvar archive-region-version "$Id: archive-region.el,v 1.1 2010-04-09 12:51:53 rubikitch Exp $")
(eval-when-compile (require 'cl))
(require 'newcomment)
(defgroup archive-region nil
  "archive-region"
  :group 'emacs)

(defvar archive-region-filename-format "%s_archive")
(defvar archive-region-date-format "[%Y/%m/%d]")

(defun archive-region (s e)
  (interactive "r")
  (if buffer-file-name
      (save-restriction
        (narrow-to-region s e)
        (uncomment-region (point-min) (point-max))
        (goto-char (point-min))
        (insert (format-time-string archive-region-date-format) "\n")
        (let ((comment-start (or comment-start "#")))
          (comment-region (point-min) (point)))
        (goto-char (point-max))
        (insert "\n")
        (append-to-file (point-min) (point-max)
                        (format archive-region-filename-format buffer-file-name))
        (delete-region (point-min) (point-max)))
    (error "Need filename")))

(provide 'archive-region)

;; How to save (DO NOT REMOVE!!)
;; (emacswiki-post "archive-region.el")
;;; archive-region.el ends here
