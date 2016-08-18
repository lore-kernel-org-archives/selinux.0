From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: mvadkert@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] semanage: Fix semanage fcontext -D
Date: Thu, 18 Aug 2016 08:40:44 -0400
Message-Id: <1471524044-30532-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 4c5b8a956829ba464046a92f7dcc19806458f6b3 ("semanage: add
auditing of changes in records") broke semanage fcontext -D.
Fix it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/semanage/seobject.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index a6681f0..ae87509 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -90,6 +90,7 @@ file_type_str_to_option = {"all files": "a",
                            "named pipe": "p"}
 
 ftype_to_audit = {"": "any",
+                  "a" : "any",
                   "b": "block",
                   "c": "char",
                   "d": "dir",
@@ -2018,7 +2019,7 @@ class fcontextRecords(semanageRecords):
                 raise ValueError(_("Could not delete the file context %s") % target)
             semanage_fcontext_key_free(k)
 
-            self.mylog.log_change("resrc=fcontext op=delete %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype_str]))
+            self.mylog.log_change("resrc=fcontext op=delete %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[file_type_str_to_option[ftype_str]]))
 
         self.equiv = {}
         self.equal_ind = True
-- 
2.7.4
