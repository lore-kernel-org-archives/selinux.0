Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1CC433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABFC2065F
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cIJYgLCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXUhK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:37:10 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:34523
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbgGXUhK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623028; bh=NGvnBbTTBP1Md8GDZxrGUroqOu7tQnYJrOVygXRv8zA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cIJYgLCBe22pk4KTdHgqIdYy2nTxneV8wituETrVXaziHLx4fBRryAhBt6rSOMVNkYktt+6aD7EE08wWh3xSR6P+ejK2oh4qrbBDfZzPBwnmfmHIpOJ6H7Qi1qRmRjtnyOCK+Y/22kxIOvlDFex3q6Kf67prq9hQIAPSTZr8CsdCt6L1lPtbHctm90V9xYtFLMCrSSa6CklM8qOSzGNi25hJC5Ttw04oRhfAK6Tom54Kcnkti1k0cFrkmcVl99nB41IebZH1EvUfB0TIlhbInK8sKhYOhaFxQ6v1w142oxoUGQu9mRxnyqP73OcszyV5FEQ3JcEXFaZI3KdtdeuHGw==
X-YMail-OSG: u1FbOREVM1mAfWYZxbEO3pTNgX9KLeUiG.K.fLAbqzjDL.AzDjJhac.LiMVoert
 DdfQarlLoax1JfMgjBd6c4KQz2Q_0VYPK8_WYd6ZrkvBWOeb6wdbh_GbtCnfl4UtdPYXj4pN.mSP
 BzxlRAuCyPdjsWUCTbN83gO5ptgby99Mn3YRzwMf99p5777Li1gWNIWQ0y2aUsbp3u2eJq6.KQcm
 qQK.MThB98bF3cLg9yRPTvvMTROG8FeldArjvRD3CyS2AYy8lemWuIuivDB2b7hvf2jdUzbjH5G9
 wHttXNYd0ygAB_7Vjq8whFnjKbwFbrZOckiszQVgFDLofbz.pzdSf7emsIh7EbI8dh7cmOOQenMr
 iiwRznFeOGR0qrKqWJ8hAM2zvQYkxtBN6Z9q2PRPDs6q8.RszmAEfR1soHqkN7k7b2DgOb0kqP2P
 F2PtiBQZEwb_Evah.K89rqrT8YMwL1pPFyJ5BwK8czbLdaUUoSZK3DGHKVgHlgoSoc7STbC371g9
 4J4xVNFyqz8PJJM4AanL0pSY8H7loLRGxSSnSWeecKMROn58iKEun3v..bMLowvyRVKgj6ZXdIko
 qK5Ia5Lrf3ScRoBOJ_gP9pn5wN_5312CntHzCi4FxpA7ZCuSgz2TZmQNRo8RuTc1LyXQD06HKP63
 7IlBbZB7ZqT4Ok_jKZSq1nsu3FdA.12z66IAbhXEg3T9De7PitZngkVN.eq1BoaBrTULRkpf.dKC
 LhsvHq8W7lbIu2stPmtLtFZ_UIz3uVthmEDpXkbgkeDanNEc1cmW7QmHRAsNkdmVug35JNEk9r5t
 8zn7dVv.FTVQcMRqU3u10yqAPmQbQQ9Nn34Kn.V6B7w.crqdIpQ2_P_GHbn6CdQSgz2CKBdymn6k
 jUlArdrbm4TjldPgqTwC.EbcdUxSrzjc1kD86tXctvmhDkbwRPPruP9hUT7sPJdXkm3h5oQEZadN
 FVU6uH2QvocRV0ork53TicU87H0Q17kfxv1YUudDNiM6wazMeI4MBpjtGiiQ5gM8ynucMQFFAUxj
 Kln1S12udhKk11KnfckQ32o5986TJJLR1qH77AckxcnH1FHt2WIoxM2K5VMNHTOafXvKSBqT5Bxx
 hzU9DDnYEAXgrEf4oiGMztnp1DUEGDsothq_OnnK1M9mWC2__DnMqjYg5_R4o1S_YS9XoBc_cIPf
 BxgKPguLp6024GsiuIWER8sF62LjLUUftyM5bTvjt6gHl7HdNzZyMKsuV4PzsS3UU0elhnTjIdcM
 tLkfqO9rRal4AuA_y34KQaVH25bRHvYUPsTuG8dcuuwvaKRMAit3tkh1_YvJD4xetSW.2OhuLFVc
 cCGzMnbR0o_WOvnyPWal5gXzA6.WGERiB62JAABjtFmHsaVmscJdE8py3F_unRFA0Woc9Xf74f2S
 8Ccd_IiqEdEbiod4Ow4f.qnd0yzi95A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:37:08 +0000
Received: by smtp413.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 82eadaa6441a98443cd5bb4d2b8b5c03;
          Fri, 24 Jul 2020 20:37:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 24 Jul 2020 13:32:07 -0700
Message-Id: <20200724203226.16374-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
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
index 294410533b51..6d403a522918 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -441,7 +441,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1055,7 +1055,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..22e0e7cbefde 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -733,14 +733,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -756,6 +756,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -763,7 +764,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index f9a249a93215..d6d882b1f7d5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1692,9 +1692,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

