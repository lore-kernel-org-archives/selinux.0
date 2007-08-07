Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EGSna027437
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:16:28 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EGKmT019843
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:16:20 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141537.121835132@hp.com>
References: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:18 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 3/5] NetLabel: add IP address family information to the netlbl_skbuff_getattr() function
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

Index: linux-2.6_staticlbl/include/net/netlabel.h
===================================================================
--- linux-2.6_staticlbl.orig/include/net/netlabel.h
+++ linux-2.6_staticlbl/include/net/netlabel.h
@@ -366,6 +366,7 @@ int netlbl_sock_setattr(struct sock *sk,
 int netlbl_sock_getattr(struct sock *sk,
 			struct netlbl_lsm_secattr *secattr);
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
+			  u16 family,
 			  struct netlbl_lsm_secattr *secattr);
 void netlbl_skbuff_err(struct sk_buff *skb, int error);
 
@@ -418,6 +419,7 @@ static inline int netlbl_sock_getattr(st
 	return -ENOSYS;
 }
 static inline int netlbl_skbuff_getattr(const struct sk_buff *skb,
+					u16 family,
 					struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOSYS;
Index: linux-2.6_staticlbl/net/netlabel/netlabel_kapi.c
===================================================================
--- linux-2.6_staticlbl.orig/net/netlabel/netlabel_kapi.c
+++ linux-2.6_staticlbl/net/netlabel/netlabel_kapi.c
@@ -331,6 +331,7 @@ int netlbl_sock_getattr(struct sock *sk,
 /**
  * netlbl_skbuff_getattr - Determine the security attributes of a packet
  * @skb: the packet
+ * @family: protocol family
  * @secattr: the security attributes
  *
  * Description:
@@ -341,6 +342,7 @@ int netlbl_sock_getattr(struct sock *sk,
  *
  */
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
+			  u16 family,
 			  struct netlbl_lsm_secattr *secattr)
 {
 	if (CIPSO_V4_OPTEXIST(skb) &&
Index: linux-2.6_staticlbl/security/selinux/hooks.c
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/hooks.c
+++ linux-2.6_staticlbl/security/selinux/hooks.c
@@ -3129,6 +3129,7 @@ static int selinux_parse_skb(struct sk_b
 /**
  * selinux_skb_extlbl_sid - Determine the external label of a packet
  * @skb: the packet
+ * @family: protocol family
  * @sid: the packet's SID
  *
  * Description:
@@ -3141,13 +3142,16 @@ static int selinux_parse_skb(struct sk_b
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
@@ -3635,7 +3639,7 @@ static int selinux_socket_sock_rcv_skb(s
 	if (err)
 		goto out;
 
-	err = selinux_netlbl_sock_rcv_skb(sksec, skb, &ad);
+	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
 	if (err)
 		goto out;
 
@@ -3692,11 +3696,19 @@ static int selinux_socket_getpeersec_dgr
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
@@ -3757,7 +3769,7 @@ static int selinux_inet_conn_request(str
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, &peersid);
+	selinux_skb_extlbl_sid(skb, sk->sk_family, &peersid);
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3795,7 +3807,7 @@ static void selinux_inet_conn_establishe
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	selinux_skb_extlbl_sid(skb, &sksec->peer_sid);
+	selinux_skb_extlbl_sid(skb, sk->sk_family, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
Index: linux-2.6_staticlbl/security/selinux/include/netlabel.h
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/include/netlabel.h
+++ linux-2.6_staticlbl/security/selinux/include/netlabel.h
@@ -46,13 +46,17 @@ void selinux_netlbl_sk_security_init(str
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
@@ -83,6 +87,7 @@ static inline void selinux_netlbl_sk_sec
 }
 
 static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
+					       u16 family,
 					       u32 base_sid,
 					       u32 *sid)
 {
@@ -106,6 +111,7 @@ static inline int selinux_netlbl_inode_p
 }
 static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 					      struct sk_buff *skb,
+					      u16 family,
 					      struct avc_audit_data *ad)
 {
 	return 0;
Index: linux-2.6_staticlbl/security/selinux/netlabel.c
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/netlabel.c
+++ linux-2.6_staticlbl/security/selinux/netlabel.c
@@ -141,6 +141,7 @@ void selinux_netlbl_sk_security_clone(st
 /**
  * selinux_netlbl_skbuff_getsid - Get the sid of a packet using NetLabel
  * @skb: the packet
+ * @family: protocol family
  * @base_sid: the SELinux SID to use as a context for MLS only attributes
  * @sid: the SID
  *
@@ -150,7 +151,10 @@ void selinux_netlbl_sk_security_clone(st
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
@@ -161,7 +165,7 @@ int selinux_netlbl_skbuff_getsid(struct 
 	}
 
 	netlbl_secattr_init(&secattr);
-	rc = netlbl_skbuff_getattr(skb, &secattr);
+	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr, base_sid, sid);
 		if (rc == 0 &&
@@ -289,6 +293,7 @@ int selinux_netlbl_inode_permission(stru
  * selinux_netlbl_sock_rcv_skb - Do an inbound access check using NetLabel
  * @sksec: the sock's sk_security_struct
  * @skb: the packet
+ * @family: protocol family
  * @ad: the audit data
  *
  * Description:
@@ -299,6 +304,7 @@ int selinux_netlbl_inode_permission(stru
  */
 int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 				struct sk_buff *skb,
+				u16 family,
 				struct avc_audit_data *ad)
 {
 	int rc;
@@ -310,7 +316,7 @@ int selinux_netlbl_sock_rcv_skb(struct s
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = netlbl_skbuff_getattr(skb, &secattr);
+	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr,
 						    SECINITSID_NETMSG,

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
