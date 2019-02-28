Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A092C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4182133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M22my2fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfB1WT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:57 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:46186
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbfB1WT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=PYI3vyL47ujLwObxHa1iTlJBA3/bkZVAya4yPQPA0G0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M22my2fBZIz+CcZJfQxh3Dgrd9bIIQDfm/aLjsr/9IBdo1LfqtNYCm//sv7SnIt7LDAkJbBmpFPYtNWS+5jxG7XA+W+S7YuMGp2UkVd9wMFYD55tAHMIWx67jQx6mXOc29pxZPH0zkfzfqPhe0RYGqlftJoy1JiFJGamwdeHupiJQAz7owzD+mnox6sjow6t2e4VSTDgZhQBqtgGhb3v+4m3kLlrEw2o4Lvrl90c2HmMNTeXpiu/i9BVxh3za4sY2CyhUqwLoDQYHd3OQEPSI9/aQaR5s46XlVBMIrlt7QK2bYRkVmkGonXDAEMOIniU0wl5JnIRvXGOMBpOHyDMVg==
X-YMail-OSG: hR2EzRwVM1mxe.djPT3WL5kaUcONjzHDAL1hY3m04eCL2.O5z6JIZTBzgQFDI_4
 oINvjy2nAB2wp4p5HviXFqw4Y8SzO9BQgqYI4.825KDAuQ1Udz9lxq2tjq5fJBPlUES6HwpcnbVG
 2Qd140o5R_xQd0vnV6ejys.uBibtDGnJu_tOy5YFL4zbuH7__DS.4RZJqKGrTwbvqmpEw6LZy0q8
 hpCZrTIsXoq2RfVVNUWaJOhB82XejjC15YoecprZSLWZT13qBZpzMZbExr8hnLhjMx73ZM.CzTdZ
 LMpdkxJO0Adt44SOdD2RX_HKbfaCzwobEieDuS8_eHHTYhsJSDLdW5QKyMpMjC0.cgtIk77LPAJ.
 bRovXh5BO7O1lZxRPDMxBrWHjqJI4Owm25T5PYCE7Z03YdxJigdtp9Cw5nUb6qkkjPTIqGfPlpeI
 TIAaCrUbWefBw3PMFQ4Epr7GmLgDoXnOBLIMqb4kziz9_QQA7DkmfgDYiQQ64noCKE25LOlm3dTZ
 HIDhFyj1yAemTixOBAwKvYJvbQib1k4P5U2W0.L0YtaOCk6Zl9NaZvAYyiejv7DCFPDIOLiyxW6X
 QnewTUT7bs31M9oMq.VlfdJxh8QhF_yVqiNxZo5d1CUfGgfcmVZ8Du.884ln81LF6oXzDjy9J3Wy
 9sTJ3uoqSTmBRrwzB9G0iwQx1R1Ur54LImPnfuutt_brSHa3apAY7PfhL1YcTuwCl4j9w8SfQVn_
 HTdZpyRyTq5p9T3Xel1oxQ2csVzN8T5j2vLL45.u0wSxGS7yBvGOG9xmK3AmBwGvYwcwHcieuMCf
 .m8AaU8XwBkT9CVH_hky7QtSaI7lv4Gc_pJ0M.0x.6nIzFdG.GLgrZY3ErnUGbpRHswYI_k5cUlz
 kCZqFboclWiUVRvXo_Xe4DNcHq2p_.4fsQ8BWWherZ17tkJAIGFW1vjLQkfjUa9htNtSPsm9ehLQ
 Ytwf8ZRVy7P0B7RYbeFKhmEQ6vRyIkjFg..PW0WHjChg6uP9OfBftEfUJ9hng8Ln44EHLx_TfdlG
 ZwvOsUGbkBoQ8Ngw60aamcCB4uDyCQObyqORRT1v226EWhrqauQaVVTf4OdMHyTRqcMnkIitIXt8
 vSVHcKWfTluOozMI9iGsMb1R3aAwQSBsreaFuQBXzWz1pgsk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 16/97] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Thu, 28 Feb 2019 14:18:12 -0800
Message-Id: <20190228221933.2551-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secctx_to_secid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secctx_to_secid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  7 ++++---
 security/apparmor/include/secid.h |  3 ++-
 security/apparmor/secid.c         |  9 +++++----
 security/security.c               |  8 ++++++--
 security/selinux/hooks.c          | 12 +++++++++---
 security/smack/smack_lsm.c        |  7 ++++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 50629fb10cd5..97ef535dafd0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1311,8 +1311,8 @@
  *	context.
  *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
+ *	Convert security context to exported lsm data.
+ *	@l contains the pointer to the generated security data.
  *	@secdata contains the security context.
  *
  * @release_secctx:
@@ -1656,7 +1656,8 @@ union security_list_options {
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
 				u32 *seclen);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
+	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 03369183f512..5381eff03d4f 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -27,7 +27,8 @@ struct aa_label;
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index ab4dc165e43e..69d98a89db75 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -75,9 +75,9 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l)
 	return label;
 }
 
-static inline void aa_import_secid(struct lsm_export *l, u32 secid)
+static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 {
-	l->flags = LSM_EXPORT_APPARMOR;
+	l->flags |= LSM_EXPORT_APPARMOR;
 	l->apparmor = secid;
 }
 
@@ -111,7 +111,8 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	return 0;
 }
 
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l)
 {
 	struct aa_label *label;
 
@@ -119,7 +120,7 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 				    seclen, GFP_KERNEL, false, false);
 	if (IS_ERR(label))
 		return PTR_ERR(label);
-	*secid = label->secid;
+	aa_export_secid(l, label->secid);
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 6e05d3127760..f3c29dd51c7a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1998,8 +1998,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+	int rc;
+
+	rc = call_int_hook(secctx_to_secid, 0, secdata, seclen, &data);
+	lsm_export_secid(&data, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eae3c42c07fd..744fa6141ae1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6204,10 +6204,16 @@ static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
 				       secdata, seclen);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+				   struct lsm_export *l)
 {
-	return security_context_to_sid(&selinux_state, secdata, seclen,
-				       secid, GFP_KERNEL);
+	u32 secid;
+	int rc;
+
+	rc = security_context_to_sid(&selinux_state, secdata, seclen,
+				     &secid, GFP_KERNEL);
+	selinux_export_secid(l, secid);
+	return rc;
 }
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 83a2b1153790..1ee9c94c0e16 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4371,14 +4371,15 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+				 struct lsm_export *l)
 {
 	struct smack_known *skp = smk_find_entry(secdata);
 
 	if (skp)
-		*secid = skp->smk_secid;
+		smack_export_secid(l, skp->smk_secid);
 	else
-		*secid = 0;
+		smack_export_secid(l, 0);
 	return 0;
 }
 
-- 
2.17.0

