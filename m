Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6EDaHhu003092
 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2014 09:36:17 -0400
Subject: [PATCH v2] selinux: fix the default socket labeling in sock_graft()
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Mon, 14 Jul 2014 09:36:13 -0400
Message-ID: <20140714133613.12269.69088.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Milan Broz <gmazyland@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The sock_graft() hook has special handling for AF_INET, AF_INET, and
AF_UNIX sockets as those address families have special hooks which
label the sock before it is attached its associated socket.
Unfortunately, the sock_graft() hook was missing a default approach
to labeling sockets which meant that any other address family which
made use of connections or the accept() syscall would find the
returned socket to be in an "unlabeled" state.  This was recently
demonstrated by the kcrypto/AF_ALG subsystem and the newly released
cryptsetup package (cryptsetup v1.6.5 and later).

This patch preserves the special handling in selinux_sock_graft(),
but adds a default behavior - setting the sock's label equal to the
associated socket - which resolves the problem with AF_ALG and
presumably any other address family which makes use of accept().

Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 include/linux/security.h |    5 ++++-
 security/selinux/hooks.c |   13 +++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6478ce3..794be73 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -987,7 +987,10 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	Retrieve the LSM-specific secid for the sock to enable caching of network
  *	authorizations.
  * @sock_graft:
- *	Sets the socket's isec sid to the sock's sid.
+ *	This hook is called in response to a newly created sock struct being
+ *	grafted onto an existing socket and allows the security module to
+ *	perform whatever security attribute management is necessary for both
+ *	the sock and socket.
  * @inet_conn_request:
  *	Sets the openreq's sid to socket's sid with MLS portion taken from peer sid.
  * @inet_csk_clone:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 336f0a0..b3a6754 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4499,9 +4499,18 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
-	    sk->sk_family == PF_UNIX)
+	switch (sk->sk_family) {
+	case PF_INET:
+	case PF_INET6:
+	case PF_UNIX:
 		isec->sid = sksec->sid;
+		break;
+	default:
+		/* by default there is no special labeling mechanism for the
+		 * sksec label so inherit the label from the parent socket */
+		BUG_ON(sksec->sid != SECINITSID_UNLABELED);
+		sksec->sid = isec->sid;
+	}
 	sksec->sclass = isec->sclass;
 }
 
