Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D41C2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D027206C3
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gcl9E/63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDFUzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:55:54 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35984
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgDFUzy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206552; bh=WJCVOWYYuSJXpVEiT7a5PyQ02j71B6bFCC0MlNxEBBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Gcl9E/63XpCPhWuRgbyFFRtmxWXhRCSrFu1mgcvYq1vSRsXz4Ot4HSujuX/QJRgJ65OhCauopcMBrt53KWJwly5+BDTmIxENs9qbmPjeKg6CLABcVMZ2JlmX2wVqZ2f3YgKAX+VyCNH3Stdw9BkpilbV+7Ybbqd76urkeC8rFC1n21vPM8XyKVQH7iHDk+I9aqK0/W6IGUMtC8SlE/To9fazRzH6zElJatVSE7+6r9+SLBoauvA94KYczjfINdaYNGA1J45XaUjfYo9sfXieIp9dXyeXSicLDCiZGqXzITSZzswHlTthVa8Z9ma7RwjR0oAQuZC3n14+DRfvBhtY/w==
X-YMail-OSG: jlTv0zAVM1kT2TEnYsl.JJ2KJNldj.TmTpPjHu_LAeVgtYxfYDJi7vlIFoYkN.v
 VBYzEG2KkV3J.qGPz_s4doNqZ57Odm771KsTVlWgmUyCagyUGqvFWkj6jEplKbAkd1Deb2qHFnY8
 xT7rSdQUJzcq2KtSzoKM9SzcbogxMrslfBBObCiUYKtvj4bSSsshQK12e89b5Fz7jvTNGG8InWc4
 ffW8KTU1ChF__U8335OPS4.ZgQaYyv9fQ_30WbHqQ6ikNX1C95oue4civnhuTcF_mHRvPbRaHbBJ
 hq1rnxlQzOzQTE8r5JVCxRnRAB1NKB6osHf1EIcgd9RPIK92z.RO.PQmgxyBRy5sopQz7KBDR5KE
 eV0LC0Nm.sv0Dml8EbxOXVWMVF2WMsI7VfWs_3fILjfV3fBG5.hv0QHzbqCXr3tRjxzIKmiKjjLV
 5nL2LFAtz2xErKlD78sWLoKPLzcQ1GtOlOuJSsMQ3Dv6WYorJ.cm5jqJ57FTKQlTOyBJOEHk87tf
 Z.75eKTUJDWh08F6_Mjv8Hq1OT_TFkfr6mBbOa2j52Sbmz8RhT01ZxYDXu8fG50Tmqa8jPWgLjDh
 OM59nVNBzY4_LxlO2tp3XyIL8Y8W9urqwl4o7j130zqvRz6bWWSafmLNVAv3MWOIXNj3Teu9G6ht
 IsswdTM_NGC_9ZRaMLpjzfCc1RAJzETW95nYPVu9Hbbh7RMmjCW80Rq_SS0VQM6aIsdTp3nlQ_Wf
 wFpPXKkqYzV0pHrmSJUJzhnwLnVVCK4Y5313SsweebRxLh7cgMFmTfSrUSGI4Pv0A4C7nGM_ZGvV
 .lBQJ9ccnY6EJDLZ2wZxGIiVVVk7J26TnIFMZmrCfy8vYVdPFatBM2PsbUuRRkS74OC.V3dsI.1o
 OiUWYv8.nvLyvbmxWlcdEspjbcnaXRbDgrINWRITqA.9O3ekuI0eUhhIcOGdLJ5vczPJ57tdPVR5
 pVlAz2ZQX_TwHBoUCMv3q4DXuLX493x5asw4thOhQ0177abugWn4OU9qvlRdKmUEMidiVgEJtSd7
 CBqoEscYyWunk7FxqkOblbdUniAL4ac9JwRPPqcrAfLiu9dYV8b62XHmzsFi5WT8XyaADUcNshtj
 WP26T8JuGK992YM32fToZX_jXJviNMtaKkwSruRM8OVG3hhAHjc46._R2esX8urWbCI4UcBxVJyf
 vOcQCVI3jk0Dpb0WqLCaqVC.PNGR2BZBcCvtlr_kSRwQGtXDg8vswJm4A4GF3qL3n6PtE0ofh6oG
 STTB0eoWDH2CVlTSvKhRQ4qrlwOoL2GWapzwDwM4OhYSIzHK_kKpWXW4Mgqv1yyVBhUTxAE3KsU1
 11eMH74xZYUsvoxWhkiUdjpoTrKspdEgruK8XC8989Y.ACeh8aVSri5WSKYUE1zk.PfXz3xTRlu1
 jBlmADvLYJBL2Qx0Hvjdbn6zbSSYKGE.L1xadv5XXbsCGHpbUKEwwF80hy_nDhz49ndQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:55:52 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eb6070422de118e57d805646a4428c36;
          Mon, 06 Apr 2020 20:55:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon,  6 Apr 2020 13:54:50 -0700
Message-Id: <20200406205509.42473-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205509.42473-1-casey@schaufler-ca.com>
References: <20200406205509.42473-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is undated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9d83c6832bae..1bfaf9ece13e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1045,7 +1045,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b1793..fae63c0a1b36 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index b3fab8fdbb57..914aecd89822 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1647,9 +1647,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.24.1

