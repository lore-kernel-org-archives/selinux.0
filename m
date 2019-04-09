Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2BC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F52084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d2Ktawrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDITTK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:10 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:45703
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbfDITTK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837548; bh=7li7tkNnxiLkHtu/0oyIewmS2h9OYS5xrTRq2nlRU0I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=d2KtawrzQTkis6EXNl9h+FPpMo33HVOo6IMPZEDKRVwQgDIOLRHOa4otQcUXLdng8yWNdkAWld6bP6TymeWvs3i8gultJaHBg2mr6Hh/Dr4VC72uKsfC9w6Yu6+HRQtteCfZ8dTu7KJrxpZlPzTgUourNHm2yMgfAOM+D/4JfiGGof5Bo12sdjYR+d2EDUNFux3PED/PnD/oeyXW7FE3Rh8B0sWiwQGHjV+srsiykTOx6aALJAhljWipS9uYTnbEOuE5I4sZ0+WcO4KZzmY55xS8rz0k8hlMdN7Kk7+4Ph6qXGTkdR7fupMe+BaJmAWWO9wVftwAqSnQsmDbMokx6g==
X-YMail-OSG: vZnFMjEVM1mizXJb7zxWryw.iMQkNy1XKQoUv6MYurXHmthe.46F0_owoVImZ24
 IVewUMmkhRh90SAXVR7zjI0NytGlPHZJIREzOMwJ0_wKjjN7cGp6FZ1OWuYRd31oHkktHnjXG9h1
 Aji3k_Zaa6Dl3XghMA.eXtgqXKOiPAfR241SGpL8fy5rhLGeA8QBgcLXDmbGJqcJvR37y6xC3IC0
 Z7sGKGzN_TfzlqlAa9RlYiqPUocOjJzEwtR9gFh04gtNkAn9oeVAgj3rxxE0OCZZeing2xehqBug
 Kt8cTARRIdI0nIeTTlHuhRzUZMydwJEkE891fCKS97RRYDNNKqZbIBqi0B5uadaL1wEPIoZfb4wU
 Bb9hCxJByg2uXCbQHdCKR35Ox89BEB40czgGZqDx5dMBFIq7ctlhqaBlf3utaKHpcIroofd4oUF7
 SmYEIW5YoNFSGf6Y.lnRdirvlA4dqEerztkAtL8N5djmFR88ak.faFCrl_gG3pEIfnqptZw47SYK
 WoJsyRI1lP.PZR1qK5459z1vu1pyPD2XjQTACxXx_brEnPBWcb8xZW4de73cES5IcedI8oW0EMLp
 CBblmR0jzAAs4BULi.nQL0hbMKncLjsr22IjYod35otLD9ynn1i2kKTDmEIzACT8iQCvr4mRhWXc
 nu2RH8Zj3e3iKIm1KbNum2S1DLubpG56syqt8b57egF44FNARtlP4oKZDIVB3tksRhCJZV7j9Vs_
 zc5XEEfXETnjW.3GIoM5X3YxZCpzTPjpEgLbOR76PxezQtcJVfZzWE2e7rqo0qxzmQ11aCBxOVKF
 G0WyF6bWUIyvyZiluc0o7yCSgGt3Fslu3OzaFsczoizG6UxZC6pa1U9qYnAJHuZEOu.QkEUfRGpO
 TPtQvUj5GwnM3VIWLRB1ZDnDrUhOwybC.3vMC_w1m_nSHvciVraSVz6NVuMKI3c2QLBMfoYco.hz
 6im5EPQC0NcKW7JUJPRFa6sf3NFdwZZq0.2hZnpdvByW.O_eiAaDkLMoUdPYqExrLBmAXZqIVPus
 KnQBBHsPhIi4aMWVaoWHYdbZ8BjNzv700L_xbHRxc52GgQtCO6Yu5j3Z0EUsEgGno5.IIBCaGkyf
 fayiBTpnJTeHVrka8YTYtH8asbul5C7iGO7HSexg11qaSvT6O5AaA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 18/59] LSM: Use lsm_export in security_secid_to_secctx
Date:   Tue,  9 Apr 2019 12:18:07 -0700
Message-Id: <20190409191848.1380-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_secid_to_secctx to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  4 +++-
 include/linux/security.h                |  9 +++++++--
 include/net/scm.h                       |  4 +---
 kernel/audit.c                          |  9 +++++++--
 kernel/auditsc.c                        | 13 +++++++++----
 net/ipv4/ip_sockglue.c                  |  5 ++---
 net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
 net/netfilter/nf_conntrack_standalone.c |  4 +++-
 net/netfilter/nfnetlink_queue.c         |  8 ++++++--
 net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
 net/netlabel/netlabel_user.c            |  6 +++---
 net/unix/af_unix.c                      |  9 ++++++---
 security/security.c                     |  8 ++------
 13 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8685882da64c..9119333f794b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3120,9 +3120,11 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
+		struct lsm_export le;
 
 		security_task_getsecid(proc->tsk, &secid);
-		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
+		lsm_export_to_all(&le, secid);
+		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index 991d2d2e290e..5cea6260bbd9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -115,6 +115,10 @@ static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
 	case LSM_EXPORT_APPARMOR:
 		*secid = data->apparmor;
 		break;
+	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
+		/* For scaffolding only */
+		*secid = data->selinux;
+		break;
 	default:
 		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
 			data->flags);
@@ -436,7 +440,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l);
 void security_release_secctx(char *secdata, u32 seclen);
@@ -1214,7 +1218,8 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(struct lsm_export *l,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 13b8a369fd89..b5d1c24318e3 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,7 +33,6 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
 	struct lsm_export	le;		/* Passed LSM data */
 #endif
 };
@@ -48,7 +47,6 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
 	security_socket_getpeersec_dgram(sock, NULL, &scm->le);
-	lsm_export_secid(&scm->le, &scm->secid);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
@@ -99,7 +97,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->le, &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/kernel/audit.c b/kernel/audit.c
index c89ea48c70a6..b5d96a0320fb 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1430,7 +1430,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+			struct lsm_export le;
+
+			lsm_export_to_all(&le, audit_sig_sid);
+			err = security_secid_to_secctx(&le, &ctx, &len);
 			if (err)
 				return err;
 		}
@@ -2073,12 +2076,14 @@ int audit_log_task_context(struct audit_buffer *ab)
 	unsigned len;
 	int error;
 	u32 sid;
+	struct lsm_export le;
 
 	security_task_getsecid(current, &sid);
 	if (!sid)
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	lsm_export_to_all(&le, sid);
+	error = security_secid_to_secctx(&le, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 822ba35e4e64..83aba0336eac 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -946,6 +946,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
+	struct lsm_export le;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -955,7 +956,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+		lsm_export_to_all(&le, sid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1197,7 +1199,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
+			struct lsm_export le;
+			lsm_export_to_all(&le, osid);
+			if (security_secid_to_secctx(&le, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1348,9 +1352,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (n->osid != 0) {
 		char *ctx = NULL;
 		u32 len;
+		struct lsm_export le;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
+		lsm_export_to_all(&le, n->osid);
+		if (security_secid_to_secctx(&le, &ctx, &len)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b8ef7677a7e5..a4f37ba6dbe2 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -132,15 +132,14 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
 	struct lsm_export le;
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
 	int err;
 
 	err = security_socket_getpeersec_dgram(NULL, skb, &le);
 	if (err)
 		return;
 
-	lsm_export_secid(&le, &secid);
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	err = security_secid_to_secctx(&le, &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 66c596d287a5..b069277450c5 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -330,8 +330,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct nlattr *nest_secctx;
 	int len, ret;
 	char *secctx;
+	struct lsm_export le;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsm_export_to_all(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return 0;
 
@@ -615,8 +617,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
+	struct lsm_export le;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	lsm_export_to_all(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index c2ae14c720b4..12318026d8d4 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	int ret;
 	u32 len;
 	char *secctx;
+	struct lsm_export le;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	lsm_export_to_all(&le, ct->secmark);
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 0dcc3592d053..4c74c383e26b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -309,13 +309,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+	struct lsm_export le;
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
-	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+	if (skb->secmark) {
+		lsm_export_to_all(&le, skb->secmark);
+		security_secid_to_secctx(&le, secdata, &seclen);
+	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index fc38934ccb35..00922f55dd9e 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -389,6 +389,7 @@ int netlbl_unlhsh_add(struct net *net,
 	struct audit_buffer *audit_buf = NULL;
 	char *secctx = NULL;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -451,7 +452,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
+		lsm_export_to_all(&le, secid);
+		if (security_secid_to_secctx(&le,
 					     &secctx,
 					     &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
@@ -488,6 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -507,8 +510,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsm_export_to_all(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -550,6 +555,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -568,8 +574,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
+		if (entry != NULL)
+			lsm_export_to_all(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -1092,6 +1100,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	u32 secid;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1146,7 +1155,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	lsm_export_to_all(&le, secid);
+	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 4676f5bb16ae..1079cdea872c 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,6 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -112,10 +113,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
+	lsm_export_to_all(&le, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	    security_secid_to_secctx(&le, &secctx, &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ddb838a1b74c..4d4107927ba2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,17 +143,20 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	lsm_export_secid(&scm->le, &(UNIXCB(skb).secid));
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	lsm_export_to_all(&scm->le, UNIXCB(skb).secid);
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	u32 best_secid;
+
+	lsm_export_secid(&scm->le, &best_secid);
+	return (best_secid == UNIXCB(skb).secid);
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index 868e9ae6b48c..b6a096be95ac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1957,13 +1957,9 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	struct lsm_export data;
-
-	lsm_export_to_all(&data, secid);
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
-				seclen);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.19.1

