From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded test.
Date: Fri, 17 Apr 2015 09:42:21 -0400
Message-Id: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux can be disabled via the selinux=0 kernel parameter or via
/sys/fs/selinux/disable (triggered by setting SELINUX=disabled in
/etc/selinux/config).  In either case, selinuxfs will be unmounted
and unregistered and therefore it is sufficient to check for the
selinuxfs mount.  We do not need to check for no-policy-loaded and
treat that as SELinux-disabled anymore; that is a relic of Fedora Core 2
days.  Drop the no-policy-loaded test, which was a bit of a hack anyway
(checking whether getcon_raw() returned "kernel" as that can only happen
if no policy is yet loaded and therefore security_sid_to_context() only
has the initial SID name available to return as the context).

May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=1195074
by virtue of removing the call to getcon_raw() and therefore avoiding
use of tls on is_selinux_enabled() calls.  Regardless, it will make
is_selinux_enabled() faster and simpler.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/enabled.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index 5c252dd..1731ac3 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -11,26 +11,10 @@
 
 int is_selinux_enabled(void)
 {
-	int enabled = 0;
-	char * con;
-
 	/* init_selinuxmnt() gets called before this function. We
  	 * will assume that if a selinux file system is mounted, then
  	 * selinux is enabled. */
-	if (selinux_mnt) {
-
-		/* Since a file system is mounted, we consider selinux
-		 * enabled. If getcon_raw fails, selinux is still enabled.
-		 * We only consider it disabled if no policy is loaded. */
-		enabled = 1;
-		if (getcon_raw(&con) == 0) {
-			if (!strcmp(con, "kernel"))
-				enabled = 0;
-			freecon(con);
-		}
-        }
-
-	return enabled;
+	return (selinux_mnt ? 1 : 0);
 }
 
 hidden_def(is_selinux_enabled)
-- 
2.1.0
