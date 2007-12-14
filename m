Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBELvKoj028624
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 16:57:20 -0500
Received: from QMTA08.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBELvJIO020513
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 21:57:19 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v8 13/18] SELinux: Better integration between peer
	labeling subsystems
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 14 Dec 2007 16:51:02 -0500
Message-ID: <20071214215102.10069.72455.stgit@flek.lan>
In-Reply-To: <20071214213548.10069.59135.stgit@flek.lan>
References: <20071214213548.10069.59135.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rework the handling of network peer labels so that the different peer labeling
subsystems work better together.  This includes moving both subsystems to a
single "peer" object class which involves not only changes to the permission
checks but an improved method of consolidating multiple packet peer labels.
As part of this work the inbound packet permission check code has been heavily
modified to handle both the old and new behavior in as sane a fashion as
possible.
---

 security/selinux/hooks.c            |  204 +++++++++++++++++++----------------
 security/selinux/include/netlabel.h |    3 +
 security/selinux/include/objsec.h   |    2 
 security/selinux/include/security.h |    4 +
 security/selinux/netlabel.c         |   10 +-
 security/selinux/ss/services.c      |   85 +++++++++++++++
 6 files changed, 208 insertions(+), 100 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 05b58cc..e088a31 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -50,6 +50,7 @@
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
+#include <net/net_namespace.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 #include <linux/bitops.h>
@@ -3189,36 +3190,39 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 }
 
 /**
- * selinux_skb_extlbl_sid - Determine the external label of a packet
+ * selinux_skb_peerlbl_sid - Determine the peer label of a packet
  * @skb: the packet
  * @family: protocol family
- * @sid: the packet's SID
+ * @sid: the packet's peer label SID
  *
  * Description:
- * Check the various different forms of external packet labeling and determine
- * the external SID for the packet.  If only one form of external labeling is
- * present then it is used, if both labeled IPsec and NetLabel labels are
- * present then the SELinux type information is taken from the labeled IPsec
- * SA and the MLS sensitivity label information is taken from the NetLabel
- * security attributes.  This bit of "magic" is done in the call to
- * selinux_netlbl_skbuff_getsid().
+ * Check the various different forms of network peer labeling and determine
+ * the peer label/SID for the packet; most of the magic actually occurs in
+ * the security server function security_net_peersid_cmp().  The function
+ * returns zero if the value in @sid is valid (although it may be SECSID_NULL)
+ * or -EACCES if @sid is invalid due to inconsistencies with the different
+ * peer labels.
  *
  */
-static void selinux_skb_extlbl_sid(struct sk_buff *skb,
-				   u16 family,
-				   u32 *sid)
+static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 {
 	u32 xfrm_sid;
 	u32 nlbl_sid;
+	u32 nlbl_type;
 
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
-	if (selinux_netlbl_skbuff_getsid(skb,
-					 family,
-					 (xfrm_sid == SECSID_NULL ?
-					  SECINITSID_NETMSG : xfrm_sid),
-					 &nlbl_sid) != 0)
-		nlbl_sid = SECSID_NULL;
-	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
+	selinux_netlbl_skbuff_getsid(skb,
+				     family,
+				     SECINITSID_NETMSG,
+				     &nlbl_type,
+				     &nlbl_sid);
+
+	if (security_net_peersid_resolve(nlbl_sid, nlbl_type,
+					 xfrm_sid,
+					 sid) != 0)
+		return -EACCES;
+
+	return 0;
 }
 
 /* socket security operations */
@@ -3284,6 +3288,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	if (sock->sk) {
 		sksec = sock->sk->sk_security;
 		sksec->sid = isec->sid;
+		sksec->sclass = isec->sclass;
 		err = selinux_netlbl_socket_post_create(sock);
 	}
 
@@ -3587,104 +3592,114 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	return 0;
 }
 
-static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
-				       struct avc_audit_data *ad,
-				       u16 family, char *addrp)
+static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
+						struct sk_buff *skb,
+						struct avc_audit_data *ad,
+						u16 family,
+						char *addrp)
 {
-	int err = 0;
-	u32 netif_perm, node_perm, node_sid, if_sid, recv_perm = 0;
-	struct socket *sock;
-	u16 sock_class = 0;
-	u32 sock_sid = 0;
-
- 	read_lock_bh(&sk->sk_callback_lock);
- 	sock = sk->sk_socket;
- 	if (sock) {
- 		struct inode *inode;
- 		inode = SOCK_INODE(sock);
- 		if (inode) {
- 			struct inode_security_struct *isec;
- 			isec = inode->i_security;
- 			sock_sid = isec->sid;
- 			sock_class = isec->sclass;
- 		}
- 	}
- 	read_unlock_bh(&sk->sk_callback_lock);
- 	if (!sock_sid)
-  		goto out;
-
-	if (!skb->dev)
-		goto out;
+	int err;
+	struct sk_security_struct *sksec = sk->sk_security;
+	u16 sk_class;
+	u32 netif_perm, node_perm, recv_perm;
+	u32 port_sid, node_sid, if_sid, sk_sid;
 
-	err = sel_netif_sid(skb->iif, &if_sid);
-	if (err)
-		goto out;
+	sk_sid = sksec->sid;
+	sk_class = sksec->sclass;
 
-	switch (sock_class) {
+	switch (sk_class) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
 		node_perm = NODE__UDP_RECV;
 		recv_perm = UDP_SOCKET__RECV_MSG;
 		break;
-	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_RECV;
 		node_perm = NODE__TCP_RECV;
 		recv_perm = TCP_SOCKET__RECV_MSG;
 		break;
-
 	case SECCLASS_DCCP_SOCKET:
 		netif_perm = NETIF__DCCP_RECV;
 		node_perm = NODE__DCCP_RECV;
 		recv_perm = DCCP_SOCKET__RECV_MSG;
 		break;
-
 	default:
 		netif_perm = NETIF__RAWIP_RECV;
 		node_perm = NODE__RAWIP_RECV;
+		recv_perm = 0;
 		break;
 	}
 
-	err = avc_has_perm(sock_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
+	err = sel_netif_sid(skb->iif, &if_sid);
 	if (err)
-		goto out;
+		return err;
+	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
+	if (err)
+		return err;
 	
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
-		goto out;
-	
-	err = avc_has_perm(sock_sid, node_sid, SECCLASS_NODE, node_perm, ad);
+		return err;
+	err = avc_has_perm(sk_sid, node_sid, SECCLASS_NODE, node_perm, ad);
 	if (err)
-		goto out;
+		return err;
 
-	if (recv_perm) {
-		u32 port_sid;
+	if (!recv_perm)
+		return 0;
+	err = security_port_sid(sk->sk_family, sk->sk_type,
+				sk->sk_protocol, ntohs(ad->u.net.sport),
+				&port_sid);
+	if (err)
+		return err;
+	return avc_has_perm(sk_sid, port_sid, sk_class, recv_perm, ad);
+}
 
-		err = security_port_sid(sk->sk_family, sk->sk_type,
-		                        sk->sk_protocol, ntohs(ad->u.net.sport),
-		                        &port_sid);
-		if (err)
-			goto out;
+static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
+				       struct avc_audit_data *ad,
+				       u16 family, char *addrp)
+{
+	int err;
+	struct sk_security_struct *sksec = sk->sk_security;
+	u32 peer_sid;
+	u32 sk_sid = sksec->sid;
+
+	if (selinux_compat_net)
+		err = selinux_sock_rcv_skb_iptables_compat(sk, skb, ad,
+							   family, addrp);
+	else
+		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+				   PACKET__RECV, ad);
+	if (err)
+		return err;
 
-		err = avc_has_perm(sock_sid, port_sid,
-				   sock_class, recv_perm, ad);
+	if (selinux_policycap_netpeer) {
+		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
+		if (err)
+			return err;
+		err = avc_has_perm(sk_sid, peer_sid,
+				   SECCLASS_PEER, PEER__RECV, ad);
+	} else {
+		err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, ad);
+		if (err)
+			return err;
+		err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, ad);
 	}
 
-out:
 	return err;
 }
 
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u16 family;
-	char *addrp;
-	int err = 0;
-	struct avc_audit_data ad;
+	int err;
 	struct sk_security_struct *sksec = sk->sk_security;
+	u16 family = sk->sk_family;
+	u32 sk_sid = sksec->sid;
+	u32 peer_sid;
+	struct avc_audit_data ad;
+	char *addrp;
 
-	family = sk->sk_family;
 	if (family != PF_INET && family != PF_INET6)
-		goto out;
+		return 0;
 
 	/* Handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -3693,26 +3708,27 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = skb->iif;
 	ad.u.net.family = family;
-
 	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
 	if (err)
-		goto out;
+		return err;
 
-	if (selinux_compat_net)
-		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family, addrp);
-	else
-		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
-				   PACKET__RECV, &ad);
-	if (err)
-		goto out;
+	/* If any sort of compatibility mode is enabled then handoff processing
+	 * to the selinux_sock_rcv_skb_compat() function to deal with the
+	 * special handling.  We do this in an attempt to keep this function
+	 * as fast and as clean as possible. */
+	if (selinux_compat_net || !selinux_policycap_netpeer)
+		return selinux_sock_rcv_skb_compat(sk, skb, &ad,
+						   family, addrp);
 
-	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
+	err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+			   PACKET__RECV, &ad);
 	if (err)
-		goto out;
+		return err;
 
-	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
-out:	
-	return err;
+	err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
+	if (err)
+		return err;
+	return avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER, PEER__RECV, &ad);
 }
 
 static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
@@ -3775,7 +3791,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 	if (sock && family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		selinux_skb_extlbl_sid(skb, family, &peer_secid);
+		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3801,6 +3817,7 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 
 	newssec->sid = ssec->sid;
 	newssec->peer_sid = ssec->peer_sid;
+	newssec->sclass = ssec->sclass;
 
 	selinux_netlbl_sk_security_clone(ssec, newssec);
 }
@@ -3824,6 +3841,7 @@ static void selinux_sock_graft(struct sock* sk, struct socket *parent)
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
 		isec->sid = sksec->sid;
+	sksec->sclass = isec->sclass;
 
 	selinux_netlbl_sock_graft(sk, parent);
 }
@@ -3836,7 +3854,9 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, sk->sk_family, &peersid);
+	err = selinux_skb_peerlbl_sid(skb, sk->sk_family, &peersid);
+	if (err)
+		return err;
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3874,7 +3894,7 @@ static void selinux_inet_conn_established(struct sock *sk,
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	selinux_skb_extlbl_sid(skb, sk->sk_family, &sksec->peer_sid);
+	selinux_skb_peerlbl_sid(skb, sk->sk_family, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 272769a..c8c05a6 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -49,6 +49,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
 				 u32 base_sid,
+				 u32 *type,
 				 u32 *sid);
 
 void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock);
@@ -89,8 +90,10 @@ static inline void selinux_netlbl_sk_security_clone(
 static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 					       u16 family,
 					       u32 base_sid,
+					       u32 *type,
 					       u32 *sid)
 {
+	*type = NETLBL_NLTYPE_NONE;
 	*sid = SECSID_NULL;
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6140734..1114629 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -112,8 +112,8 @@ struct sk_security_struct {
 	struct sock *sk;		/* back pointer to sk object */
 	u32 sid;			/* SID of this object */
 	u32 peer_sid;			/* SID of peer */
-#ifdef CONFIG_NETLABEL
 	u16 sclass;			/* sock security class */
+#ifdef CONFIG_NETLABEL
 	enum {				/* NetLabel state */
 		NLBL_UNSET = 0,
 		NLBL_REQUIRE,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a22de97..9347e2d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -99,6 +99,10 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
+int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
+				 u32 xfrm_sid,
+				 u32 *peer_sid);
+
 int security_get_classes(char ***classes, int *nclasses);
 int security_get_permissions(char *class, char ***perms, int *nperms);
 int security_get_reject_unknown(void);
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 4073d5a..af78cb9 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -134,7 +134,6 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 	 * lock as other threads could have access to ssec */
 	rcu_read_lock();
 	selinux_netlbl_sk_security_reset(newssec, ssec->sk->sk_family);
-	newssec->sclass = ssec->sclass;
 	rcu_read_unlock();
 }
 
@@ -143,6 +142,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
  * @skb: the packet
  * @family: protocol family
  * @base_sid: the SELinux SID to use as a context for MLS only attributes
+ * @type: NetLabel labeling protocol type
  * @sid: the SID
  *
  * Description:
@@ -154,6 +154,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
 				 u32 base_sid,
+				 u32 *type,
 				 u32 *sid)
 {
 	int rc;
@@ -174,6 +175,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 			netlbl_cache_add(skb, &secattr);
 	} else
 		*sid = SECSID_NULL;
+	*type = secattr.type;
 	netlbl_secattr_destroy(&secattr);
 
 	return rc;
@@ -191,13 +193,10 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
  */
 void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock)
 {
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct netlbl_lsm_secattr secattr;
 	u32 nlbl_peer_sid;
 
-	sksec->sclass = isec->sclass;
-
 	rcu_read_lock();
 
 	if (sksec->nlbl_state != NLBL_REQUIRE) {
@@ -235,11 +234,8 @@ int selinux_netlbl_socket_post_create(struct socket *sock)
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	sksec->sclass = isec->sclass;
-
 	rcu_read_lock();
 	if (sksec->nlbl_state == NLBL_REQUIRE)
 		rc = selinux_netlbl_sock_setsid(sk, sksec->sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1e78786..3f2af1c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2051,6 +2051,91 @@ out:
 	return rc;
 }
 
+/**
+ * security_net_peersid_resolve - Compare and resolve two network peer SIDs
+ * @nlbl_sid: NetLabel SID
+ * @nlbl_type: NetLabel labeling protocol type
+ * @xfrm_sid: XFRM SID
+ *
+ * Description:
+ * Compare the @nlbl_sid and @xfrm_sid values and if the two SIDs can be
+ * resolved into a single SID it is returned via @peer_sid and the function
+ * returns zero.  Otherwise @peer_sid is set to SECSID_NULL and the function
+ * returns a negative value.  A table summarizing the behavior is below:
+ *
+ *                                 | function return |      @sid
+ *   ------------------------------+-----------------+-----------------
+ *   no peer labels                |        0        |    SECSID_NULL
+ *   single peer label             |        0        |    <peer_label>
+ *   multiple, consistent labels   |        0        |    <peer_label>
+ *   multiple, inconsistent labels |    -<errno>     |    SECSID_NULL
+ *
+ */
+int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
+				 u32 xfrm_sid,
+				 u32 *peer_sid)
+{
+	int rc;
+	struct context *nlbl_ctx;
+	struct context *xfrm_ctx;
+
+	/* handle the common (which also happens to be the set of easy) cases
+	 * right away, these two if statements catch everything involving a
+	 * single or absent peer SID/label */
+	if (xfrm_sid == SECSID_NULL) {
+		*peer_sid = nlbl_sid;
+		return 0;
+	}
+	/* NOTE: an nlbl_type == NETLBL_NLTYPE_UNLABELED is a "fallback" label
+	 * and is treated as if nlbl_sid == SECSID_NULL when a XFRM SID/label
+	 * is present */
+	if (nlbl_sid == SECSID_NULL || nlbl_type == NETLBL_NLTYPE_UNLABELED) {
+		*peer_sid = xfrm_sid;
+		return 0;
+	}
+
+	/* we don't need to check ss_initialized here since the only way both
+	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
+	 * security server was initialized and ss_initialized was true */
+	if (!selinux_mls_enabled) {
+		*peer_sid = SECSID_NULL;
+		return 0;
+	}
+
+	POLICY_RDLOCK;
+
+	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
+	if (!nlbl_ctx) {
+		printk(KERN_ERR
+		       "security_sid_mls_cmp:  unrecognized SID %d\n",
+		       nlbl_sid);
+		rc = -EINVAL;
+		goto out_slowpath;
+	}
+	xfrm_ctx = sidtab_search(&sidtab, xfrm_sid);
+	if (!xfrm_ctx) {
+		printk(KERN_ERR
+		       "security_sid_mls_cmp:  unrecognized SID %d\n",
+		       xfrm_sid);
+		rc = -EINVAL;
+		goto out_slowpath;
+	}
+	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
+
+out_slowpath:
+	POLICY_RDUNLOCK;
+	if (rc == 0)
+		/* at present NetLabel SIDs/labels really only carry MLS
+		 * information so if the MLS portion of the NetLabel SID
+		 * matches the MLS portion of the labeled XFRM SID/label
+		 * then pass along the XFRM SID as it is the most
+		 * expressive */
+		*peer_sid = xfrm_sid;
+	else
+		*peer_sid = SECSID_NULL;
+	return rc;
+}
+
 static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
