From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: pass last path component in may_create
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 28 Apr 2011 15:01:56 -0400
Message-ID: <20110428190155.4332.66813.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New inodes are created in a two stage process.  We first will compute the
label on a new inode in security_inode_create() and check if the
operation is allowed.  We will then actually re-compute that same label and
apply it in security_inode_init_security().  The change to do new label
calculations based in part on the last component of the path name only
passed the path component information all the way down the
security_inode_init_security hook.  Down the security_inode_create hook the
path information did not make it past may_create.  Thus the two calculations
came up differently and the permissions check might not actually be against
the label that is created.  Pass and use the same information in both places
to harmonize the calculations and checks.

Reported-by: Dominick Grift <domg472@gmail.com>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2288203..f84d3d7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1582,7 +1582,8 @@ static int may_create(struct inode *dir,
 		return rc;
 
 	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
-		rc = security_transition_sid(sid, dsec->sid, tclass, NULL, &newsid);
+		rc = security_transition_sid(sid, dsec->sid, tclass,
+					     &dentry->d_name, &newsid);
 		if (rc)
 			return rc;
 	}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
