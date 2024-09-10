Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDC1A707C
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993994; cv=none; b=UDlAkPskPA6TGHYdGxAnmul3wcSqFEP0PZIsELbawsFdbCr/q14QagTmyvG4CBf9sgVgW5VRXDcCg+eRwpoGnQfsYyQzk1cl96gvJW31Jo8FsbW/1v+s29oS+HHDs4QGifuRUJkqOWaaz4syz3NWsQTqpQssniGzaukMM/TeUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993994; c=relaxed/simple;
	bh=2qqQ0z3D+2ZjCCq07OJJJlzqS2fA4B7I9fk5In9Guvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYqKTQz800mL92LCHfWoO+01PJcVCQb1HfbBgajkS5xdfYtM3aDBqO2Fz7EQ+bDqcAn1mpGcIP+/upObKLaHdR7BWDgSTEnLMloLioXJDt7Dd1qh/F8Kg6/OJLCm3rvt7/0ZRCxFqNPfeE+ixS1Kx0c35qgTWe3RTbGtCHy96JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HocppcJD; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HocppcJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993992; bh=3E0uhKbbsti/31w7Y2vn8vl2KCCg7vNL8Prj7v5QvvM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HocppcJDuUDoI5MTgXavveIxmLWxfQrbTf1mJrCIYKCtoooN7FP9KPSCRkjoN70wgL1nt7GpH4N6uIvgGRjo8Il3OmWpyWXxWqA5csC4ODldmSSSPdxTp9wH4cQ+x6zwx6dRujtNh4yNHuH8B4eJ8OUWK1nnaeYIysoq0YQBvMgDYtwiVs7sea9vHHxVRgFEGVHpKzZKcnf+ouysN7hye0gNJOT9K6ONrkcN33r9HHwn7vT9tDut1KsywE1fDeeDELrXWq7+AxOdDRq0CKkgSPBtO41K8HFMjeYy0FNqZmNmtP00Ksgt7fOs2R2IGq/IsSOLTir46oK1TRAZriuxRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993992; bh=m8oMulnKYQb/AESAh3/zts2m12AJ/Vc62CVThC18uOP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Y4cMh8Q4mKX5ZqMRXMC/mebzxGmuXUS9saAaSM9KxK4pjV5v95DtDaFSY+5UrBmLQ/Q/EgmO0lWj244lVa+AZt4yP30A8ycuaOTBBm9Xg6x39OntvH3i/lvTcMHCJ6gvDCN+I+xEhqmANVl+H4q8pDkrzmS8Unrhat7IoWei+UEz6MYsZNTUzI7tZ0twrVhGfbKCocZGJgg3XF096nKEcBRpU/XIlByeKtOtMcyMwA3MmbpI5dfUnoRG6uYKbW9wZcGKPUfaSzpvfePEZO4l1IJZeryDJBPfMYCHiW9MKMCdUh7DsvX4z2saEh8/A3ONI49m0CqZ4yE/1gL1+psLeg==
X-YMail-OSG: XImXzEYVM1miACWdEvitI4BuG19vLEgJEeW1Po4o0fmct88cOsZl3UTw9eaqnJl
 Z2BO0XvPkBXvzd1b9AkfO4renWur3NNJvdKMtVSuJifF4uqK2_yApEDMfBq4qhFbwyZS1flZg3LE
 ULcoPuFWB4hp4FuvVlWlGIUBgTPctvPIdsEjlrHRylwtXcNqO6C6OK_WhIOhGD3y3q3QBlnq2fOe
 mL.dcf.f1KxjJYYl05OIcO6eTybvTKb53efdOloziu6OLvt1zGOWqpqVHUv0LjMZwbYrEndBeRyZ
 Adv.RoTEkj4MwQNPrx4o87iwe_fEnLk9LLDTCTYdC726KL_IQp5.niHk8m3AhZf3gOQ16JNGv_vK
 YB18giQdEZaEUb5RnEG5aqep8CU6YFUmqfYmqUzEgP0vwV7Lhs4JN.CY_hEuzQvNE03i2f1_bSWN
 htINe7aNv0Qo10ii4gAUey34mgbvTqXmZ7xlnf2Y1CaixSW0YGpNGaPvjG_eK8xk_51oBEF8Jxk2
 ocD0f0rN_Y2mBETrBmlGo_s81lSWdnvNUSJqu7RNRW2P9iRu85Q.XJTEsOvmo6PUIoGveoknMezt
 RUZ3O0J6wL2s28E2uXr21rIHg1sNHEElbjWWpP2JX8ATXTNqUKW61cEJbCDWS4YEKGPRc1QmhW8D
 oEBNoUPwmCdldcvVL8.ajkrfdEJJpn6lLDr8IUo54_MPPkn2k95.QulG8IEhnGNc.7Fcv.7aq7OD
 FFh8PlcBOcgFA8IRSiC_uQ0sF1n5zC1LLtXcDhSwtTmgFsGNWkt88oH8E8uR1BQ6ek8YNtsmOkks
 6us8zhV1A1qaCJrok01BC5Szhg2xkUuMJUkn9udKWTpnSmYYVianJRiG_dJGINljC98U1Ezq98tv
 TRGRd_ZKqTrVQqiu0ZSOClXwbXHlDl6STfzwTt.4BulvjHO61l4IqS9y75UjCXbc8St1XJeaBC3E
 cIdabb021gIlscmwKOJHnt7N_.Ssphl6Q6MDmOeN_PkMLWYgR5OiJJY.4Fw.9IdtFENcPiGVBjC6
 ghJQG0039mal6uTJBQs10yMPhIIpuDTZSHzS.B2Xma0TYXxfp4xgEIpKe8U3mCNsMi_2AEr5Z5e2
 qd50PZubfM4cJykI5yDL.g9T_LHzVlprRG5SGU.j5stKP.qxLeh3aZhp7v4xlgfTrH1E2JQQWfsg
 ilgQ2rH7DpRoqokHUv2KfHniqz6p1Mw2QXg3DBQZCpwyeWuJKctrPgc81zDikSt1o3bk3MxxPahH
 D9S7nTUlnzWl8pUJ2dEZ4YbdEvsCArUWiivbNtg_JKs_7ORRH5LPk6bCz.5Qbwk15.kYx7RxkegV
 rvmwRy9xfLJedijx886TtqtrkKrGPDin.Jp6tjXk6uXn_aenaOsa7iLW5iQioR6XwDyRTmSN6fgv
 ZoKWCYZRrZAyaIyPeA7_iX5Y2B1F5moU0qdNIIgLj5tvADQ3RPeYjT7YNvVUa4OBUrAPJ.hLsWi4
 gizWunNPHJeI7vvlgC.vMvQ5qNVpjJRaIGle81D4PpX1988MSI6TfUmdRnCMyPY93t.ucpNqT4uN
 VIqkXqoLPVuEOEq3eUXAetgDOTj8ehEj27n2fqdsGLuRbgj1HMwf.9xMs7pQ2yTz6LNV_FKFD15X
 crxctLPjPgPyz_bQsUiMKNG3wOWE7njOZDD_N7GylHciG5NdVqMNHWcIUN7buv9txD0oxfixDjaE
 vrS_vABEhpXFlCESXzWgNN1ow1PcFQc1QhVpdB0VaxegK.IWBNVLc1mIO5vuhwU0hmKpklW43GgZ
 ObT_uUcBDKbsp3it29TPI3hKen1A2wosl5cfyQpoDsQ_u_N2H1rOAn.j.l4U3QbQyP11tbgDFR1L
 dPZ8R5U5RB5W6E6uXsruF2oLGJthMjsUv5iKX8Hb47mfV720kwtB6N8NDQK17swFhsmmAmRm6yTP
 LyLnQBjaky4H1XCqAj5rMyU4e_MFbq.s5k2iboUox6mIeHtrZDpKSv6tKP1lBd3cLC_G0XXPpb1y
 Oa5Q8pETULkshA4c3gdvEnTBgBy4HPPQSgMZiKyPeMCFG5uh8N9TlFMw_JRb5xSqaizPFOF3TJAt
 JyOjnKiGy3yuSePfv7F2fxKsdmAzSTZzWwcwBLm3cA6T8O1GYiHeJOgqXAAv27_ePNgruPiTodGx
 j6KajWAjvrgTwZvpFPg0zS2sAhmNELMvqulBqm51GdHRsXYNOgt5dkD0Su73yYsZRQ40lX3akTcv
 Gqsf9YqLuUreu6AK.1BA6OxncCISA0JtQH3Ji5tx.dVUQNLWvMY3aS8Ji2jrDoHjMXztgW2G0ERV
 lXKupt_4U.kQCYO2m3DGNtg4AASSDpiQeRI8gY4Y1ds_7l8pn
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e3b90c14-4915-4e9e-ac5f-a48a4646717c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:46:32 +0000
Received: by hermes--production-gq1-5d95dc458-rx7kt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2439121b4758407954183c0b5224f0f9;
          Tue, 10 Sep 2024 18:46:27 +0000 (UTC)
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
Subject: [PATCH v3 13/13] LSM: Remove lsm_prop scaffolding
Date: Tue, 10 Sep 2024 11:41:25 -0700
Message-ID: <20240910184125.224651-14-casey@schaufler-ca.com>
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
index ed13cf5bbe1f..86610ae0a9d2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -144,11 +144,6 @@ enum lockdown_reason {
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
@@ -157,7 +152,6 @@ struct lsm_prop {
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
index 824a85d2ee85..e2e83519d5c3 100644
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
index a523f38faca0..3177d39faf79 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3510,8 +3510,6 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	prop->selinux.secid = isec->sid;
-	/* scaffolding */
-	prop->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -4032,8 +4030,6 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
 {
 	prop->selinux.secid = cred_sid(c);
-	/* scaffolding */
-	prop->scaffold.secid = prop->selinux.secid;
 }
 
 /*
@@ -4174,16 +4170,12 @@ static int selinux_task_getsid(struct task_struct *p)
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
@@ -6348,8 +6340,6 @@ static void selinux_ipc_getlsmprop(struct kern_ipc_perm *ipcp,
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	prop->selinux.secid = isec->sid;
-	/* scaffolding */
-	prop->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -6634,13 +6624,7 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
index 74b1aafda399..14c583d171fc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3659,10 +3659,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
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
index 4d236a5ea5c6..e5b47342c274 100644
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
@@ -3473,11 +3459,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
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
@@ -4824,10 +4807,6 @@ static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	/* scaffolding */
-	if (!skp && prop->scaffold.secid)
-		skp = smack_from_secid(prop->scaffold.secid);
-
 	/*
 	 * No need to do string comparisons. If a match occurs,
 	 * both pointers will point to the same smack_known
@@ -4888,10 +4867,6 @@ static int smack_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
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

