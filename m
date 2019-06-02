Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6208C28CC7
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB4027982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k8UxniCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfFBQv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:27 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:33512
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbfFBQv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494285; bh=dwbKmDfRWBch8TA3RWmr5v6f3rBIx/+49c84tS3OSyo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=k8UxniClHJw7qwznu/CfXPfsSfKP9GufMMywp/KP5UyTdv2FKJzRfLmciHlF5+pPsb6g1m50kFwecRgq7TGVytjKc0AwtF5FalYNvALX624k22VYzro1iL/uIXBLLf68BAcJNlBiMCHKp4sfJrp4L3il6QGtfJjw9E4au3fboJu+rF/s8Ln719Y7CgZ+EkYa0dmYjzU7EC2IWNdUhyhDSxsxWcnXaOJJZi7dnU8x8VGrW7Vi50JiC191QckaRawB0Ppi9BaWWNfHcWPH4qZWpT+QvXMdwzfxAsTR8QYnEd5IRMp7LNjJc4LPQyMxqcSGpKyvEDZNApZrXM2Wu/48tQ==
X-YMail-OSG: ojKavEEVM1lB9LmWtfTPUEFUIfUp43MlzCyZvZJ8S3LRCZWh6rhDl_eRc4cz5.K
 v.O_w52_u12VCsnu3L0YSRfIbmLh8m6gOE4kjtCIZXuunrQRuBq_zbFndhawwQE7m80zs2p2M2VJ
 qQi6wtt.b61tIFrIKBNFMauYV26BWenEkoq8qBgQXUsy.jDgsSr2wek51q.OUJv6YGg_AfAfWise
 BQ6d0Z46f7uw.JwemoXIFasAnr8zJM40hFvUbSaU4qmm25F2z7ybxhVykGVjjXwMYnx8zb1dmmJz
 yWl5jcojYuTJbzIORwdDJhzOFb6PaAe0tPtYKePMJmIFXKYxfeYb6vG102GwpMlLRomxSw.SiWhG
 KrbrL_chFj6zHD8MF2RivTi5cRRleHhcXDhCCOriRTO3pY9.l9_nUUpX086vMpZousnsJtNeHxAD
 xbhQ6ONw2PuuIZ2xN14Rk.J7.d6UL5aI6sWe2yMFxCb6kjl__3L9GjjBOD9SQHn8JLfQReqQtyTN
 X6ZVEILtPWGfmJ7.Y_PYpj6WvqtaElR0A.NPev1ffHKioRMspD7tSa2ttLMh__EQ75Lk6b8xDq5r
 arf8_J5bZwNwn3W.Etb.quXEqxBAjcXmbbijdhZ6Zpl5KDGLwOm13Df0LdQX8mukJvIrhQbAI2KG
 lyn3i4nCNK2QTtXkvxjgI7Qs1TCIXyzzdu1WMbBMBQZVzC8UBlBFP29CpVrtGa0dj9oJ1nWhpr9g
 HyAHIehIgpx7qbfZGbyUKLFtWGcJRVHBNeSL.ZEN36dBYJKDdWQpmj9OiitTjdGiuJBCbkaeissh
 Jyq40gcLaRFtV6L3EWSC2O7K408_No90iojzWWI5hV_hkJlJWYtm5uGybi2TD8voEHIKeVmoaDRu
 Uc1GNVMENg_K3C01F.vhd0kqXIkNmN7o7MEu6HaIv2_vJc9eXsc_eQbBnrBbt_tYbLrvEMaf4pgv
 MYb9oTv1F6yj73RnZWt99sREYwkQZISbgWMG_eqEXhTkd3aHFsCFVqhc.kpxR3zf2LgW6fSf4zgJ
 OAiUjFFn_4dzEJ0oBs02Hw6O1hOpPzR1lXmQZIbn66nsPOVNOEc0sY_VC_42HfpZAUNNuNTC3Z5h
 J2IPncXm8WSD.FOI8.aTu.H4XJpapsobB5zNnRGxOKDc7v1mHJ5I0fYGTpCKw8YxAk7L11yUSY9t
 wn11J.Cyl1uwhgAF3wf.iA8PP2fcE4iacCpoSq_xZr_7IZgdHyFOwV6uhQhfBn3ccqo5KP8y__y5
 2NY78KHIsP78OBh.BLghPNbTfbT01OBZGqYPnYNKi_Ys7PSLc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eaaddcf00ddf2fd5d1fdcb38c64db575;
          Sun, 02 Jun 2019 16:51:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 06/58] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Sun,  2 Jun 2019 09:50:09 -0700
Message-Id: <20190602165101.25079-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_cred_getsecid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 +++--
 security/security.c        | 6 ++++--
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 09573c55e535..0f9d4174bb6e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -572,7 +572,8 @@
  *	Transfer data from original creds to new creds
  * @cred_getsecid:
  *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
+ *	@c contains the credentials
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
@@ -1596,7 +1597,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	void (*cred_getsecid)(const struct cred *c, u32 *secid);
+	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index a1f28a5e582b..ca485a777ca1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1638,8 +1638,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(cred_getsecid, c, &data);
+	lsm_export_secid(&data, secid);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0e31be22d9bb..f97dd414ac8d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3764,9 +3764,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
-static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	*secid = cred_sid(c);
+	selinux_export_secid(l, cred_sid(c));
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5e345122ccb1..15579bdd7244 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1980,13 +1980,13 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
 	skp = smk_of_task(smack_cred(cred));
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 	rcu_read_unlock();
 }
 
-- 
2.19.1

