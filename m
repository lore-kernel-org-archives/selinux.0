Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sACLaGf5021531
 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2014 16:36:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sACLaEDf023748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2014 16:36:14 -0500
Subject: [PATCH] selinux: convert WARN_ONCE() to printk() in
 selinux_nlmsg_perm()
From: Paul Moore <pmoore@redhat.com>
To: rgb@redhat.com, selinux@tycho.nsa.gov
Date: Wed, 12 Nov 2014 16:36:13 -0500
Message-ID: <20141112213613.7528.34729.stgit@localhost>
In-Reply-To: <20141112212515.GF28076@madcap2.tricolour.ca>
References: <20141112212515.GF28076@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Guy Briggs <rgb@redhat.com>

Convert WARN_ONCE() to printk() in selinux_nlmsg_perm().

After conversion from audit_log() in commit e173fb26, WARN_ONCE() was
deemed too alarmist, so switch it to printk().

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
[PM: Changed to printk(WARNING) so we can all of the different invalid
 netlink messages.  In Richard's defense, he brought this point up
 earlier, but I didn't understand his point at the time.]
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2478976..654f071 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4727,9 +4727,10 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			WARN_ONCE(1, "selinux_nlmsg_perm: unrecognized netlink message:"
-				  " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
-				  sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
+			printk(KERN_WARNING
+			       "SELinux: unrecognized netlink message:"
+			       " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
+			       sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
