Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9LOomq025022
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 16:24:50 -0500
Received: from palrel13.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9LOnuu012497
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 21:24:49 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 09/13] SELinux: Better integration between peer
	labeling subsystems
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Fri, 09 Nov 2007 16:24:40 -0500
Message-ID: <20071109212439.31738.39168.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rename the existing selinux_skb_extlbl_sid() function to
selinux_skb_peerlbl_sid() and modify it's behavior such that it now reconciles
multiple peer/external labels and if reconciliation is not possible it returns
an error to the caller.
---

 security/selinux/hooks.c            |   94 ++++++++++++++++++++++-------------
 security/selinux/include/netlabel.h |    3 +
 security/selinux/include/security.h |    4 +
 security/selinux/netlabel.c         |    3 +
 security/selinux/ss/services.c      |   85 ++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 35 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2188b9c..4d13a80 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3190,36 +3190,39 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
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
@@ -3674,17 +3677,32 @@ out:
 	return err;
 }
 
+static int selinux_sock_recv_peer_compat(struct sk_security_struct *sksec,
+					 struct sk_buff *skb,
+					 u16 family,
+					 struct avc_audit_data ad)
+{
+	int err;
+
+	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
+	if (err)
+		return err;
+
+	return selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
+}
+
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u16 family;
+	u16 family = sk->sk_family;
 	char *addrp;
-	int len, err = 0;
+	int len;
+	int err;
 	struct avc_audit_data ad;
 	struct sk_security_struct *sksec = sk->sk_security;
+	int peer_sid;
 
-	family = sk->sk_family;
 	if (family != PF_INET && family != PF_INET6)
-		goto out;
+		return 0;
 
 	/* Handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -3693,10 +3711,14 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.netif = skb->dev ? skb->dev->name : "[unknown]";
 	ad.u.net.family = family;
-
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
 	if (err)
-		goto out;
+		return err;
+
+	/* Between selinux_compat_net and selinux_policycap_netpeer this is
+	 * starting to get a bit messy - we need to setup a timetable for
+	 * deprecating some of this old/obsolete functionality so we can
+	 * reclaim some level of sanity in this function. */
 
 	if (selinux_compat_net)
 		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
@@ -3705,15 +3727,15 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 	if (err)
-		goto out;
+		return err;
 
-	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
+	if (!selinux_policycap_netpeer)
+		return selinux_sock_recv_peer_compat(sksec, skb, family, ad);
+	err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
 	if (err)
-		goto out;
-
-	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
-out:	
-	return err;
+		return err;
+	return avc_has_perm(sksec->sid, peer_sid,
+			    SECCLASS_PEER, PEER__RECV, &ad);
 }
 
 static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
@@ -3776,7 +3798,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 	if (sock && family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		selinux_skb_extlbl_sid(skb, family, &peer_secid);
+		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3837,7 +3859,9 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, sk->sk_family, &peersid);
+	err = selinux_skb_peerlbl_sid(skb, sk->sk_family, &peersid);
+	if (err)
+		return err;
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3875,7 +3899,7 @@ static void selinux_inet_conn_established(struct sock *sk,
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
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 4d3c0d3..fb807c1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -100,6 +100,10 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
+int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
+				 u32 xfrm_sid,
+				 u32 *peer_sid);
+
 int security_get_classes(char ***classes, int *nclasses);
 int security_get_permissions(char *class, char ***perms, int *nperms);
 int security_get_reject_unknown(void);
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 4073d5a..6c194f9 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -143,6 +143,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
  * @skb: the packet
  * @family: protocol family
  * @base_sid: the SELinux SID to use as a context for MLS only attributes
+ * @type: NetLabel labeling protocol type
  * @sid: the SID
  *
  * Description:
@@ -154,6 +155,7 @@ void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
 				 u32 base_sid,
+				 u32 *type,
 				 u32 *sid)
 {
 	int rc;
@@ -174,6 +176,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 			netlbl_cache_add(skb, &secattr);
 	} else
 		*sid = SECSID_NULL;
+	*type = secattr.type;
 	netlbl_secattr_destroy(&secattr);
 
 	return rc;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 19a60d6..9f340ab 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2057,6 +2057,91 @@ out:
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
