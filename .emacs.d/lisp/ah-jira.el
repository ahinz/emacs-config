;; -*- lexical-binding: t -*-

;; Requires:
;; - request.el
;; - s.el

(require 'dash)
(require 'request)
(require 's)

(defun j-create-auth-header (username password)
  `(("authorization" . ,(s-concat "Basic " (base64-encode-string (s-concat username ":" password))))))

(defconst auth-header (j-create-auth-header jira-username jira-password))
(defconst j-url-prefix "https://quanttus.atlassian.net/rest")

(defconst sprint-field "customfield_10007")

(defun filter-issue (issue)
  `(("key" . ,(assoc-default 'key issue))
    ("summary" . ,(assoc-default 'summary issue))
    ("owner" . ,(or (assoc-default 'assignee issue) "unset"))))

(defun get-issues-on-board (board callback)
  (request
   (s-concat j-url-prefix "/greenhopper/1.0/xboard/work/allData.json")
   :params `((rapidViewId . ,board))
   :headers auth-header
   :parser 'json-read
   :error (function* (lambda (&key error-thrown &allow-other-keys)
                       (message "Got error: %S" error-thrown)))
   :success (function*
             (lambda (&key data &allow-other-keys)
               (funcall callback (-map 'filter-issue (assoc-default 'issues (assoc-default 'issuesData data))))))))

(defun refresh-board (issues)
  (with-current-buffer (get-buffer-create "*sprint*")
    (erase-buffer)
    (-map (lambda (group)
            (insert (car group) "\n")
            (--map (insert (s-format "  ${key} - ${summary}\n" 'aget it)) (cdr group)))
          (--group-by (assoc-default "owner" it) issues))
    ))

(defun update-board ()
  (get-issues-on-board "3" 'refresh-board))

(defun get-summary-for-issue (issue-name result-cb)
  (request
   (s-concat j-url-prefix "/api/2/issue/QSD-803")
   :headers auth-header
   :parser 'json-read
   :error (function* (lambda (&key error-thrown &allow-other-keys)
                       (message "Got error: %S" error-thrown)))
   :success (function*
             (lambda (&key data &allow-other-keys)
               (let ((key (assoc-default 'key data))
                     (summary (assoc-default
                               'summary
                               (assoc-default 'fields data))))
                 (funcall result-cb key summary))))))

(update-board)
;; (get-summary-for-issue "QSD-803" (lambda (key sum)
;;                                    (message "Key: %S Sum: %S" key sum)))
