Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1C2572
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978350; cv=none; b=AX7i4/PrtZaZYqeMjlR/kc+QcWXxuUsr8W4FoxYf0t6HEYhZ6cVgJV38PeSQipNtRp1vGFnT1iY08HVBDbWKWITrteOmbJ7ZrjAdau3ogPG9WI4aTdNgQ11wHdBiXSj6Ez3pStAUxzHT/Xt55B6Pr/Zzr8rB7bKGpyrEhrj4UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978350; c=relaxed/simple;
	bh=pJHWjaiTkXt7S881LFOol1koX7x6cURvzQhGiG2TnJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUaRvBjxQoceUgaajvgQRqSVQkK+aRHkD0F7AAK340rmeJs8UjypOPEUlUynkYQgojIFItgt+uJyCkVZIoA/ytoB3xaOGRCeB41RV1TkjlHujQTFBCIaGauUsSjuKAwbYMWamRbJiDH6Huwd0fRfhEQPm50k44ksS6CE3d+YwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=S2E4hCKJ; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S2E4hCKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978348; bh=2a9n7n90q8lbb8Znd4oPOhNXPgdgICjDBwLf6y4cXd0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=S2E4hCKJTYsRSTVB7o2Fnkq429rAiX5BubaFNT9cN78yucqa10Rgn+SSxuwOv3D6A8c0TKkfYA/EvP/RNFherdubhVRa/2uAN3khLMKiNJu5RrbAxeMrXQKmiP0i7bvh/BLgV+WrCtQQ7Hq+9kffn7fowJGZshU3lRScovpWi7in4eYqYvCD71hCqrxHrmL44JmNQvup5CDJE5x4AYqgdb6FvDQP5knuL9bOSF+7wQBUdZvxzf+t8eoltYUe8fWM+g/m5clowe0l4jtlC9jZkU/kFCVIttY6e+h7Zjya/f1MiX19oDDteGTbodgVfFG9OPnz3L10SFEC/C0p9Y04gQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978348; bh=WBqc7csfuYkXjYkQqnY26fmaes7RIrzBBocMd8ci4MY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TLMiJjW6fMgT6SbGqr4rbIFdS6uhx5hDC8hwi1nS2rkJW1j0Km+8KlEnteh3dBJkaQEL7OjegHu/wyVCbUrt4G/LjLrGFkyMnU8/INiLj7MO6uCpoELHNQ94MxVrVUekcTC3Y0HIOa9jczTIH4yRhtl5WaBGljY0tGxiHQ0EVjPG8ss8+ZAIENn6qX/Pb0UaURN/5LgbxAtRYgxxvAZ40sse+wfZ3TkOuRRiITFrANNeWHl3DLifWX7u0l6rQA0I5WeifEPoDoz5LqgS7EO8lmxWs2Ybh6ANHYrFY8hkgooa3biTOna0247Cmb2VIaIQeklDwy/jAIrOyewiHS8A7w==
X-YMail-OSG: k8nbyVMVM1k1Wx383cE6.UWnuhZ2Ru6iRZXuEmL5qHMIdQ5iwjbk3Gl2WG2uppw
 C0fFE95.TVqyCDpSIhD2dZOwW7CfBwhgz0Pq87CiMgD5DcNM7X5pU51fHoFFBsfIfjuuCP8IH2O2
 xicOZclVgFgNDPHWw7zuZgMmg9jpf8Du5Ymc5YwAtW6r1h5DquYnhFQzArPkjTPIYmbJFJUfA5i3
 UOMP_eiOwg7JZclP1bKIEeveXPktg1VHxI5ITZk5FeO1xTtJ7ay2YBr7vQbmPVfw.2XkW52Mn4Em
 TbwRbyzakuhD2ml3CT_Tb3bfpy9cvTz2W6K3PDst4qiJ4twnvmjW_JuoizElXIeKPbEmf7oit3mR
 CwFhA2F6iwrDQj29dxNw.83.nYWNyExr10PU0AOSAOnqkcyF5F_oxHn5VvgUQ_h1QUc9UBrLIh7v
 h1.4zYRlxDb0vvUP5B6n_EAAqFt839IEFj_rk0UlLYWsj2ih.EUijkWnUhCGBI5TKQnjqdqyI_mJ
 j6KIXmgseCRIVv9yFHGsUJJlhxQc5._nKADkT_Q6An_Z.8.tomH0h9VC.kut2ELOVbwqNHWU0FMq
 yWhJD22jtfk5dqYQwWx0FPtCr3kSTFHCHoJROY8nXEH3AKPHEK585fdcOTqFbY5qSDTXZME4RetC
 jcAx8yCriAtlTwlwSXccwvq9v8e4.7Mz8EPJjzpte.HzDL.HmZhaaO1eLv9890gibN9toORL1L5W
 58nENx4xNFVVRVT41y20XG6vB3Q0gO9VcyYOCTU0jY2Z8z1LiNJD1WVJpUF3zLjL_KKozVeX6LB5
 LDclAoRhZHOwMGbpeQW6qmhYONlZ17OxVUJeeu4YybPNQHpMiOZkPO5x.uFAUvtMWIyO6KIH4g9s
 xGfi5bnkbYrKCgM0IAekF.lxYDgZ0LFZouaZalOg7VpJunFs3y4vZzbXtSJDFyRPdNlliRMv2yIZ
 hg9Eo4bZNkAsPzNyzC3Uk_7J3e._HtAg17xPeZYiK9F64GAjBl_qc9Xwh58Abt7UR0CYx6Ljuyri
 9gXwxBtx23CQSecfqYnKfdirAQnWzkDgjaReFT3N_eR0TsfTFFTtNHyF8uKkBOsGumVOWC41pT2V
 ._AY9i1caUJgM43MNYHAKtgyUrAByy5A5imgq7GAqShrF4pyVLsh4FOeEvmWmPRxFGSX9VTBY2o.
 u4cvvh71neY9UzOSXl8dXEkeLvxmANwxTAuHSbWEtahiUAibCVSDuYQUXrIITpgf2RuhRhEG2wC.
 L_QEJ.jbTttTBDCUoHEqhL67njn2kgKU4EtJOSWUdolowrq3aaMM4kfrkgm5Rerf_krSOCLKMLPZ
 lOG13i0STtPiVoFfffD.eVYCfr0alZzOONLgn6Bxs2f_RfAdgx25oZDBe8MpR3KlFfZi1IFRIsTs
 Yr7i3gW4CehUL23ToHkCwqsbSaWA.1.BcD_YeGdm03Ci56KC6cUsj1rDQ1BTB3Q.To6NQe.cI.r_
 eoLxmeNR8XNVlb5oPS5M5uXn2Wg6kFRvzckl8qytX182xGHEShg1FneX0WGMXjxGko2VuenoCwOX
 Qaa5AhQoTbr8v_RQQ1tFcwLSXbcVM7.teyx2tmSTBjbcY7AjQ8psDRaNJ5rdjfF9MJleUkU71OSR
 hNBFdtRlQfhEDKqsOsCWn.zik5gCnlkz5h7cklctrjoDNbVuIOAW6oBlIuGuOXRcNPHoJCksqeyP
 r9S5.lwsdxDyMYSmvAVnRtcTNW2_4J_gfMwf9rSP99yhsKgaQ._zQfKsA3JnDYYAmn5adt7e.U5m
 .tD8dIcFlRM6h6BfNFV6LiOg61k9NP5efKSoW7H8vZCyynIqEzQmzDJuylm4MwjiRU5pVB0pCbGl
 gOhId0IoAbSoc4pxD.hluqP7SvGRm6.Ko4bl9cjLkdUVQhxiwDpaoTnf3MBTC.HK46aJtRrBmll9
 lBeWRnwHVn0SHWo_f3UW9yVmdWGAtOMkQOsdn1BOlWHYkoLBf3x8Npsc8GujPfN0w6Z1bSM22glW
 abTMSjQYeipvkAgWudWDEW35tGtt4b5Pbgk4bC1ic.QptgDG92TzmzlJ_l.fRQEDiDLEtP8.6RVK
 4xq5ep4F14uLVP7Q.8RUT5ve_5.wb4pqyMqWluvbrUadkOV4mlbwqWzqaHv.3.BZshuTY7CFA61C
 e9e3SEV5rq9W6VOedp6lm5bl2sa39Vd4UMasGIzoH24H3_lFCc4PDTjKEUkDKfz3qJyUp2Ro.oGI
 YIeaFY8jpm9cKCeFGKw1We667h7PbMnchD2M_X.h10CR568XgoYv2L98rp8141H7X0azZYKB2Ntt
 M3tXooysq5g80iXpKj3oBYa3peTTRoBn6_D3tIA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f53caa68-4b28-49c0-9c20-d7287074aed0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:39:08 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 35a934a1749a25fd4473b6654327c16f;
          Fri, 30 Aug 2024 00:39:04 +0000 (UTC)
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
Subject: [PATCH v2 09/13] Audit: use an lsmblob in audit_names
Date: Thu, 29 Aug 2024 17:34:07 -0700
Message-ID: <20240830003411.16818-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the osid field in the audit_names structure with a
lsmblob structure. This accommodates the use of an lsmblob in
security_audit_rule_match() and security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index b1f2de4d4f1e..6c664aed8f89 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eb1c64a2af31..886564532bbe 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,19 +698,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					/* scaffolding */
-					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						/* scaffolding */
-						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -1562,13 +1558,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsmblob_is_set(&n->oblob)) {
 		char *ctx = NULL;
 		u32 len;
 
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_lsmblob_to_secctx(&n->oblob, &ctx, &len)) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2276,17 +2270,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getlsmblob(inode, &blob);
-	/* scaffolding */
-	name->osid = blob.scaffold.secid;
+	security_inode_getlsmblob(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.46.0

