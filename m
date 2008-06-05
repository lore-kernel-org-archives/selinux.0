Subject: [patch] selinux:  simplify ioctl checking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 09:21:28 -0400
Message-Id: <1212672088.2763.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Simplify and improve the robustness of the SELinux ioctl checking by 
using the "access mode" bits of the ioctl command to determine the 
permission check rather than dealing with individual command values.
This removes any knowledge of specific ioctl commands from SELinux
and follows the same guidance we gave to Smack earlier.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |   48 +++++++----------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 91b666a..f530008 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -42,9 +42,7 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
-#include <linux/ext2_fs.h>
 #include <linux/proc_fs.h>
-#include <linux/kd.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/tty.h>
@@ -2903,46 +2901,16 @@ static void selinux_file_free_security(struct file *file)
 static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
-	int error = 0;
-
-	switch (cmd) {
-	case FIONREAD:
-	/* fall through */
-	case FIBMAP:
-	/* fall through */
-	case FIGETBSZ:
-	/* fall through */
-	case EXT2_IOC_GETFLAGS:
-	/* fall through */
-	case EXT2_IOC_GETVERSION:
-		error = file_has_perm(current, file, FILE__GETATTR);
-		break;
-
-	case EXT2_IOC_SETFLAGS:
-	/* fall through */
-	case EXT2_IOC_SETVERSION:
-		error = file_has_perm(current, file, FILE__SETATTR);
-		break;
-
-	/* sys_ioctl() checks */
-	case FIONBIO:
-	/* fall through */
-	case FIOASYNC:
-		error = file_has_perm(current, file, 0);
-		break;
+	u32 av = 0;
 
-	case KDSKBENT:
-	case KDSKBSENT:
-		error = task_has_capability(current, CAP_SYS_TTY_CONFIG);
-		break;
+	if (_IOC_DIR(cmd) & _IOC_WRITE)
+		av |= FILE__WRITE;
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		av |= FILE__READ;
+	if (!av)
+		av = FILE__IOCTL;
 
-	/* default case assumes that the command will go
-	 * to the file's ioctl() function.
-	 */
-	default:
-		error = file_has_perm(current, file, FILE__IOCTL);
-	}
-	return error;
+	return file_has_perm(current, file, av);
 }
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
