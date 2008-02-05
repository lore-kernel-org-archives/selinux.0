Subject: [patch] libselinux:  don't preservebools for Linux >= 2.6.22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        "Todd C. Miller" <tmiller@tresys.com>,
        Chad Sellers <csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 10:42:25 -0500
Message-Id: <1202226145.27371.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since Linux >= 2.6.22 includes the logic to automatically preserve
active boolean values across a policy reload, the libselinux load policy
logic can check the kernel version and skip the userspace preservebools
processing in that case.  This is cleaner than introducing a config
option to /etc/selinux/config, as it will auto-detect the support and
fall back to the compatibility behavior for older kernels.  Thus,
this change does not change behavior for RHEL 5 or Debian etch.

Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2786)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -3,6 +3,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/utsname.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -48,6 +49,7 @@
 	int vers = kernvers, minvers = DEFAULT_POLICY_VERSION;
 	char path[PATH_MAX], **names;
 	struct stat sb;
+	struct utsname uts;
 	size_t size;
 	void *map, *data;
 	int fd, rc = -1, *values, len, i, prot;
@@ -129,6 +131,15 @@
 		minvers = vers_min();
 	}
 
+
+	/* 
+	 * As of Linux 2.6.22, the kernel preserves boolean
+	 * values across a reload, so we do not need to 
+	 * preserve them in userspace.
+	 */
+	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
+		preservebools = 0;
+
       search:
 	snprintf(path, sizeof(path), "%s.%d",
 		 selinux_binary_policy_path(), vers);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
