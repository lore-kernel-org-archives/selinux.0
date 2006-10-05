Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95Mb5CG005928
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:37:05 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95MZqqJ008544
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 22:35:52 GMT
Message-Id: <20061005223704.067757000@hp.com>
References: <20061005222823.387569000@hp.com>
Date: Thu, 05 Oct 2006 18:28:24 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/1] NetLabel: use SECINITSID_UNLABELED for a base SID
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch changes NetLabel to use SECINITSID_UNLABLELED as it's source of
SELinux type information when generating a NetLabel context.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/ss/services.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

Index: net-2.6_bugfix/security/selinux/ss/services.c
===================================================================
--- net-2.6_bugfix.orig/security/selinux/ss/services.c
+++ net-2.6_bugfix/security/selinux/ss/services.c
@@ -2336,7 +2336,7 @@ static int selinux_netlbl_secattr_to_sid
 			selinux_netlbl_cache_add(skb, &ctx_new);
 		ebitmap_destroy(&ctx_new.range.level[0].cat);
 	} else {
-		*sid = SECINITSID_UNLABELED;
+		*sid = SECSID_NULL;
 		rc = 0;
 	}
 
@@ -2519,7 +2519,7 @@ void selinux_netlbl_sock_graft(struct so
 	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
 	    selinux_netlbl_secattr_to_sid(NULL,
 					  &secattr,
-					  sksec->sid,
+					  SECINITSID_UNLABELED,
 					  &nlbl_peer_sid) == 0)
 		sksec->peer_sid = nlbl_peer_sid;
 	netlbl_secattr_destroy(&secattr);
@@ -2552,9 +2552,6 @@ u32 selinux_netlbl_inet_conn_request(str
 	if (rc != 0)
 		return SECSID_NULL;
 
-	if (peer_sid == SECINITSID_UNLABELED)
-		return SECSID_NULL;
-
 	return peer_sid;
 }
 
@@ -2616,11 +2613,13 @@ int selinux_netlbl_sock_rcv_skb(struct s
 	u32 netlbl_sid;
 	u32 recv_perm;
 
-	rc = selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &netlbl_sid);
+	rc = selinux_netlbl_skbuff_getsid(skb,
+					  SECINITSID_UNLABELED,
+					  &netlbl_sid);
 	if (rc != 0)
 		return rc;
 
-	if (netlbl_sid == SECINITSID_UNLABELED)
+	if (netlbl_sid == SECSID_NULL)
 		return 0;
 
 	switch (sksec->sclass) {
@@ -2658,10 +2657,6 @@ int selinux_netlbl_sock_rcv_skb(struct s
 u32 selinux_netlbl_socket_getpeersec_stream(struct socket *sock)
 {
 	struct sk_security_struct *sksec = sock->sk->sk_security;
-
-	if (sksec->peer_sid == SECINITSID_UNLABELED)
-		return SECSID_NULL;
-
 	return sksec->peer_sid;
 }
 
@@ -2677,16 +2672,10 @@ u32 selinux_netlbl_socket_getpeersec_str
 u32 selinux_netlbl_socket_getpeersec_dgram(struct sk_buff *skb)
 {
 	int peer_sid;
-	struct sock *sk = skb->sk;
-	struct inode_security_struct *isec;
-
-	if (sk == NULL || sk->sk_socket == NULL)
-		return SECSID_NULL;
 
-	isec = SOCK_INODE(sk->sk_socket)->i_security;
-	if (selinux_netlbl_skbuff_getsid(skb, isec->sid, &peer_sid) != 0)
-		return SECSID_NULL;
-	if (peer_sid == SECINITSID_UNLABELED)
+	if (selinux_netlbl_skbuff_getsid(skb,
+					 SECINITSID_UNLABELED,
+					 &peer_sid) != 0)
 		return SECSID_NULL;
 
 	return peer_sid;

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
