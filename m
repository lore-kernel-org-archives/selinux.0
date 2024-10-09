Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DD16F0E8
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495250; cv=none; b=Ucwv8bFL2ylRPrsQb8GnTc+TYLLijaIQKck2wjP5p+Lc/QketqMKzKQ+iZlvsAgI+UOilES6HQ0DJD49xRikVnHoDfyo9Pv/YvztzkVy9fgoMI896TQ7in6eMjKZFR//kAuPX8XJEXvxh43gKjQ5K2uKn8dIqdm1v+e9GAhwoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495250; c=relaxed/simple;
	bh=FyZL+jVtpf/tYxhn0EH8VQfz1LJ7CjgK0uyii/nDry0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4I3XqHPZIq6xwJfhB05S8vVpg/ZfLik3K0YV/lDIljPhZuxfbyK1oOfMu8rrokZwD0Z1UVd3lqn0p4/o8tHHQxJ75yfLUdUMxMZL6wI70lccjpnzNCr/rfXio8KqWD21VRxTHiFRM4iPMOeCYbe+4pR9MAk12eMZVvBSARJOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LvonbgFw; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LvonbgFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495246; bh=VYsNlM7MDoh1w0refd1WTiBThNASgo71a3RwWgcl4/0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LvonbgFw2Rl2IS0tH08gK2X53SH40liToR8GRU/BVeFHW/2jZHPeLR3Z/7OM/fQM4Rv1ydbSBV9lDd7JPNgbHJqBPc2ge3phQa/GNMGyxWx6jon1q+lbBPLDKR+2NaE3sHSeuTkSBnTj7Y07zZQYJzv04CqQ6Fy3KWAiQjM7p6a1AFNhgm5j/AFOFNW8RhxIT0mp+n56TRtVBYUo8s/j/GRwpvkrXHHcAYbBovVS2Cwo+oYeovJOUQGRe5miwSomKYCKLyA4XTM9Zs2KQfzc28a/2SmST0FnpS8z3Rwf6Q81vXf+Z3Io3XwCyPz2F3l8pxNmZKHFGulFKp/XYt/Y4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495246; bh=F1NHCbXKJMETsP6fWTs1XGS+bnK5mUHVFJIHkOgDe6u=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qjQe1ZDaHYIIQAQx0EnVwRxcYy36r4murrWvuRBJAiZv+UDU18jWmqCCIK4/ggyjzNqwzBkqvJL0YAo+pcHYHRkaRd0ah25JSpWVHw9ZkO4M3xroCIOv62cQ5ITaA7UzOEM6GpZ+fluZUr8nHNtvzqud9820aSf5qSbym3G1kS5VgGulmQZviqgG+06Qy1MTjTcmZp4ea3zWESK3DIEPzU+Aqy7AByONgF2b4TjBx+8o1uhSoyLo6cfNty9KoF3V4E+UN8dHwwqVJDdtvqgCx2ei+oM/cgF6l53wifQ6cwRkyeO1gHH0MjLNYYlyHPgLGzl8tH+WJxoK5iilxJPhwQ==
X-YMail-OSG: iTph0FUVM1kN3HW.L4HLw84AhaHjg3jXRLplpeK83trgzaICP2sCyk1keOXVVnS
 DG5C0gtMPu33AiXRoBfCOMe2UOFQEYrAUZhRa5mSVn49X4dLInohkoZzsS7ejrAeAd3_wRnoSvCo
 SvnczOyFEayLtJXPlBM00i5vdl.8hu8XUqxC.8A3yqLjN1zg.tMCgnRxM2xmr8Ap_ObsOfAz7lqs
 s7H969tIi10uMjqPFyyLgbmyV5BJi1P_bh7ef1jiE.Pck_CKXv78IscTkGjVBKZP3i.oKCMAAN2X
 g9ABtl1E3BC8FwEKizDji6Kqo2TX3W.An.HdvZdwFgYSNjj9yQorwIV60oiHtWB2uBMmwu5yVXlw
 DNuitCCYEOMKpT5GELlUEh8yfBMk5Rd_fOJb2Sq63VmM.c9BCAKObrdlOmFuzjs1bhImI_7CljDR
 mhlhSFEJQwog5.fphVQWmKxARJ8FRYkez5Rt6OM4HqG.hWTz9Dowm1.OJlwSvYvRWcxUKsPHCBDQ
 uCHNI9sE.idzvvbuINUbfo2PY6Jd8lEmBhDURXOCQHpbFg3MvAg_b_WqtyB3vFHWrqgjUgZbGmzz
 jJve_HRl4SKgOWaFXSbJuCnDhM57VguVob7AvukQzqU3ZXWFHkagqsBFaduyLUM9vExGRRhq4SUv
 eMuRL_ABwwCzmNxcLnzAeJ6jQEGPlzp2YLzKa7P9kQzD.DTGGoj_wbS5oe3dzzh4iIbf9nSglOaj
 FlxHPGeqPN61R8lVm_b_sPSndQ7R1x1zERla.Y_rqEuM5lNvYYLf2lP2VwgtpyFV0YaGLHafHuX5
 fW1_Umg4Jr2RPki1rWKuVBo.l4VjAWcgsReGxLZmlhNaY3nC0CJbdGgMY3RgSRSRivhXUiVsXyoq
 dqYDdDP.pvnVe_BWuqQ5GP.40VE6RZzA6HgZ8AkDJ.gaFpsdYxv5BV3iOun4iQhiMEuGl_N4.n48
 LR7YS8dvimuRchKlSkoCtk4qXzZyqM4cgkwDKNrwYSX_OsZvq5EgJq4Ic7C2mOl3VIyPedT.ZYwn
 1dESMJan5pl97sFGvgNRCJYLU_lCbJzJr2cpSJwkC6E9Dic.777jC0gbVsD6W3hy01JubAIZpryY
 xCYqx8Z.A6fhGuk6pUhRLoFfPm7INP_g2p5T_SVLSdO099uR9HygvmoPCmJUHe4j17lbDbeOcGZZ
 9nZHWrVfgjudWlUVJY3jlyGkUx0GpatPM7t.mgjXCTOB5npJWOBW47l81of6UNn1_.Jd5hIg0d41
 hrileDyNyLuuEly_c.7FSb89Gtg4PFx1qIQXLAgc2ZJyzwBCyTgYF4aK8BieKoxhpzX7ON6ktK4O
 ef94hUH0uX.7pxcNxwJlQyxb95q01vITs9A32A2dmeJEgMho2IetKWG.nV4OR4qw_TM.5f_amaAe
 v376YCRj2KysxZThrxaIVwQOwJftXDp5WE.Jfaxa2LtcOYXvHEbowmzLUhNyw8uEAYJ5kl6L4TGl
 jRko.oUzcyYqpzaOwTVpTp6idZ35ZPBgsVHmt9tY5GdAdU05gDsMWmmHEfpbFGzmMM2LA2pou4QJ
 IRhHLv_.aJLEL4e9ZDdkPE6Rcb6w5boOkR5s_GArrcP2hAdNqTsjLIRag2TzSSSrozhahW6Sbjny
 5a_zImP8_TGM7HUJ.vgyFWqxsl92M_fnlTS7IRewvSdvEfzhb2cpGpRZbhbwcU9u3MOe5qujqnuo
 dtEhiv19GuH5NUDzRI5k9U5FFR2OumXeWUN8.LxyNZ4LlB43zrzRFr3HAVzIUnKzKEXYz5yyBUb_
 zNqhdZHiZ7QaD7VGvAjtTTpH3oWOcg_1AClwxt8TGQwW18TFtR4oECkUsKUFJKefausHA1lLmTJx
 6YIZEC8y_qB52uhSJYxxn9fCWWEjBWk0jpdv93C.ZQYuwo3F2j01cS2jzjM6LEY9gUXOB70EMhHY
 g4cnebk1M5rsYdRxkOjdQ.IbXAohshEmnBxgH2SdijM7tQt74g0CkdCkOZM_3diajNPpzhS5Ndj_
 .GQQ7JoiUEZwnwqUkJskmq5T0DIiK3PRywCgLZ0jF6ZTQ5sD5RMVraQvFq4wac.Jw3K46qafcy6s
 oobxx3lvGIaDMz.pEggQWMNBzKwVZS9wM22KSok.y_TZzZJTBEH0bjTbln87gPtNWeErM_D3sTFw
 xqFRMCUjeK7dTQFKjXvUYmtiwR1l9SBZNuZioo8FO77QKLHo9MtbYdZaj2jpoFtjJN2rX37RuAsv
 b65fEDadGxoheDtf1YVyNsp173g6S.a_EFgWab_RqRR5xTGqxB0pBhAovXBBFmvHoQC3f1vD9HTL
 bJK8GAJgaTGq6_XIjV3TbGwz8xv4.WMtRdS_S
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 16617802-1c8b-43b6-9667-7bf386e0d09e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:34:06 +0000
Received: by hermes--production-gq1-5d95dc458-6q8w6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7e77129a0d9b2a8b8a48f1f6322a7dc;
          Wed, 09 Oct 2024 17:34:04 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v4 04/13] Audit: maintain an lsm_prop in audit_context
Date: Wed,  9 Oct 2024 10:32:12 -0700
Message-ID: <20241009173222.12219-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the secid value stored in struct audit_context with a struct
lsm_prop. Change the code that uses this value to accommodate the
change. security_audit_rule_match() expects a lsm_prop, so existing
scaffolding can be removed. A call to security_secid_to_secctx()
is changed to security_lsmprop_to_secctx().  The call to
security_ipc_getsecid() is scaffolded.

A new function lsmprop_is_set() is introduced to identify whether
an lsm_prop contains a non-zero value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 24 ++++++++++++++++++++++++
 kernel/audit.h           |  3 ++-
 kernel/auditsc.c         | 19 ++++++++-----------
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index f1c68e38b15d..5652baa4ca3c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -291,6 +291,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 
 #ifdef CONFIG_SECURITY
 
+/**
+ * lsmprop_is_set - report if there is a value in the lsm_prop
+ * @prop: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+{
+	const struct lsm_prop empty = {};
+
+	return !!memcmp(prop, &empty, sizeof(*prop));
+}
+
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
 int register_blocking_lsm_notifier(struct notifier_block *nb);
 int unregister_blocking_lsm_notifier(struct notifier_block *nb);
@@ -552,6 +565,17 @@ int security_bdev_setintegrity(struct block_device *bdev,
 			       size_t size);
 #else /* CONFIG_SECURITY */
 
+/**
+ * lsmprop_is_set - report if there is a value in the lsm_prop
+ * @prop: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+{
+	return false;
+}
+
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
 	return 0;
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..d14924a887c9 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -160,7 +161,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsm_prop		oprop;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index aaf672a962d6..e89499819817 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				/* scaffolding */
-				prop.scaffold.secid = ctx->ipc.osid;
-				if (security_audit_rule_match(&prop,
+				if (security_audit_rule_match(&ctx->ipc.oprop,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
 		break; }
-	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
-
+	case AUDIT_IPC:
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsm_prop_is_set(&context->ipc.oprop)) {
 			char *ctx = NULL;
 			u32 len;
 
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_lsmprop_to_secctx(&context->ipc.oprop,
+						       &ctx, &len)) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->ipc.perm_gid,
 				context->ipc.perm_mode);
 		}
-		break; }
+		break;
 	case AUDIT_MQ_OPEN:
 		audit_log_format(ab,
 			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
@@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	/* scaffolding */
+	security_ipc_getsecid(ipcp, &context->ipc.oprop.scaffold.secid);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.46.0

