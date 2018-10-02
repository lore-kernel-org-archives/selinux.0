Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w92BJ9BF012760
 for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2018 07:19:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so1833174wme.3
 for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2018 04:19:03 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
 stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Al Viro <viro@zeniv.linux.org.uk>
Date: Tue,  2 Oct 2018 13:18:30 +0200
Message-Id: <20181002111830.26342-1-omosnace@redhat.com>
Subject: [PATCH] selinux: fix race when removing selinuxfs entries
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Letting the following set of commands run long enough on a multi-core
machine causes soft lockups in the kernel:

    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &
    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &
    (cd /sys/fs/selinux/; while true; do find >/dev/null 2>&1; done) &
    while true; do load_policy; echo -n .; sleep 0.1; done

The problem is that sel_remove_entries() calls d_genocide() to remove
the whole contents of certain subdirectories in /sys/fs/selinux/. This
function is apparently only intended for removing filesystem entries
that are no longer accessible to userspace, because it doesn't follow
the rule that any code removing entries from a directory must hold the
write lock on the directory's inode RW semaphore (formerly this was a
mutex, see 9902af79c01a ("parallel lookups: actual switch to rwsem")).

In order to fix this, I had to open-code d_genocide() again, adding the
necessary parent inode locking. I based the new implementation on
d_walk() (fs/dcache.c), the original code from before ad52184b705c
("selinuxfs: don't open-code d_genocide()"), and with a slight
inspiration from debugfs_remove() (fs/debugfs/inode.c).

The new code no longer triggers soft lockups with the above reproducer
and it also gives no warnings when run with CONFIG_PROVE_LOCKING=y.

Note that I am adding Fixes: on the commit that replaced the open-coded
version with d_genocide(), but the bug is present also in the original
code that dates back to pre-2.6 times... This patch obviously doesn't
apply to this older code so pre-4.0 kernels will need a dedicated patch
(just adding the parent inode locks should be sufficient there).

Link: https://github.com/SELinuxProject/selinux-kernel/issues/42
Fixes: ad52184b705c ("selinuxfs: don't open-code d_genocide()")
Cc: <stable@vger.kernel.org> # 4.0+
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/selinuxfs.c | 88 ++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3a5a138a096..4ac9b17e24d1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1316,10 +1316,92 @@ static const struct file_operations sel_commit_bools_ops = {
 	.llseek		= generic_file_llseek,
 };
 
-static void sel_remove_entries(struct dentry *de)
+/* removes all children of the given dentry (but not itself) */
+static void sel_remove_entries(struct dentry *root)
 {
-	d_genocide(de);
-	shrink_dcache_parent(de);
+	struct dentry *parent = root;
+	struct dentry *child;
+	struct list_head *next;
+
+	spin_lock(&parent->d_lock);
+
+repeat:
+	next = parent->d_subdirs.next;
+
+	while (next != &parent->d_subdirs) {
+		child = list_entry(next, struct dentry, d_child);
+		next = next->next;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+
+		if (!list_empty(&child->d_subdirs)) {
+			/* Current entry has children, we need to remove those
+			 * first. We unlock the parent but keep the child locked
+			 * (it will become the new parent). */
+			spin_unlock(&parent->d_lock);
+
+			/* we need to re-lock the child (new parent) in a
+			 * special way (see d_walk() in fs/dcache.c) */
+			spin_release(&child->d_lock.dep_map, 1, _RET_IP_);
+			parent = child;
+			spin_acquire(&parent->d_lock.dep_map, 0, 1, _RET_IP_);
+
+			goto repeat;
+		}
+
+resume:
+		if (child->d_inode) {
+			/* acquire a reference to the child */
+			dget_dlock(child);
+
+			/* drop all locks (someof the callees will try to
+			 * acquire them) */
+			spin_unlock(&child->d_lock);
+			spin_unlock(&parent->d_lock);
+
+			/* IMPORTANT: we need to hold the parent's inode lock
+			 * because some functions (namely dcache_readdir) assume
+			 * holding this lock means children won't be removed */
+			inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+
+			/* now unlink the child */
+			if (d_is_dir(child))
+				simple_rmdir(d_inode(parent), child);
+			else
+				simple_unlink(d_inode(parent), child);
+			d_delete(child);
+
+			inode_unlock(parent->d_inode);
+
+			/* drop our extra reference */
+			dput(child);
+
+			/* re-lock only the parent */
+			spin_lock(&parent->d_lock);
+		} else
+			spin_unlock(&child->d_lock);
+	}
+
+	if (parent != root) {
+		/* we processed contents of a subdirectory, ascend and continue
+		 * by removing the subdirectory itself (now empty) */
+		child = parent;
+		parent = child->d_parent;
+
+		/* we have to re-lock the child after locking the parent */
+		spin_unlock(&child->d_lock);
+		spin_lock(&parent->d_lock);
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+
+		/* set next to the next sibling */
+		next = child->d_child.next;
+		goto resume;
+	}
+
+	spin_unlock(&root->d_lock);
+
+	/* try to clean up the stale entries */
+	shrink_dcache_parent(root);
 }
 
 #define BOOL_DIR_NAME "booleans"
-- 
2.17.1
