From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/5] security: make LSMs explicitly mask off permissions
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 23 Jul 2010 11:43:57 -0400
Message-ID: <20100723154357.13217.2456.stgit@paris.rdu.redhat.com>
In-Reply-To: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
References: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux needs to pass the MAY_ACCESS flag so it can handle auditting
correctly.  Presently the masking of MAY_* flags is done in the VFS.  In
order to allow LSMs to decide what flags they care about and what flags
they don't just pass them all and the each LSM mask off what they don't
need.  This patch should contain no functional changes to either the VFS or
any LSM.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 fs/namei.c                 |    3 +--
 security/selinux/hooks.c   |    2 ++
 security/smack/smack_lsm.c |    2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0049114..13ff4ab 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -282,8 +282,7 @@ int inode_permission(struct inode *inode, int mask)
 	if (retval)
 		return retval;
 
-	return security_inode_permission(inode,
-			mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND));
+	return security_inode_permission(inode, mask);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c7130cb..62a503a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2648,6 +2648,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 {
 	const struct cred *cred = current_cred();
 
+	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
+
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index be07665..c448d57 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -598,6 +598,8 @@ static int smack_inode_rename(struct inode *old_inode,
 static int smack_inode_permission(struct inode *inode, int mask)
 {
 	struct smk_audit_info ad;
+
+	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
 	/*
 	 * No permission to check. Existence test. Yup, it's there.
 	 */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
