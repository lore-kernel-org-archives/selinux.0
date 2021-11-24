Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C398C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhKXCJ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:09:56 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:42816
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233601AbhKXCJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719606; bh=fqcTlcbDfiUQwYvQNPEEr3xdoMx6PZueujFjkwYX6NE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iy4jolzB2CrUq5u6FRYIERYQX57KoM4CgW8Cq2OkLJjmzOPuk9EUuZ/147i857SVnvHS5xoC+VwDfH8Vq+d4A63Xu3zatD5FSCTPdOCsNgv9Wt7/98afcPY7xR8fuuN1AnnOjWsQ0vjCP8YtVPTvcQ9vVjVJD5u3pLNXqTQtUuk5JrZGEvgXqykShGX6AsHKr/lVLfGaJmDP+xhMGbG9G76Zphfe0/zHzkEQvTp4W85NY3ky4VxT2yrg5E/JnegMbuxBxjTL6PyBleFNsl3cdBu54FI9i5qzNFp75FI/xQde63gJTconeFqu6vpkl/H8ISAKvnfskYFu8MZCKmYFow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719606; bh=WOF3jwcf6r6TVtrhHhPD7z+nUBHxj6xT4oRvE8CHQBa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SlZxOGNTzfd26eyeT+nJAFKeqSNoz2WdNSOFOVLKGy1bLzc78Ec2U9k/95bdkHOZ4viJDly/MpRjF8yzBwHtJ8FCG4Eu0QTeyBFUZk1P84/2icCYZftKMwCaIJcZhiV143oQVfZJZwoEI9HcB4ELcjMKF819myN/rADwuXLPOMVnw6ISUpkWQT7gspA9+hYSGuJ8w51DPHTOJHa96Tt+Qxvb7XbK5ewg7cHbs2dcJHVtgGgM6EXb2TNcXX+Ej3luE/HJFmPMF2cNCswywBJGMbEuo8/K4J/6IQlNd7GAeRUpDWuG0mCmGd9KQEhqYeuMLGz9G4GZrguFY1WUfXW4eQ==
X-YMail-OSG: 5VHsWzEVM1l0jvin9hM4wwJB4GrEVy1i_Iodb5ukNGfSVhyFXkTYPY807dkjMJ1
 TY9pksLBgmrSxg.wtR64hGy5eh7AZtAGh_vsemSx4FqLazwHBQIxKeVjR5z3XwnOgvtl0Bj3SkJ7
 0rk9T8APPfYWg2KJdQIOpEmcSlw82BN6yO8Rkqj8z.P_dOui5w3T0a33PeCmob6QC3AdwJFD2kLM
 g.P_Qnsk1ZuPf2FPhQf4HlklGviAwLXE.gffQSh8eCVoRQoq17vscR5N4dOwq2zhsNJbSEH_GnIz
 2kTFbEzCE_z2wWPDSHtjdIfZOQ_2ZeYzsNTX7Uxo31I8cBJKTA9XfUoHzrYsoXaEZ2DdECQRJ7iB
 TgDMJ9PTqzlOKmVCRQI3m9fEDUZwRENvjfrEokOQWGy0aLyHP2d7Gy_XARtTMa7Vn.9U7MONATkK
 mem9oaleHgBlEcz__5bmQN8gw3s.2msXBCOqsXLMW3eZK1KwSvOdP0bWD7oqZWr_VSNCr4JdoudF
 raSzItNiYdt0BAux3AOhy0U3y.e6w21.WsXrPFU8A_m971X1kFx2Dq3dATUAOAmsEr_PFxPHTcVl
 YC6RttVwWh9Zq2HOudaTq8aY6yRR5iImNvOsqjjosnTSq4pVVKA3ZPvlNzTLyThUsQkQivbeAv2Q
 dHOJBDN3bsQzHtenO..YxTo4Ald5uCwxjwCmn1PD4pFoPk70w1cNlO_clJCIbKbZgge6xONZ8b9u
 4eIJfzNpFQbd2nFLZuzqbwAtp_vxugyJHyskQlLBR8qQUd7E_vjapBnY5.czmACGWg18fyBa1QmR
 xJVycy_gZ24MR_uavbJpG69pmb2OQCfQtWpg9av3FpfcAM7vlW725wKx5FegQ7ckWC4hL8sMFMFN
 DY542A9emtf9FFlkNE8Gl7Lj3FOUElc2mULSo8iAhWjAJ8N4cBIEW5qioCoJ4t0F3lDpMR6PdCCt
 sOgNfW_HS7hbYqzgJyQyExRIhqMp3hfRq.OXRnUcfToH7MzZVthoyrlmyQQMVs2Ju0xZNlTA.RIs
 CSBTr6mi7Pl4iI6lCJYZBJeZNOIL8WHFJv2Q6NwlIpI7cEfJmXB4qk9xNSjyY5vqfmVdrc8y76tU
 uNguoMkU2mzaxVLhvQzL2XF2_QvMOmiGkEhHAca5tWqEyEysQP92uIZF_wkwYEr.alWu1f0_iX64
 Aml8rLNQiOtb1kza8jrkMhL2P9dR7ggtFcam.t_tDo8BN3eq5Dz34bLiSJ7cMKAzh5wuwSVy_t8d
 Ba31cyg3e6KdtbRzqMuYIYdWroJk.o.zMUul5S19JVBCFDconDFlmWAzuibeT0Iy6oPkQoIv0HCs
 3d2HKFPvOBIRaoaDIxo5NATZJxCuh1FQ0t2pAzy0HY4gSO7b5C2XdNOG8dFpaeZzrCA1XolPaS8x
 8sC9l5lPzRyEkWWI6b7am0B406Zww.qBW.qCYtiEYpCFzGXIYAoasYrBKvDGRvmm6j1xvT7t2yvJ
 oSC_4H5d4pIZ6kqDdhN3Tbt.9iLgkz5DffXEjskUNVs4H9SjkzWcAT0fSj1j3fzNKXXjjWt9ZTqD
 tKKxEoUtWA8CBHxJikicF6N3jRVZdy6TyKTDzmkKHTiRwKUH.MD0ZfSzzBCBXa4kMMryKt7.efYt
 NVpLpmD.dQvv6OEBUZ_OiAGJvIjxR_NVfs44CvPqETnckk8.EZcxcrMxbpZtM0rGbdrdH3wa00kn
 as7yAKGBgbo4u4kivt2kW_nbm4lnUq8RxKd3ADkvEsSOf0FvRRzOwmy0pMPDgPvTqsypQO5dw7kO
 J5NabKwZB6CZxqoWs.I8FskekklfyKZAsJAr6Q0rbhclAcid3tQif41OIJICvmmiQ9BQYHe9_mz6
 tmK7kp4WPOYwRuWxzqnBIANl.buApGw4WtIktIwAN9XaQFVYBY1cnqcREp2zwJvc0dhx3qYiIjdH
 NpMm_v8tF9TUHBQnSW29MrBJo0iZSjZnPsGvvvrMLo95f7f14dB6on8SbcsMABr6gjJD9JAo8z5p
 uuaZI98mDoeRrRlsT89QQYcqGCjx4qzi7hkxmON1wKE5zY4K17Y_A_yK.8FNXuJHCraf0700ltdh
 ZsQBVqthXI5zdDVQDaKSVL_QX_phtqKLnmYwmvXdVy3VcnIQbOPeB3tMClhfBNVKpAl0kVbIiYLm
 VYrcbbs84.wlsxzkl_JikPRK0p1dAeUgTYvr9jftE_bwdxAdFMTlIM_P.44SSpfvYmXLCS61q4PL
 Iv.IdzO3.bTg4k_zb2aoev7nJhcrQzMCzg75B2LpVe4uUK76Ap0DGqalOpJR62PgAuMjok_gwfcC
 kb1_8bMZPo2XXTdLOPA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:06:46 +0000
Received: by kubenode516.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3d833dde794aa50aade8b956ea9555fd;
          Wed, 24 Nov 2021 02:06:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 21/28] LSM: Extend security_secid_to_secctx to include module selection
Date:   Tue, 23 Nov 2021 17:43:25 -0800
Message-Id: <20211124014332.36128-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a parameter to security_secid_to_secctx() to identify
which of the security modules that may be active should
provide the security context. If the parameter is greater
than or equal to zero, the security module associated with
that LSM "slot" is used. If the value is LSMBLOB_DISPLAY
the "interface lsm" is used. If the value is LSMBLOB_FIRST
the first security module providing a hook is used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  2 +-
 include/linux/security.h                |  7 +++++--
 include/net/scm.h                       |  2 +-
 kernel/audit.c                          |  4 ++--
 kernel/auditsc.c                        |  7 ++++---
 net/ipv4/ip_sockglue.c                  |  2 +-
 net/netfilter/nf_conntrack_netlink.c    |  4 ++--
 net/netfilter/nf_conntrack_standalone.c |  2 +-
 net/netfilter/nfnetlink_queue.c         |  2 +-
 net/netlabel/netlabel_unlabeled.c       | 11 +++++++----
 net/netlabel/netlabel_user.c            |  2 +-
 security/security.c                     | 19 +++++++++++++++++--
 12 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 7172d864579d..38987c68f4d5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2721,7 +2721,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index a35618740b19..763dca314c00 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -184,6 +184,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
+#define LSMBLOB_FIRST		-5	/* Use the first slot */
 
 /**
  * lsmblob_init - initialize an lsmblob structure
@@ -598,7 +600,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1459,7 +1462,7 @@ static inline int security_ismaclabel(const char *name)
 }
 
 static inline int security_secid_to_secctx(struct lsmblob *blob,
-					   struct lsmcontext *cp)
+					   struct lsmcontext *cp, int ilsm)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index b77a52f93389..f4d567d4885e 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -101,7 +101,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		 * and the infrastructure will know which it is.
 		 */
 		lsmblob_init(&lb, scm->secid);
-		err = security_secid_to_secctx(&lb, &context);
+		err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, context.len,
diff --git a/kernel/audit.c b/kernel/audit.c
index 841123390d41..3c6e88a9ff62 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1443,7 +1443,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context);
+						       &context, LSMBLOB_FIRST);
 			if (err)
 				return err;
 		}
@@ -2138,7 +2138,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context);
+	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bdb368382e5d..ded4e8740fa2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1123,7 +1123,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx)) {
+		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1369,7 +1369,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1532,7 +1533,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
+		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 47d1085e037e..ebbde7d9d8bc 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -140,7 +140,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 		return;
 
 	lsmblob_init(&lb, secid);
-	err = security_secid_to_secctx(&lb, &context);
+	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 0c3e1a8aaf2b..dc31f7a68d6d 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -347,7 +347,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	 * security_secid_to_secctx() will know which security module
 	 * to use to create the secctx.  */
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
@@ -658,7 +658,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	struct lsmblob blob;
 	struct lsmcontext context;
 
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index c8825e89a21e..541a49d5be9d 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -180,7 +180,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 69343275c54b..ea43bfd14544 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -316,7 +316,7 @@ static void nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 		 * blob. security_secid_to_secctx() will know which security
 		 * module to use to create the secctx.  */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, context);
+		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 60e36324568f..a70269367827 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -437,7 +437,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(lsmblob, &context) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -491,7 +492,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -550,7 +552,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -1120,7 +1123,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	ret_val = security_secid_to_secctx(lsmb, &context);
+	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 951ba0639d20..1941877fd16f 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context) == 0) {
+	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
 		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
diff --git a/security/security.c b/security/security.c
index e776f71d126c..1d28d25d0ade 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2327,13 +2327,28 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm)
 {
 	struct security_hook_list *hp;
-	int ilsm = lsm_task_ilsm(current);
 
 	memset(cp, 0, sizeof(*cp));
 
+	/*
+	 * ilsm either is the slot number use for formatting
+	 * or an instruction on which relative slot to use.
+	 */
+	if (ilsm == LSMBLOB_DISPLAY)
+		ilsm = lsm_task_ilsm(current);
+	else if (ilsm == LSMBLOB_FIRST)
+		ilsm = LSMBLOB_INVALID;
+	else if (ilsm < 0) {
+		WARN_ONCE(true, "LSM: %s unknown interface LSM\n", __func__);
+		ilsm = LSMBLOB_INVALID;
+	} else if (ilsm >= lsm_slot) {
+		WARN_ONCE(true, "LSM: %s invalid interface LSM\n", __func__);
+		ilsm = LSMBLOB_INVALID;
+	}
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-- 
2.31.1

