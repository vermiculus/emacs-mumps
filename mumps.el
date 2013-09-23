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


;; hooks for run before mode run
(defvar mumps-mode-hook nil)

;; keywords for syntax highlighting
(defvar mumps-keywords-ucase-abbrev
  '("B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "TC" "TRE" "TRO" "TS" "U" "V" "W" "X" "ZA" "ZB" "ZD" "ZH" "ZHO" "ZI" "ZK" "ZL" "ZN" "ZP" "ZQ" "ZR" "ZS" "ZSY" "ZTC" "ZT" "ZTS" "ZU" "ZW")
  "MUMPS uppercase abbreviated keywords")

(defvar mumps-keywords-lcase-abbrev
  '("b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "tc" "tre" "tro" "ts" "u" "v" "w" "x" "za" "zb" "zd" "zh" "zho" "zi" "zk" "zl" "zn" "zp" "zq" "zr" "zs" "zsy" "ztc" "zt" "zts" "zu" "zw")
  "MUMPS lowercase abbreviated keywords")

(defvar mumps-keywords-ucase-full
  '("BREAK" "CLOSE" "CONTINUE" "DO" "ELSE" "ELSEIF" "FOR" "GOTO" "HALT" "HANG" "IF" "JOB" "KILL" "LOCK" "MERGE" "NEW" "OPEN" "PRINT" "QUIT" "READ" "SET" "TCOMMIT" "TRESTART" "TROLLBACK" "TSTART" "USE" "VIEW" "WHILE" "WRITE" "XECUTE" "ZALLOCATE" "ZBREAK" "ZDEALLOCATE" "ZHANG" "ZHOROLOG" "ZINSERT" "ZKILL" "ZLOAD" "ZNSPACE" "ZPRINT" "ZQUIT" "ZREMOVE" "ZSAVE" "ZSYNC" "ZSYSTEM" "ZTCOMMIT" "ZTRAP" "ZTSTART" "ZUSE" "ZWITHDRAW" "ZWRITE" "ZZDUMP")
  "MUMPS uppercase full-length keywords")

(defvar mumps-keywords-lcase-full
  '("break" "close" "continue" "do" "else" "elseif" "for" "goto" "halt" "hang" "if" "job" "kill" "lock" "merge" "new" "open" "print" "quit" "read" "set" "tcommit" "trestart" "trollback" "tstart" "use" "view" "while" "write" "xecute" "zallocate" "zbreak" "zdeallocate" "zhang" "zhorolog" "zinsert" "zkill" "zload" "znspace" "zprint" "zquit" "zremove" "zsave" "zsync" "zsystem" "ztcommit" "ztrap" "ztstart" "zuse" "zwithdraw" "zwrite" "zzdump")
  "MUMPS lowercase full-length keywords")

(defvar mumps-functions-ucase-abbrev
  '("$A" "$C" "$D" "$E" "$F" "$FN" "$G" "$IN" "$I" "$J" "$L" "$LI" "$LB" "$LD" "$LF" "$LFS" "$LG" "$LL" "$LS" "$LTS" "$NA" "$N" "$NUM" "$O" "$P" "$Q" "$QL" "$QS" "$R" "$S" "$ST" "$T" "$TR" "$V" "$ZBA" "$ZBC" "$ZBF" "$ZBG" "$ZBL" "$ZBN" "$ZB" "$ZBSE" "$ZBST" "$ZBX" "$ZCVT" "$ZC" "$ZD" "$ZDH" "$ZDT" "$ZDTH" "$ZDEV" "$ZI" "$ZO" "$ZP" "$ZSE" "$ZSO" "$ZT" "$ZTH" "$ZTL" "$ZU")
  "MUMPS uppercase abbreviated functions")

(defvar mumps-functions-lcase-abbrev
  '("$a" "$c" "$d" "$e" "$f" "$fn" "$g" "$in" "$i" "$j" "$l" "$li" "$lb" "$ld" "$lf" "$lfs" "$lg" "$ll" "$ls" "$lts" "$na" "$n" "$num" "$o" "$p" "$q" "$ql" "$qs" "$r" "$s" "$st" "$t" "$tr" "$v" "$zba" "$zbc" "$zbf" "$zbg" "$zbl" "$zbn" "$zb" "$zbse" "$zbst" "$zbx" "$zcvt" "$zc" "$zd" "$zdh" "$zdt" "$zdth" "$zdev" "$zi" "$zo" "$zp" "$zse" "$zso" "$zt" "$zth" "$ztl" "$zu")
  "MUMPS lowercase abbreviated functions")

(defvar mumps-functions-ucase-full
  '("$ASCII" "$BIT" "$BITCOUNT" "$BITFIND" "$BITLOGIC" "$CASE" "$CHAR" "$DATA" "$EXTRACT" "$FACTOR" "$FIND" "$FNUMBER" "$GET" "$INCREMENT" "$INUMBER" "$ISOBJECT" "$ISVALIDNUM" "$JUSTIFY" "$LENGTH" "$LIST" "$LISTBUILD" "$LB" "$LISTDATA" "$LISTFIND" "$LISTFROMSTRING" "$LISTGET" "$LISTLENGTH" "$LISTNEXT" "$LISTSAME" "$LISTTOSTRING" "$NAME" "$NEXT" "$NORMALIZE" "$NUMBER" "$ORDER" "$PIECE" "$QLENGTH" "$QSUBSCRIPT" "$QUERY" "$RANDOM" "$REVERSE" "$SELECT" "$SORTBEGIN" "$SORTEND" "$STACK" "$SYSTEM" "$TEXT" "$TRANSLATE" "$VIEW" "$ZABS" "$ZARCCOS" "$ZARCSIN" "$ZARCTAN" "$ZBAND" "$ZBCOUNT" "$ZBFIND" "$ZBGET" "$ZBIT" "$ZZBITAND" "$ZBITCOUNT" "$ZBITFIND" "$ZBITGET" "$ZBITLEN" "$ZBITNOT" "$ZBITOR" "$ZBITSET" "$ZBITSTR" "$ZBITXOR" "$ZBLEN" "$ZBNOT" "$ZBOOLEAN" "$ZBOR" "$ZBSET" "$ZBSTR" "$ZBXOR" "$ZCONVERT" "$ZCVT" "$ZCOS" "$ZCOT" "$ZCRC" "$ZCSC" "$ZCYC" "$ZDATE" "$ZDATEH" "$ZDATETIME" "$ZDATETIMEH" "$ZDEVICE" "$ZEXP" "$ZF" "$ZHEX" "$ZINCREMENT" "$ZINFO" "$ZLN" "$ZLOG" "$ZMESSAGE" "$ZNAME" "$ZNEXT" "$ZOBJCLASSMETHOD" "$ZOBJPROPERTY" "$ZORDER" "$ZPARSE" "$ZPOWER" "$ZPREVIOUS" "$ZSEARCH" "$ZSEC" "$ZSEEK" "$ZSIN" "$ZSOCKET" "$ZSORT" "$ZSQR" "$ZSTRIP" "$ZTAN" "$ZTEXP" "$ZTIME" "$ZTIMEH" "$ZTLOG" "$ZTRNLMN" "$ZUCI")
  "MUMPS uppercase full-length functions")

(defvar mumps-functions-lcase-full
    '("$ascii" "$bit" "$bitcount" "$bitfind" "$bitlogic" "$case" "$char" "$data" "$extract" "$factor" "$find" "$fnumber" "$get" "$increment" "$inumber" "$isobject" "$isvalidnum" "$justify" "$length" "$list" "$listbuild" "$lb" "$listdata" "$listfind" "$listfromstring" "$listget" "$listlength" "$listnext" "$listsame" "$listtostring" "$name" "$next" "$normalize" "$number" "$order" "$piece" "$qlength" "$qsubscript" "$query" "$random" "$reverse" "$select" "$sortbegin" "$sortend" "$stack" "$system" "$text" "$translate" "$view" "$zabs" "$zarccos" "$zarcsin" "$zarctan" "$zband" "$zbcount" "$zbfind" "$zbget" "$zbit" "$zzbitand" "$zbitcount" "$zbitfind" "$zbitget" "$zbitlen" "$zbitnot" "$zbitor" "$zbitset" "$zbitstr" "$zbitxor" "$zblen" "$zbnot" "$zboolean" "$zbor" "$zbset" "$zbstr" "$zbxor" "$zconvert" "$zcvt" "$zcos" "$zcot" "$zcrc" "$zcsc" "$zcyc" "$zdate" "$zdateh" "$zdatetime" "$zdatetimeh" "$zdevice" "$zexp" "$zf" "$zhex" "$zincrement" "$zinfo" "$zln" "$zlog" "$zmessage" "$zname" "$znext" "$zobjclassmethod" "$zobjproperty" "$zorder" "$zparse" "$zpower" "$zprevious" "$zsearch" "$zsec" "$zseek" "$zsin" "$zsocket" "$zsort" "$zsqr" "$zstrip" "$ztan" "$ztexp" "$ztime" "$ztimeh" "$ztlog" "$ztrnlmn" "$zuci")
    "MUMPS lowercase full-length functions")

;; define keywords for completion
(defvar mumps-keywords
  '("BREAK" "CLOSE" "CONTINUE" "DO" "ELSE" "ELSEIF" "FOR" "GOTO" "HALT" "HANG" "IF" "JOB" "KILL" "LOCK" "MERGE" "NEW" "OPEN" "PRINT" "QUIT" "READ" "SET" "TCOMMIT" "TRESTART" "TROLLBACK" "TSTART" "USE" "VIEW" "WHILE" "WRITE" "XECUTE" "ZALLOCATE" "ZBREAK" "ZDEALLOCATE" "ZHANG" "ZHOROLOG" "ZINSERT" "ZKILL" "ZLOAD" "ZNSPACE" "ZPRINT" "ZQUIT" "ZREMOVE" "ZSAVE" "ZSYNC" "ZSYSTEM" "ZTCOMMIT" "ZTRAP" "ZTSTART" "ZUSE" "ZWITHDRAW" "ZWRITE" "ZZDUMP" "break" "close" "continue" "do" "else" "elseif" "for" "goto" "halt" "hang" "if" "job" "kill" "lock" "merge" "new" "open" "print" "quit" "read" "set" "tcommit" "trestart" "trollback" "tstart" "use" "view" "while" "write" "xecute" "zallocate" "zbreak" "zdeallocate" "zhang" "zhorolog" "zinsert" "zkill" "zload" "znspace" "zprint" "zquit" "zremove" "zsave" "zsync" "zsystem" "ztcommit" "ztrap" "ztstart" "zuse" "zwithdraw" "zwrite" "zzdump" "$ASCII" "$BIT" "$BITCOUNT" "$BITFIND" "$BITLOGIC" "$CASE" "$CHAR" "$DATA" "$EXTRACT" "$FACTOR" "$FIND" "$FNUMBER" "$GET" "$INCREMENT" "$INUMBER" "$ISOBJECT" "$ISVALIDNUM" "$JUSTIFY" "$LENGTH" "$LIST" "$LISTBUILD" "$LB" "$LISTDATA" "$LISTFIND" "$LISTFROMSTRING" "$LISTGET" "$LISTLENGTH" "$LISTNEXT" "$LISTSAME" "$LISTTOSTRING" "$NAME" "$NEXT" "$NORMALIZE" "$NUMBER" "$ORDER" "$PIECE" "$QLENGTH" "$QSUBSCRIPT" "$QUERY" "$RANDOM" "$REVERSE" "$SELECT" "$SORTBEGIN" "$SORTEND" "$STACK" "$SYSTEM" "$TEXT" "$TRANSLATE" "$VIEW" "$ZABS" "$ZARCCOS" "$ZARCSIN" "$ZARCTAN" "$ZBAND" "$ZBCOUNT" "$ZBFIND" "$ZBGET" "$ZBIT" "$ZZBITAND" "$ZBITCOUNT" "$ZBITFIND" "$ZBITGET" "$ZBITLEN" "$ZBITNOT" "$ZBITOR" "$ZBITSET" "$ZBITSTR" "$ZBITXOR" "$ZBLEN" "$ZBNOT" "$ZBOOLEAN" "$ZBOR" "$ZBSET" "$ZBSTR" "$ZBXOR" "$ZCONVERT" "$ZCVT" "$ZCOS" "$ZCOT" "$ZCRC" "$ZCSC" "$ZCYC" "$ZDATE" "$ZDATEH" "$ZDATETIME" "$ZDATETIMEH" "$ZDEVICE" "$ZEXP" "$ZF" "$ZHEX" "$ZINCREMENT" "$ZINFO" "$ZLN" "$ZLOG" "$ZMESSAGE" "$ZNAME" "$ZNEXT" "$ZOBJCLASSMETHOD" "$ZOBJPROPERTY" "$ZORDER" "$ZPARSE" "$ZPOWER" "$ZPREVIOUS" "$ZSEARCH" "$ZSEC" "$ZSEEK" "$ZSIN" "$ZSOCKET" "$ZSORT" "$ZSQR" "$ZSTRIP" "$ZTAN" "$ZTEXP" "$ZTIME" "$ZTIMEH" "$ZTLOG" "$ZTRNLMN" "$ZUCI" "$ascii" "$bit" "$bitcount" "$bitfind" "$bitlogic" "$case" "$char" "$data" "$extract" "$factor" "$find" "$fnumber" "$get" "$increment" "$inumber" "$isobject" "$isvalidnum" "$justify" "$length" "$list" "$listbuild" "$lb" "$listdata" "$listfind" "$listfromstring" "$listget" "$listlength" "$listnext" "$listsame" "$listtostring" "$name" "$next" "$normalize" "$number" "$order" "$piece" "$qlength" "$qsubscript" "$query" "$random" "$reverse" "$select" "$sortbegin" "$sortend" "$stack" "$system" "$text" "$translate" "$view" "$zabs" "$zarccos" "$zarcsin" "$zarctan" "$zband" "$zbcount" "$zbfind" "$zbget" "$zbit" "$zzbitand" "$zbitcount" "$zbitfind" "$zbitget" "$zbitlen" "$zbitnot" "$zbitor" "$zbitset" "$zbitstr" "$zbitxor" "$zblen" "$zbnot" "$zboolean" "$zbor" "$zbset" "$zbstr" "$zbxor" "$zconvert" "$zcvt" "$zcos" "$zcot" "$zcrc" "$zcsc" "$zcyc" "$zdate" "$zdateh" "$zdatetime" "$zdatetimeh" "$zdevice" "$zexp" "$zf" "$zhex" "$zincrement" "$zinfo" "$zln" "$zlog" "$zmessage" "$zname" "$znext" "$zobjclassmethod" "$zobjproperty" "$zorder" "$zparse" "$zpower" "$zprevious" "$zsearch" "$zsec" "$zseek" "$zsin" "$zsocket" "$zsort" "$zsqr" "$zstrip" "$ztan" "$ztexp" "$ztime" "$ztimeh" "$ztlog" "$ztrnlmn" "$zuci")
  "MUMPS keywords for completion")



(define-derived-mode mumps-mode fundamental-mode
  "mumps mode"
  "LorikeeM MUMPS Developer Tools"

  (setq mumps-unmatched-open-paren "\(.*$")
  (setq mumps-unmatched-close-paren "\).*$")
  (setq mumps-line-label "^[%A-Za-z][A-Za-z0-9]*:?\\|^[0-9]+:?")
  (setq mumps-string-error "\\\\\".*$")

  ;; create the thingy that we'll feed to font-lock-defaults
  (setq mumps-font-lock-keywords 
	`(      
	  (,";.*$" . font-lock-comment-face)       
	  (,(regexp-opt mumps-keywords-ucase-abbrev 'words) . font-lock-keyword-face)
	  (,(regexp-opt mumps-keywords-ucase-full 'words) . font-lock-keyword-face)
	  (,(regexp-opt mumps-keywords-lcase-abbrev 'words) . font-lock-keyword-face)
	  (,(regexp-opt mumps-keywords-lcase-full 'words) . font-lock-keyword-face)
	  (,(regexp-opt mumps-functions-ucase-full 'words) . font-lock-function-name-face)
	  (,(regexp-opt mumps-functions-ucase-abbrev 'words) . font-lock-function-name-face)
	  (,(regexp-opt mumps-functions-lcase-abbrev 'words) . font-lock-function-name-face)
	  (,(regexp-opt mumps-functions-lcase-full 'words) . font-lock-function-name-face)	
	  (,mumps-line-label . font-lock-type-face)
	  (,mumps-string-error . font-lock-warning-face)
	  ))

  
  (setq font-lock-defaults '((mumps-font-lock-keywords)))
  
  (run-hooks 'mumps-mode-hook))

(provide 'mumps-mode)
