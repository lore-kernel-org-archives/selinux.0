From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] cgroupfs: use init_cred when populating new cgroupfs mount
To: containers@lists.linux-foundation.org, selinux@tycho.nsa.gov
Cc: menage@google.com, lizf@cn.fujitsu.com, sds@tycho.nsa.gov,
        rhel6-cc-external-list@redhat.com
Date: Wed, 25 May 2011 17:35:34 -0400
Message-ID: <20110525213534.28016.33058.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We recently found that in some configurations SELinux was blocking the ability
for cgroupfs to be mounted.  The reason for this is because cgroupfs creates
files and directories during the get_sb() call and also uses lookup_one_len()
during that same get_sb() call.  This is a problem since the security
subsystem cannot initialize the superblock and the inodes in that filesystem
until after the get_sb() call returns.  Thus we leave the inodes in
an unitialized state during get_sb().  For the vast majority of filesystems
this is not an issue, but since cgroupfs uses lookup_on_len() it does
search permission checks on the directories in the path it walks.  Since the
inode security state is not set up SELinux does these checks as if the inodes
were 'unlabeled.'

Many 'normal' userspace process do not have permission to interact with
unlabeled inodes.  The solution presented here is to do the permission checks
of path walk and inode creation as the kernel rather than as the task that
called mount.  Since the kernel has permission to read/write/create
unlabeled inodes the get_sb() call will complete successfully and the SELinux
code will be able to initialize the superblock and those inodes created during
the get_sb() call.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 kernel/cgroup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 909a355..38b32dd 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -27,9 +27,11 @@
  */
 
 #include <linux/cgroup.h>
+#include <linux/cred.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/init_task.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -1513,6 +1515,7 @@ static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 		struct cgroup *root_cgrp = &root->top_cgroup;
 		struct inode *inode;
 		struct cgroupfs_root *existing_root;
+		const struct cred *cred;
 		int i;
 
 		BUG_ON(sb->s_root != NULL);
@@ -1592,7 +1595,9 @@ static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 		BUG_ON(!list_empty(&root_cgrp->children));
 		BUG_ON(root->number_of_cgroups != 1);
 
+		cred = override_creds(&init_cred);
 		cgroup_populate_dir(root_cgrp);
+		revert_creds(cred);
 		mutex_unlock(&cgroup_mutex);
 		mutex_unlock(&inode->i_mutex);
 	} else {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
