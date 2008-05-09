Subject: [RFC][PATCH] selinux:  simplify ioctl checking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Fri, 09 May 2008 08:43:11 -0400
Message-Id: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an RFC for changing the SELinux ioctl checking.  There have been
prior discussions and patches for this in the past, but they've never
been brought to conclusion.  This does yield a change in behavior, but
I'm hoping to avoid having to introduce yet another policy capability or
compatibility knob for it unless we find that it actually yields
breakage with existing policies.  I was able to boot and login with this
patch applied without any denials, both as an unconfined_u user and as a
user_u user.  

A few comments on the patch:
1) It completely removes all knowledge of individual ioctl commands.
Alternatively, we could retain specific knowledge of the vfs layer
generic ioctl commands while dropping the specific driver and filesystem
ioctl commands (which represent a layering/encapsulation violation
presently).  But I'm not sure we want to deal with tracking any
individual ioctls vs. just using the IOC_DIR for everything.

2) It uses read vs. write permissions rather than getattr vs. setattr
permissions.  With the prior patches, we found that mapping IOC_WRITE to
SETATTR caused real breakage with existing policies as we tend to be
stingy with setattr permission in policy to specifically limit
chmod/chown and friends, and not everything marked with IOC_WRITE truly
corresponds to a SETATTR.  If we feel we need SETATTR checking on
specific ioctl commands, then I think we need to introduce
security_inode_setattr() hook calls in the corresponding driver and/or
filesystem code rather than trying to catch them here since we are
otherwise violating layering.

3) It removes ext2-specific handling that is a legacy of the original
SELinux kernel patches that was never updated to cover ext3 ioctls.  Yet
another reason for doing it the general way instead.

4) It removes the special checking of KDSKBENT/KDSKBSENT that was
introduced into SELinux a long time ago.  I believe that checking
CAP_SYS_TTY_CONFIG was added to the vt code (see
drivers/char/vt_ioctl.c) a while back for those ioctls, such that the
SELinux check is now redundant.  Also another example of a layering
violation.

5) If the ioctl command access mode bits are clear, then it still falls
through to checking the IOCTL permission. So all operations remain
mediated.

Review and wider testing requested.

---<snip>---

Simplify and improve the robustness of the SELinux ioctl checking by 
using the "access mode" bits of the ioctl command to determine the 
permission check rather than dealing with individual command values.
This removes any knowledge of specific ioctl commands from SELinux
and follows the same guidance we gave to Smack earlier.

---

 security/selinux/hooks.c |   48 +++++++----------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 59c6e98..88ddb46 100644
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
@@ -2871,46 +2869,16 @@ static void selinux_file_free_security(struct file *file)
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
