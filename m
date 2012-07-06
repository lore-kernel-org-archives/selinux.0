From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: [PATCH 2/2] SELinux: do not check open perms if they are not known to policy
Date: Fri,  6 Jul 2012 14:13:30 -0400
Message-Id: <1341598410-29965-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1341598410-29965-1-git-send-email-eparis@redhat.com>
References: <1341598410-29965-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I introduced open perms policy didn't understand them and I
implemented them as a policycap.  When I added the checking of open perm
to truncate I forgot to conditionalize it on the userspace defined
policy capability.  Running an old policy with a new kernel will not
check open on open(2) but will check it on truncate.  Conditionalize the
truncate check the same as the open check.

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: stable@vger.kernel.org # 3.4.x
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e94349b..ac9e7099 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2709,7 +2709,7 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (ia_valid & ATTR_SIZE)
+	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE))
 		av |= FILE__OPEN;
 
 	return dentry_has_perm(cred, dentry, av);
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
