Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA4AaHb4019971
 for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2015 05:36:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 98D838F4E6
 for <selinux@tycho.nsa.gov>; Wed,  4 Nov 2015 10:36:00 +0000 (UTC)
From: Vladis Dronov <vdronov@redhat.com>
To: "<selinux@tycho.nsa.gov>" <linux-security-module@vger.kernel.org>
Cc: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2] selinux: rate-limit unrecognized netlink message warnings
 in selinux_nlmsg_perm()
Date: Wed,  4 Nov 2015 11:35:51 +0100
Message-Id: <1446633352-5070-1-git-send-email-vdronov@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Any process is able to send netlink messages with invalid types.
Make the warning rate-limited to prevent too much log spam.

The warning is supposed to help to find misbehaving programs, so
print the triggering command name and pid.

Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 security/selinux/hooks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e4369d8..3d8087d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4787,11 +4787,12 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			printk(KERN_WARNING
-			       "SELinux: unrecognized netlink message:"
-			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
+			pr_warn_ratelimited("SELinux: unrecognized netlink"
+			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
+			       " from %s[%d]\n",
 			       sk->sk_protocol, nlh->nlmsg_type,
-			       secclass_map[sksec->sclass - 1].name);
+			       secclass_map[sksec->sclass - 1].name,
+			       current->comm, current->pid);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
-- 
