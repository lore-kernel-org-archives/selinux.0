Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F8j85J019368
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 04:45:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 322664E330
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 08:45:07 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] semanage: default to "s0" if serange empty for port modify
Date: Mon, 15 Aug 2016 10:44:58 +0200
Message-Id: <1471250698-16573-2-git-send-email-mvadkert@redhat.com>
In-Reply-To: <1471250698-16573-1-git-send-email-mvadkert@redhat.com>
References: <1471250698-16573-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In case serange is empty, but the record is beeing modified
(setype was supplied), use default "s0" range. With the original
code the audit event would be printed with no range (i.e.
"system_u:object_r:ssh_port_t:")

Note that default "s0" is currently used in other places
of seobject.py.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 538ff0a..a6681f0 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1161,8 +1161,11 @@ class portRecords(semanageRecords):
 
         con = semanage_port_get_con(p)
 
-        if (is_mls_enabled == 1) and (serange != ""):
-            semanage_context_set_mls(self.sh, con, untranslate(serange))
+        if is_mls_enabled == 1:
+            if serange == "":
+                serange = "s0"
+            else:
+                semanage_context_set_mls(self.sh, con, untranslate(serange))
         if setype != "":
             semanage_context_set_type(self.sh, con, setype)
 
-- 
1.8.3.1
