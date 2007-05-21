From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 2/4] selinux: rename sel_remove_bools() for more general usage.
Date: Mon, 21 May 2007 11:38:34 -0400
Message-Id: <1179761918482-git-send-email-cpebenito@tresys.com>
In-Reply-To: <11797619172804-git-send-email-cpebenito@tresys.com>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Christopher J. PeBenito <cpebenito@tresys.com>

sel_remove_bools() will also be used by the object class discovery, rename
it for more general use.

Signed-off-by: Christopher J. PeBenito <cpebenito@tresys.com>

---
 security/selinux/selinuxfs.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 98af83f..9c7b6ef 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -940,9 +940,8 @@ static const struct file_operations sel_commit_bools_ops = {
 	.write          = sel_commit_bools_write,
 };
 
-/* delete booleans - partial revoke() from
- * fs/proc/generic.c proc_kill_inodes */
-static void sel_remove_bools(struct dentry *de)
+/* partial revoke() from fs/proc/generic.c proc_kill_inodes */
+static void sel_remove_entries(struct dentry *de)
 {
 	struct list_head *p, *node;
 	struct super_block *sb = de->d_sb;
@@ -998,7 +997,7 @@ static int sel_make_bools(void)
 	kfree(bool_pending_values);
 	bool_pending_values = NULL;
 
-	sel_remove_bools(dir);
+	sel_remove_entries(dir);
 
 	if (!(page = (char*)get_zeroed_page(GFP_KERNEL)))
 		return -ENOMEM;
@@ -1048,7 +1047,7 @@ out:
 	return ret;
 err:
 	kfree(values);
-	sel_remove_bools(dir);
+	sel_remove_entries(dir);
 	ret = -ENOMEM;
 	goto out;
 }
-- 
1.5.1.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
