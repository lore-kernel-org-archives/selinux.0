Subject: [PATCH] SELinux: Use unknown perm handling to handle unknown
 netlink msg types
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Wed, 05 Nov 2008 09:34:42 -0500
Message-Id: <1225895682.3300.111.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently when SELinux has not been updated to handle a netlink message
type the operation is denied with EINVAL.  This patch will leave the
audit/warning message so things get fixed but if policy chose to allow
unknowns this will allow the netlink operation.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f85597a..c6f8f3e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4387,7 +4387,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 				  "SELinux:  unrecognized netlink message"
 				  " type=%hu for sclass=%hu\n",
 				  nlh->nlmsg_type, isec->sclass);
-			if (!selinux_enforcing)
+			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
