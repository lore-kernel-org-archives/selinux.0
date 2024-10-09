Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32041D4176
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495352; cv=none; b=e2y5VsYR0UqGnqD7Pjz3VHtTigV2nQo2+H6lyvIFyFdTbQBnasUay3LurFnYKqJPCa6BguF68zgfteT2sgnaGZC+3zMeOrIrkTpX6leREK0WYeSQUoBlEvWhN2Or4mWGMYwJyC7rcToJA1hBUdZ2qTLac/wOk3/2A3jlBWhuNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495352; c=relaxed/simple;
	bh=8lc+7LE68DiZStdNT+SsbwiHqdHBM83bYfeJA0aXVds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbyYj7CQZueQWkNc61g0NH3gtOcAQjVqcFQnJTZO/9e04m5GWzybJYqCentPt39WTrDgn1hpjAWmfE8Xp7fqabeduOCCSqqLQhxUJyumD3GKutpr7ltNhTzggElcdm0btw1fUGhgrCbcHXYQG9tqA28Gh51xH7D/fFwq6RKohS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PxjcbnxT; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PxjcbnxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495349; bh=dSKF4YjsFZbJKDV20QBxq17uyW97kaIyIuj5Z7hhKuY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PxjcbnxTUkQdAsG9fZ5r6/II4L7+daLDUHPlqZrK6FdMTU6AEt74ovE7Ej98dgES5D5K38nhjnPTcN4p/EHl2mp1VkJVcZHsUGeprFdYr26DJVPb0V7TfF02lx8qTuIon89SqHcLzguIt1ecYUCYxb08dZPkXV3bC6pubMeJbz7qU1IrejUmAt1LZ+PxXHG5ARx4fix6wCUCK0+VcYowo0Rp2KtKbwKfuSk67wwwDCJZv4GnM82eKfEA7hl7l5efUwyZy0nRj2bvqvoPkfD+CHvFdwjEuDGAUuOY6hBG5BhOjhDteFbWTs7nRXGgDQwPOUWaPrVhbwymVPm1wUyxcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495349; bh=5TTLdVaaiPovqpivGD+oEQnNCWAtmjU/Ll9+9OBk3B+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GWdaxbxtHIyvSw7RJnhLlrN5Ai968yRCuXTuiIAMa7FhWyCgA9nlBWLMHlHaP2w8//ZLKllDZQfP/1kTi1I6KBoKKRHeKBYO8xjoEPny8MvK9/ZjdHwts2x6vjsjG59JmC4EEEgWWlpm4QySKrejmwnZZoNnGGbVElTYscvl4TG+6e9hjn1aBMFtMtA+M+kXd8CfdkoP/AnL6rivCno2GkzTiRuQRx+9V7w0paLjz5piIHaPJCvZV0SiSTeVb48Rdmcx+mcICw/Y+R/Cby4Y7dMSgQFMWhR+Y4onkXRTXhQe9HZ/ZtkAqKPcEIdb6lbN0pZ4viIq8YMsX45hSwVIDA==
X-YMail-OSG: LnzsonQVM1kh96vfkGHfbJeR49fG1FCqr3DSyE9rgbKWWBIXoB8hL9Vm5hbVUdf
 IErK607zqzw8etgU3KXp5vF4ZBFv9p6X_9CvCjymvQmyqL_x5tEm73Qy8KxYrJYWqbBKg5_FHH4e
 3YYUOa50wUruEIEesn3HCLPz.2zoLaxReQV1XBBBlBVGCDMlDkfY.yEF3g0OJjEHByqwz9Gb67Zy
 4EooPpcxg3TTad1a1DQo3wXseC_z2eQmGW37MfKpleluNntBrf.tGTAVbhmCyAzXyj7Xk4bPQrwa
 Uo3x1uZlFeJV9HPh07YE7o1az9S2HNsRrtkuucxTGrpNeZewHJNRC0p_SbvMWGbRQPxKw9pYNwrc
 ixmkHx_zRgcG0t5waaRXDDaCw7Lp9OoxDwgspCCqlSFC83Kgh5zjA7_ztz7iA7ZrII.NyMr.lJF2
 zZuOIrot20mV5iyfkcp6uEXSl26F3nJXF4FQbhx0nG4hwy1Npu9yqjA44mxhWDuNHN6ly8oH1GUa
 WOagRNv9w5uUUnt30SIP4ng7kunLxbsX52PwkEIyG2fGIhW5zBuJlhiJXLupNuLK0CKCXGKBNYJA
 _ZfLgSujMXNNIHKYQiMJ6wxTeMLVi3lwH7BYBiLzR23llo7E2n6ctY94rU3hcOUojD204stoZYT0
 Zc1yXKrOsyahF7T_PnROcKc12tiBPmKZlbw5syLwVZPz.1_bLcEY_Zy1cwLsGxpzLnhuR59bygnV
 7wV4cq.BMCKFNqVvpP7qGnUdRzCyewxbNi1mdv1sSDR0Ihhw4X96gKh38jVWZJuV4FGes6eT2D6B
 XNkc_eEvJe93gnsUp8U99Q0JTstsQCUOYX9z6bGdHg8CfOjsw0V_yN14AhcF3aDH9ZHGkQ.MQuck
 5xEfXJFhFssjoG6wF7YZmdi2Bt8bzULD12sAZHj9Bi3M1iK.IQk.hDu.sz_9_QB13l11yUQ1GVar
 igRgRRrJ01HJfRCjxbuRgh8SrEljMNK_idS8HxCiFQQjDgVfnBVxpqoFRuhooik2r2FMeZ6RCNc1
 XinW0NzZ8xOY8N_rm5dgU4Aiz9oVYRBEmQPrC3CeBR5u75G_uM_Dr84wH8HAixls1FDn.PTWFlpi
 ZgKf15Rj2.YlpJ5puGPcR7LKI8aGRCSIiXllE0B1oi8dgvLp6857OGuBUl2fVEAII8VRrvcw2po3
 oZ8.Myv1yRtG9mXOA8IVPpuTBPhyfA7Rd1s5ouZnsPKEmQB_ZooS440o.0F3LDn1SPX0y8xhHfC.
 khse9rav1yQCCwfssFbVdK4E_QVzWFEqOu5WXBcHyUTpu4hSyHq90uw0CUMk4OYSSdWh6GxhhMeR
 IgCZ1dDnvxvGkczBVnYs8SPcKlK4yim5Vm8iJ4oIKEs3YDMQCzB0CPy0xljfQbcPuEykgA6smTTD
 RbzfsX0OY4oP2BHILV7CpxE8pJ2A8t2PSC2ALcit3GzRFi2suYMJn6W6P7VpOvpnkZyH3_nt75TF
 XNzoFVh4KL71L75DhzTeo0vluRO_AcUSJfC5470Y8QMLd.K9YHT98YSeRXXRP3X1q3iWdBw3fYZb
 nlneYrb6gzMwPu2bmInsdLoUYXUpv_Mop0kWYAVTThpxOIELw_YYTMar98cuh_0BWUs.z4In0Bkl
 ooBOYPNPAeibxDY9xfR.4V9XZefVd5Y8nN__lEPFWwCkX9N_2gBlyXewsNSjyNzXv6s910b9s6kH
 x9KrofrvlsY6C6Q.5GR9wPgw2IpLU8m.ffEZ.8oS9FdUCoUIH.DgDIST4O6.N_l2AGTrXOLK8B2_
 mTBD8rNigneDKHSU9l3_akCTBxxHP0tjl_YkWAcPXBLQHy00ktqfMBuGHfeup0zFicI_JgrpFNr7
 6NkNV00bklPOAXnbtJILW5wdF4pbKYAjI213iNygMEd3hLW88UwSwDKoPSLHbHl7odyXy8Lh0Ud6
 jjlZk6lKnOZV2B6Tc2IbYWxv_mH9eiLWCRspQX6ETSe_bbgVrDqQw5tN7eeoyUsulPAyDjkWPP4a
 g98QHhwYv.1wPj60SRMEmFqj18yf.Y3Y.q5qZ2vAtQf9H0bjJvlG.pKajH.1oumPESLqsIunQRTP
 GB1NEE9_rHiCId.5bJrDC7y16C1y78azPDlNY4x8tK8DZygl6KvFnbD.CiDZ8jU2uljfL_.ZSPos
 3s3TbXbN1IE2DfYgggYeExC06zZLhCqdOXs5Eded13JU3MUSnMqht6Fe1c_4rfF1FAcCNt4rAuCL
 7NNZrL0ZJ1sbVYkGRXNbnB2WoURko19cTz0KiDKf52w_Anw1wym03h5590vHv5_iwvk7XLRjjcKA
 bK_boMKAJFNH8ww0Qtmv4KMKxzEn5LTMy8d9g.wmm5g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 063a13ac-3647-47c8-adff-6f53c7c50ffd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:35:49 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 502c2859a32e83ed73c2b19ff921ebf0;
          Wed, 09 Oct 2024 17:35:44 +0000 (UTC)
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
Subject: [PATCH v4 09/13] Audit: use an lsm_prop in audit_names
Date: Wed,  9 Oct 2024 10:32:17 -0700
Message-ID: <20241009173222.12219-10-casey@schaufler-ca.com>
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
index 372302f0528b..53fbd2e5d934 100644
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

