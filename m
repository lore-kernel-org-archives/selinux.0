Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA35C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA9720851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tyObs72y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfB1WUg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:36 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:36922
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731521AbfB1WUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392421; bh=Z3r1HTDy1+P+o1sE/iyAOYjrezPUZ2YchMc8TzthhyQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tyObs72yqGv6SnEfuRTkRuITWXxfaraNEeLDDvB4jMSN7ChUyQUdtpl7C4ZZCFu/JG0v5gAYthjUnwxTvWpZxbGV91QpK3i56NTOy52dZzGIqk9y97Kx9w3QQYOE9+wsEGCIh/wLGTGMW481Shx983o5rLVYcD785GcPST0Y3BpAD0cT5UepSDfWpSnKoHgQCJ1sVQag7A3PYHcKDpnVYq2nnlEH3eSD3rJEYV9KqBzFOG8q3bJL3WqklHYp2OC+rCVAnnNhgiw77QrxsNtMHqTcFhDtj5Ln98CO5aR0u4Q3tIqVp6ZAcZGcqx6S+t1PXkLW7xZA3gMBv3MyC4JjdA==
X-YMail-OSG: mpZWuHIVM1nO_JSORObInWOiBXpGHv9saYabFGH6rQoqVxl36aymu_Q8skCbP8_
 0A0AQE5V1M7u7Jc9rU6rlCyUfn2XojaCTWx2mwWBqsdZgP9GOEz.h.HzPzvlwu2mADXX.tCVSc1S
 D4s0IMrMA3MzJYkrc80Pv2SbDu9rhyr5LnmwY1eKHllwjfww_PYIYErbK6qkzYZNKIi_MEAhuu6s
 Cy7GVHb3ypu2y0q5Rz91cL.G_nstl8cLEOBWcfRiY3efDaE79XiBWis_nUuQZRcYLzw3RsWD92Yz
 D.fFouWl5P.uYj2ERaXCFPLvDqPKi07xYS7IWsokuivNjv64SqlGH2gah9vNXR8_dCd05UhG3dJh
 5eL9wNlQrikYjRwbtTc.Kmt.kyaQ.Qn.COL4hqA_9CwBxcCeblJPnNl0y_dIAnvJp8wntqgRdlOC
 3jOqXOk1DvVg1irH34iCnrilCG2KnUlmv5DNpzbhY.8I6zip5F3RFhg_Sn330KUPnePmpYLwKfMS
 D1Vr6CPgpoJXXhQym_.LkoFL_mN00MXKHz1U1XraokRIiVe97NrLlzaaPCSvuTWDNY3Ng.buuFQC
 cS4FA_GiirZm9VeR2MF5RRI.mdQORc6RJlGwoTMZ2C0FwZrA.MlB6ZUz2wWwBYB_XOzEbBcMTCOx
 gRceiwVzFDRysmnLHzu6Eo6d6lLs1S43OOlRbzvpN0HSyf1222UbM5AmjYOsIeur0kK_K3VKW3xg
 3w3bXbdj.csYeLzqTsZyeAzpzdrYQufmkBm584HvgQV380BkXTVOvVXZk3zTiLCqJMvF13TRHHMx
 Gm8fJTS4ThLpXbWRDqr1K8ogPn9Ma1YZ.cz2yAucZWivl92XKT70QBE9.NuhLAvDf7nRckHo2fMZ
 A4haEL6B0FjrEj5ScfBh9BSXJxyEB49RRTbdXWvWv_1h1Q2Ako8S1htuVhDXlUEhbrM3HpfuIVxV
 Lg6SXJ1d8AojH2syZM4jM13pFsDP9S3tVpLgeSBMd69hazfG.4IKvCmA1.1VUIN8OYsbg6GyDM1n
 O4jrn9Uvp3kzVy1Nk1AIs1Ur1no8ETQE6y8XDuCV7k7iXhvC5MWPnfFCQV3AlCjhX40vnvBhVDWg
 CbXK3mbb0Nq87CkEOVdvgfa9Cc4GuL5_6_qh3QRa.vnwce.4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:21 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 55/97] LSM: Use lsm_context in security_secid_to_secctx
Date:   Thu, 28 Feb 2019 14:18:51 -0800
Message-Id: <20190228221933.2551-56-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secid_to_secctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Add a flag for lsm_export to indicate that the caller of
security_secid_to_secctx() is only interested in the length
of the context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h                | 13 +++++++------
 include/net/scm.h                       |  2 +-
 kernel/audit.c                          |  7 +++----
 kernel/auditsc.c                        |  8 ++++----
 net/ipv4/ip_sockglue.c                  |  2 +-
 net/netfilter/nf_conntrack_netlink.c    |  9 +++++----
 net/netfilter/nf_conntrack_standalone.c |  2 +-
 net/netfilter/nfnetlink_queue.c         |  2 +-
 net/netlabel/netlabel_unlabeled.c       | 10 ++++------
 net/netlabel/netlabel_user.c            |  3 +--
 security/apparmor/secid.c               |  3 +--
 security/security.c                     | 13 ++-----------
 security/selinux/hooks.c                |  3 +++
 security/smack/smack_lsm.c              |  2 +-
 14 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b5c03e326e32..46cc16a67212 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -81,10 +81,11 @@ struct lsm_export {
 	u32	apparmor;
 	u32	flags;
 };
-#define LSM_EXPORT_NONE		0x00
-#define LSM_EXPORT_SELINUX	0x01
-#define LSM_EXPORT_SMACK	0x02
-#define LSM_EXPORT_APPARMOR	0x04
+#define LSM_EXPORT_NONE		0x00000000
+#define LSM_EXPORT_SELINUX	0x00000001
+#define LSM_EXPORT_SMACK	0x00000002
+#define LSM_EXPORT_APPARMOR	0x00000004
+#define LSM_EXPORT_LENGTH	0x80000000	/* Only the length required */
 
 static inline void lsm_export_init(struct lsm_export *l)
 {
@@ -428,7 +429,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l);
 void security_release_secctx(struct lsm_context *cp);
 
@@ -1197,7 +1198,7 @@ static inline int security_ismaclabel(const char *name)
 }
 
 static inline int security_secid_to_secctx(struct lsm_export *l,
-					   char **secdata, u32 *seclen)
+					   struct lsm_seccontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 7e242ebdd258..b25ca3b6a514 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -96,7 +96,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(&scm->le, &lc.context, &lc.len);
+		err = security_secid_to_secctx(&scm->le, &lc);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
diff --git a/kernel/audit.c b/kernel/audit.c
index 55b9431489fc..87e5f6fffb7b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1416,8 +1416,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		if (lsm_export_any(&audit_sig_lsm)) {
-			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &lc.context, &lc.len);
+			err = security_secid_to_secctx(&audit_sig_lsm, &lc);
 			if (err)
 				return err;
 		}
@@ -2166,7 +2165,7 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (lsm_export_any(&n->olsm)) {
 		struct lsm_context lc;
 
-		if (security_secid_to_secctx(&n->olsm, &lc.context, &lc.len)) {
+		if (security_secid_to_secctx(&n->olsm, &lc)) {
 			audit_log_format(ab, " osid=(unknown)");
 			if (call_panic)
 				*call_panic = 2;
@@ -2209,7 +2208,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsm_export_any(&le))
 		return 0;
 
-	error = security_secid_to_secctx(&le, &lc.context, &lc.len);
+	error = security_secid_to_secctx(&le, &lc);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 797a9f1847cb..8e48053d4a74 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -935,7 +935,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 unsigned int sessionid,
 				 struct lsm_export *l, char *comm)
 {
-	struct lsm_context lc = { .context = NULL, };
+	struct lsm_context lc;
 	struct audit_buffer *ab;
 	int rc = 0;
 
@@ -947,7 +947,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsm_export_any(l)) {
-		if (security_secid_to_secctx(l, &lc.context, &lc.len)) {
+		if (security_secid_to_secctx(l, &lc)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1161,8 +1161,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (lsm_export_any(l)) {
-			struct lsm_context lc = { .context = NULL, };
-			if (security_secid_to_secctx(l, &lc.context, &lc.len)) {
+			struct lsm_context lc;
+			if (security_secid_to_secctx(l, &lc)) {
 				audit_log_format(ab, " osid=(unknown)");
 				*call_panic = 1;
 			} else {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 18a7fab8b2d3..56035b53952d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -138,7 +138,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(&le, &lc.context, &lc.len);
+	err = security_secid_to_secctx(&le, &lc);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 03c3488a37d8..72aeba0de49c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -337,7 +337,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	le.selinux = ct->secmark;
 	le.smack = ct->secmark;
 
-	ret = security_secid_to_secctx(&le, &lc.context, &lc.len);
+	ret = security_secid_to_secctx(&le, &lc);
 	if (ret)
 		return 0;
 
@@ -622,18 +622,19 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
 	struct lsm_export le;
+	struct lsm_context lc;
 
 	lsm_export_init(&le);
-	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_LENGTH;
 	le.selinux = ct->secmark;
 	le.smack = ct->secmark;
 
-	ret = security_secid_to_secctx(&le, NULL, &len);
+	ret = security_secid_to_secctx(&le, &lc);
 	if (ret)
 		return 0;
 
 	return nla_total_size(0) /* CTA_SECCTX */
-	       + nla_total_size(sizeof(char) * len); /* CTA_SECCTX_NAME */
+	       + nla_total_size(sizeof(char) * lc.len); /* CTA_SECCTX_NAME */
 #else
 	return 0;
 #endif
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index e1a8eaa3a62d..8574a5611823 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -178,7 +178,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	le.selinux = ct->secmark;
 	le.smack = ct->secmark;
 
-	ret = security_secid_to_secctx(&le, &lc.context, &lc.len);
+	ret = security_secid_to_secctx(&le, &lc);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index b70871693368..4a3d4b52caef 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -322,7 +322,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 		le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
 		le.selinux = skb->secmark;
 		le.smack = skb->secmark;
-		security_secid_to_secctx(&le, &lc.context, &lc.len);
+		security_secid_to_secctx(&le, &lc);
 		*secdata = lc.context;
 	}
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 19cdcf58683d..f01c97eb6285 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -450,7 +450,7 @@ int netlbl_unlhsh_add(struct net *net,
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
 		struct lsm_context lc;
-		if (security_secid_to_secctx(l, &lc.context, &lc.len) == 0) {
+		if (security_secid_to_secctx(l, &lc) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
 			security_release_secctx(&lc);
 		}
@@ -504,8 +504,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->le,
-					     &lc.context, &lc.len) == 0) {
+		    security_secid_to_secctx(&entry->le, &lc) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
 			security_release_secctx(&lc);
 		}
@@ -566,8 +565,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->le,
-					     &lc.context, &lc.len) == 0) {
+		    security_secid_to_secctx(&entry->le, &lc) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", lc.context);
 			security_release_secctx(&lc);
 		}
@@ -1137,7 +1135,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lep = &addr6->le;
 	}
 
-	ret_val = security_secid_to_secctx(lep, &lc.context, &lc.len);
+	ret_val = security_secid_to_secctx(lep, &lc);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 0418f0935199..11ea98525c4e 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -112,8 +112,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsm_export_any(&audit_info->le) &&
-	    security_secid_to_secctx(&audit_info->le, &lc.context,
-				     &lc.len) == 0) {
+	    security_secid_to_secctx(&audit_info->le, &lc) == 0) {
 		audit_log_format(audit_buf, " subj=%s", lc.context);
 		security_release_secctx(&lc);
 	}
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 46c8b9a67ac7..9dc17903a936 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -92,8 +92,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	if (!label)
 		return -EINVAL;
 
-	/* scaffolding check - Casey */
-	if (cp)
+	if (!(l->flags & LSM_EXPORT_LENGTH))
 		len = aa_label_asxprint(&cp->context, root_ns, label,
 					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT,
diff --git a/security/security.c b/security/security.c
index 4f0c7d2cd1dd..2b2520ba9554 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1973,18 +1973,9 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, &lc);
-	if (secdata)
-		*secdata = lc.context;
-	else
-		security_release_secctx(&lc);
-	*seclen = lc.len;
-	return rc;
+	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, cp);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ea9603b63f77..07213ae8929f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6199,6 +6199,9 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	if (l->flags & LSM_EXPORT_LENGTH)
+		return security_sid_to_context(&selinux_state, secid,
+					       NULL, &cp->len);
 	return security_sid_to_context(&selinux_state, secid,
 				       &cp->context, &cp->len);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 332ac71e8a41..1861587b3620 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4357,7 +4357,7 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
-	cp->context = skp->smk_known;
+	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
 	cp->len = strlen(skp->smk_known);
 	return 0;
 }
-- 
2.17.0

