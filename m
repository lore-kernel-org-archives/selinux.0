From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 03/05] selinux_current_policy_path will return none on a disabled SELinux system
Date: Wed, 13 Nov 2013 10:43:46 -0500
Message-Id: <1384357428-21732-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 policycoreutils/audit2allow/sepolgen-ifgen | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/audit2allow/sepolgen-ifgen b/policycoreutils/audit2allow/sepolgen-ifgen
index 3967ba5..83c7ecf 100644
--- a/policycoreutils/audit2allow/sepolgen-ifgen
+++ b/policycoreutils/audit2allow/sepolgen-ifgen
@@ -63,7 +63,7 @@ def parse_options():
 
 def get_policy():
     p = selinux.selinux_current_policy_path()
-    if os.path.exists(p):
+    if p and os.path.exists(p):
         return p
     i = selinux.security_policyvers()
     p = selinux.selinux_binary_policy_path() + "." + str(i)
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
