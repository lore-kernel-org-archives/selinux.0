From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: do not set automatic i_ino in selinuxfs
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Tue, 23 Nov 2010 11:56:39 -0500
Message-ID: <20101123165639.4669.29701.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinuxfs carefully uses i_ino to figure out what the inode refers to.  The
VFS used to generically set this value and we would reset it to something
useable.  After 85fe4025c616 each filesystem sets this value to a default
if needed.  Since selinuxfs doesn't use the default value and it can only
lead to problems (I'd rather have 2 inodes with i_ino == 0 than one
pointing to the wrong data) lets just stop setting a default.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/selinuxfs.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8bae68e..45d35e6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -989,7 +989,6 @@ static struct inode *sel_make_inode(struct super_block *sb, int mode)
 	struct inode *ret = new_inode(sb);
 
 	if (ret) {
-		ret->i_ino = get_next_ino();
 		ret->i_mode = mode;
 		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
 	}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
