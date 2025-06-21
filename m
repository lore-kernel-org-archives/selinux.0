Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E7221FC0
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526349; cv=none; b=TA92y6A2mbLYenHXH8r/xLIGzgYZRbxlNGsi+68djZ6F8horT7VBZCltWae+t5/JhLGic3YEySXxEkyGYBs+mG+1AQ76XCMXocBkm3wZammsBGcpCB3LM/QFgHlx5oYLTVdsDgC/0lM0fhqEQ/q5mJZCFlikIMNaviJiWfNVVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526349; c=relaxed/simple;
	bh=f/ieU2SBlQarA4UPMRaLfv1Or/VeNhHMPTpO+QdUsqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krBWQ2LclvRXwiK8CNsZpDg5RyxyJyVqLBlPbrfMmGCFJUp6sYK6s4NvwN7OQC0Op5qYXrrtvOuGjexym5GM5zRMTz+2crW2dlLS3F3XKEGrs/up8dN6XA2pt+zYTNtZo67UWfkzlTgFznyHjY7exbArrRIaOt3nw7bVTjVud7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=c+/mK39b; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c+/mK39b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526341; bh=nlAYkCZOgW9StF3nsNr63pDVEMmu9DZvz9PJ8UJIL14=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=c+/mK39bGEN88k6s1zSkTHFMWHUFhIZa+3eWLkYQq717MQmQnrt9grtW8NCCp/ryGP/Y6hE/yWCuFBJ7wXcrJ9/XKiV6/NUH0YM9gTEzf2dIcel0p0GtpzNXUQ1I+FGta0p6QWOHhiQ19xKU4q6gvlu/kG94WNjzzftn60sKPOoO1rHJRrJB0bCYEk68AMxPUGpuhVFpCU0uT7XWmaFZoxt8RWT7zz6GEkwcm3tlxytJ1fB3SeKqbncFR3HoY2sxq48SQixRUdFkqKIk0otbv/GYliIXMlMLHMcXAfZp7D+yuiKrwgh7v+FqTvSpNZH4/0Z3+HryhV5Lb8pZ5CxfTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526341; bh=V0yYj7f6Aww0C3PIJ5lfoOr5h4JMs0nQLcg8oBpolaZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XmhGaL3AT2SNzPdr3OGaP0WWmaIJWqwfQQb1hUDaJgQDKNgWYxdxirhzCUlDl2UD8/JiJ/G+BOYCXqpCn0nV93yEMSYYUSFRWlC7cGcodtSsekjEqw69M41FwssM658XIm7oHn+6D8uCtd/f61AYpb4IHkFUCQZM0lv2seNFw0doioWrk3frEebqy7fEsYL2j+vWKjLmWu+xNVjDmciGaqiV34C88j8pbui22coSAGaKGy7OB4c3dh3EVNk8T5kPABmWToguqhdSwllDFge7Dwuq6RLth4cVuEXDfdK5hxGlpkzM1NbgHEGwvRIv0X00mPeX4wes61nEwW6waiC6zg==
X-YMail-OSG: PqwLdiwVM1mV59oiMLsZ7Xp9k1m6QonPKfAKdXxSmveRxqvwiUC6_CRtVsP4l5l
 zlRzYdrb69fqczhOhCISocBo0N07UyDnAiqKhHjc48kjnDbXQEIdhgFxgA5rN0CIdJGRH3AhZvs3
 BjO07YYq.Ea..DADNLU0BImXRXJ0gnRKPRJIHC4dDHJMHGtamJvN_d9d._YxFG03.bD3v8isX4lH
 Maek1qc4nOupePT9IG0_in9JPXgTUs0NMrEi_hkZ1fAtXlb.qmljTc1CyC5mVx1d9xTNkuuIGJMF
 cz9F8pHVMAg7xKs9QWA5SoRW_CkIQEDR2Mgj1wW58kPNzlD0R0qZyRa1vK2MuMHp7yfKjVpuCaQN
 EodNh5K4iTSGTgUaIaODb.mYfHlxAJvRNcGNlY2S5NSUQ1byLg8RhOMwOMMVDmOLcgrOApOZhrwz
 L9P56FF8B9rRtkhupdr8HEkN28n3rGeiG5xqdK_JCF3A3wcDJWJDMcnKJocBqkE23h.i7d6czaoK
 qOYJB.Hp_QGWdE_cggnvIZ7u3SF9dDVwW94rNs1GGEVKmRaTGg9BtKNNCZvcDRl37ClRDT0Xbuir
 gAWwNwJXiW2FfnOUIsFH8P2bqXKS1ckyS3l3IRQ9tTm5YFKHNo4fJpunY_BS0EBDq3FwwU5EnaiS
 VXpbZlJzEpmUJnshses1XUWePSE307w7E7iUvHQWB99IWZZK.A6jhgbrrIWKlVsouRCmOC6.391k
 KotqmfzXtIOyfeexf7y6SP6n2Yw2U9.GwjhGrBPPlHv3bY0o9sWS8IAPY5PSeZh3oS22ryi9gRXn
 nK8kqnKQ03gUswi5xmSc7xe0amUEogEzgjrVxLcWYdJ4l.QybFuc.YMGR0d7w4PePmYMVm5D5JeF
 RuvFL8oln7q1x1IVceRCp4Zepxcz9dwvi5egGaVPiOpg65JAZsJMVweAtoR8C2e4D6RNPZA9ooF5
 _M7obpnjVVa8OIOKYRqJrhYj.iVjd4o8WS6UTH1t75kXkmFKsQ1et9UjgPC_4BVjYVz9OlpqE1Ws
 HniqF.tf_G1x4icJOwyiRPuTGeUEA_6RxvSaGDlNBls3kU2buLxEChgAZoDCWj.Cl2yj8jwhqTdO
 at84tFx_98Pi5nGrF5hutx7imDZJ.gcbZdQLU2gaIdnD0AuyorvFm5As.cIF7OOnkAfw3VXzxBL8
 si4pf1zxeT.jXa..084KstCgCg6g0dvsyFH5m4sotwlFhQVIWpjhBBoWsFi0HwiySpMDMCzqz7j3
 rqEc5u4S9hm9FFGu__NwEqlv_ddHtmRZEaAMFZyDSn2UQzGsi9YxDcG24SsoEpDOIGJ_rKRgHglZ
 UUbeDWyxtJDiDuFJKOgpgnZnuPpVldAbE7lvlvEO9PgMSn0EV5xb6t76xiwHGVdJ5DMKy7O4PUVJ
 xAGh.q3cuRHtDfQAc_LMs03uq2X1lkz3FGonfaeAX33hUseQgD5XZh_bQPIxUS0aPPcsgxD1rdwc
 _XGYlZtH.XXG6ofFLIC67DL1.T_oQsWrU8UX4RNDhSCDWYRfockgZNTtLJE8pkfrqq9u8jN9lFVG
 i6eWTznl_oI4dHLZkhaxKQ3KBWmz_ZT25xGwbcLMrLWbc6hfDd_jhnLgftpMB63XJwVMQ_x2nquw
 VSwu7xmmlw8bVE7opt3r9K6YmMGu7GvXeNDmzFgm92dlMs.bCuAxQcLmNCFgEDwdRqdS7SQ0PUws
 0Qovg9Zrr7Obv0Xtx.4GtPcibhFakF6fmCKBkE0RlLNfbwSn2wx5MlGvWU4yANdwK_20okEnegaZ
 By5iQ9E96V3_LkvUJVGN8wlx3iEyPqWvCm0WlCul5RKRHevTvl3Zh7PGeQ9ckIDxfty24LHt9mFg
 mShfD7k2qcrZT2CwlLoPDUByL.BvigtU7CCsQjhxOFUlHIh6QllBrVUaHzi34BMMXLOBNTyaWAul
 N8TisXVAHeyCD6AUSHqMKmnDF4IaQ.cK0d96fk1hvfGg3k.XUhPjaApm4z9bUlTPB255L.7ldeo2
 CvPojiEarVaH43foeBP22q.cuBv6lbRFmsoataxz4N_C2goGB6kaN78lMqketIneGMXLfNnLyuP.
 KvZ5_21Fv6U.ULUSxgVtNXVuNeQ.apu7fNaKXZe6mGZ1asq9OUxAFfvEXRCuqvwli4RAMkSmJ5VC
 ihrZFtlWAxJbSpB7olr5sw7E4gz76QCXzgaBQxWK_xlOIC_Sy3SGxgudfFel2aLWj_ZkvrtUSRsH
 Eq4HEoYIyddZ3mEihK5oMGuv20BxLiFvRVqmN.9DDYU5REsYZSjC8ZBFBpLffPInIe5fCwfHk3S9
 Buwyl0jxUNJB1WWFSY2vJR8_u
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2e27f746-1c00-4ce9-9e9c-04cc21375c2c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:19:01 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 250c349a2671887e65e0396b7ea9bbf4;
          Sat, 21 Jun 2025 17:18:58 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 02/15] LSM: security_lsmblob_to_secctx module selection
Date: Sat, 21 Jun 2025 10:18:37 -0700
Message-ID: <20250621171851.5869-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
of the security modules that may be active should provide the security
context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
a hook is used. security_secid_to_secctx() is unchanged, and will
always report the first LSM providing a hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h     |  6 ++++--
 kernel/audit.c               |  4 ++--
 kernel/auditsc.c             |  8 +++++---
 net/netlabel/netlabel_user.c |  3 ++-
 security/security.c          | 13 +++++++++++--
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c032ec4e95ff..5fbe38521938 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -564,7 +564,8 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1536,7 +1537,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
 }
 
 static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
-					     struct lsm_context *cp)
+					     struct lsm_context *cp,
+					     int lsmid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 547967cb4266..226c8ae00d04 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1473,7 +1473,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case AUDIT_SIGNAL_INFO:
 		if (lsmprop_is_set(&audit_sig_lsm)) {
 			err = security_lsmprop_to_secctx(&audit_sig_lsm,
-							 &lsmctx);
+							 &lsmctx, LSM_ID_UNDEF);
 			if (err < 0)
 				return err;
 		}
@@ -2188,7 +2188,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx);
+	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
 	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 528b6d2f5cb0..322d4e27f28e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1109,7 +1109,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmprop_is_set(prop)) {
-		if (security_lsmprop_to_secctx(prop, &ctx) < 0) {
+		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1395,7 +1395,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsm_context lsmctx;
 
 			if (security_lsmprop_to_secctx(&context->ipc.oprop,
-						       &lsmctx) < 0) {
+						       &lsmctx,
+						       LSM_ID_UNDEF) < 0) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", lsmctx.context);
@@ -1560,7 +1561,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (lsmprop_is_set(&n->oprop)) {
 		struct lsm_context ctx;
 
-		if (security_lsmprop_to_secctx(&n->oprop, &ctx) < 0) {
+		if (security_lsmprop_to_secctx(&n->oprop, &ctx,
+					       LSM_ID_UNDEF) < 0) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 0d04d23aafe7..6d6545297ee3 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,7 +98,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsmprop_is_set(&audit_info->prop) &&
-	    security_lsmprop_to_secctx(&audit_info->prop, &ctx) > 0) {
+	    security_lsmprop_to_secctx(&audit_info->prop, &ctx,
+				       LSM_ID_UNDEF) > 0) {
 		audit_log_format(audit_buf, " subj=%s", ctx.context);
 		security_release_secctx(&ctx);
 	}
diff --git a/security/security.c b/security/security.c
index 8a4e0f70e49d..e4b596bedb93 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3756,6 +3756,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert secid to security context.  If @cp is NULL the length of the
  * result will be returned, but no data will be returned.  This
@@ -3782,9 +3783,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
  *
  * Return: Return length of data on success, error on failure.
  */
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid)
 {
-	return call_int_hook(lsmprop_to_secctx, prop, cp);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, lsmprop_to_secctx) {
+		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
+			continue;
+		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+	}
+	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmprop_to_secctx);
 
-- 
2.47.0

