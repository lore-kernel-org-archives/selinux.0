From: Richard Guy Briggs <rgb@redhat.com>
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 trinity@vger.kernel.org
Subject: [PATCH] selinux: convert WARN_ONCE() to printk_once() in
 selinux_nlmsg_perm()
Date: Wed, 12 Nov 2014 14:01:34 -0500
Message-Id: <49c549f887cd1a0284f79251765606eccacd11e3.1415818605.git.rgb@redhat.com>
In-Reply-To: <2373486.3IgvVOFVQB@sifl>
References: <2373486.3IgvVOFVQB@sifl>
Cc: vlee@twopensource.com, james.l.morris@oracle.com, sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Convert WARN_ONCE() to printk_once() in selinux_nlmsg_perm().

After conversion from audit_log() in commit e173fb26, WARN_ONCE() was deemed
too alarmist, so switch it to printk_once().  If this gets buried in the noise,
it may be converted to a rate-limited call in the future.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/selinux/hooks.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e663141..17d0066 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4725,9 +4725,9 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			WARN_ONCE(1, "selinux_nlmsg_perm: unrecognized netlink message:"
-				  " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
-				  sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
+			printk_once("selinux_nlmsg_perm: unrecognized netlink message:"
+				    " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
+				    sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
-- 
1.7.1
