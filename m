Message-ID: <1516888138.9570.0.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Thu, 25 Jan 2018 08:48:58 -0500
References: <1516850875-25066-16-git-send-email-takondra@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: [Fwd: [PATCH v2 15/15] selinux: delay sid population for rootfs
 till init is complete]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-------- Forwarded Message --------
From: Taras Kondratiuk <takondra@cisco.com>
To: H. Peter Anvin <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi
Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, li
nux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-m
odule@vger.kernel.org, xe-linux-external@cisco.com
Subject: [Non-DoD Source] [PATCH v2 15/15] selinux: delay sid
population for rootfs till init is complete
Date: Thu, 25 Jan 2018 03:27:55 +0000

From: Victor Kamensky <kamensky@cisco.com>

With initramfs cpio format that supports extended attributes
we need to skip sid population on sys_lsetxattr call from
initramfs for rootfs if security server is not initialized yet.

Otherwise callback in selinux_inode_post_setxattr will try to
translate give security.selinux label into sid context and since
security server is not available yet inode will receive default
sid (typically kernel_t). Note that in the same time proper
label will be stored in inode xattrs. Later, since inode sid
would be already populated system will never look back at
actual xattrs. But if we skip sid population for rootfs and
we have policy that direct use of xattrs for rootfs, proper
sid will be filled in from extended attributes one node is
accessed and server is initialized.

Note new DELAYAFTERINIT_MNT super block flag is introduced
to only mark rootfs for such behavior. For other types of
tmpfs original logic is still used.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 security/selinux/hooks.c            | 9 ++++++++-
 security/selinux/include/security.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f3fe65589f02..bb25268f734e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -716,7 +716,7 @@ static int selinux_set_mnt_opts(struct super_block
*sb,
 			 */
 			if (!strncmp(sb->s_type->name, "rootfs",
 				     sizeof("rootfs")))
-				sbsec->flags |= SBLABEL_MNT;
+				sbsec->flags |=
SBLABEL_MNT|DELAYAFTERINIT_MNT;
 
 			/* Defer initialization until
selinux_complete_init,
 			   after the initial policy is loaded and the
security
@@ -3253,6 +3253,7 @@ static void selinux_inode_post_setxattr(struct
dentry *dentry, const char *name,
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct inode_security_struct *isec;
+	struct superblock_security_struct *sbsec;
 	u32 newsid;
 	int rc;
 
@@ -3261,6 +3262,12 @@ static void selinux_inode_post_setxattr(struct
dentry *dentry, const char *name,
 		return;
 	}
 
+	if (!ss_initialized) {
+		sbsec = inode->i_sb->s_security;
+		if (sbsec->flags & DELAYAFTERINIT_MNT)
+			return;
+	}
+
 	rc = security_context_to_sid_force(value, size, &newsid);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to map context to
SID"
diff --git a/security/selinux/include/security.h
b/security/selinux/include/security.h
index 02f0412d42f2..585acfd6cbcf 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -52,6 +52,7 @@
 #define ROOTCONTEXT_MNT	0x04
 #define DEFCONTEXT_MNT	0x08
 #define SBLABEL_MNT	0x10
+#define DELAYAFTERINIT_MNT 0x20
 /* Non-mount related flags */
 #define SE_SBINITIALIZED	0x0100
 #define SE_SBPROC		0x0200
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-
security-module" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
