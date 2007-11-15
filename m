Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFGU811007652
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 11:30:08 -0500
Received: from palrel10.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAFGTim4025783
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 16:29:45 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v7 06/13] NetLabel: add IP address family information to
	the netlbl_skbuff_getattr() function
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 15 Nov 2007 11:29:29 -0500
Message-ID: <20071115162928.9970.80315.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
References: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In order to do any sort of IP header inspection of incoming packets we need to
know which address family, AF_INET/AF_INET6/etc., it belongs to and since the
sk_buff structure does not store this information we need to pass along the
address family separate from the packet itself.
---

 include/net/netlabel.h              |    2 ++
 net/netlabel/netlabel_kapi.c        |    2 ++
 security/selinux/hooks.c            |   24 ++++++++++++++++++------
 security/selinux/include/netlabel.h |    8 +++++++-
 security/selinux/netlabel.c         |   12 +++++++++---
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 18b73cf..a3bffb4 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -363,6 +363,7 @@ int netlbl_sock_setattr(struct sock *sk,
 int netlbl_sock_getattr(struct sock *sk,
 			struct netlbl_lsm_secattr *secattr);
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
+			  u16 family,
 			  struct netlbl_lsm_secattr *secattr);
 void netlbl_skbuff_err(struct sk_buff *skb, int error);
 
@@ -415,6 +416,7 @@ static inline int netlbl_sock_getattr(struct sock *sk,
 	return -ENOSYS;
 }
 static inline int netlbl_skbuff_getattr(const struct sk_buff *skb,
+					u16 family,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOSYS;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index d3762ea..4914615 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -332,6 +332,7 @@ int netlbl_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr)
 /**
  * netlbl_skbuff_getattr - Determine the security attributes of a packet
  * @skb: the packet
+ * @family: protocol family
  * @secattr: the security attributes
  *
  * Description:
@@ -342,6 +343,7 @@ int netlbl_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr)
  *
  */
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
+			  u16 family,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	if (CIPSO_V4_OPTEXIST(skb) &&
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8bb673b..2188b9c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3192,6 +3192,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 /**
  * selinux_skb_extlbl_sid - Determine the external label of a packet
  * @skb: the packet
+ * @family: protocol family
  * @sid: the packet's SID
  *
  * Description:
@@ -3204,13 +3205,16 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
  * selinux_netlbl_skbuff_getsid().
  *
  */
-static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
+static void selinux_skb_extlbl_sid(struct sk_buff *skb,
+				   u16 family,
+				   u32 *sid)
 {
 	u32 xfrm_sid;
 	u32 nlbl_sid;
 
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	if (selinux_netlbl_skbuff_getsid(skb,
+					 family,
 					 (xfrm_sid == SECSID_NULL ?
 					  SECINITSID_NETMSG : xfrm_sid),
 					 &nlbl_sid) != 0)
@@ -3703,7 +3707,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (err)
 		goto out;
 
-	err = selinux_netlbl_sock_rcv_skb(sksec, skb, &ad);
+	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
 	if (err)
 		goto out;
 
@@ -3760,11 +3764,19 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 {
 	u32 peer_secid = SECSID_NULL;
 	int err = 0;
+	u16 family;
+
+	if (sock)
+		family = sock->sk->sk_family;
+	else if (skb->sk)
+		family = skb->sk->sk_family;
+	else
+		family = PF_UNSPEC;
 
-	if (sock && sock->sk->sk_family == PF_UNIX)
+	if (sock && family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		selinux_skb_extlbl_sid(skb, &peer_secid);
+		selinux_skb_extlbl_sid(skb, family, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3825,7 +3837,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, &peersid);
+	selinux_skb_extlbl_sid(skb, sk->sk_family, &peersid);
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3863,7 +3875,7 @@ static void selinux_inet_conn_established(struct sock *sk,
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	selinux_skb_extlbl_sid(skb, &sksec->peer_sid);
+	selinux_skb_extlbl_sid(skb, sk->sk_family, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 218e3f7..272769a 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -46,13 +46,17 @@ void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
 void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 				      struct sk_security_struct *newssec);
 
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u32 base_sid, u32 *sid);
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
+				 u16 family,
+				 u32 base_sid,
+				 u32 *sid);
 
 void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock);
 int selinux_netlbl_socket_post_create(struct socket *sock);
 int selinux_netlbl_inode_permission(struct inode *inode, int mask);
 int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 				struct sk_buff *skb,
+				u16 family,
 				struct avc_audit_data *ad);
 int selinux_netlbl_socket_setsockopt(struct socket *sock,
 				     int level,
@@ -83,6 +87,7 @@ static inline void selinux_netlbl_sk_security_clone(
 }
 
 static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
+					       u16 family,
 					       u32 base_sid,
 					       u32 *sid)
 {
@@ -106,6 +111,7 @@ static inline int selinux_netlbl_inode_permission(struct inode *inode,
 }
 static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 					      struct sk_buff *skb,
+					      u16 family,
 					      struct avc_audit_data *ad)
 {
 	return 0;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index d243ddc..4073d5a 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -141,6 +141,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 /**
  * selinux_netlbl_skbuff_getsid - Get the sid of a packet using NetLabel
  * @skb: the packet
+ * @family: protocol family
  * @base_sid: the SELinux SID to use as a context for MLS only attributes
  * @sid: the SID
  *
@@ -150,7 +151,10 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
  * assign to the packet.  Returns zero on success, negative values on failure.
  *
  */
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u32 base_sid, u32 *sid)
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
+				 u16 family,
+				 u32 base_sid,
+				 u32 *sid)
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
@@ -161,7 +165,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u32 base_sid, u32 *sid)
 	}
 
 	netlbl_secattr_init(&secattr);
-	rc = netlbl_skbuff_getattr(skb, &secattr);
+	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr, base_sid, sid);
 		if (rc == 0 &&
@@ -289,6 +293,7 @@ int selinux_netlbl_inode_permission(struct inode *inode, int mask)
  * selinux_netlbl_sock_rcv_skb - Do an inbound access check using NetLabel
  * @sksec: the sock's sk_security_struct
  * @skb: the packet
+ * @family: protocol family
  * @ad: the audit data
  *
  * Description:
@@ -299,6 +304,7 @@ int selinux_netlbl_inode_permission(struct inode *inode, int mask)
  */
 int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 				struct sk_buff *skb,
+				u16 family,
 				struct avc_audit_data *ad)
 {
 	int rc;
@@ -310,7 +316,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = netlbl_skbuff_getattr(skb, &secattr);
+	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr,
 						    SECINITSID_NETMSG,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
