Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EJt99h028824
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 15:55:09 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EJt8tB026644
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 19:55:08 GMT
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 67BA435356
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 15:55:08 -0400 (EDT)
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614195450.864175486@hp.com>
References: <20070614195103.903260734@hp.com>
Date: Thu, 14 Jun 2007 15:51:04 -0400
To: selinux@tycho.nsa.gov
Subject: [REFERENCE ONLY 1/1] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These changes will make NetLabel behave like labeled IPsec where there is an
access check for both labeled and unlabeled packets as well as providing the
ability to restrict domains to receiving only labeled packets when NetLabel is
in use.  The changes to the policy are straight forward with the following
necessary to receive labeled traffic (assuming SECINITSID_NETMSG is defined to
use "netlabel_peer_t"):

 allow mydomain_t netlabel_peer_t:{tcp_socket udp_socket rawip_socket} recvfrom;

The policy for unlabeled traffic would be:

 allow mydomain_t unlabeled_t:{tcp_socket udp_socket rawip_socket} recvfrom;

---
 security/selinux/hooks.c    |   21 +++++++++++----------
 security/selinux/netlabel.c |   25 ++++++++++---------------
 2 files changed, 21 insertions(+), 25 deletions(-)

Index: net-2.6_netmsg/security/selinux/hooks.c
===================================================================
--- net-2.6_netmsg.orig/security/selinux/hooks.c
+++ net-2.6_netmsg/security/selinux/hooks.c
@@ -3124,17 +3124,19 @@ static int selinux_parse_skb(struct sk_b
 /**
  * selinux_skb_extlbl_sid - Determine the external label of a packet
  * @skb: the packet
- * @base_sid: the SELinux SID to use as a context for MLS only external labels
  * @sid: the packet's SID
  *
  * Description:
  * Check the various different forms of external packet labeling and determine
- * the external SID for the packet.
+ * the external SID for the packet.  If only one form of external labeling is
+ * present then it is used, if both labeled IPsec and NetLabel labels are
+ * present then the SELinux type information is taken from the labeled IPsec
+ * SA and the MLS sensitivity label information is taken from the NetLabel
+ * security attributes.  This bit of "magic" is done in the call to
+ * selinux_netlbl_skbuff_getsid().
  *
  */
-static void selinux_skb_extlbl_sid(struct sk_buff *skb,
-				   u32 base_sid,
-				   u32 *sid)
+static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
 {
 	u32 xfrm_sid;
 	u32 nlbl_sid;
@@ -3142,10 +3144,9 @@ static void selinux_skb_extlbl_sid(struc
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	if (selinux_netlbl_skbuff_getsid(skb,
 					 (xfrm_sid == SECSID_NULL ?
-					  base_sid : xfrm_sid),
+					  SECINITSID_NETMSG : xfrm_sid),
 					 &nlbl_sid) != 0)
 		nlbl_sid = SECSID_NULL;
-
 	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
 }
 
@@ -3690,7 +3691,7 @@ static int selinux_socket_getpeersec_dgr
 	if (sock && sock->sk->sk_family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peer_secid);
+		selinux_skb_extlbl_sid(skb, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3751,7 +3752,7 @@ static int selinux_inet_conn_request(str
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peersid);
+	selinux_skb_extlbl_sid(skb, &peersid);
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3789,7 +3790,7 @@ static void selinux_inet_conn_establishe
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &sksec->peer_sid);
+	selinux_skb_extlbl_sid(skb, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
Index: net-2.6_netmsg/security/selinux/netlabel.c
===================================================================
--- net-2.6_netmsg.orig/security/selinux/netlabel.c
+++ net-2.6_netmsg/security/selinux/netlabel.c
@@ -198,7 +198,7 @@ void selinux_netlbl_sock_graft(struct so
 	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
 	    secattr.flags != NETLBL_SECATTR_NONE &&
 	    security_netlbl_secattr_to_sid(&secattr,
-					   SECINITSID_UNLABELED,
+					   SECINITSID_NETMSG,
 					   &nlbl_peer_sid) == 0)
 		sksec->peer_sid = nlbl_peer_sid;
 	netlbl_secattr_destroy(&secattr);
@@ -293,37 +293,32 @@ int selinux_netlbl_sock_rcv_skb(struct s
 {
 	int rc;
 	u32 netlbl_sid;
-	u32 recv_perm;
+	u32 perm;
 
-	rc = selinux_netlbl_skbuff_getsid(skb,
-					  SECINITSID_UNLABELED,
-					  &netlbl_sid);
+	rc = selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &netlbl_sid);
 	if (rc != 0)
 		return rc;
 
 	if (netlbl_sid == SECSID_NULL)
-		return 0;
+		netlbl_sid = SECINITSID_UNLABELED;
 
 	switch (sksec->sclass) {
 	case SECCLASS_UDP_SOCKET:
-		recv_perm = UDP_SOCKET__RECVFROM;
+		perm = UDP_SOCKET__RECVFROM;
 		break;
 	case SECCLASS_TCP_SOCKET:
-		recv_perm = TCP_SOCKET__RECVFROM;
+		perm = TCP_SOCKET__RECVFROM;
 		break;
 	default:
-		recv_perm = RAWIP_SOCKET__RECVFROM;
+		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(sksec->sid,
-			  netlbl_sid,
-			  sksec->sclass,
-			  recv_perm,
-			  ad);
+	rc = avc_has_perm(sksec->sid, netlbl_sid, sksec->sclass, perm, ad);
 	if (rc == 0)
 		return 0;
 
-	netlbl_skbuff_err(skb, rc);
+	if (netlbl_sid != SECSID_NULL)
+		netlbl_skbuff_err(skb, rc);
 	return rc;
 }
 

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
