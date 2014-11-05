Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA5Fgs7J014202
 for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2014 10:42:54 -0500
Subject: [PATCH 3/7] SELinux: Stub in copy-up handling
From: David Howells <dhowells@redhat.com>
To: linux-unionfs@vger.kernel.org, selinux@tycho.nsa.gov
Date: Wed, 05 Nov 2014 15:42:48 +0000
Message-ID: <20141105154248.2555.15813.stgit@warthog.procyon.org.uk>
In-Reply-To: <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
References: <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Provide stubs for union/overlay copy-up handling.  The xattr copy up stub
discards lower SELinux xattrs rather than letting them be copied up so that
the security label on the copy doesn't get corrupted.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/selinux/hooks.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e66314138b38..f3fe7dbbf741 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3142,6 +3142,19 @@ static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
 	*secid = isec->sid;
 }
 
+static int selinux_inode_copy_up(struct dentry *src, struct dentry *dst)
+{
+	return 0;
+}
+
+static int selinux_inode_copy_up_xattr(struct dentry *src, struct dentry *dst,
+				       const char *name, void *value, size_t *size)
+{
+	if (strcmp(name, XATTR_NAME_SELINUX) == 0)
+		return 1; /* Discard */
+	return 0;
+}
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -5868,6 +5881,8 @@ static struct security_operations selinux_ops = {
 	.inode_setsecurity =		selinux_inode_setsecurity,
 	.inode_listsecurity =		selinux_inode_listsecurity,
 	.inode_getsecid =		selinux_inode_getsecid,
+	.inode_copy_up =		selinux_inode_copy_up,
+	.inode_copy_up_xattr =		selinux_inode_copy_up_xattr,
 
 	.file_permission =		selinux_file_permission,
 	.file_alloc_security =		selinux_file_alloc_security,
