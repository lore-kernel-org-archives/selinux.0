From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: do not compute transition labels on mountpoint
	labeled filesystems
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, esandeen@redhat.com
Date: Wed, 01 Dec 2010 16:22:54 -0500
Message-ID: <20101201212254.30815.38691.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux_inode_init_security computes transitions sids even for filesystems
that use mount point labeling.  It shouldn't do that.  It should just use
the mount point label always and no matter what.

This causes 2 problems.  1) it makes file creation slower than it needs to be
since we calculate the transition sid and 2) it allows files to be created
with a different label than the mount point!

# id -Z
staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023
# sesearch --type --class file --source sysadm_t --target tmp_t
Found 1 semantic te rules:
   type_transition sysadm_t tmp_t : file user_tmp_t;

# mount -o loop,context="system_u:object_r:tmp_t:s0"  /tmp/fs /mnt/tmp

# ls -lZ /mnt/tmp
drwx------. root root system_u:object_r:tmp_t:s0       lost+found
# touch /mnt/tmp/file1
# ls -lZ /mnt/tmp
-rw-r--r--. root root staff_u:object_r:user_tmp_t:s0   file1
drwx------. root root system_u:object_r:tmp_t:s0       lost+found

Whoops, we have a mount point labeled filesystem tmp_t with a user_tmp_t
labeled file!

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e066bc2..35403e5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2523,7 +2523,10 @@ static int selinux_inode_init_security(const struct qstr *qstr, struct inode *in
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
 
-	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
+	if ((sbsec->flags & SE_SBINITIALIZED) &&
+	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
+		newsid = sbsec->mntpoint_sid;
+	else if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
 		rc = security_transition_sid(sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
 					     qstr, &newsid);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
