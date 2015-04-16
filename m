From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] org.selinux.policy: Require auth_admin_keep for all actions.
Date: Thu, 16 Apr 2015 09:41:33 -0400
Message-Id: <1429191693-26082-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fedora permits obtaining local policy customizations and the list
of policy modules without admin authentication, but we would prefer
more conservative defaults upstream.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/sepolicy/org.selinux.policy | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/org.selinux.policy b/policycoreutils/sepolicy/org.selinux.policy
index 44ae625..0126610 100644
--- a/policycoreutils/sepolicy/org.selinux.policy
+++ b/policycoreutils/sepolicy/org.selinux.policy
@@ -40,7 +40,7 @@
         <defaults>
           <allow_any>no</allow_any>
           <allow_inactive>no</allow_inactive>
-	  <allow_active>yes</allow_active>
+	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
     <action id="org.selinux.semodule_list">
@@ -49,7 +49,7 @@
         <defaults>
           <allow_any>no</allow_any>
           <allow_inactive>no</allow_inactive>
-	  <allow_active>yes</allow_active>
+	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
     <action id="org.selinux.relabel_on_boot">
-- 
2.1.0
