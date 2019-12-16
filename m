Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5AC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6821739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PJaHbZ8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLPWgu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:36:50 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:41994
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbfLPWgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535808; bh=/tjZqQ3eFg6RGmAZKeaCUxadHu2YVRy2b3KPUAFCwsc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PJaHbZ8H+64R01ajDceePQReC5MIOslfLWuVArp46+t/BkFpnnpsBew6XV3hxBSDttfPckvO9y0EeDt3Gj+0Arh0EL10UYK1uBThU4o5pI2tzaplJyI1EA3z/4bAZDqdKzBfSSM2+sWr42qU0l8yP+t4fpAJLHOfL68ItUaJOu/0CFPDKtZONTTriQMTbHIZXvR1QGeSHbvcj7f50b93D28ZTQK9MATWltVfBxNoPjTON6EAHLkMKZCyTFxwWQRP5FA7YpTbJAYzHn0iGILVJluLBssLRVEqiug6Jp/dNwxp4sJ82m3vdluNcdSzAblL8Cte7tzLFngpKKTRwEpCww==
X-YMail-OSG: EEHHLicVM1nr6pnUbXlAaKLg8P69lKFNIho9QuA1CQG9npgTAWD4hloDaUs1H6h
 dBAcQql_tBtPcC_2_KM0mOqqRy2annbmDAg83GcESTrzebqrn7Puc79cjDVfwopfPMFP_YmYQC65
 QpHKhrs7dGiRF7wP1tEkjvKU5lcoovyEqt5l_7pI6_lbzZlmD6fm.F4e54RHNkzimTmTl6Ia9udp
 S8N6DGToQYb0GSK4WJAOadOaiVKV_CaJcBVbK0YXT1DqoaQLybPU2U4scAzSVVsWQEKX5DI2DyR0
 LZo1__GlJ.voDSwl85x0ntBeH2PZdgbwxL5FKWhnqJmzdaK0j2_eczJouHSa2zu9MMYGQ.hO7oCU
 V0bpSTzn3fq3R.lmt.6Dgq_QVzdI1Eubhv_WZANgIsynTOZzYDmJ43r3fCneNq_J4vXMpWmOP3E5
 ikHfWY3zF2d8o6zGYs82dXVHY608ts_3T1Nxa11YEKJDqM1yc82eREj2fjlLYJpfZNYl3whNzQIl
 ePyxd__2L2DLu07_hIP9HL1.zsQRldvFb7gSUabEm3v5vb0.H2BzoqCAs3bSPp1irH_3Hn8iVGqE
 PQejqJsCqYxTKf1s303x3XUIPBAkjlqkveDQ5UVGKWpyFEiHDX3eLzRwDv1ACr.Sde7aoODEaz0p
 u_8ivMYvQoNnFDsbNd1sAyZr6iiaQ5JJDKhqqbUInoQVq2QHOIi6lGjrCI7D4UaTZM0ClyTrOCXY
 MNvLgnPzanMHnTtdCyIVC_JyN5qYmibUN07GEj6AleKGmcxEHzCPxybtcM5rgb0vfc8vi9WZ0pFv
 JxDstEOSDNjmc_Lr1RQ_1LYxs5LVgRITK0fJFSR96ZYWwCyYocrEUwZ6_n599z8gawYP.RoDfIHn
 GD0OV9t.5E00YvvZMqopjbM07LSNaeUQEmeMkQIhpdM_NQeBnxLgfd061bGIH5fn68jQRd_plcDm
 uppFgIJUI0ecj8IYEUmm_MMHKNR_vPi2BJCae.3GGxme8OuuIARLM3snFfy9yaDyjbbmWLg0Lv9X
 C9Yk6Uja6Xh5E0t7QRwFO8tirp5Jd7_0Oc6duXeImRZcNdwiW8WRWA6Lw_EJglLmEzhr24lazU_f
 kxOar0ZlvCpYZWCHSg53rfH37H1mLXRyS5WktWHC8Eg8viie3HIAacdgsapX3H6fIFBnOQDS4vOf
 4sUcbcigR0PcfHwPtTaab5qXNyeWoj_aPRLbkm6YGtbUmNkYoVRRpyL7nFNxo5JeGR5ttgPV4oeM
 YjM_xked4NRuhSjauBT9QVvQpu.ClRNiEXJW5ihy7PBpdWcqvK.cw2OO7.7A9ODUazliCugLMe4Z
 Cfby3JsUKbDidixREO2nLAR64faNCjpYGQuDbXBF38t4ZWxa4MrLkPV2ILz.ET.DDD9UHmovgU4Z
 sjRB9DQtNjDVH.8_pimOAO_o3HIzmYNUnVBgia9._hhzSsgXHxFf7s2AFgblwsJB1qw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:36:48 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d9d1cdd036ab55d1ad38f3162a989ce6;
          Mon, 16 Dec 2019 22:36:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 16 Dec 2019 14:36:00 -0800
Message-Id: <20191216223621.5127-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index 9c6dbe248eaf..322ed9622819 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1043,7 +1043,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..846ac4b23c16 100644
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
index bfea9739c084..cee032b5ce29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

