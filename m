Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFgiV009697
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:43 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 3/7] selinux: Get rid of file_path_has_perm
Date: Mon, 26 Oct 2015 22:15:24 +0100
Message-Id: <1445894128-6765-4-git-send-email-agruenba@redhat.com>
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use path_has_perm directly instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65e8689..d6b4dc9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1673,18 +1673,6 @@ static inline int path_has_perm(const struct cred *cred,
 	return inode_has_perm(cred, inode, av, &ad);
 }
 
-/* Same as path_has_perm, but uses the inode from the file struct. */
-static inline int file_path_has_perm(const struct cred *cred,
-				     struct file *file,
-				     u32 av)
-{
-	struct common_audit_data ad;
-
-	ad.type = LSM_AUDIT_DATA_PATH;
-	ad.u.path = file->f_path;
-	return inode_has_perm(cred, file_inode(file), av, &ad);
-}
-
 /* Check whether a task can use an open file descriptor to
    access an inode in a given way.  Check access to the
    descriptor itself, and then use dentry_has_perm to
@@ -2371,14 +2359,14 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 			struct tty_file_private *file_priv;
 
 			/* Revalidate access to controlling tty.
-			   Use file_path_has_perm on the tty path directly
+			   Use path_has_perm on the tty path directly
 			   rather than using file_has_perm, as this particular
 			   open file may belong to another process and we are
 			   only interested in the inode-based check here. */
 			file_priv = list_first_entry(&tty->tty_files,
 						struct tty_file_private, list);
 			file = file_priv->file;
-			if (file_path_has_perm(cred, file, FILE__READ | FILE__WRITE))
+			if (path_has_perm(cred, &file->f_path, FILE__READ | FILE__WRITE))
 				drop_tty = 1;
 		}
 		spin_unlock(&tty_files_lock);
@@ -3537,7 +3525,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	 * new inode label or new policy.
 	 * This check is not redundant - do not remove.
 	 */
-	return file_path_has_perm(cred, file, open_file_to_av(file));
+	return path_has_perm(cred, &file->f_path, open_file_to_av(file));
 }
 
 /* task security operations */
-- 
2.5.0
