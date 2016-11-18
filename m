From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, paul@paul-moore.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: keep SELinux in sync with new capability definitions
Date: Fri, 18 Nov 2016 10:23:09 -0500
Message-Id: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a new capability is defined, SELinux needs to be updated.
Trigger a build error if a new capability is defined without
corresponding update to security/selinux/include/classmap.h's
COMMON_CAP2_PERMS.  This is similar to BUILD_BUG_ON() guards
in the SELinux nlmsgtab code to ensure that SELinux tracks
new netlink message types as needed.

Note that there is already a similar build guard in
security/selinux/hooks.c to detect when more than 64
capabilities are defined, since that will require adding
a third capability class to SELinux.

A nicer way to do this would be to extend scripts/selinux/genheaders
or a similar tool to auto-generate the necessary definitions and code
for SELinux capability checking from include/uapi/linux/capability.h.
AppArmor does something similar in its Makefile, although it only
needs to generate a single table of names.  That is left as future work.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/include/classmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 1f1f4b2..e2d4ad3a 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -24,6 +24,10 @@
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
 		"wake_alarm", "block_suspend", "audit_read"
 
+#if CAP_LAST_CAP > CAP_AUDIT_READ
+#error New capability defined, please update COMMON_CAP2_PERMS.
+#endif
+
 /*
  * Note: The name for any socket class should be suffixed by "socket",
  *	 and doesn't contain more than one substr of "socket".
-- 
2.7.4
