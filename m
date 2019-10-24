Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0574ACA9EBC
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DC321A4C
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VzQ5rtWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfJXUxQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:16 -0400
Received: from sonic303-31.consmr.mail.gq1.yahoo.com ([98.137.64.212]:46314
        "EHLO sonic303-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbfJXUxP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950394; bh=CCN60CwQwbfIZPCY4wMAqtbUR9OPypM+nFfLfEcrWEQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VzQ5rtWttyvMY1FY7OprM7/EZJDd4mOKTaIYMXRQy3Ll7qOWP+frCYf8Z3QXkr3dVCg3jtWbmjR7K7bL3rGzcBoxNUQgXcff2QHxsI98HpROqhio9CAgwGhMt6S+K/hKgZeWHlrOowJFbGK5HP3VXA7f7O0tSku8zAqWy0lsytNU9RZYs3Zr1BO+g8TZNMopJ8aTumBz02Zz3qAW9FskPGU0pzLORr/fh9aVD8vnsyGNCsAwjwTNEENgNlBRBpl8pz1FYIl4h4kYE+wSXKd3cEbr6xjUlt8pvS2rWTWS9NlquXFeXY8QKggrbn9f+aQlPnxymD+xUhFMw4p7EMoGOQ==
X-YMail-OSG: .sU.8PUVM1niVMXOtXJItBel.X.KzRDhrKFp7NkzC6VXzvPJiBtSLe0w0LtCCdm
 6HP9Ur98E259cgSiM4FInzVssyt9ITdIq3.JEk1_Synt4KJrX4IM.ET0_yr8of2Iha0vGKFgxM9_
 yc42pfpgGRT35knitFgQCGA9MAYY1fXrqgOy8B2NUTjuQmgnZUE4x1hYIw7lozEyikfAnf_wPZ_I
 a3qiKqx4peua3P8QKQz.17mDVa.bpMdRmpJEpuSkDEKAWVo4h7YH9_sbqL6bPI9PxtklovJkGN2W
 63H6Yuf.HOttBttKBQokwpcUaMXnK6qWrD1iwQTqd_2q8i3MxGGyiP5WxnhFIzf3uHaZyOF1NDhj
 VhRjhRJ3Noy7A4pAwp6kJTiTvfXepKXztDuoly4zTwLZsR7j1yTxYQl5Q3yMbLpEt7KUraDYK4Gi
 S5w_aCVRNE.odqFBSOQ3bswPqnbc8WmcpgUA6lF6xh1zIV3g27UiOUCe6F2odx7fgpviTofAZelT
 f34LtIXdNFNF0FGV4QSXPXR_zNvFJF8RA2gl8OwP9ryRpwpoliIHGvrEySJ6iltCumTplj6TvmAC
 zYSaKWFEWn0jz84A3zBrfc6QxaiaPV6BTBsNQefIMFAGJt3wbHS7KA209QE4i5wgHRLTQazgU2pV
 sSpjsfzL9Tg5U6rrHWuo3QbU8Ol7mTbjDFOPK6nBLWqcVopCIbyuX7hKlX1PerAIhm9e2zBfFGQD
 NwcFFCNHknK_pqsZo1V8jOFguQceXg5YsyapfPDWiUVm.1cYQXT3ORVghRxkCmq9QnnMxllhg0SQ
 yaGSBJwyAgJk2E2AP7Ez27FyMWiOlMZfHvWC_7gbFOwFKkTI830PGf6WZ_7IkEGSWYBwqdTuFFYb
 2KTRYekDK9WrREQybx4IUYcCB.sDUYEsLCRjuk6SvWyjeLZ_dvO1yY23Gk5.B3nWB.gAHo9uV4z6
 9StmcrNfJ.J54y73ddQ0DCyxZ9TlDTLeWUZcBV4zpB5tBIOuwtyV3uaAWy47_sk9geHDk.UstakA
 GWV6x_YI.3NTZlJx_uDMQYnAfqCV9AJtgOkqonipvy2phVIq28.SLNtv.rakDzdCF71rdu3yjj0R
 KdAwX_3R04p3WvZ0tmhRbF1XJfrKWu1fjDtvRjXS52SqkvDJdtr739.GtQSLoYz2.Idkrd7AXdEF
 zCK8RZ1QWgzrut28agK2hgayVd.kPCjIBt65c3dTT4NTbPidlpeK4uilUzDBXjeK4A.aZcFaXtZb
 g4q59.ua8y.yK9iRJRIcxEuZIJiyFfX8eZUuNoYrb7hfNy0fuJjAJxrC85PDLhtU.Ix9sKMis7JB
 p_HP3kWYu3hDyfnkXq5o_mdKya7dDnD_WjpkbGxopg3kDcMpLrmeOPZJIzegHxQrVFeE8S0nDX_5
 dVTekM8gA3O65WSJbdfs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:14 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5303e37f81df37f0f883923f3f0a8567;
          Thu, 24 Oct 2019 20:53:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 24 Oct 2019 13:52:07 -0700
Message-Id: <20191024205228.6922-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..9a21c376ed97 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
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
index c22fa5bfaad8..cd09e7b1df9f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -380,7 +380,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -963,7 +963,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..71c14dda107e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 8fd5c8cd4f50..7879da7025d2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1566,9 +1566,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.20.1

