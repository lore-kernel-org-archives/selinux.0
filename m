From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 05/18] selinux: remove secondary ops call to sb_umount
Date: Wed, 28 Jan 2009 19:55:33 -0800
Message-Id: <1233201347-17568-6-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-5-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
 <1233201347-17568-4-git-send-email-jmorris@namei.org>
 <1233201347-17568-5-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to sb_umount, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bdd4830..42aa8de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2543,11 +2543,6 @@ static int selinux_mount(char *dev_name,
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
 	const struct cred *cred = current_cred();
-	int rc;
-
-	rc = secondary_ops->sb_umount(mnt, flags);
-	if (rc)
-		return rc;
 
 	return superblock_has_perm(cred, mnt->mnt_sb,
 				   FILESYSTEM__UNMOUNT, NULL);
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
