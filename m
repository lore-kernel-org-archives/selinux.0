Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF95C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB8F2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GctxdS4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDIVkh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:37 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:46204
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=seyjgce0pdmEa+cpaRVpjQK9OBPNuMErUFViqdarFKQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GctxdS4ZjDWc4sJ9bqL7yyIMqH8jAaJBAzAns1jxy1jexvWr0m3fcTXaePXwX7OqwUluaqE6NxyPr9MW6vYRrkALhfQVMo1DL7WDcgRJh2RjTUNmeuH8H+1kHOwTy+drurYxHmFRP5MTvQTDpKX1v75AeArhDcw+KhLg10jMQxIKrN4Bx1FrUb9bt89lq1WpjLyjF3cOKq4lZJJkLAKLgt9EI/TnnpGdg3EB5BQWgg/v0R3iH9hS+6ICYicEKCMNeUmRqpMDPZzpo4tf8ZeO9pdTBQpkGI34Z4+tlBclGnVqU3u2nz4WLU+mZrneiMMtemmz3zZ7p3HQPj6u4h4Bag==
X-YMail-OSG: l549ItYVM1kxaTdV9HZlkn9F_XyoxLzGYKXJ3LJi3034pz_bIsVNq3TfOZrOkV0
 W95.wU5a8Nef43bKq3FLr3ZyIj9VjEnDWZdeud2db9UZVD71AzgjfMbk.Rfdj0bToT0nU0k_k.GJ
 j9JC3Nxx43imuofvnJpIsk5qffTLgKRH11ET.sO8UiwXa6l4Ji.7mlPmX_2faTsNz8rJrzZcbuL9
 zY0gFq0a7k7PHWuFmBalS8oBkMJFddMr5BgwW7CeRzkxb6y0moFC2ER_VHQVE5mS2GuHtfI36S3c
 o3cfvBcWxuX22Q_ngdIzUxr4FcsUT6DgM1dVzrZsI1Bpj.KtSeJQPq6FT4Yg845SiGlOK5vnpTs8
 pBJoypObgCSp.zLIIEBALEz49nXs0DmZDg2ehydW2cAxCKuHpvC9jpIR0oBefCbmex9CR9XnXD5U
 UYvf8lJzXA3qeB3ISicH0VgRTc4ATh0gNpHySmLPHHJMOrEsCKizUukrncaFv7ixIuYPWqwIFB8y
 Ezm45zFla8BOx0.FBYX6fq4R2eWuL3A7.3yFC0VHc9RLt85cS5RtM3hQA5clobmah4RM_5HxCRz9
 8_wNkfVS2ENHR_K5qLggv5LkXb6mYzSgrXzRznuql56BSxcjcI5B_VlPj6LUbVQX12RJI_XP1Epx
 4EOWCxiBN5k2CtOPxmbTARi0TLmJI2.J8vQO8KXDWnd0DfnXL06H8rBdjpWivWcz6WNuZR1APoAC
 TTfNvBs0fQ5L0t4LxeT69709VnQzdmyNttcT4AU54OW6kzq3PVtvWIfkKB1KzecK6awVQXrYxrvU
 SbFPzSP5PTozU_P8MwwmC8sp8osyJ7olgHIpVINM45Qxf2PcNzt8yA4ykvnOY7dZ56i3bbLeCucy
 PIrEXrHCQAbZZ_kznjYmSr99x6vBftCLA04SkCfJonRfLEGvD3j1PLyEbYkuw7.h68DF_IL.Uoav
 ku9Zs4gaPov3Bvdn4yQzJnxyhfDywY2Ud5lKIpGjF4ElUYrr8nkdnKa93S6uyCrfc0qW9LAXJOwe
 StDyER5OoKIo0d3ChXkappPR7VIu_XI1qP9upBnkuDG1dVyrcbFm_jAWIljRp79hRQScu1UWQMgv
 IglfMg0XkAEDqlSYYLv0zH6a7LtLwlXHSNycK9i9b4gCQbsW73rIuAA2t0PE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3d2ea789de6b345569f1c9b3872b02c3;
          Tue, 09 Apr 2019 21:40:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 12/59] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Tue,  9 Apr 2019 14:38:59 -0700
Message-Id: <20190409213946.1667-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 690ab020508e..11ace5c923bd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1322,7 +1322,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1672,7 +1672,8 @@ union security_list_options {
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

