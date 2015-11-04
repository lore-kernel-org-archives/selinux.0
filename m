Date: Wed, 4 Nov 2015 04:53:15 -0500 (EST)
From: Vladis Dronov <vdronov@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Message-ID: <1877573826.3709395.1446630795740.JavaMail.zimbra@redhat.com>
In-Reply-To: <1216757539.2756181.1446567923836.JavaMail.zimbra@redhat.com>
Subject: [PATCH] selinux: rate-limit unrecognized netlink message warnings
 in selinux_nlmsg_perm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Any process is able to send netlink messages with invalid types.
Make the warning rate-limited to prevent too much log spam.

The warning is supposed to hel

Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 security/selinux/hooks.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e4369d8..bf5010b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4787,10 +4787,9 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			printk(KERN_WARNING
-			       "SELinux: unrecognized netlink message:"
-			       " protocol=%hu nlmsg_type=%hu sclass=%s\n",
-			       sk->sk_protocol, nlh->nlmsg_type,
+			pr_warn_ratelimited("SELinux: unrecognized netlink"
+			       " message: protocol=%hu nlmsg_type=%hu"
+			       " sclass=%s\n", sk->sk_protocol, nlh->nlmsg_type,
 			       secclass_map[sksec->sclass - 1].name);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
--
