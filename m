Subject: [PATCH 1/3] SELinux: require open policycap in truncate checks
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Wed, 06 Jun 2012 11:53:33 -0400
Message-ID: <20120606155333.32443.15937.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We were accidentally checking the open permission even on policies that did
not define the open permission policy capbility.  We should only check open
if the policy explicitly claims to mediate the 'open' permission.

This was reported as a problem in that a machine with old policy which did not
define the open policy capbility would boot, but the user was unable to ssh
into the machine.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eric Paris <eparis@redhat.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1e59f47..72df621 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2758,7 +2758,7 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (ia_valid & ATTR_SIZE)
+	if ((ia_valid & ATTR_SIZE) && selinux_policycap_openperm)
 		av |= FILE__OPEN;
 
 	return dentry_has_perm(cred, dentry, av);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
