Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7123BCFA
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372642; cv=none; b=fZ6TF4vRQ/I3Si4xONRgieSJRTfzsJzmQ7/bWTTOMI5gJqKd/e7tKIkmWy3I1KB1PPsTllrDXVc5SUcS/vjuPSyShIzVvFmyiDthQRWLbWN4LO9dQse/+qmqfXQVwSZ4qlMJzSzTt+8YyTHhQuL2KrjA73pV1DKcfgdB4vhPCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372642; c=relaxed/simple;
	bh=l3hAOTdFWFPeDsiTh+QFM06dt1Vg/1ETKhCKYfaIKuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLRrAP4pMziiC+Ba2n3AYcZWccxE32IJ71LU5bOudKU5/R+jcuR+EP1tIA54igzhLFrCzwexfjuSCPIz6+TqEpkAhSTbaOuKbcwtKccixmqmdX7lyL9WMIzopdrNz8kiS05URMMGt7JlFDkpUpjRucFiVmfxh/jwSpdjepvN2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=W3EShh5M; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W3EShh5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372639; bh=spbXtOSsR1EeX44UoKopWfeHY1ZWMyOJ+GR3xZECzhk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=W3EShh5MzAW/doeNftNgCmvqIO4YEXd7h1mgaOp1WITVMLuB/J5urbLMNZas0ouB3Q9XwZIcbPV3hnTcrlgFHLVc6vB6/04WIsFnYUeYErUxRuTAtM8B7hRK+cF0DN7aZReo4XEKYILrdOZiGUF7XdjQbuoA4Vl03AzEl6ANe/iFG6FIPdjn1XZjr0O8C1Eo9PQ6z+1CMGOxQERTEVzsWva/pWakpVEyHwbzXiA3ffcuP5yJaYnpX6LqUbh43fFYmPHj3wAQVA9RSd3MDK1b70IYXVeqfHjGoJ0vQ67xTSDwGNudgLta4TLttWDNMyDHV1aWlVfQ09LhcvqCiNwaOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372639; bh=aetwbMJAKZFLiS66plhssUfMuMSVmbgplcN4qlapxtC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VyWMKZ9h2R1kfsTxf4XZYdS0TuXTLEcdTgFdHJtCCXSCuzHcfPR03Y5NsXPUJLuq6tpDajmyDzHibJGTI1rMSsRMR5VHJT9AsB1kgpDX1btOG5qYboEEDmwQkklOGATGVE1QPl3Vb744VTBru9MR3vXElEPcO1Z5TnXw2G42kePx1hclcLsoInLdJXEqVM0vQxo8+skhNbxBKfeL2UR7IJLhxQG8eRz/KXZ+2e8OsywX9SbG4vkGUkXVsJ/9emXzNMfRRwpWpH5OyPVoi/I2XStXne4TNLoh7mRF4g33j/Kp4TnID4n4MT/rt/VP0rDFGvVIuThDX5/3Ao8PrsHlgg==
X-YMail-OSG: YJW.heQVM1m6o24YdCnY697RgoGJRIecO0HpQ8baO5F7fK_eY2IXYg4Oz.ZzEtv
 B9OEQTLn2zmfifDuKKPmJ9itYIg_YNEmJ.49HCU0j6jqTW6ZftThIVsjESqFWaw890hoAYCMPqm1
 8fj50Bf82keFOKU0qM2lSQRhPWMwWegAURiuYj65yVOETcV_5wX7.KarvtypW091RSO_aSyKOr8Q
 k4p4dPJceyuW2g4zotMMCGxd.vt9n5Um0wGhs47LV3RsQOY5440lO8olln0Z5l2WUWtEPqbLw5Li
 k_NdVwfkymfKQ14gAnEBLhTpHQ0vwvcnd2nd68f5qANuxyMwKam9ZBNpC7u.t5zmn8_1QAsX.tuK
 IxvpseP10HXmdU6Px5BaGlEW_E6Xpbw.2VSwrC61wCqcWCLFA_Aj0nRWHIj.maaMUD5xrZumUSl5
 UmYVgUaiTTwfWsk4a4vI.7XMwWfUqpLs5ZXFoIxoAlp_KGwnlVftD4JmyKZcdW5K0YQ1k7CwtUOz
 DE78FhIYY8t6GFLJVHv99OguVIWOZwPH8j9WT80gb8UZT.js5KMYYMLNnpMIGM5ab4YIBETMhanQ
 3I8XvmqcwBzyYNRg3jY6t_v8i5SaZfnUtbpUFmMBpSb7D3wtjP9ZQt1IvagbmOm0IMPpNfW2dvBq
 QqS_kwbxLNrtgFsa5ps.TmSeUDIEUsDidxUGKME4UullFANaoCM90Tat0e1x0YWhwMsqOx53uFz7
 9nHGyVX9OEsb.DgQJHLtQp_sBxZhWKAzsz2c42b_wgCDb_p4SIvSI2pPGSTfKdmQAx6.1o7XJtyS
 4U4hMClJcDzEAYqGv3MYLBpneEDAV7A3iq26dzlSteeRiMgeaFQkK506WxXQwOMJ20xf1KSVnfUi
 TXgnQE21KagUIyeesGMZK6fTugupdMcp471sHDnv9K8OfSpRrcYN5xZsnrOFsvd2Uov8SouY5GUU
 4krPOqPFQEVZXzSTWezRZaimWHf.eTQLhWhxyoGWG7wdTQMXzyRDKBp..R61zDlQzhIvZVKl.LCq
 6dNFfZ8aB5pnxQBCQxT.r7OSw5ze6RilFeOAJC4OLSYxnZSF7c64WW8GZWbjECWVQqRHatYiukvs
 Z9ouj9klphMwTIirWBdcHeuIR_SkZiu5ZMzGlCARC_6rEhHg6aaFv.s4vlxra_Pap0qiGBdneyYM
 AzMpDRvG4.bwODWdwTNGVMBcp0AS.BqBp_K09Hdwgi7gVfXwaWYWZiSiuoxvYfnxsmyLLUfKgs8R
 hQHbt1Pnw.VxRRGaJvG4R82sn7JqNl.9VdtdjZ8c34Efx6JgzSuIJUmFnSvBEWqLBrm_6ntyqGq2
 bfsVQV7mV89Um5P3wIETceQskIbAPDUbqUadTmRYjoaBhLsDMPb0SWrCnPE7oeas3MFuLAkur9N9
 4Sd6sunG9zXUVE1qxl3O1JBR52K0.nSSFwYRfke3MhgYCoUIa0eJqyPVXM9W3J8zhhbMXXI3aAQT
 bnkgO3gH0tFYnTiZFcyCwIifSpkkpInx.O5o1GBcUgYopc244RkGDtM7dnBDEQx_MgT2TMx74jZG
 3cyMxHhEnTHxE3yXyvwjta3XFuuXCYQRtv8hqdyJEeg7M4x4.SDRLsqpN4X0j51nmtjOnRn3ekMK
 wjcFgJYVBFmdS6UqZF46LzEDUHFQWZloHqdVSeqnoM1wNPHWJAkcr9ppaf0FHKEKGXNb0hMmH4nC
 0mEQIjzC.yA9yDsWUM78fWucrZKiJeyig2r5IJAngtd_88X5JlEYjowIvHWKbDe7mrhLz9XR.Uzt
 yfP7CVPVEHqv2p54QuHdvUOkwwwldlYjp9wADq_zfvK_2N1KXYMQgr2vxemBVjthQx9jAvPec9C1
 dh_Ylf25KTf7z5QaD6YE8pmpZq2uudFAItpeG3jTmaxQpSP0BGlLm93dAW_sxfNBszheR4cLRWLY
 h98em80pSGrRCfepnYsgbmJd91IVp2Jb0RRQYU6bnZj5GsM1QfXE4DtmmlA3Lu8tD6QlKV32T2BQ
 EdhBtvXJhuocyUz3zHUfPEMm4A2wEUd.lfou2IANp80EHuJO1YfWn9eY77PAx_FCtlG4tYA5l2oh
 E4RTkncwHa26KIXZ6_UkAOp2dE4zgbUmgbxfy4wS_AMW7GssTrIgUrVKyTEMB1OjdZ1ysAHKlCP4
 Blv3QsWDWrF2h5O8cqmCfAolJOnFPUSBrE4wJt1ABXyCj7ZnN73sbNJo7JgVqcmVbUWEaOp4dSQv
 OYerAUmqiWiysWWMGXMaDXBAcdzTWbd4y.r6jusygC1amJJPwAWduoMnsh5gFMOleztAX6l.atoG
 1pxiBnXGv3R7IkpaOMrNLVlKD4LlQ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5c7460b6-392f-4b0a-82a5-a083544e999c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:37:19 +0000
Received: by hermes--production-gq1-7d5f4447dd-9qjv2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e6d6a2ea591e1dd2da3497c747300b1;
          Fri, 07 Mar 2025 18:37:15 +0000 (UTC)
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
Subject: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
Date: Fri,  7 Mar 2025 10:36:58 -0800
Message-ID: <20250307183701.16970-4-casey@schaufler-ca.com>
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
index 980b6c207cad..540894695c4b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -566,7 +566,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1543,7 +1544,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
 }
 
 static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
-					     struct lsm_context *cp)
+					     struct lsm_context *cp,
+					     int lsmid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index a4945f1c3ec0..293364bba961 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1475,7 +1475,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case AUDIT_SIGNAL_INFO:
 		if (lsmprop_is_set(&audit_sig_lsm)) {
 			err = security_lsmprop_to_secctx(&audit_sig_lsm,
-							 &lsmctx);
+							 &lsmctx, LSM_ID_UNDEF);
 			if (err < 0)
 				return err;
 		}
@@ -2247,7 +2247,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx);
+	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
 	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2ec3a0d85447..d98ce7097a2d 100644
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
index 143561ebc3e8..55f9c7ad3f89 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert secid to security context.  If @cp is NULL the length of the
  * result will be returned, but no data will be returned.  This
@@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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
+		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
+			continue;
+		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+	}
+	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmprop_to_secctx);
 
-- 
2.47.0

