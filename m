Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCCAC433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA0A217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UcxE4rhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfHGWnQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:16 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:33014
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389626AbfHGWnQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217794; bh=an+JziXz8H4AvWcfkwZGI8Zlibq8Fr6kfkg9d3Edf6g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UcxE4rhwDg5RqpfWvJCyyszXTNaaRvzoWLG0EJPn7vzZv8LwWeLRWBiKsOjAjEmRSEsu80bh+6Qf2q+mt7dao/7o8sdSwhS+Hr11yqfd25a/pqmc3wqKVc/6aVg5C+k/BFG4gKYIUBD/I0zUKPKN+WO+y2P/HDks+wIhMB2RAMZ1oDZOzqE8mIs2RbGc4U6PfN1eJf8xVyCbOJi4iBz99AvJa8UsrHz1rZB9rAbhAisSg89zcpfJGC3L2ujEAM0aAAsg6xGHs+Zp9FwnwJ015omfvHgTqhMjUuutQ5rIC5q3M4CO3kTQspgMUU+OqCyxRLj2ojGFBrE6qgIThckc5Q==
X-YMail-OSG: OhmH5ZIVM1mHzdL3VUF5Vda1Ap3YpVmDqtYJ2XDeeTYDOchy8iA.Xy5mwSLFjrY
 J.jWDKT.bXLFlJ4CWROjBH5KBRJkki3On0M.uyqcYHkBQYfXbbf8vqcZ7tBl58OG7Narr1nvVvNf
 yGXLQ3xtTwci0rtrMLvfLfKnT3zcR7EgknZMdu1seEpVlLN9LvGS79gj3hqUmOxlx6nlHyAzh7ob
 Y8KCNt5jRmiQBFfKFGI4N8Uwb6ZbGbuO7DBQ3L5YG9LGs3o1kPimPncSUeN14jWW_6dCc6KUphEM
 RtJbiyxpH8RwmIfmPUtkywlROH7.QOjDYdu.pk00wTMUwsSQa7IEM7jzgnczUKQLcxnf2B6vIltM
 imreyl.jqAsVv3v8F5fbieCAu5J3gNABQQOP7fFmvK2oth6gvoFpLH3yDkByE19eNdXjORjAeaZD
 B0dOQppnSiA2W2F06NLzJME_D13u3lxspKl3eqW7L0.U_VmYWJBCWzejBtWptUusIE7ZV86Aj965
 gqeiO1Ny4aGFSivNxpeICXVmCZkbX30ZlP2HA57rVIf5mSTZ8nG5uRw96VbrWROT4ZhLyz_5wW_U
 7Gcpr0SRH2dmNGy2i_dw58iWHn9MQuHgEazb6UVCipBo_H7xzBOON33M6k9qrrUbM2_L.DkTzMbV
 KJGyVJIbA2QXmB7VeDAXzS8SGn1AZhtmE1IP_srjPpayR5_Iwb033a2DXV.zq1jUPiHfKxfUdHHu
 YOBcsK1.7w_A76X29AkFPuCHjOq_PIOI9QW5KHM3rUQQN1Z4vPcO3.CXVaJmDnVnoJCUeE_X61HJ
 1POZcP3PbUPtHDYq1i0TBJXqIJ.yxT01wVxp5UgmJUAieZUSMYAvGAg_EcQvjnXXgqFLXmGI_kZ3
 9aRxWklwMq.0NOw9b1QWKigF6IOTI5A_74NFoKTqUZP8t4XM20h_hgSYLwL6Xa04rzFmqfSZKB6O
 .G5WBfKkWfKBXRKnk0QdUT2lDqo.JzeHWjdNr220KSkbHBsrWYAstRxi9fuBNWgdOyPCh8GIEzag
 MP7aDz3hNLiB6edhNykzVWWp0DMhr.ROe0SGwOwwwuliHHNH.Gf0QdiFafvMIEJY4i3GzaNBJHkg
 Yw9tKVVzgF1V5ry0vWniQZFMu8yogdfSq0S0U7PtcMEfw.EwRoLM5FOaIQl.jCSxIsPK28sfI8lu
 9lqLo5RuNRf3iFftznhuzcHWPp0jQ4XSWuBHfjiyPCPeGHBQL5AVqK_t.hcsQ0JaFOPP9la4GUra
 JbMjTe_LDhCcqNk6od.b02wNWS53lYI5duBHDe3Ktft_RexB3fabEBFVOwtkuC.Rh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:14 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90d0e6b59b40235a6b1cae6254f016be;
          Wed, 07 Aug 2019 22:43:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 12/16] Netlabel: Provide labeling type to security modules
Date:   Wed,  7 Aug 2019 15:42:41 -0700
Message-Id: <20190807224245.10798-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return the labeling type when setting network security attributes.
This allows for later comparison of the complete label information
to determine if the security modules agree on how a packet should
be labeled.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 70 +++++++++++++++++++++---------------
 security/selinux/netlabel.c  | 23 +++++++-----
 security/smack/smack_lsm.c   |  8 +++--
 3 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index a0996bdc8595..496d6a38b2aa 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -975,15 +975,14 @@ int netlbl_enabled(void)
  * Attach the correct label to the given socket using the security attributes
  * specified in @secattr.  This function requires exclusive access to @sk,
  * which means it either needs to be in the process of being created or locked.
- * Returns zero on success, -EDESTADDRREQ if the domain is configured to use
- * network address selectors (can't blindly label the socket), and negative
- * values on all other failures.
+ * Returns the labeling type of the domain, or negative values on failures.
  *
  */
 int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
 			const struct netlbl_lsm_secattr *secattr)
 {
+	int rc;
 	int ret_val;
 	struct netlbl_dom_map *dom_entry;
 
@@ -995,17 +994,17 @@ int netlbl_sock_setattr(struct sock *sk,
 	}
 	switch (family) {
 	case AF_INET:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_sock_setattr(sk,
-							dom_entry->def.cipso,
-							secattr);
+			rc = cipso_v4_sock_setattr(sk, dom_entry->def.cipso,
+						   secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1013,17 +1012,17 @@ int netlbl_sock_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_sock_setattr(sk,
-						       dom_entry->def.calipso,
-						       secattr);
+			rc = calipso_sock_setattr(sk, dom_entry->def.calipso,
+						  secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1104,14 +1103,16 @@ int netlbl_sock_getattr(struct sock *sk,
  * Description:
  * Attach the correct label to the given connected socket using the security
  * attributes specified in @secattr.  The caller is responsible for ensuring
- * that @sk is locked.  Returns zero on success, negative values on failure.
+ * that @sk is locked.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_conn_setattr(struct sock *sk,
 			struct sockaddr *addr,
 			const struct netlbl_lsm_secattr *secattr)
 {
-	int ret_val;
+	int rc;
+	int ret_val = 0;
 	struct sockaddr_in *addr4;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *addr6;
@@ -1128,16 +1129,17 @@ int netlbl_conn_setattr(struct sock *sk,
 			ret_val = -ENOENT;
 			goto conn_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_sock_setattr(sk,
-							entry->cipso, secattr);
+			rc = cipso_v4_sock_setattr(sk, entry->cipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
 			netlbl_sock_delattr(sk);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1152,16 +1154,17 @@ int netlbl_conn_setattr(struct sock *sk,
 			ret_val = -ENOENT;
 			goto conn_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_sock_setattr(sk,
-						       entry->calipso, secattr);
+			rc = calipso_sock_setattr(sk, entry->calipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
 			netlbl_sock_delattr(sk);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1184,12 +1187,14 @@ int netlbl_conn_setattr(struct sock *sk,
  *
  * Description:
  * Attach the correct label to the given socket using the security attributes
- * specified in @secattr.  Returns zero on success, negative values on failure.
+ * specified in @secattr.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_req_setattr(struct request_sock *req,
 		       const struct netlbl_lsm_secattr *secattr)
 {
+	int rc;
 	int ret_val;
 	struct netlbl_dommap_def *entry;
 	struct inet_request_sock *ireq = inet_rsk(req);
@@ -1203,14 +1208,15 @@ int netlbl_req_setattr(struct request_sock *req,
 			ret_val = -ENOENT;
 			goto req_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_req_setattr(req,
-						       entry->cipso, secattr);
+			rc = cipso_v4_req_setattr(req, entry->cipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			netlbl_req_delattr(req);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1224,14 +1230,15 @@ int netlbl_req_setattr(struct request_sock *req,
 			ret_val = -ENOENT;
 			goto req_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_req_setattr(req,
-						      entry->calipso, secattr);
+			rc = calipso_req_setattr(req, entry->calipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			netlbl_req_delattr(req);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1277,7 +1284,8 @@ void netlbl_req_delattr(struct request_sock *req)
  *
  * Description:
  * Attach the correct label to the given packet using the security attributes
- * specified in @secattr.  Returns zero on success, negative values on failure.
+ * specified in @secattr.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_skbuff_setattr(struct sk_buff *skb,
@@ -1314,6 +1322,8 @@ int netlbl_skbuff_setattr(struct sk_buff *skb,
 		default:
 			ret_val = -ENOENT;
 		}
+		if (ret_val == 0)
+			ret_val = entry->type;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
@@ -1337,6 +1347,8 @@ int netlbl_skbuff_setattr(struct sk_buff *skb,
 		default:
 			ret_val = -ENOENT;
 		}
+		if (ret_val == 0)
+			ret_val = entry->type;
 		break;
 #endif /* IPv6 */
 	default:
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 120d50c1bcac..8088a787777a 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -266,6 +266,8 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	}
 
 	rc = netlbl_skbuff_setattr(skb, family, secattr);
+	if (rc > 0)
+		rc = 0;
 
 skbuff_setsid_return:
 	if (secattr == &secattr_storage)
@@ -321,8 +323,10 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	}
 
 	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
-	if (rc == 0)
+	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_LABELED;
+		rc = 0;
+	}
 
 assoc_request_return:
 	netlbl_secattr_destroy(&secattr);
@@ -354,6 +358,8 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 	if (rc != 0)
 		goto inet_conn_request_return;
 	rc = netlbl_req_setattr(req, &secattr);
+	if (rc > 0)
+		rc = 0;
 inet_conn_request_return:
 	netlbl_secattr_destroy(&secattr);
 	return rc;
@@ -418,15 +424,12 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	if (secattr == NULL)
 		return -ENOMEM;
 	rc = netlbl_sock_setattr(sk, family, secattr);
-	switch (rc) {
-	case 0:
-		sksec->nlbl_state = NLBL_LABELED;
-		break;
-	case -EDESTADDRREQ:
+	if (rc == NETLBL_NLTYPE_ADDRSELECT)
 		sksec->nlbl_state = NLBL_REQSKB;
+	else if (rc >= 0)
+		sksec->nlbl_state = NLBL_LABELED;
+	if (rc > 0)
 		rc = 0;
-		break;
-	}
 
 	return rc;
 }
@@ -579,8 +582,10 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 		return rc;
 	}
 	rc = netlbl_conn_setattr(sk, addr, secattr);
-	if (rc == 0)
+	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_CONNLABELED;
+		rc = 0;
+	}
 
 	return rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2d88983868e8..62189558bb6a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2414,6 +2414,8 @@ static int smack_netlabel(struct sock *sk, int labeled)
 	else {
 		skp = ssp->smk_out;
 		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+		if (rc > 0)
+			rc = 0;
 	}
 
 	bh_unlock_sock(sk);
@@ -4141,9 +4143,11 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	hskp = smack_ipv4host_label(&addr);
 	rcu_read_unlock();
 
-	if (hskp == NULL)
+	if (hskp == NULL) {
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
-	else
+		if (rc > 0)
+			rc = 0;
+	} else
 		netlbl_req_delattr(req);
 
 	return rc;
-- 
2.20.1

