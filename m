Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CKu1LF016924
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 15:56:01 -0500
Received: from e35.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CKuSEN000297
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 20:56:28 GMT
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2CKpeiZ003284
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 13:51:40 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o2CKtep4056952
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 13:55:40 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o2CKtbLJ023649
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 13:55:39 -0700
Date: Fri, 12 Mar 2010 14:55:37 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: lkml <linux-kernel@vger.kernel.org>, SELinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Kees Cook <kees.cook@canonical.com>, Andrew Morgan <morgan@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eric Paris <eparis@parisplace.org>
Subject: [PATCH] Define CAP_SYSLOG
Message-ID: <20100312205537.GA1091@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Privileged syslog operations currently require CAP_SYS_ADMIN.  Split
this off into a new CAP_SYSLOG privilege which we can sanely take away
from a container through the capability bounding set.

With this patch, an lxc container can be prevented from messing with
the host's syslog (i.e. dmesg -c).

There is one downside to this patch:  If some site or distro currently
has syslogd/whatever running as a non-root user with cap_sys_admin+pe,
then it will need to be changed to run with cap_syslog+pe.  I don't
know if there are such sites, or if that concern means we should take
a different approach to introducing this change, or simply refuse this
change.

I'm also sending out corresponding patches for libcap and refpolicy, and
will whip up a man-pages patch next week.

Changelog: mar 12 2010: add selinux capability2:cap_syslog perm

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
Acked-by: Andrew G. Morgan <morgan@kernel.org>
Acked-By: Kees Cook <kees.cook@canonical.com>
Cc: James Morris <jmorris@namei.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@parisplace.org>
---
 include/linux/capability.h          |    7 +++++--
 security/commoncap.c                |    2 +-
 security/selinux/include/classmap.h |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 39e5ff5..837a55c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -249,7 +249,6 @@ struct cpu_vfs_cap_data {
 /* Allow configuration of the secure attention key */
 /* Allow administration of the random device */
 /* Allow examination and configuration of disk quotas */
-/* Allow configuring the kernel's syslog (printk behaviour) */
 /* Allow setting the domainname */
 /* Allow setting the hostname */
 /* Allow calling bdflush() */
@@ -355,7 +354,11 @@ struct cpu_vfs_cap_data {
 
 #define CAP_MAC_ADMIN        33
 
-#define CAP_LAST_CAP         CAP_MAC_ADMIN
+/* Allow configuring the kernel's syslog (printk behaviour) */
+
+#define CAP_SYSLOG           34
+
+#define CAP_LAST_CAP         CAP_SYSLOG
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 6166973..018985e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -899,7 +899,7 @@ int cap_syslog(int type, bool from_file)
 	if (type != SYSLOG_ACTION_OPEN && from_file)
 		return 0;
 	if ((type != SYSLOG_ACTION_READ_ALL &&
-	     type != SYSLOG_ACTION_SIZE_BUFFER) && !capable(CAP_SYS_ADMIN))
+	     type != SYSLOG_ACTION_SIZE_BUFFER) && !capable(CAP_SYSLOG))
 		return -EPERM;
 	return 0;
 }
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8b32e95..f03cf56 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -142,7 +142,7 @@ struct security_class_mapping secclass_map[] = {
 	    "node_bind", "name_connect", NULL } },
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
-	{ "capability2", { "mac_override", "mac_admin", NULL } },
+	{ "capability2", { "mac_override", "mac_admin", "syslog", NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
