Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD684409
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978450; cv=none; b=P6JwSIDjx45ZYzJW1WzZ44YEbp/v9YTZDOFtjZqo/lGi7umon/emtOBfq5sRuHz16eGXTCWUng/ycPuRTcK4ttbQuK3ro287NwQWpu8Cozc91/HQoGiDw9vdTEaJCFT5hkSC4UjlFErnV+U6XH+s2r3iIVPvkwnJun2l8JTdGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978450; c=relaxed/simple;
	bh=4/KZFWecS5zb5lJZnHM/E62AqJJUQdgTitz88DVye2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkalaCzqhFBacoDvjmcc/91ns8BCaDT+CLJd32dx2E3K9r3SNYUkMv9uOPbeEhEcZIj05nF92PNA3aAvMlwyIkSgWSKUzmImgwEw2Tx9b9g+J71X9u8OcciOR54Py6El3CAolhICKKv+eUCivBYDWsMCw2CRqEVS1U5BQuJ6kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Gr4ZDVGz; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gr4ZDVGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978447; bh=TxWTsCJSCiKurwEk4rkgIxrG9GNsiF7/jFX3EOhTndo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Gr4ZDVGzNxvNsHLfMibxHLYnI/nbwP9DSXaajaHCuOGqkCGH3LVloUtEO50RYjUUAbqg8fEMSVMekSsPF2582N7JptVYhUZ5Xb3yxb4P13ITJd/1xFV1yoJXz5ZYIY8lKjTE3zypr9eWp5EOXOPsha6kCfXBss0mogcjqVLrxGfLe/aS7xmbEP3JTRuEcaCxEGQ90l0BBXC3W3gIC5n672PS7LHriSfyesrIeM+zPSzYg1Xz2YIEsw0f5Vu00KQV6pWYEB0u1XVF/FRdjRXMSH3N1ZyBp87WzbWptv1CkDMrNQjqyV9+aSsKmCocgfBmaCcivV60bzbky1Q3XcIVnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978447; bh=NReIMNrfK2TB8oDJumvVk2r4FNqk5DUHbaErczf/XOw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xw3X+l8oN5ZnpNVshb1RXlKpy4kozXcp8eoXok0Sdn61ZUDb7kZ/fKiIfo7fvlxE+lzNyw/b8hJ6mwVMgaIqVbiOnNqaBzjAzxiT9nT+/A5oUow1X36L3XdQmZP77AzpNCHrd9L2jXBmia7JRjPENCEilaOpDRmDIc3lOLIGJQ7PNK0AfGGNOO7C40nCrXAKpvKUh6j1MR+GpF1WEJrVeWtLjWPJow2r8YNL22DOpviLum1/BRX4WfNlKK7TnrV6v7H7s5xsYt/apv6CVfakyzRNy1ET/iSMes2V+Wotqx9dHZDLeAn4kEWax/Kca5JdVtqg4UI4a2HTNMCJXeXlkA==
X-YMail-OSG: Eb96Yd4VM1mJVQTfmoWWfgMg11s.1i2FPP3NSlUyU2f05VLewVu6GtlnuSninTU
 r1vk9.XaZKSEJpO.2AkHh7IdFwu0ErkwHZZFv_sXpiwiMGq16HOofula7QDgr24LbXLijqkbof50
 yDgoWKNQPWGTU.EhU.gyckMqiSxMTjJYtB3ANoBx_qjQV858wGf76ex.YjzV59SkuFpUcVUT6siT
 K9QtDkcUZOURBvxM9kSiaf70VpGncryJwsXTZSmUyltw93_.T54_9rwc8_tPBOmOZyoQQvPY4gSI
 UrqKqNH.vQRxacXRpX64leSdkNCzwUTOyNaphLIPZMi9shHXLrn0iEVRGrVqv5ADZjbgb0_QvdkG
 hXXt3Ewp4B8z4NqZlkrnpxaywEHcARSDj5MXyF22fqTKcppoJquTS6cwADaEyZVEzLWG3UmIPmKr
 AODumtjleSOG3epQFnoW1QYOr71jfFre9L3n9t5glyLTkQIBeevfn5zwaSPyqB.Zxt9fCMeEm1dO
 iV7ZxjORRpdlBh_10rWQCebQi2ISu7rP3kX750HyVO3CkAd628wMZJdmDUSXr0vVF8Myw4T8RmUh
 qwj.GEK.02W.k2vX4Kk2j0R7ZAV9LXvVl8hprRu1KOgY0GBguCKbiJxgrjolai3S0quNzsA5BDsA
 tgwi9UUlqKZhhfguReW3TaBFZ1LnouD9A1qJ_A1tYwildrbcEJJLWXNsDa8jjT8HY5wOd.UvNjvg
 ax.2B6HNRkCcObPBF0Dqe5bdFnBBS_.0jOwU7WVCLVG9hOnif_5fbIxpqn4vB9ByrqHOnYn4237M
 2iKGZiJ8kM7MKDZ795.24O.zTwM4ZplMZh.EjVyKytFIsCSxjQx8p21a2nTAmaB.qcgZdEVkp2LZ
 7KN5UWMa3Dlkbv9g6Eg23x3bgSfIz5l8t9pVLH0jxEpXd0Kv7xa00cpb2ruZElzMUQWnWrcE.def
 gDo6QgW6dh3qXyZvetClyzPQoGhCtqR0MRtifWjyfxvR4qiirwupMFndbqcFS8ncS0QXzGoffM7s
 QN5..NItAXGO9ZBiEQTyl5OCEWWjdveLNMvIzo0guL35X41ymm1XX0dK5Hf1xGlwS1eHwV4y02vi
 kbsFdD0FuDK4z11tXsgqXqa6vOkcdMOoR_aRl2XSthH0ryUbttRkhdzOeE0MbyxzAPZ69yi1igr1
 2yaYRCslog.hDEE5hcL5iHuv0T1sbCRgxIani6nATwAzbEVDka2zfQowLH38Qv7ZY4oV7I94WTJ4
 QxLf1SrfygX5KSu5eKtJ4s2CyaWGy8lziJ9.DVwOM932_VNFzq7YyMnWJ00UsXc.973XoSAhdqkL
 1Usy8vmqgv8Aylz0q5FkAzczgbfD8yMd1gi5oct0PyUYv32cRYVVF9SuAoBkjvg_asL6hsC3BNuQ
 4F_AnORhqrtmtQvFbiXoMqEf_YaU3x3Ic87o4amyDbZkO9r5Q_DdSBp_8Z0Kx8LXgYxeGWv8xv_u
 udV0PpmKzfqpxl2.6Bpf0LX59FKIyNBLA76hfpqlnxzEDSW.PRemv49ArhFjToem7KAzviKwLx2f
 C2dpERQUPElbQDjtE5z1iTler7b.YHyhZbxavQmcuLQ8T7N0RoGpUgIzXplLmwuHyfxig0kLRQPb
 YSL_iwKqBMeaVWHc6n7P23tVV_MWm9fyrS157kQQvO25bw2rXx81SPN2KiFHnOoIOkB5cmQzGb_L
 JME1a7vcmwgsJ7JJfI49G6Ys32SOy6JpePbhmOXAo2o8ySdI3CeMxFibCJxky8iuDUqixKKM5CLY
 7EWM9dnvgrrFdFTI71lG58vQl9K3Lz8xov4x7F0Q6BnJe8FiP0PNHrw447vhVA40T01nnJudvXWv
 ozi0LP_FHc22KWyKpYZoKf3QW7QRMYHeVwLibMzVtt_.KOCet4cfA4c9D_iJcDUbp3Fle5YDOADr
 36XzevmXZBI0T086Yc5BIuWjfDOTdAG2BU885a4nTyztg0NPN8wtPhxg8O6kl9phEeP1B6z9qesR
 6Hu.KHC6MTi4TgCYRf147FOfAuvMwHn0c8neFs2qEMZ.eMkwoXqveTfmTkpN5QhCZV2sWUOIOCzn
 NotZYos7J3kCxR.DYnEBqQmV26lZCPgD1ij1uXz5P.AeeUpc3ezo4Eq1eAr11_L6I7PK_b1bwg3Y
 4jMsjA5gYw9hVvfLYgUza31sHHaqtq4pN6YMd8cD6YqF0xqiHqRsfojdeObnZq65DTKPPnS3o6pR
 Eq2LhcQSGsJEfgGNVFf_eF.iztYMF_c8nmWq3INSHc8WWEUmOWmq_2tXmku7EujXPQBU9PsmRglz
 s87cZ1IvvZWFaQc7pmgsa_B19sLAtFke3keiiMeUenyON0g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 569b8181-139a-4e63-a74e-34808d97d88c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:40:47 +0000
Received: by hermes--production-gq1-5d95dc458-dxlpk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cc2d6a8057ac7b246e10bf9aa95792e4;
          Fri, 30 Aug 2024 00:40:42 +0000 (UTC)
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
Subject: [PATCH v2 13/13] LSM: Remove lsmblob scaffolding
Date: Thu, 29 Aug 2024 17:34:11 -0700
Message-ID: <20240830003411.16818-14-casey@schaufler-ca.com>
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

Remove the scaffold member from the lsmblob. Remove the
remaining places it is being set.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h       |  6 ------
 security/apparmor/audit.c      |  6 +-----
 security/apparmor/lsm.c        |  4 ----
 security/apparmor/secid.c      |  6 +-----
 security/selinux/hooks.c       | 18 +-----------------
 security/selinux/ss/services.c |  4 ----
 security/smack/smack_lsm.c     | 33 ++++-----------------------------
 7 files changed, 7 insertions(+), 70 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 111c1fc18f25..ca4f3b41f344 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -144,11 +144,6 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
-/* scaffolding */
-struct lsmblob_scaffold {
-	u32 secid;
-};
-
 /*
  * Data exported by the security modules
  */
@@ -157,7 +152,6 @@ struct lsmblob {
 	struct lsmblob_smack smack;
 	struct lsmblob_apparmor apparmor;
 	struct lsmblob_bpf bpf;
-	struct lsmblob_scaffold scaffold;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 758b75a9c1c5..120154a6d683 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -270,11 +270,7 @@ int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule)
 	struct aa_label *label;
 	int found = 0;
 
-	/* scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 877c4e809ae8..08fde302c9fe 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -987,8 +987,6 @@ static void apparmor_current_getlsmblob_subj(struct lsmblob *blob)
 	struct aa_label *label = __begin_current_label_crit_section();
 
 	blob->apparmor.label = label;
-	/* scaffolding */
-	blob->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
@@ -998,8 +996,6 @@ static void apparmor_task_getlsmblob_obj(struct task_struct *p,
 	struct aa_label *label = aa_get_task_label(p);
 
 	blob->apparmor.label = label;
-	/* scaffolding */
-	blob->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 7ba48d0b3ee8..301a98d7cc6f 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -102,11 +102,7 @@ int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 {
 	struct aa_label *label;
 
-	/* scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	return apparmor_label_to_secctx(label, secdata, seclen);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 076511c446bd..a81529c21517 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3510,8 +3510,6 @@ static void selinux_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	blob->selinux.secid = isec->sid;
-	/* scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -4032,8 +4030,6 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 static void selinux_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
 {
 	blob->selinux.secid = cred_sid(c);
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 /*
@@ -4174,16 +4170,12 @@ static int selinux_task_getsid(struct task_struct *p)
 static void selinux_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	blob->selinux.secid = current_sid();
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static void selinux_task_getlsmblob_obj(struct task_struct *p,
 					struct lsmblob *blob)
 {
 	blob->selinux.secid = task_sid_obj(p);
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -6348,8 +6340,6 @@ static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	blob->selinux.secid = isec->sid;
-	/* scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -6634,13 +6624,7 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 				     u32 *seclen)
 {
-	u32 secid = blob->selinux.secid;
-
-	/* scaffolding */
-	if (!secid)
-		secid = blob->scaffold.secid;
-
-	return security_sid_to_context(secid, secdata, seclen);
+	return security_sid_to_context(blob->selinux.secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 43eb1d46942c..002072912800 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3660,10 +3660,6 @@ int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		goto out;
 	}
 
-	/* scaffolding */
-	if (!blob->selinux.secid && blob->scaffold.secid)
-		blob->selinux.secid = blob->scaffold.secid;
-
 	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a2445e4f906d..f462051e683f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1655,11 +1655,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_inode(inode);
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_inode(inode);
 }
 
 /*
@@ -2162,8 +2158,6 @@ static void smack_cred_getlsmblob(const struct cred *cred,
 {
 	rcu_read_lock();
 	blob->smack.skp = smk_of_task(smack_cred(cred));
-	/* scaffolding */
-	blob->scaffold.secid = blob->smack.skp->smk_secid;
 	rcu_read_unlock();
 }
 
@@ -2265,11 +2259,7 @@ static int smack_task_getsid(struct task_struct *p)
  */
 static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_current();
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_current();
 }
 
 /**
@@ -2282,11 +2272,7 @@ static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 static void smack_task_getlsmblob_obj(struct task_struct *p,
 				      struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_task_struct_obj(p);
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_task_struct_obj(p);
 }
 
 /**
@@ -3474,11 +3460,8 @@ static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
 				 struct lsmblob *blob)
 {
 	struct smack_known **iskpp = smack_ipc(ipp);
-	struct smack_known *iskp = *iskpp;
 
-	blob->smack.skp = iskp;
-	/* scaffolding */
-	blob->scaffold.secid = iskp->smk_secid;
+	blob->smack.skp = *iskpp;
 }
 
 /**
@@ -4825,10 +4808,6 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	/* scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	/*
 	 * No need to do string comparisons. If a match occurs,
 	 * both pointers will point to the same smack_known
@@ -4889,10 +4868,6 @@ static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 {
 	struct smack_known *skp = blob->smack.skp;
 
-	/* scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	if (secdata)
 		*secdata = skp->smk_known;
 	*seclen = strlen(skp->smk_known);
-- 
2.46.0

