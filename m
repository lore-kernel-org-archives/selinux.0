Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BAFC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457C2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S76Y3s8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFBQxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:25 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:36361
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbfFBQxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494404; bh=1xMyB3SejRKDCdQmKeBsMf7OEE0vB0tP/pBY2Hpzm7I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=S76Y3s8Fe6DqZRtPt2C2t4gR9MgIPKBPzHNdtutDlKrTwh3HzJDeTK0WQeULNF4M2XK45+BTVo/YfRvxt24GysPMZiCpaAcDG0tkbBzUqEVlvVXv76P4bQmNG+taBmOXBwToCo+Y5ABjBDTc64M3A1e5n/mqhvkFiYRA1T+0aCRW+Miy1q27FnFOSSpjM4iHw3aQ4pzrYDYZ5BfRff9zD7ySle/G0ptqmqDxuQ93cyUwvZnEEmGFo86cLQczXDmf0eoIjDdCi3C5pKBijH3BBV59Suoew/d0/Z2e6iKmLXuVTA56yqyPdjkSpe5rN6nnvmjGY7hJ3RKoJV+ZjQ1JEw==
X-YMail-OSG: x.Ly5qMVM1kBQz4ix_5qE.JcmKie6rZ5pDwN61Nvp91ihu9.xuMQj2V242.pSyP
 N5Fbbx24Bgk4wDU2nKlgwvXQIIgJnmXN72ufzIhDXVej.soAVX29IopIFZYwV49Qs1mHrUc7MSqC
 JJ5ChwpM5E58ohWIWjMUH4k9q4WeBieMhpFC6vMAThi6ObcB0H.mB698uXterga.ykeeCCR6vvdu
 DxfJ0180hqPInw1iehK_UEtMLu0rZMi7C2qhV9J2p55gL_LxWGURCycgV8NC_NypJiJb06RUFewO
 cm7GxAwiocIV5JTZKjn5.jPqulEqK5EjPqW0DfTW_QLdpzfh9Hk3PdQGPAboqbLUFjzr8_8IAA0z
 fMkfAKpFfdvIU.GKkYo.qytzja5wlK8xkprOV570FMWmTswM24c8rkshFR6T3zdH95zRLsgY6QJO
 IGKUgWUZojTFitXTLbAR9jhhcLOxoEVcxcWA0h7Xe7KDEiLSl_ac.tqtWJbCQQmDySljzk3TRtUc
 IQolL6B3PjtKURXVePt1qEhnIQsudtChwOFkPgucts_uFoCoj9XHveutPomgC5JIAgPKyuMrYmMl
 W8asxjxJYqbq6p8_5E2yedfYGC7P0UU15OkQV5mzWCgZW1vtESDcF_ppLnnz8q3zvqO34nhyYKDB
 7lTYElMJ2DWmIZt_y5LtBSVdvX7CBX5LInvm5NfS4UK58vk.KU0n29rTrQru8Nxk9qB0Rb5QCoPV
 v.a1e3bdBK2ShqZCjOB4imbS_V9ruPgMUoNND02ZF26dPrO8k69d2taviJ7XuM9YVYwsT8200RYm
 WcLxanmf8a9GznT.Fmti0ZrhdagEyF0FEP_Q6QR9rwI2Sch7Hyfquf.9Akd0WHjpgNyZrICyHzyY
 iNX2w3lG7G2cLMxR_uMNLZZMH9M135AHeDlnpVrCSDgJVmsSEHsOSr0IlFpfUjHsrrh5hm6ltana
 ..LvQ1yxAMZ_BpoGcUX07asnN.L7FCyVVHkY2V17jdbLQtGWv0A8USqQZYbzsc8T73Xh.jQo6NVr
 Yr19i_gyQxNiJMG8PmCBZ4WiRHnMu81_a13Dy1cqmpW49zpj_7a10Z706aXenkzaHPCwO5XZcO5X
 YuYT3EQos1.6bODZ92_d0hfLNq4xjgSL5lkZpc_YAXs2rVjS8XTanNMzV2LdvrN2GoO5XzwmNbhr
 7V9eEJsurH0C_DpyxG6zuaDd01z7Ho4kiu9xYwllzsuV4_YSGDiymPxKDN8v4.A0KD3w9lCS4lXe
 7o6xs0UeJunt7waM7dDXyOARJm5C.OE8NcVy5CPKGFRfSbIr63A7GSg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 037f0ce5b74e0a8af50a9035f5845b74;
          Sun, 02 Jun 2019 16:53:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 37/58] LSM: Use lsm_context in secid_to_secctx hooks
Date:   Sun,  2 Jun 2019 09:50:40 -0700
Message-Id: <20190602165101.25079-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppArmor to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 ++----
 security/apparmor/include/secid.h |  2 +-
 security/apparmor/secid.c         | 11 +++++------
 security/security.c               | 12 ++++++++++--
 security/selinux/hooks.c          |  5 ++---
 security/smack/smack_lsm.c        |  8 +++-----
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0837c214cc17..229899452678 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1320,9 +1320,8 @@
  *	length and the next call which actually allocates and returns the
  *	secdata.
  *	@l points to the security information.
- *	@secdata contains the pointer that stores the converted security
+ *	@cp contains the pointer that stores the converted security
  *	context.
- *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
  *	Convert security context to exported lsm data.
  *	@l contains the pointer to the generated security data.
@@ -1664,8 +1663,7 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
-				u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen,
 				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 5381eff03d4f..964d3dc92635 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 69d98a89db75..4e11434605d6 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,7 +81,7 @@ static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label;
@@ -89,13 +89,12 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 
 	label = aa_secid_to_label(l);
 
-	AA_BUG(!seclen);
-
 	if (!label)
 		return -EINVAL;
 
-	if (secdata)
-		len = aa_label_asxprint(secdata, root_ns, label,
+	/* scaffolding check - Casey */
+	if (cp)
+		len = aa_label_asxprint(&cp->context, root_ns, label,
 					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 					FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT,
 					GFP_ATOMIC);
@@ -106,7 +105,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	if (len < 0)
 		return -ENOMEM;
 
-	*seclen = len;
+	cp->len = len;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 365970f2501d..ac0498daa49e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1974,8 +1974,16 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
-				 seclen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, &lc);
+	if (secdata)
+		*secdata = lc.context;
+	else
+		security_release_secctx(lc.context, lc.len);
+	*seclen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7dd333f133db..6a2a82dcd948 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,14 +6301,13 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
-				   u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
-				       secdata, seclen);
+				       &cp->context, &cp->len);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a837af153ed9..10d6c6a1a001 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4434,8 +4434,7 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
-				 u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	struct smack_known *skp;
 	u32 secid;
@@ -4443,9 +4442,8 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
 	smack_import_secid(l, &secid);
 	skp = smack_from_secid(secid);
 
-	if (secdata)
-		*secdata = skp->smk_known;
-	*seclen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
 	return 0;
 }
 
-- 
2.19.1

