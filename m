Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SF9vnX012277
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 11:09:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6SFA0kH014618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 11:10:00 -0400
Subject: [PATCH] Revert "selinux: fix the default socket labeling in
 sock_graft()"
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 28 Jul 2014 11:09:58 -0400
Message-ID: <20140728150958.23156.75132.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This reverts commit 4da6daf4d3df5a977e4623963f141a627fd2efce.

Unfortunately, the commit in question caused problems with Bluetooth
devices, specifically it caused them to get caught in the newly
created BUG_ON() check.  The AF_ALG problem still exists, but will be
addressed in a future patch.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 include/linux/security.h |    5 +----
 security/selinux/hooks.c |   13 ++-----------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 794be73..6478ce3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -987,10 +987,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	Retrieve the LSM-specific secid for the sock to enable caching of network
  *	authorizations.
  * @sock_graft:
- *	This hook is called in response to a newly created sock struct being
- *	grafted onto an existing socket and allows the security module to
- *	perform whatever security attribute management is necessary for both
- *	the sock and socket.
+ *	Sets the socket's isec sid to the sock's sid.
  * @inet_conn_request:
  *	Sets the openreq's sid to socket's sid with MLS portion taken from peer sid.
  * @inet_csk_clone:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b3a6754..336f0a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4499,18 +4499,9 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	switch (sk->sk_family) {
-	case PF_INET:
-	case PF_INET6:
-	case PF_UNIX:
+	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
+	    sk->sk_family == PF_UNIX)
 		isec->sid = sksec->sid;
-		break;
-	default:
-		/* by default there is no special labeling mechanism for the
-		 * sksec label so inherit the label from the parent socket */
-		BUG_ON(sksec->sid != SECINITSID_UNLABELED);
-		sksec->sid = isec->sid;
-	}
 	sksec->sclass = isec->sclass;
 }
 
