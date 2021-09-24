Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DCEC433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5373061164
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhIXSTv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:19:51 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:44339
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345030AbhIXSTp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507491; bh=Agpf/fG0Sx+k8/NpwK7vAPHjo1UT0GHhFZ0hQjWMVoU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PsSCh6hCZjqMOayrrNkfzv9++vvzeX70VJcGXTtIn2w7syreRyND9vg2ZSevyzA68U6aOmD5WI18TWDgPhGli6aCjJJKTL+I1grbQPIZxwBHHGvh63jkOJ5D8k7QeK90yaxUQzbC4uh0qmjiCwvlRawVkE9ntocpaRylh3WU2a1nRImrq4AzHQBwmopMy/U7r6vPZoz9grwpCWMBapHWkCsuFxXOLmUdsNu2BIaFaf8+vMSvIPyjgoX31BngKEau5X9/r4387kYGmLbBTbJbz7GgHVMjs7vsvCbnBA4UpYnDs1HfyNG2HWOn0HzltOCW9Pq1ExLdOSGKd6YFWYZ10w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507491; bh=5OBQWR8ovwwNr3a/7kaV0XznJGE8jC3Y8+0xl9NdxOX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CBKJ6HzZH5MXJBEnPvoqB2JsHE8UNgtWIAWhYCOoSY/P4RSH5Hsq1Rdvl2niic05fJ/v2F1Fft158TlMk1blznmpcvrDYhkNmwbgZB+pTZWgTuaBYEWa23pmgSzyyHXMk4b9LvyezCoZSsx62OaeLMxiyr5f1tp+InrgwC/0prTQFDuDpyIh3r3GVIttzJd18Z0JbQR56nXviNmrnVopoA+p+bm75gN4pyZxH0egwtUZgLVfHGmelVRs6Q+ZVEwlpmGgxiVKG2j2Bw0LLOx9vmtyK8dFOxtxiqhapF4By7p3BfMxneR709TYfN8oeuaabw4y/C9m7TlhZqo0ekr6ZQ==
X-YMail-OSG: Dc7LvCIVM1miL5GgB9pczW0OJrITRCJO81qVfnz3tzxpLX67skMrBvf5iyF1ceg
 iNDBWOGc_mWuT0hSIwyO4jHfBAXBn2ZvIHPVtbnB1cSn6iRrn28pfPv0OKa3cKcOyTD.okPiWRyK
 RRW6jyZXcpLGnDrIOWAQaILYfp4_MZiknwtC9mnPYuOrtyamTrPe.LyXBBBeGR1DCzUPHZvb9K.q
 FlOEw.I3ryIvr1djrwyi8wHwVLukiYEzqs8z8Q4xreNbiUz5c32c1H.Dj2QlXz1yQVuptcp19Zey
 JLJ92Fd9Qa2Y.Vc2yGimBtKXCiLrP.x63ENnsx1T9dUWxCYk.6BnzCV0kuhCKXmfU2giVIiakixb
 B4aq7TTuE7hQ1jYGvmtEawi_uxWlzUffvuRV8N53g8AkJovRTpXzVuN1_Ml7J5G_oGO2hgHuj0gF
 cYfog.Chp4bfSfH.r6rhlY8_P5zMbYdp.kO_tBlP9mAgYWlNswey0bg7uJ.UZDM8qR3FAGJR9Hvx
 SbY6dOTI8qyTTNszEnxVMkNESyI8e4Sv15BgNVsqPuHuGSD1R6WriqNtnO3gPt7rQ8PMhEka2.l2
 g_aV4Zco7vX9A_u_W0SUHKM3NJl1xQ4FIfup7V8a4kEUXcV31oDxGSWXC7nGuWTvVxy7V49J162B
 UatxrlblFbephw.ja5UWefMeZvTp1xAAtNtslUoUg5AoNEdRB8mMflWymv5c4xuw8M.U1O5Ljnow
 CgdIHcTrs4tqueCCgb8ANCZX84JD4ECQCMl1sjboLq242N1QvWnJxpgMsoVDAfBDPp896dQBvJ.i
 PWflUjSFHIAfd8z0qVB0u7psKQHzc2aJamgUg4Akl26jAbUPyZhsPFEHCzvWJ4a7KIYulhTSXgJV
 nWI2IzDSjxSfS_AzRvHw9JlM_Vd.K7KtfWmbvUViVN1DOxLCvwIQDsqUzvH9umbbx21zwXdwPDeO
 QOihau4LAhIwnCCZ50OJZMfLecabja9_io1.BhNeRX6AkUuuCWcPadjaDaYYS5cr1DZO1SviksQL
 OMrkSwvg2.Nu1zDYUfbUhv926FPOA1d.CTZWrzPxlb0VRiDexsRLELdIYWWl9nLNyJ0Q9dtz_h9e
 ee_o8lGEzbkbNOLN94bARGqcahjvMWhCM11_eq0lYuenHFhfctmOhuyF0DqcPRBg0jA4H1aMABsq
 l.7ajarp30seTFBOOu8.r1OWZVdnUy_PAcvVh5ZLQxx5O_YrphOuGBKOe68N3VLOxBG.ZoFV_mxV
 MieQDnRWWNx57sFUDklF6Wr2mvxYyf81tbRZbXWd2J3PEPOs.tvqVr5sdUkHMnGK1rLYEReDF9pQ
 V35NII_ObfCe99HTFyqQZ6sVheYPJGxbniDfjAU7OaEKwYgM14wJ.cfwXF0cAOuHxDkccFPS.NYV
 nUteA0ttzoc_TnZ2Gpy2KzTP.qn5fbtZ4DBRj6tVgMVChzUVvakkhpd4uMIwCncLe8MnyrUZPMcm
 Zf7D5fDx204GNbYRlBKCA_0fcE_U71GHW5hWaPE67rydBJXzK2rqwyi1HIHz2fJPjfgkjdC2PmFt
 wuJZXoesVXKXP1SOBOYVCwHDxTccfZJeT3W3x5tIpja9T0GnY1gTaV_rEgvw3Im25PuwsNS.DY3Q
 60C_77VehUgLGt2mF99_9nvmwoz4SGoelwqtlxOWkVobSxDiJn7sn7MUnRDPaxnQE32gaTnKYgaX
 LSQ28zo4Whv4qFO98Pte.mrqWh9fZo2dq.gs2xVuSVZLC0DfR5KUzeLv1D9lxNV6n7.1yI1NcejH
 GW02xV5FSeQs6ymsu9O1Bej2AItRLE8r.F6hCfW2rw0GhAZkN8VEkynHkdedNYByGBC.AMSEBPfY
 CqJ_gQd4AeiZrIPK2AAY4wVTliZl02NW42OPYqwKlWXMQkLZcjgyOgg2AvNEeogCMo.eeIpjACyd
 nuWg0QLPSsQU.UlKj2QcpqBAI7P.DrCIBz5XGwL0BAb5iSb11VY_R3Hay3cW6CQq.AaDqbl_FSdQ
 Gc3.FUyjLNr2PXItmN..Rok_4.CwxlN0CoJV0X7Z.sVAxjq68oRPKVTsASkbMgmFrV9A_Z1B7.1V
 36MP6TgJqzs8gQ07KO69VWBf2gAgvGgPsdFeTc_.zAWwmPZfEbcqD_74Rz5lIdSSBWynWHwwDtDy
 V8vbaWe_a.NXG634Nr_gXzogGt8vZ1y63qFm_A3hqoMe1FgTSmGBLJMh9ChCaa9RN00tO1gBpEmK
 T5dyR5C.gP6exYoR3mk8TPvSzvEltiUGRByF0NV7RA5Jfyj1TM9O2zuSAzZ60VMV6MVfEaT.AclJ
 cERhViwUA65yRjBPF2cEmLLjpiEjb2uOE
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:18:11 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fe6765e6fea095686f56584b9af1cdde;
          Fri, 24 Sep 2021 18:18:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 21/28] LSM: Extend security_secid_to_secctx to include module selection
Date:   Fri, 24 Sep 2021 10:54:34 -0700
Message-Id: <20210924175441.7943-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
index 1159b4e44b28..e5b1ba72efac 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2722,7 +2722,7 @@ static void binder_transaction(struct binder_proc *proc,
 		 * case well anyway.
 		 */
 		security_task_getsecid_obj(proc->tsk, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index e5fd1711bf8b..7096a60fbbfe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -183,6 +183,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
+#define LSMBLOB_FIRST		-5	/* Use the first slot */
 
 /**
  * lsmblob_init - initialize an lsmblob structure
@@ -579,7 +581,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1434,7 +1437,7 @@ static inline int security_ismaclabel(const char *name)
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
index d198f307a4d8..e87f21cf9494 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1013,7 +1013,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx)) {
+		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1259,7 +1259,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1416,7 +1417,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
+		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 588e4d2dcd15..680bb0969fee 100644
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
index b6922af82911..0d79832d8130 100644
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
index 155da0e9b778..96b1d9c37d49 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2355,13 +2355,28 @@ int security_ismaclabel(const char *name)
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

