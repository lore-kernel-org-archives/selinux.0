Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t32FwJLs005963
 for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2015 11:58:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t32FwGVN021085
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2015 11:58:16 -0400
From: Marek Milkovic <mmilkovi@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: Print 'sclass' as string when unrecognized netlink
 message occurs
Date: Thu,  2 Apr 2015 17:58:14 +0200
Message-Id: <1427990294-19573-1-git-send-email-mmilkovi@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This prints the 'sclass' field as string instead of index in unrecognized netlink message.
The textual representation makes it easier to distinguish the right class.

Signed-off-by: Marek Milkovic <mmilkovi@redhat.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 87a9156..d75f525 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4712,8 +4712,8 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 		if (err == -EINVAL) {
 			printk(KERN_WARNING
 			       "SELinux: unrecognized netlink message:"
-			       " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
-			       sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
+			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
+			       sk->sk_protocol, nlh->nlmsg_type, secclass_map[sksec->sclass - 1].name);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
-- 
2.1.0
