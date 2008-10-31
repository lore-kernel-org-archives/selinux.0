Subject: [PATCH]SELinux: properly handle empty tty_files list
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Fri, 31 Oct 2008 17:40:00 -0400
Message-Id: <1225489200.3371.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux: handle empty tty_files list

From: Eric Paris <eparis@redhat.com>

SELinux has wrongly (since 2004) had an incorrect test for an empty
tty->tty_files list.  With an empty list selinux would be pointing to
part of the tty struct itself and would then proceed to dereference that
value and again dereference that result.  An F10 change to plymouth on a ppc64
system is actually currently triggering this bug.  This patch uses list_empty()
to handle empty lists rather than looking at a meaningless location.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3e3fde7..f85597a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2126,14 +2126,16 @@ static inline void flush_unauthorized_files(struct files_struct *files)
 	tty = get_current_tty();
 	if (tty) {
 		file_list_lock();
-		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
-		if (file) {
+		if (!list_empty(&tty->tty_files)) {
+			struct inode *inode;
+
 			/* Revalidate access to controlling tty.
 			   Use inode_has_perm on the tty inode directly rather
 			   than using file_has_perm, as this particular open
 			   file may belong to another process and we are only
 			   interested in the inode-based check here. */
-			struct inode *inode = file->f_path.dentry->d_inode;
+			file = list_first_entry(&tty->tty_files, struct file, f_u.fu_list);
+			inode = file->f_path.dentry->d_inode;
 			if (inode_has_perm(current, inode,
 					   FILE__READ | FILE__WRITE, NULL)) {
 				drop_tty = 1;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
