Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7E1E04AA
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495451; cv=none; b=We4rTszyrgnbi147L2yyou7TV+fxJi4IyRVtIY46Xqnvuzvp/vbCUc9sMJJiGu5OaLom4wzIklshLJaP7lN2XJ4qrcqYPmXSzmGAZ5K8XDtKCfNLVKxWwiQELqu5rIL5yy7O3EcwbNuwa+fgxjlW56hxmqfwlJtjikfdsvuYYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495451; c=relaxed/simple;
	bh=lMOK5KOAfNPQW7erRNtalTcnH2NWLJtaSuwOlE9FteU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvC0jmHWBJ+JdFWhXN5DKXFvzhlFI6Me9WtGjrzQxxoxKj6e8ZK1mzqI2sM3t2Ix/j51olIkT5U4bcjYXAV4h5b31QwqvnirRbpjhydAxKJEznoOKjt5nUEWeo7pj4J88TSWfML3MFQUHW0bxtWxGMSHdWVLg6vKQQIigEsJxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fP/MgI1W; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fP/MgI1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495449; bh=/+bNDlC2zxAcxrtS4Ze9mN8zJjtzFTDuPxQWb8z8RAQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fP/MgI1W12YKPt8UFStIaZvs4e9miNgqOhe/EIv6yhH/5vnH8ZerOHaC0DcxaHBeu8mE1oiw2NCREBQxb+xB8+KAKhYk4VkMmY4Zv4RGKI065JubYyG+ORlFRWRGM599kbPwb1NvUqXeWIl8aUVJw+NUPycR/yYVJyX6hxwGLHzNH2ZQKZCj+XcYX1KpqnZ29v5m6jvbDr8cOPnhsEYJvTcFNSf1dyIPrFO/oLNBKGmwTOYknC5mJdcLdN8FQGLDRNOF908GMumeWMyvxat/nq/8ui3VwXOk26IwiySv2nGzc6L2pijrP29ZxJhbzn6Iu56Y+QhQypeExMWdPYWJog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495449; bh=Htht49EkIR+K4FdG1KIb+t90frJj+QK2sAYlxjlIWas=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DqSfXNftVM6NevcXZyGE/v3Ta8I1ek5kIgQeVA/Ud4Im1R4LBlJvllaughNY+sPTGodcdAKFUnUSFYvwE3ySxE8We+iw8lxmomcY1b23tDLGh2PD6MOMsiIqtX9c6A5VLlcXVk6n2l4t+VXjkXl/lcl8IE1FwjymaVWMp1+EpHljJGNykud7TvGFKE6MGwigku91gqaqJTfsFIuSMokpAqciQPYT4AKplkNmsweXNR3rLg209Cbo4USFK8y5bVKT15pJ8pfgEM3IV6cgzjmNd77rRUa1pfOnVQs50BXXQWcIivcOGg2UkTcQr8aJ+e/lqmtCcdpyhOhNcO+l/eDMyQ==
X-YMail-OSG: kKdKUrIVM1leXplsEw6EHmV3WwclcGjlit6cTNFx3O4LPMbf2fZ.ayR10QdLHvD
 pcQmTu7epI5Q6RpTaqHhmghmbwO0UyL8LeDZCz1oCEItTLgsANHG.0HeMUkGW0Ygcbqw.n5VsexE
 ORKWII0b.2pIM5J4_u6rN3PdzP54aFv8ctV92CCr75eC9qIQw1Fa2kD0a1aU_orhnBUtvG7RA0rg
 NA2_rG8r3aKtzB3a9JPqe_wPhYloqKYOYSTzQ0kpuwxxXB1KBUZtW3BYbW6UQN9TxSpwsrfFVEih
 V5nfvMmFwzrO7DlZm4nUDHtMNKPqgHJ1Bl2svEJOsoyFlVYKQ1PJia4Y3i9GYOWNqDr8mR4CYqQz
 z_mQ2RYIoaDrHM9m8DldF3sUwT1c69t8mI3P3wwYGBzlsKBH8elmgWVTLhRaWWBHOfzwt3ER66Wx
 mjGH3s91.x9OJpnWaRvDL94MTFeupr57uDK2ltmNAjQQbGEi6y.OWSKhquEk5zk_iPMK89XOzb8z
 4i7Vr9Pxm4.FuXcLxGU81Uvw4JUurC.UKzBsLn_KfsuKT92VQlB_lVDqX9pTSCYLt6M6VBLXy2AG
 Hze8hWBDLcpz8IZMbx1X6Gx_N_ogfKX57BqLtw833l_z6puzIoT1KHw.OLRsKjuYzxIK7rz7D7_k
 KsYnxEnXsk5JjZmx9DAdMcMkVyJiWxc7SsXDymA80PTB2iya_a_A7PqHfXoUQ3IaWHUlO_Bb0pX0
 yxF47rnXlkH2p6qZ.JzbKoivHEY6WxY2qn7YKTr5.hk5AtrxGugY7PXPoJqYMB8hcHZdBnnaCyxa
 eqhh7OkES.kONrd9zhB7nYe8RuQOM4GXg0s3o6D8frMcfrbkBs8ITnCp929aUG1AkRXKRepmr9Ar
 blyuKMAzloOj_a5VGG_EFeaTQHXdj4Q_._fJ92m9YhSq20EXZnm2jbIkzNarO3ePUZW9Obzh7BI3
 lr0F1W9_j7mzRpXcb24GiSWJL0CyjIE23kZr4ZLJenQnF9ljjGEO1Xr9bNiB4dao0KA44UP8KAoL
 QCyIhKlstNcFkBX0WFaeLtD9o9TYLIouh0Ic1bZlNe8D1DX2rNN_luicIqYtvskI3rgb55HXxMig
 R6C970ye7qcB2cUVGUhnO6ibHl0iKLVyTN1.jnmvx67Ek19vPju7QaDsvZ.DC.UXMe5A6K9VvUb1
 E.C3fU23.YTYz4Xd_Zn99zNhJ865rfbqifY_n9YbNazA6HfCnfmWe5m.CvVzfZCHs4mq708I.zcK
 u.H6V5Oek0EK24U7yVgqdPiamGQFr983.lzj5h.oZJV7Qj8HIYerQi.GRoBXYyyxsCHSnoYMZ1hP
 tmzHerkFUHqnDJG8K07XOr9yJ8D_.iayDd0VTttph7vYhwmIktnQnXaUadihNQqo_7.RedO9nNbL
 crc88XBTNtrt7Zi7w_8JJl8j9OQYOtkZqYMeCTc9dl7QPmP1LCjMYkMQLj05pVYqyCuJZ91XQA8N
 Sy_7e.OSVN1TBh.v17svuwj2BO9d2uvCJsevXzo4_5StmZ6jMhfryaSbmvGW5nH9.p8GVwKXQ3is
 1WmG32j7s7HumS5HIlFPj88srWUvcgxXjJpWOsoaHNfKkip99Knt9LC5.EW9S2i04lwdri.QLo.L
 y8Wwx5uzRU4z3SG4HqgW.Y0ieoRNng97MZCL1jfNaOYornlu4hU4fpng7tX8gkFs4SYZmk6Tlstn
 RKCG22Tta8En2xkD8oH.rGMNyGxupsysy05BYv5y72iFrzjLq.pSvvONcdCrYM3snheWKKJ3Ag.h
 osFM7zOMQYZ0LWHvqakBFSTS0rh5Y6wFBCxKOwOXibsuO1x9X41G6AXOfgy8qUbknEFmLJr3yYPP
 1D2.L2HbDNRk_.swXhB08uVXR0pioQ4RwxPjXsRqLcVDOt_QQWiwguG63nL1HJWIaRtGmUJFelUV
 Yru4fU0hUM_mLiPGcimK8BcqdBP1iTSGPy29kLrzr7TyIG.LEQMkf6vTWEupMRLnn0z4qi.CLWK8
 DaGOTmw82Ig1WDXoms_1Fc54vkCwXNdkC7LnhOBhUc4CvfRqx2DCMwlNQZqxsXik9bhp62F.Y.6T
 gudGd7z41UvqkB2.IEq5d_A1HHxNI3Gu45IayXsPxWYC7wBH3bPoIp1tfjTZMjLaztZ9e0cuRGpC
 htHU6CYrPEuweHErkMP0ehAk2A8sztzz7xFWGhYzX0C37mu0UzEZkz0iX5k0ci7uwm7SfQ_ddzjb
 zjzVNTOw3CMRHRiQMSlxS6dozK28wC1l2hlsyysKVBqEVvgsxQkviRWj9QE9zZwMKNiieHOO49LO
 XEHd_C03doJA_kchAGWc..Tn9tislatp04l4yL13GlfMmyCp2
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 507da6d7-95df-46cc-8d01-c2d2ff63acdf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:37:29 +0000
Received: by hermes--production-gq1-5d95dc458-xmcnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 934db59ff91b58b27af467a3ec48d37e;
          Wed, 09 Oct 2024 17:37:24 +0000 (UTC)
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
Subject: [PATCH v4 13/13] LSM: Remove lsm_prop scaffolding
Date: Wed,  9 Oct 2024 10:32:21 -0700
Message-ID: <20241009173222.12219-14-casey@schaufler-ca.com>
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

Remove the scaffold member from the lsm_prop. Remove the
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
index acd2e5d1b0ff..fd690fa73162 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -156,11 +156,6 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
-/* scaffolding */
-struct lsm_prop_scaffold {
-	u32 secid;
-};
-
 /*
  * Data exported by the security modules
  */
@@ -169,7 +164,6 @@ struct lsm_prop {
 	struct lsm_prop_smack smack;
 	struct lsm_prop_apparmor apparmor;
 	struct lsm_prop_bpf bpf;
-	struct lsm_prop_scaffold scaffold;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 87df6fa2a48d..73087d76f649 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -270,11 +270,7 @@ int aa_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 	struct aa_label *label;
 	int found = 0;
 
-	/* scaffolding */
-	if (!prop->apparmor.label && prop->scaffold.secid)
-		label = aa_secid_to_label(prop->scaffold.secid);
-	else
-		label = prop->apparmor.label;
+	label = prop->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6331bcb35ec0..1edc12862a7d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -987,8 +987,6 @@ static void apparmor_current_getlsmprop_subj(struct lsm_prop *prop)
 	struct aa_label *label = __begin_current_label_crit_section();
 
 	prop->apparmor.label = label;
-	/* scaffolding */
-	prop->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
@@ -998,8 +996,6 @@ static void apparmor_task_getlsmprop_obj(struct task_struct *p,
 	struct aa_label *label = aa_get_task_label(p);
 
 	prop->apparmor.label = label;
-	/* scaffolding */
-	prop->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 34610888559f..6350d107013a 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -102,11 +102,7 @@ int apparmor_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
 {
 	struct aa_label *label;
 
-	/* scaffolding */
-	if (!prop->apparmor.label && prop->scaffold.secid)
-		label = aa_secid_to_label(prop->scaffold.secid);
-	else
-		label = prop->apparmor.label;
+	label = prop->apparmor.label;
 
 	return apparmor_label_to_secctx(label, secdata, seclen);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 438dfa17faae..025b60c5b605 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3508,8 +3508,6 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	prop->selinux.secid = isec->sid;
-	/* scaffolding */
-	prop->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -4040,8 +4038,6 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
 {
 	prop->selinux.secid = cred_sid(c);
-	/* scaffolding */
-	prop->scaffold.secid = prop->selinux.secid;
 }
 
 /*
@@ -4182,16 +4178,12 @@ static int selinux_task_getsid(struct task_struct *p)
 static void selinux_current_getlsmprop_subj(struct lsm_prop *prop)
 {
 	prop->selinux.secid = current_sid();
-	/* scaffolding */
-	prop->scaffold.secid = prop->selinux.secid;
 }
 
 static void selinux_task_getlsmprop_obj(struct task_struct *p,
 					struct lsm_prop *prop)
 {
 	prop->selinux.secid = task_sid_obj(p);
-	/* scaffolding */
-	prop->scaffold.secid = prop->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -6339,8 +6331,6 @@ static void selinux_ipc_getlsmprop(struct kern_ipc_perm *ipcp,
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	prop->selinux.secid = isec->sid;
-	/* scaffolding */
-	prop->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -6625,13 +6615,7 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 static int selinux_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
 				     u32 *seclen)
 {
-	u32 secid = prop->selinux.secid;
-
-	/* scaffolding */
-	if (!secid)
-		secid = prop->scaffold.secid;
-
-	return selinux_secid_to_secctx(secid, secdata, seclen);
+	return selinux_secid_to_secctx(prop->selinux.secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e0c14773a7b7..07ba5b3643dd 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3661,10 +3661,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
 		goto out;
 	}
 
-	/* scaffolding */
-	if (!prop->selinux.secid && prop->scaffold.secid)
-		prop->selinux.secid = prop->scaffold.secid;
-
 	ctxt = sidtab_search(policy->sidtab, prop->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 52cc6a65d674..0c476282e279 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1655,11 +1655,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 {
-	struct smack_known *skp = smk_of_inode(inode);
-
-	prop->smack.skp = skp;
-	/* scaffolding */
-	prop->scaffold.secid = skp->smk_secid;
+	prop->smack.skp = smk_of_inode(inode);
 }
 
 /*
@@ -2162,8 +2158,6 @@ static void smack_cred_getlsmprop(const struct cred *cred,
 {
 	rcu_read_lock();
 	prop->smack.skp = smk_of_task(smack_cred(cred));
-	/* scaffolding */
-	prop->scaffold.secid = prop->smack.skp->smk_secid;
 	rcu_read_unlock();
 }
 
@@ -2265,11 +2259,7 @@ static int smack_task_getsid(struct task_struct *p)
  */
 static void smack_current_getlsmprop_subj(struct lsm_prop *prop)
 {
-	struct smack_known *skp = smk_of_current();
-
-	prop->smack.skp = skp;
-	/* scaffolding */
-	prop->scaffold.secid = skp->smk_secid;
+	prop->smack.skp = smk_of_current();
 }
 
 /**
@@ -2282,11 +2272,7 @@ static void smack_current_getlsmprop_subj(struct lsm_prop *prop)
 static void smack_task_getlsmprop_obj(struct task_struct *p,
 				      struct lsm_prop *prop)
 {
-	struct smack_known *skp = smk_of_task_struct_obj(p);
-
-	prop->smack.skp = skp;
-	/* scaffolding */
-	prop->scaffold.secid = skp->smk_secid;
+	prop->smack.skp = smk_of_task_struct_obj(p);
 }
 
 /**
@@ -3466,11 +3452,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 static void smack_ipc_getlsmprop(struct kern_ipc_perm *ipp, struct lsm_prop *prop)
 {
 	struct smack_known **iskpp = smack_ipc(ipp);
-	struct smack_known *iskp = *iskpp;
 
-	prop->smack.skp = iskp;
-	/* scaffolding */
-	prop->scaffold.secid = iskp->smk_secid;
+	prop->smack.skp = *iskpp;
 }
 
 /**
@@ -4805,10 +4788,6 @@ static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	/* scaffolding */
-	if (!skp && prop->scaffold.secid)
-		skp = smack_from_secid(prop->scaffold.secid);
-
 	/*
 	 * No need to do string comparisons. If a match occurs,
 	 * both pointers will point to the same smack_known
@@ -4869,10 +4848,6 @@ static int smack_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
 {
 	struct smack_known *skp = prop->smack.skp;
 
-	/* scaffolding */
-	if (!skp && prop->scaffold.secid)
-		skp = smack_from_secid(prop->scaffold.secid);
-
 	if (secdata)
 		*secdata = skp->smk_known;
 	*seclen = strlen(skp->smk_known);
-- 
2.46.0

