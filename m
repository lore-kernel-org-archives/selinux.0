Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E951A4F2E
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993896; cv=none; b=IQCnp1OSBwyS9IvIGm5SnXeOuokY/YnonydKaW2eNwquuzCvdILocMjIFzjvZ6AGDg59UsC8vyjK8XiRMR1yauqdJCjEsWoUQFTmHXu13U9ajCXCE5yuDOEIcCMTaQvQoarW+zqAjHJaedlz7eL00DHse9BE41fOdrhL7FfentQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993896; c=relaxed/simple;
	bh=hqc3TZRMP1PD2mJh19BK0UIVktdahRiV2R+hnZAo5iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzi7yWXCdISvZIP/DzdrIFgNmiji4+kP2IR0q+q06awLgoPdI3IA8QPIIR5q5MpyrNeJeDUopXLCoLC2s4ybTRn40qIFLu7VAVTpUQ6pnkgTY4hfX4s4DDiDpTpGAVAO80Q5pCKiznu98io1yRVqiQj2Xyx+CSJLrdxH1Qk0k/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RNTPdRNK; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RNTPdRNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993893; bh=P/ZrrntebfjX9fvINT7ujS9u+gREomSsDH9S52nl05I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RNTPdRNKsmqKOBbbhbLyhv4/nfERM5B4hK80fw/Fcas7w7FEwVtPGZ7ROrCGqRTR9vEBF7cZAlF/+t7diKid8c6TW3qkboBEkV4lK4Htpbq57dqLwW5dpXSKws0Foso2Bao43nz77M4Pq3jPwnQ2MblHBoedfsPJNYFzi1geuBJQgzbX//PQI5opQHwzU3nYMVvzGlRlzVYZl79sXS3EyZF3ygtYvIytiYcWl9RzPqPQz8teWp+sZ1PYgSsIzjmUXudGSrTKk+7ERw2W2+IxlJOnS/RymhgNHx8fKtVwk24Bw1JvyUJgBJXkPxDBKGRmd2QMkQskI0TH5ch7QikJ7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993893; bh=uCdoqU08AkRTcAuxmLlgLpNyv1KjNf8ukv+Uql1fN5e=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CUeYFjVyDj/kVJQiiQL3Cv4zgVhqpqBnMY1vdqh7t6B0lcbtyfIzd0jdKn5GOqbIOQH+ZJt+Y89YSYM3GOl7ttYfbgeCjjAxqtSJ4JGpaJM8Po2hSsGGjTxz3qeKJDvGWDDdPtCZ1IDNTU/rGL0jl9uQkct8oGXtDKoJPDPCJXZgMdwwfqDBXPXas9ok0IdOHBvAB3eVJDRsoxgjGG5GFGP0ZEZmcJ1Pn9arNONo5/ITa8gsrs0kzPlgfFZ5eid09XVuAHnQSXVHdkxtI5TdiQWDXcysoSk5/U2xfUklqQUGlRgVOrcGoxe47WhAZsrx7dysu6WrwrusXjLRDTDoBg==
X-YMail-OSG: 4JoJZb0VM1nVVyJwgH7JPBqloS.bQoGiT9e7LoIawgX2_2UO0_LpYBEciOXsCxR
 x2rLq_nBlCan62eyS2vy7oaE5Pwd.JydABamr8v9nXxIKUs3EyBAot6kjQotcqYI.yONn5A8fq00
 WPVAU30_rOgHcillxNKmeMqAvlMXlqvekqucATP8h3CztzJ8e2K3Wb1yPLupkiqTo_cFi8.yBqT2
 GymYkoP9uCcD7MmS5kyH_oqZs6rcvecY_zh6goje2h9x1L6xVc_dEjj_Yc4zRVAWyip.amqM9Frz
 MTaXLT5SZ92HHwymHa2Kw7F94k1qXvC019A.K6hc54o2uFPoK9IRc.rzYGUqgtbc8tH0eDp8Q7Qs
 fmqxkvuVK86A4bW9njnA1f6vdJRlGFqv9qUrSllwliEAe4gAa3lviBv__gFPo7OubyMAOICY91mk
 MTycaWG1PWW.HZOmYqroHsO4XF.aqjHFgKMWhkoyHR2RJv7J7bKZ98aFO7PkNphPDvNxmAjrI00L
 oFjcSgsPNgnD9lNthYCJOikhXdR6Qf7VcCQkKl1NLBglqKjqVilTRfV4uIXi.zCiT9Indvw87yhN
 NsQ3QxL1szp7le2upopVbVXOyhdS0V0iftxX_0tgE0GUu9yy.EEIVU_bR.K.qlHDLbYrGgpyebYx
 uXDudKPKjDppjheHETz_olPm_fccX1Bvq6Z03LeoN3U6.LbWJ8o3woObdBzWc83SFd3Y4jtYyBR4
 IXUQzervHew2jhnZZuhDjbKg_m3oxxk0X9.XnqXMRUSK.U7u0PsCn_WYRWMi7vRVNOo.34JxsnIA
 _xGmS6SN8f8osN31r0glZktTx.qhdmz1tLuHTAX5cpw46LVKzVmIiFsbcNBZ_ieLoYo2ategcHgV
 BN8CRuj9owojwVqY6Oo3Bewpn17t0XyZD8tiCFenuUTZynZRkRhsr5HoIZAMoOuAX_2fClLkL4bK
 83usnEStt30u2rfFKxXn.n89XPvEvF6LLZV7_Dan_8L6ID4skV2qeTS.WAd3UPLKUspi.MuEVwqt
 q_isVcLfgJHpUuMlqOTlVCC2QuBsbWFVLQMneG5JmUHlpdB4F3XOf3efWN1Ad8mfVDT3G11RSo7Y
 RhB3XBV8ILCEWtfjiWDvFQBLQUEigjYzE3odoZ8dim3ulwt0nkdOSjNOtGb5eEh8w4Xe32twS5jA
 3KY_EsYBXP5KNY6FMf1Ix91Qb3Us55w1pVQWUPUI9Cyrlk9IeWPEhlEozAyQeK0gJCkHjvBN6aZP
 MiLzTekWKqyEW3fdcbEzmOyPabo1I81CMV8xglmKAOJ28S.bypBpqLiaqOCZglbZwLHKr7orQr8S
 hXbMzVKvatYubFBrR.wpC96dbNKPmib4AwOlqei3kpCV3LnIogGCaef.biAU56EAVYFt2EVMoTjs
 Jg.sAaOeC22AzlOLU1b0S_6B.GSN0PXhuNAVlz85pFSS5Opyt1S3eCre3Nrl4mgd4NZKs5rMESGh
 wcG_XeGF4DSzorGz9nAOQZdcE7XFs1BUlvUxDv0_Lm8IU4hic09KOtUlR9b9qAIudMI959PtoLQ3
 UCnDxGlc9ENhTyx543o6jrBXy0bXbE54T5No3EnacqHgkOCtVt2K07UA13fj.78f_qQz9rULHR5e
 X4CnCvCdXJs5wq3nyktk0CCJe1LFlGcSn0aRqF0xabFmI3Gs_NXA5jJ670m8pcUoGgYqvJAXNWBT
 Xvl61HJO3RjF7zvT557DGqHqo6qTqqFFiwQtfo_K2sNnFup8dS6jvftZ2OWw5BBN9xJbyL0P_rMv
 vyG.PqGOq_25Nz21N_EykImANyZ8lya74IYsI_RZ2iBBuWATWnh8AJQSQp4VWiljR16umGkD9h0j
 p9sC.hBsxAQT1zeJTyOeU9dujX.wbR8kMVd3h7kxRKBeELPaWyuCcLOO32pjPSW.9yqjfaMnaDt.
 c.4ebAm3VlhBxyXi4mlJosrluVOhmJAcrojwtu7ZEk3SExMZtxRrvJPKF5W.3BUZPxCbcxRoFM1s
 MZrLrFuywD4T4YkNcRCbL9hFRv2f3XlCMMRDPnH8Mdl77PI.Ts9UTtBx.rqh.XKSaA0GIWCXcMbP
 QW_w2qrRlPfcHDbCKqkni3f96ltv2deCLiPCFLargeXW6sGTkJDZpUlQQj8notHEGk67B29DJ5.P
 3U9t80ikIrZiYh7CdCsa5tjlIQybHjQggloTPUIKmTCJFiqmpJtUcDWLHFtrKQ7PugaHRg8N4JZf
 J6r0mckKwWm0_10Z6cD0veRWCN1bG8PmdzyrKlz4LVcLW8FK9b6J9qPbZwd4GXCumXaTZ_2y4VeP
 UztGtn7_wuIHpwzHeSQHOWsDVsyPwek6N8QH2We7q7g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7822645a-bf19-4e3b-b32d-4f39caa388fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:44:53 +0000
Received: by hermes--production-gq1-5d95dc458-s958r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52d00b93a233ef9d46e84b01a7384b7d;
          Tue, 10 Sep 2024 18:44:49 +0000 (UTC)
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
Subject: [PATCH v3 09/13] Audit: use an lsm_prop in audit_names
Date: Tue, 10 Sep 2024 11:41:21 -0700
Message-ID: <20240910184125.224651-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the osid field in the audit_names structure with a
lsm_prop structure. This accommodates the use of an lsm_prop in
security_audit_rule_match() and security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index d14924a887c9..8e6f886a83a4 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsm_prop		oprop;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8302c8f44cd4..0ff78ad7c97b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,19 +698,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					/* scaffolding */
-					prop.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								&prop,
+								&name->oprop,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						/* scaffolding */
-						prop.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								&prop,
+								&n->oprop,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -1562,13 +1558,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsmprop_is_set(&n->oprop)) {
 		char *ctx = NULL;
 		u32 len;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_lsmprop_to_secctx(&n->oprop, &ctx, &len)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2276,17 +2270,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsm_prop prop;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getlsmprop(inode, &prop);
-	/* scaffolding */
-	name->osid = prop.scaffold.secid;
+	security_inode_getlsmprop(inode, &name->oprop);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.46.0

