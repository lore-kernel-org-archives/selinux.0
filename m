Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l95JXEds008617
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 15:33:14 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l95JXDT0018244
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 19:33:13 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id 834C037C1F
	for <selinux@tycho.nsa.gov>; Fri,  5 Oct 2007 15:33:11 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v4 2/3] [SELinux] Better integration between peer labeling
	subsystems
To: selinux@tycho.nsa.gov
Date: Fri, 05 Oct 2007 15:32:54 -0400
Message-ID: <20071005193254.28034.25327.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net>
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rename the existing selinux_skb_extlbl_sid() function to
selinux_skb_peerlbl_sid() and modify it's behavior such that it now reconciles
multiple peer/external labels and if reconciliation is not possible it returns
an error to the caller.
---

 security/selinux/hooks.c            |   42 ++++++++++---------
 security/selinux/include/security.h |    2 +
 security/selinux/ss/services.c      |   79 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0753b20..9923c01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3132,32 +3132,31 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 }
 
 /**
- * selinux_skb_extlbl_sid - Determine the external label of a packet
+ * selinux_skb_peerlbl_sid - Determine the peer label of a packet
  * @skb: the packet
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
-static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
+static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
 {
 	u32 xfrm_sid;
 	u32 nlbl_sid;
 
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
-	if (selinux_netlbl_skbuff_getsid(skb,
-					 (xfrm_sid == SECSID_NULL ?
-					  SECINITSID_NETMSG : xfrm_sid),
-					 &nlbl_sid) != 0)
-		nlbl_sid = SECSID_NULL;
-	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
+	selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
+
+	if (security_net_peersid_resolve(nlbl_sid, xfrm_sid, sid) != 0)
+		return -EACCES;
+
+	return 0;
 }
 
 /* socket security operations */
@@ -3640,6 +3639,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (err)
 		goto out;
 
+	/* XXX - make use of selinux_skb_peerlbl_sid() here but only once we
+	 *       have the new peer object class in place */
+
 	err = selinux_netlbl_sock_rcv_skb(sksec, skb, &ad);
 	if (err)
 		goto out;
@@ -3701,7 +3703,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 	if (sock && sock->sk->sk_family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		selinux_skb_extlbl_sid(skb, &peer_secid);
+		selinux_skb_peerlbl_sid(skb, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3762,7 +3764,9 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	u32 newsid;
 	u32 peersid;
 
-	selinux_skb_extlbl_sid(skb, &peersid);
+	err = selinux_skb_peerlbl_sid(skb, &peersid);
+	if (err)
+		return err;
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3800,7 +3804,7 @@ static void selinux_inet_conn_established(struct sock *sk,
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	selinux_skb_extlbl_sid(skb, &sksec->peer_sid);
+	selinux_skb_peerlbl_sid(skb, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cc53ce4..f193693 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -100,6 +100,8 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
+int security_net_peersid_resolve(u32 nlbl_sid, u32 xfrm_sid, u32 *peer_sid);
+
 int security_get_classes(char ***classes, int *nclasses);
 int security_get_permissions(char *class, char ***perms, int *nperms);
 int security_get_policycaps(int *len, int **values);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7059400..338aa09 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2013,6 +2013,85 @@ out:
 	return rc;
 }
 
+/**
+ * security_net_peersid_resolve - Compare and resolve two network peer SIDs
+ * @nlbl_sid: NetLabel SID
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
+int security_net_peersid_resolve(u32 nlbl_sid, u32 xfrm_sid, u32 *peer_sid)
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
+	if (nlbl_sid == SECSID_NULL) {
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
+		 * then pass along the XFRM SID as it has the most peer label
+		 * information */
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
