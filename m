Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2Fg5ov006458
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:19 -0500
Received: by igvg19 with SMTP id g19so120487553igv.1
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:11 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 06/19] Smack: Handle labels consistently in untrusted mounts
Date: Wed,  2 Dec 2015 09:40:06 -0600
Message-Id: <1449070821-73820-7-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The SMACK64, SMACK64EXEC, and SMACK64MMAP labels are all handled
differently in untrusted mounts. This is confusing and
potentically problematic. Change this to handle them all the same
way that SMACK64 is currently handled; that is, read the label
from disk and check it at use time. For SMACK64 and SMACK64MMAP
access is denied if the label does not match smk_root. To be
consistent with suid, a SMACK64EXEC label which does not match
smk_root will still allow execution of the file but will not run
with the label supplied in the xattr.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 16cac04214e2..0e555f64ded0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -921,6 +921,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	struct inode *inode = file_inode(bprm->file);
 	struct task_smack *bsp = bprm->cred->security;
 	struct inode_smack *isp;
+	struct superblock_smack *sbsp;
 	int rc;
 
 	if (bprm->cred_prepared)
@@ -930,6 +931,11 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
+	sbsp = inode->i_sb->s_security;
+	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&
+	    isp->smk_task != sbsp->smk_root)
+		return 0;
+
 	if (bprm->unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
 		struct task_struct *tracer;
 		rc = 0;
@@ -1733,6 +1739,7 @@ static int smack_mmap_file(struct file *file,
 	struct task_smack *tsp;
 	struct smack_known *okp;
 	struct inode_smack *isp;
+	struct superblock_smack *sbsp;
 	int may;
 	int mmay;
 	int tmay;
@@ -1744,6 +1751,10 @@ static int smack_mmap_file(struct file *file,
 	isp = file_inode(file)->i_security;
 	if (isp->smk_mmap == NULL)
 		return 0;
+	sbsp = file_inode(file)->i_sb->s_security;
+	if (sbsp->smk_flags & SMK_SB_UNTRUSTED &&
+	    isp->smk_mmap != sbsp->smk_root)
+		return -EACCES;
 	mkp = isp->smk_mmap;
 
 	tsp = current_security();
@@ -3532,16 +3543,14 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			if (rc >= 0)
 				transflag = SMK_INODE_TRANSMUTE;
 		}
-		if (!(sbsp->smk_flags & SMK_SB_UNTRUSTED)) {
-			/*
-			 * Don't let the exec or mmap label be "*" or "@".
-			 */
-			skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
-			if (IS_ERR(skp) || skp == &smack_known_star ||
-			    skp == &smack_known_web)
-				skp = NULL;
-			isp->smk_task = skp;
-		}
+		/*
+		 * Don't let the exec or mmap label be "*" or "@".
+		 */
+		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
+		if (IS_ERR(skp) || skp == &smack_known_star ||
+		    skp == &smack_known_web)
+			skp = NULL;
+		isp->smk_task = skp;
 
 		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
 		if (IS_ERR(skp) || skp == &smack_known_star ||
-- 
1.9.1
