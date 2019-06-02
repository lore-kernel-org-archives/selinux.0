Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD127982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Dt8YPhjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfFBQvq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:46 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:33350 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfFBQvq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494304; bh=e+8uXyTo2CH/SxRFMxOILZ2iZwykcjjY1wTO6Nmz4rg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Dt8YPhjmgYlBnREPoVAO+dDzPY2Y9Kvtw/liALf3CB4S68G7yJI82tkMojCGnaAfvsT60+EVtoR2Wt0wydqTMYUsLKviHr4vFSo46HcaH9Ne9MMYFALD5Rt2ZaZu9tm8P9Y/VYCLuUb2rrzi4pAq++5jPYdnkoBoW4t4Jt3h723arweP4Hm5ABedZ1cvIj3SrB402jwKF9uZHVq2bCMifZ6KNe8AO28jYnxXiM9jXxIeHy0aMVV0VlVLZMOFckNEmMCpTyCAjihkO+ExZnu6X8sB5QTahVi5FKCrw9Pa9qz1K62Ps55DcjtBkwPQJa/ZxVLeXcplYjVHAjGD85geXQ==
X-YMail-OSG: TfbWB0oVM1n0IEpLScnIT9wXcBoL2eplGeluOKD.jGl3hUqhVRYjJxzyXCLmj6e
 oaa4VHiAbH7lhZJyqV75JLFGPQv30ORPKO1mdvyiUeZZIjNNxQvnL9Xc38S4eaPMLk5_QYhfL95p
 HvWh3EppyQXJ_j7IHPte0xiKkSnCiKXtwawF7MMG9Q5dZN.Q.4pfEbEPLd8nk7gXZmFF59pNKSTF
 qwADo0cFM8MBxVP6V0QjI8dbjNCQh0PWBRjmpOomo9tb1bRQdk3VM26j1nnj7sPJ_c0wJeD4LkUI
 zIq3BOF0kLx8pscCPJk.XZwWkZ38.b0jLaimU4KsIP2uuruYFRjRqegT6K6RV.Q38en0ktZcYbjI
 3hYgj.hKG8DzjIOkxFoUWsqQy9Ui_T0AWwv2Qrz.N3ZikXr47DPwpwrlFxMaMi.M1UKGVsnDzm0l
 NmDGIsjiXBLp7ONubuYYrkng8aY1O043Q7yCRNKSngFBjDNK37vYjOb2VRTcolNei0A1_zAZEziZ
 oCCtrSXs_R6dbx28OAl1ZP9G0MCLBIeK7WbKJ_r3OoS0L9HuDDQz.BY4_k1mR07bRbjr65itUBpX
 dkFIDT4CxFaas06EL9NIkKaW0dGga1nwr9NgCUndBxdScjeiW3JQP6FLVWRWcSSdKYoX8fg6A7S5
 CM3rT0JaeJc.3GyO6LEo.daCOdfU.DJ1AM96bgkY3yZyheQQrV7n546codLAajZcTJhdYxsDjxut
 ILF_bf8VCtsx3Fh3JkX753RO269Ef..TtUzuVXKuIInmkfe.JBAjq2_fdO.SQ7r1H33GZ3PxlBk1
 _z7jeaLu0ZzB15ZLfhbfearTrBG_qeS7WqqBNEXvmf3ht2dlUex2NpfHRNjLlz3IDrdVW3jzqt9w
 j3GIMoiyR7e0IttA5B2xSv8gRHcXSC8bajy72orAwLU1pVftJNNDCpctm4rhdVItk9SVE_ApB_d_
 eyfIlb1OvvSEPQiOVs0RbMzeUXXKduo_wpz_VF9nE95rTvmxRVFsac4GtoKBZgJze68FR2joNYjK
 N.L108jS77dyX.WWTR0fVVGNdt02Y85kRMNzUClR0fSDGi5nT3Ha253AFiEW7ob5SnTi0Oxv1.Z.
 ucInCldBbnlH7e_zsHku7PePmNtyAlKivgJPaYWaNw7ATBH4q0JWgthhERO.BouhTXauWlRqXQJ4
 RtcJC3FOzK4Gw9Wc8TW6jUkZwzPhFzxtwT0OkTY2ApGF07Nr01qS5f9gpqmI.P2CBs8tRZvgmCiS
 D4vr1.Z7nLM1iiHnaxAKi0peAuuaLtNAJTpjq.t_BSsiR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:44 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3a8ad7d79501e3c392fdc3d79d8fa55;
          Sun, 02 Jun 2019 16:51:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 11/58] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Sun,  2 Jun 2019 09:50:14 -0700
Message-Id: <20190602165101.25079-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secid_to_secctx hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secid_to_secctx()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 5 +++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 6 ++----
 security/security.c               | 5 ++++-
 security/selinux/hooks.c          | 6 +++++-
 security/smack/smack_lsm.c        | 9 +++++++--
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 01296e4ce474..433d98dcb928 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1319,7 +1319,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1664,7 +1664,8 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
+				u32 *seclen);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index c283c620efe3..03369183f512 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 1546c45a2a18..ab4dc165e43e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,15 +81,13 @@ static inline void aa_import_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct lsm_export data;
 	struct aa_label *label;
 	int len;
 
-	aa_import_secid(&data, secid);
-	label = aa_secid_to_label(&data);
+	label = aa_secid_to_label(l);
 
 	AA_BUG(!seclen);
 
diff --git a/security/security.c b/security/security.c
index 60dd064c0531..adf4cb768665 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,7 +2002,10 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
+	struct lsm_export data;
+
+	lsm_export_to_all(&data, secid);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
 				seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfd0f1f5979f..16d902158e8a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,8 +6301,12 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
+				   u32 *seclen)
 {
+	u32 secid;
+
+	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
 				       secdata, seclen);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a3776501965d..809af981f14c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4433,9 +4433,14 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
+				 u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp;
+	u32 secid;
+
+	smack_import_secid(l, &secid);
+	skp = smack_from_secid(secid);
 
 	if (secdata)
 		*secdata = skp->smk_known;
-- 
2.19.1

