From: Stephen Smalley <sds@tycho.nsa.gov>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] fs: switch order of CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH
 checks
Date: Fri, 17 Feb 2017 13:24:15 -0500
Message-Id: <1487355855-3508-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

generic_permission() presently checks CAP_DAC_OVERRIDE prior to
CAP_DAC_READ_SEARCH.  This can cause misleading audit messages when
using a LSM such as SELinux or AppArmor, since CAP_DAC_OVERRIDE
may not be required for the operation.  Flip the order of the
tests so that CAP_DAC_OVERRIDE is only checked when required for
the operation.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 fs/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ad74877..8736e4a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -340,22 +340,14 @@ int generic_permission(struct inode *inode, int mask)
 
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
-			return 0;
 		if (!(mask & MAY_WRITE))
 			if (capable_wrt_inode_uidgid(inode,
 						     CAP_DAC_READ_SEARCH))
 				return 0;
-		return -EACCES;
-	}
-	/*
-	 * Read/write DACs are always overridable.
-	 * Executable DACs are overridable when there is
-	 * at least one exec bit set.
-	 */
-	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
 			return 0;
+		return -EACCES;
+	}
 
 	/*
 	 * Searching includes executable on directories, else just read.
@@ -364,6 +356,14 @@ int generic_permission(struct inode *inode, int mask)
 	if (mask == MAY_READ)
 		if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
 			return 0;
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable when there is
+	 * at least one exec bit set.
+	 */
+	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
+		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
+			return 0;
 
 	return -EACCES;
 }
-- 
2.7.4
