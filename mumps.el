;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    Copyright 2013 Christopher Kotfila
;;
;;    Licensed under the Apache License, Version 2.0 (the "License");
;;    you may not use this file except in compliance with the License.
;;    You may obtain a copy of the License at
;;
;;      http://www.apache.org/licenses/LICENSE-2.0
;;
;;    Unless required by applicable law or agreed to in writing, software
;;    distributed under the License is distributed on an "AS IS" BASIS,
;;    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;    See the License for the specific language governing permissions and
;;    limitations under the License.
;;
;;
;;
;; A fair amount of the boiler plate syntax highlighting code has been taken from:
;;               https://github.com/CoherentLogic/lorikeem
;;

(require 'comint)

;; hooks for run before mode run
(defvar mumps-mode-hook nil)

;; keywords for syntax highlighting
(defvar mumps-keywords-abbrev
  '("b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "tc" "tre" "tro" "ts" "u" "v" "w" "x" "za" "zb" "zd" "zh" "zho" "zi" "zk" "zl" "zn" "zp" "zq" "zr" "zs" "zsy" "ztc" "zt" "zts" "zu" "zw")
  "MUMPS abbreviated keywords")

(defvar mumps-keywords-full
  '("break" "close" "continue" "do" "else" "elseif" "for" "goto" "halt" "hang" "if" "job" "kill" "lock" "merge" "new" "open" "print" "quit" "read" "set" "tcommit" "trestart" "trollback" "tstart" "use" "view" "while" "write" "xecute" "zallocate" "zbreak" "zdeallocate" "zhang" "zhorolog" "zinsert" "zkill" "zload" "znspace" "zprint" "zquit" "zremove" "zsave" "zsync" "zsystem" "ztcommit" "ztrap" "ztstart" "zuse" "zwithdraw" "zwrite" "zzdump")
  "MUMPS full-length keywords")

(defvar mumps-functions-abbrev
  '("$a" "$c" "$d" "$e" "$f" "$fn" "$g" "$in" "$i" "$j" "$l" "$li" "$lb" "$ld" "$lf" "$lfs" "$lg" "$ll" "$ls" "$lts" "$na" "$n" "$num" "$o" "$p" "$q" "$ql" "$qs" "$r" "$s" "$st" "$t" "$tr" "$v" "$zba" "$zbc" "$zbf" "$zbg" "$zbl" "$zbn" "$zb" "$zbse" "$zbst" "$zbx" "$zcvt" "$zc" "$zd" "$zdh" "$zdt" "$zdth" "$zdev" "$zi" "$zo" "$zp" "$zse" "$zso" "$zt" "$zth" "$ztl" "$zu")
  "MUMPS abbreviated functions")

(defvar mumps-functions-full
  '("$ascii" "$bit" "$bitcount" "$bitfind" "$bitlogic" "$case" "$char" "$data" "$extract" "$factor" "$find" "$fnumber" "$get" "$increment" "$inumber" "$isobject" "$isvalidnum" "$justify" "$length" "$list" "$listbuild" "$lb" "$listdata" "$listfind" "$listfromstring" "$listget" "$listlength" "$listnext" "$listsame" "$listtostring" "$name" "$next" "$normalize" "$number" "$order" "$piece" "$qlength" "$qsubscript" "$query" "$random" "$reverse" "$select" "$sortbegin" "$sortend" "$stack" "$system" "$text" "$translate" "$view" "$zabs" "$zarccos" "$zarcsin" "$zarctan" "$zband" "$zbcount" "$zbfind" "$zbget" "$zbit" "$zzbitand" "$zbitcount" "$zbitfind" "$zbitget" "$zbitlen" "$zbitnot" "$zbitor" "$zbitset" "$zbitstr" "$zbitxor" "$zblen" "$zbnot" "$zboolean" "$zbor" "$zbset" "$zbstr" "$zbxor" "$zconvert" "$zcvt" "$zcos" "$zcot" "$zcrc" "$zcsc" "$zcyc" "$zdate" "$zdateh" "$zdatetime" "$zdatetimeh" "$zdevice" "$zexp" "$zf" "$zhex" "$zincrement" "$zinfo" "$zln" "$zlog" "$zmessage" "$zname" "$znext" "$zobjclassmethod" "$zobjproperty" "$zorder" "$zparse" "$zpower" "$zprevious" "$zsearch" "$zsec" "$zseek" "$zsin" "$zsocket" "$zsort" "$zsqr" "$zstrip" "$ztan" "$ztexp" "$ztime" "$ztimeh" "$ztlog" "$ztrnlmn" "$zuci")
  "MUMPS full-length functions")

;; define keywords for completion
(defvar mumps-keywords
  (append (mapcar #'upcase mumps-keywords-full)
          (mapcar #'downcase mumps-keywords-full)
          (mapcar #'upcase mumps-functions-full)
          (mapcar #'downcase mumps-functions-full))
  "MUMPS keywords for completion")

(defvar mumps-cli-file-path "/home/kotfic/bin/ossp")

(defvar mumps-cli-arguments '(""))

(defvar mumps-mode-map
  (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
    map))

(defvar mumps-prompt-regexp "^GTM>"
  "Prompt for `run-mumps'.")


(defun mumps ()
  "Run an inferior instance of `cassandra-cli' inside Emacs."
  (interactive)
  (let* ((mumps-program mumps-cli-file-path)
         (buffer (comint-check-proc "MUMPS")))
    ;; pop to the "*MUMPS*" buffer if the process is dead, the
    ;; buffer is missing or it's got the wrong mode.
    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'mumps-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer "*MUMPS*"))
       (current-buffer)))
    ;; create the comint process if there is no buffer.
    (unless buffer
      (apply 'make-comint-in-buffer "MUMPS" buffer
             mumps-program nil mumps-cli-arguments)
      (mumps-mode))))


(define-derived-mode mumps-mode fundamental-mode
  "mumps mode"
  "LorikeeM MUMPS Developer Tools"

  (setq mumps-unmatched-open-paren "\(.*$")
  (setq mumps-unmatched-close-paren "\).*$")
  (setq mumps-line-label "^[%A-Za-z][A-Za-z0-9]*:?\\|^[0-9]+:?")
  (setq mumps-string-error "\\\\\".*$")

  ;; create the thingy that we'll feed to font-lock-defaults
  (setq mumps-font-lock-keywords
	`((,";.*$" . font-lock-comment-face)
          (,(regexp-opt (mapcar #'upcase mumps-keywords-abbrev)    'words) . font-lock-keyword-face)
          (,(regexp-opt (mapcar #'upcase mumps-keywords-full)      'words) . font-lock-keyword-face)
          (,(regexp-opt (mapcar #'downcase mumps-keywords-abbrev)  'words) . font-lock-keyword-face)
          (,(regexp-opt (mapcar #'downcase mumps-keywords-full)    'words) . font-lock-keyword-face)
          (,(regexp-opt (mapcar #'upcase mumps-functions-full)     'words) . font-lock-function-name-face)
          (,(regexp-opt (mapcar #'upcase mumps-functions-abbrev)   'words) . font-lock-function-name-face)
          (,(regexp-opt (mapcar #'downcase mumps-functions-abbrev) 'words) . font-lock-function-name-face)
          (,(regexp-opt (mapcar #'downcase mumps-functions-full)   'words) . font-lock-function-name-face)
          (,mumps-line-label . font-lock-type-face)
          (,mumps-string-error . font-lock-warning-face)))


  (setq font-lock-defaults '((mumps-font-lock-keywords)))

  (run-hooks 'mumps-mode-hook))

(provide 'mumps-mode)
