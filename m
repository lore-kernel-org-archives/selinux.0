Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7CDvUcc021503
 for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2016 09:57:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD7DF4E33F
 for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2016 13:57:20 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] semanage: correct fcontext auditing
Date: Fri, 12 Aug 2016 15:57:16 +0200
Message-Id: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For modify action actually audit the selinux type, i.e. use setype
variable.

For deleting equal fcontext rules do not audit ftype, as the ftype value
for equal rules makes little sense.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 786ed0e..8d3088c 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1992,7 +1992,7 @@ class fcontextRecords(semanageRecords):
         if not seuser:
             seuser = "system_u"
 
-        self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", type, serange))
+        self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", setype, serange))
 
     def modify(self, target, setype, ftype, serange, seuser):
         self.begin()
@@ -2030,7 +2030,7 @@ class fcontextRecords(semanageRecords):
             self.equiv.pop(target)
             self.equal_ind = True
 
-            self.mylog.log_change("resrc=fcontext op=delete-equal %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype]))
+            self.mylog.log_change("resrc=fcontext op=delete-equal %s" % (audit.audit_encode_nv_string("tglob", target, 0)))
 
             return
 
-- 
1.8.3.1
