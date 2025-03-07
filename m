Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3735242930
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372742; cv=none; b=LgNcNrIv3koMlLqTqzL1+cvkoxcymiG8M7Ma41vpZozMMlCbEPeP6MI+j+LC8XYxcEJsdb+VDVuGgEspQR1fS8SCX7OXs277hKinj+VVSVY9mGSuxvRZK7gUu2Sb8cLAc71Ra5pFiTYg3Ohy36/8fMfTIZZUFtaMGyBEBp2Btio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372742; c=relaxed/simple;
	bh=Af5KTKsQk6wc/oG/z+DaiMXKAfgl5ohzN1roqLwBscM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2vTxB5xsgVA3jP2KKwj6G3S5cMNnx5f2vQ4PaxlxpFK/nyzFMoj3xXiWZjUNoghDC6C5cvmw0Qa7/AiwmI4ynlTz3U+PHVS+kTvMb6GGvosjxafT3U4sjefKi8y01S0u7nyKxW7rnxr2rgAePtygme1AzkI3t0zXEmTkwl0Deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pAY1XrLm; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pAY1XrLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372733; bh=iDZEMDZr9QVsP0Bv/S7z/KogfWoghwIPZsAMo/z1I/k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pAY1XrLmpfx3QxouD5iRx0O1IxmuPW6mz8+baxrAJNKlrhdCT4EueOnxtC/4C1ctfV5CdMeNlEp35k604qinNj3EmU7rsJjV8+3YaZnY0cNpnbQ4MEFiQiwuRpRKO5gvVgynsi4RyVlpmk+FK5A5Lz/VUK1EuFS1L0CpDEZItetyIZJWOs+EW+KkbzRzrA2qVsgw6WeoyLa3npXOSwr7uvPLiz7oh0tc1SvolUQMlhVNpkAmQ7CZvTrjgw6dIiBUVFget9kZicdXMa4CenQXQZ3FlmcStG5BWXRLQ9KSLg2/KPd1Zh5q/f+ibwU5OtTO/ZMRF8mTQSAhm8EisCSr7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372733; bh=pzsphi5EXunbdnc1UQqrYL4cpJOC3DADG7Q6rr3f+8I=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Iltak5ECk8Baab9l9ZaO5qePykGBxGihs7jPzwJNk7yaeFelB85vucXW3ts3JSOW+Yby83bGem7ZmDMUPJQQ8dzh3jt35Gh29GCOL1zrZED+WS6NrgCcwaax4MGFlBWy08kBA6zBYBmi2a6zy/20EmrSgAC9HFgvq4IPx+snzrXIcmx50g06OKd9Ng5KnEFqkAl2kI2alSiVaWGMUc8bc3CpX76peJP35Vkp8VtHEK1wWExr6bLAB+QRZQ+OcuOkdugL5/DzytbVKwhsH+dC1aD2uNxEO6WQgudO1tTXnCKwGZEUSdvXmh6LJo3e+1Sr1pCHUSeuY00pwifCHKXsPw==
X-YMail-OSG: LAOhvpAVM1nNrTQgoiW_qKhfudkMofd.zcl4Wp9CDFz8hWB4WuCz.yblbLoRiwm
 6sjOzB8exRqbj.M_A5snF12xeML7bpbA1aQLxb3F1yAtt4LP2q57MzT0bVuZxbv_YEgdR26FPQPE
 mkh8Tn7LSflVS99UDqHJ4eM0TmPu7nixId15DVzeWIKdY87fPp5dLB2U917lD9GeLtCELc5IvPQ_
 8ZiwmVVBiLitScmmXwPrxQsFu5F7t9lctCKFGOLUhGEyYs.YTYcTI_gexe20yIe8_Zo04hDVJ_Bt
 _TL_rzEhZBelUFazZhVJABMGfFZ1cY9XZeeIkkFwyN23ZuQcyR7fVP_Y8lcnCWyLXkAaQiJPy6Se
 ZYIyXTLx92G8yHCrLjXcnCg4jpJ9o.Rp5xtvQwN5qVZg4_uTylBPXDKkKZOBiz6fETcTJ9puQ8gD
 KvhaV_lPZRIBeOd9zoPkcsvHnZzjW63uOpwS7VB.Eo0KGNQ9AaiH8AIiBND6bsJ7viwY1YHyp2a0
 xCKEFbrhx0gUC.CpTW8xXrO9DYElSCgWRSlJHoAP5Uta.qVcoyzIu7Du5oeRdYJAy.1.giz6iVia
 Rrs9xSRG1dwv_e2EgRahHzJAz53tZ7WMiAYu8hxo8wq1OKV6mgwP7UsexasDHX8YeTz7rqF_K3_1
 zUb0RTeNex7oygDFJPvjMN_0EJpai8tUoVASdR0BEzAWTiStdMZUmhWZdsktLulOW3ejPT6UnkFr
 .uPSXxOqogft29_x3AylrN_xSDtzuEC.3liW7V1WcJ1vt.oYtVJpl8Kf9BFMB7hGReyJWh6woVkH
 80FUWW3fcYdhDPsrYVBclOEsxbiX0m1HoN9RQipAqoBnP.mpWaHVwYn7qQkEbnAS0N2VEhYrTl2i
 H7WgrbuNcpDyfuX6qT2lZg.oZy4e4MbqTla5lqrbOpsG859dMBum7GSGwEgQjXOB5QGYzsHB9nAK
 c0UwCNEi8cfs0GcXZXc4TLSAwGU8G3yUtAvqa59OjAKquxjP_alDvUGlw_B3dOzpNrv9vK.i6YMW
 hcdjQHo.Sv_QLVWya.IORV8goJJe1rPpkqG1Jx4rXU8jbNVzbaRkdgty4uJe6nrCb9wSgkhtu6p_
 Qqb9MAOv_PX7TijTtNhrfH.3kJvvFucUYDPGz.PzhgtaQfSw8kCEbQzwbaCqnxopgxR2aM4nkHjR
 JBXufXnFTTKp69qxIrhVYXxjRU6lGIYDpPyS4z4pCnDMMF5DaO4zMSC5WCrvLIn6ZylW1.ls1Lhs
 4Bwoq9VdG1c6t3KVNoMUY7TTpnsejWjR.zsnBhVWs.43QdqHqA4D_2vgbmiPjvoHjAwNzq4iPYi_
 pF7LYBg2GJqm5Ov.Yb70Y7VdNM4B1FgiPyp1or4B8j9km5XNfZxmuG2hj3CwE.J.i.GjbITIqFSX
 5XhgpKaDm6nafWmuU9VvhbkL9Q5cHDUvTehLDXivFJuYAVq7YqQQztu.6lqm845Bqyhdgdg4icR4
 990Hbst6KDeGMS7eVHg6GwIdwwANNUdfcy1lxSBVLC6_9i6GDpt0TEQivhF_mm1ULCnLyS7M1eoO
 vruZJoR3Nih6mVE1Nz5E6B0pb3AzcPziW2MPJpty.Oui0AKOca.kCLlSdB7CfzYZDgwE1ATHtSBd
 R1AhZRD9xlEPxJlO_pdsTam9Xi0Dy0n0zumsiO2FXdBswAKONlBg28SQxeNiT63m7RxUT4BpzOqa
 sEm.u8OvNH6GXhhLuD4qNIy94sJaoFIgaysxh_alcPnMGJ1KFwn.75HdMaQH7Y9kGw838._eJBH.
 F5opfmLMQQ5MhgFxm.MMMfztBMEkQkpNDa1HI2da2fok0qKF2cHQyrbbI02YsUctqTZ7.vHc6cNl
 aSULoVh8MGfAz6PgEBjd0T8rxm3tu5lnKLOYj8A4UeJsBXynZ.jafSXdFx3JMSQHWFb6SuI5RN4z
 BHi1H7gQD1u0RG40dItG3yXqJcqZJH4JbGRKngNrnf6zHfikqZ5kjGm_FPiJ7DP.KVMv.T3oT775
 MI4LcB1Mj.5jC7Q_iMByGU2xVEem9nLLmLIBOIPcgwSPbHcG.ZqfbM1aJx8hiAeLmPOEfzmR7YFg
 1r.IF2fhuz3a7xsTXdVbda2TjV1QGyYIdSc3fyMGwZc2uuH5v1iDEmttSZhKBwklUS.liKcICTG3
 vNCcA4FhpIS6FfFe.C4nMG1sAHmwDe52IrZuFP5CQgQAZnTsTgzx1wmpzdpyZ_6Rnj48HFvktqnt
 fkR7oUwUlK9wcQB0K3FGEJON.w2x7LLvjHzhGIgYWqFBoy70hQnzqpTSHley8uZxLwOR11E2oXmw
 1EZ8a5NqB.WVtWzZhdklhaNLu.Tqn
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ca76bb5f-cb09-40e6-835a-00d5b7889725
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:38:53 +0000
Received: by hermes--production-gq1-7d5f4447dd-mxg2z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84a3ec74d8bfe114e53660abafd57a8a;
          Fri, 07 Mar 2025 18:38:50 +0000 (UTC)
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
Subject: [PATCH v2 4/6] Audit: Add record for multiple task security contexts
Date: Fri,  7 Mar 2025 10:36:59 -0800
Message-ID: <20250307183701.16970-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307183701.16970-1-casey@schaufler-ca.com>
References: <20250307183701.16970-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1423) record is:

    type=MAC_TASK_CONTEXTS[1423]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 include/linux/security.h   |  1 +
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 45 ++++++++++++++++++++++++++++++++------
 security/apparmor/lsm.c    |  1 +
 security/bpf/hooks.c       |  1 +
 security/security.c        |  3 +++
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 9 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fe..e4d303ab1f20 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -81,6 +81,7 @@ struct lsm_static_calls_table {
 struct lsm_id {
 	const char *name;
 	u64 id;
+	bool subjctx;
 };
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 540894695c4b..79a9bf4a7cdd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -168,6 +168,7 @@ struct lsm_prop {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
+extern u32 lsm_subjctx_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d9a069b4a775..5ebb5d80363d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -146,6 +146,7 @@
 #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
+#define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 293364bba961..59eaf69ee8ac 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -54,6 +54,7 @@
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
@@ -2241,21 +2242,51 @@ int audit_log_task_context(struct audit_buffer *ab)
 {
 	struct lsm_prop prop;
 	struct lsm_context ctx;
+	bool space = false;
 	int error;
+	int i;
 
 	security_current_getlsmprop_subj(&prop);
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
-	if (error < 0) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (lsm_subjctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", ctx.context);
+		security_release_secctx(&ctx);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", ctx.context);
-	security_release_secctx(&ctx);
+	/* Multiple LSMs provide contexts. Include an aux record. */
+	audit_log_format(ab, " subj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (!lsm_idlist[i]->subjctx)
+			continue;
+		error = security_lsmprop_to_secctx(&prop, &ctx,
+						   lsm_idlist[i]->id);
+		if (error < 0) {
+			if (error == -EOPNOTSUPP)
+				continue;
+			audit_log_format(ab, "%ssubj_%s=?", space ? " " : "",
+					 lsm_idlist[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_task_context");
+		} else {
+			audit_log_format(ab, "%ssubj_%s=%s", space ? " " : "",
+					 lsm_idlist[i]->name, ctx.context);
+			security_release_secctx(&ctx);
+		}
+		space = true;
+	}
+	audit_buffer_aux_end(ab);
 	return 0;
 
 error_path:
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..17ec93a8d3fc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1427,6 +1427,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 static const struct lsm_id apparmor_lsmid = {
 	.name = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.subjctx = true,
 };
 
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index db759025abe1..aaaa1227ce13 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 static const struct lsm_id bpf_lsmid = {
 	.name = "bpf",
 	.id = LSM_ID_BPF,
+	.subjctx = false, /* property exists, but will not be used */
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/security.c b/security/security.c
index 55f9c7ad3f89..8450cc5f82d5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -320,6 +320,7 @@ static void __init initialize_lsm(struct lsm_info *lsm)
  * Current index to use while initializing the lsm id list.
  */
 u32 lsm_active_cnt __ro_after_init;
+u32 lsm_subjctx_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
@@ -626,6 +627,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		if (lsm_active_cnt >= MAX_LSM_COUNT)
 			panic("%s Too many LSMs registered.\n", __func__);
 		lsm_idlist[lsm_active_cnt++] = lsmid;
+		if (lsmid->subjctx)
+			lsm_subjctx_cnt++;
 	}
 
 	for (i = 0; i < count; i++) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..1e2e1545eb2e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7142,6 +7142,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
+	.subjctx = true,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 239773cdcdcf..75bd62fe1513 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5057,6 +5057,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
+	.subjctx = true,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
-- 
2.47.0

