Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40237C2BB1D
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A4520801
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PhNbIZPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDGAGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:06:31 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:43438
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727905AbgDGAGa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586217989; bh=WJCVOWYYuSJXpVEiT7a5PyQ02j71B6bFCC0MlNxEBBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PhNbIZPYbK8tPsZGMUpLEhW0S0SNccAK8hc8TFraCN5a+j1nC6MCQxWl7PuJ2Eja8yBEdT5eg2kbLnykS4aJNhJ1DpiDjD3PhObaZF8CiUBPgu4PqPFWfBetxKwATXX702kaxOH5v/AgZeU45V4Sc53oBTrNZpWf1MMzgCoAwOqq4oMO5o5pkqIc3kVSdH1+dFCEybTPXKaEOV0qxara6hy6iQgcMilgWkKrT15FnhkEtz6k/nf7i6JIZBqNi92GRZ9XSqONomh2ODSiAZEMkedeuvHR4zXYXO7orjNjPhulXEc6urdE88XZZA/UBe+LOqhusjMGywuFe0lTtQf0Xg==
X-YMail-OSG: U8.wlY4VM1ndKkYP23m0WEM4nVfCxfcALCO4At4KpzhbpPk96.kEmaCvhshQM1f
 8ER5KR5yS0BXjzJx12qxf7XzUHV.bGkEwASxnhu2hpcsPyb3VecziJPYK8WFWeaP8jzGZdDd5T6L
 IbdvlUNvyx1dLNAV.7X_mJ7nzW99oiNb0HtLGPi_BeofCzgUGDsL9L6pBHsaOVWAe2rOc.xwUcjA
 rvcVPPaTpSFESTYtHnq.JOrg_N7c0WnMGECdF6HHXSv3.T06P2Vz004rpNaUorcJUs2p4z0vq0rY
 Q1F1xhiYX5d8G_WcvomVbvciUpUocWGhvtQdwRmcbcjasGESD3_gbTPQMIR4.rXzZWq0ejh5FyWb
 SIwgo9rPGOeVAWDdN75mAxB2vWud4xr6VCAx0Xk223jtEjdw0zNPZP4KqxbRl9FqjPoYVYKi44WX
 gVPuAIcNSJXWxghPgj1Pbe6qhHt7hXJzhDTcpS1aXaliFt0m6eCgbalXch2zi14EUri_2YcpuLOk
 6FcGfsGB_bW4FC319FzXFxD.tPGUIQZo2iedK82oocKDa3j6L80vzeN931.kEk8lg5a5SQGED96o
 W_QcNJ.tVTXivMlm04wmjPdFMEHD_hNgDTH9VCSzH2QS8cJzKZqZYoWd8Vk8Yat2y9OzP9EwRzWj
 XrAzpr2OgljjiUM1uy5qSI5ucX2NFXoE4GTgcl1PA6rpsOVcvSs6bFZRB7nWmuSWUpsYrS440lZp
 Ch8T0hmsXxFSwSajNK0f5Xaz584QTElPAIAHzqNMmOARWNphBlsk_NWnY2UnPkGi9IPSGi4Fqmzg
 _7xCJBLG8PCi3MrVkaSlkjOQMLRpOgUc6MikVakKwuM7MUV5wcGdQ5_4jFE9U8Mto1rl6T5T79a6
 cYijqECCURVossOgi8IHfQQvOvwGUNyewAdEC3h_dWVB0m_9w1JH_cWdh.NgmbXHKNlRyrKIRW2c
 PzQurcCULU7CViXwFoA00vXbp_Q_5m_bv6ZWG2eeFl4zv4IOtm80ZreYOKVmHQitU6YG15VGAXlx
 ZgYRF_hFO1YuSBazdRz1QMnMGsWZ00pMVUXd4fZcuaTZxjDQpA_12GBfEiPSvueeFipbazn95BN1
 skbE4X0tl2FEauzRZDz1TMJpY6D_lsaOZS9xcjhTTqRTEDLtcPgzT3N1txi2NAY1A4_TbWsCUVoW
 QOcnQLUDy.sSfWkKqQKu4N9I__RGdhuS.1Ym7sHXWWfAMikBlTMrz870LrabFgDwsP2.93t.Z4g2
 vJh40Ck27FJE_wwZk01QWA1zMPhdVB4LRdSxx5BfbXCb0BLhfQ5alDBrXz2De4y4Xr1SWt3RZwpV
 6kaOup9HXNKEl1P5WcIpvRxRQi5FeV26HatQOcbk5O6c.6WiHZAWhxwCOmZBZMduCstdbb3y6DfH
 88duGXRlmE1gGZeY1BQmDGFY8Hq788cahkUJv9_EoyHk1WXxyzd88d93aUCP29Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:06:29 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 39916020a5adb736ca8885a0e053afc1;
          Tue, 07 Apr 2020 00:06:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon,  6 Apr 2020 17:01:40 -0700
Message-Id: <20200407000159.43602-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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

