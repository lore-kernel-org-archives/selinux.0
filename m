Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D8C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F00B2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MrkrEw8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDIVlp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:45 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:45189
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbfDIVlo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MrkrEw8pm8ttBm05lrJojST2YyevypLstjvJskacrqg6RowijQCix6X522jYQv+CzyDBldvmXR2heJe6FcuY9BApPDd22esSWwFZiYHDVkmaRtC7pfR5LLHdcoE2nJq/B7Y5qXfoCHvdaJyiMqwUEk/eZXf+0iFePoPoZqPJ8w2mRkBgFH6hYOQyFmc8+qDOmS3qQgpzkg34epyHe6Wx+IfBc2z41w6CbxYMh0Oay27Q49JY1Yk1VKWrT5xxd/pgrBTmwYoiaIwevDHhArZ2ouH2ScEVmHZyBcVPJY6/gyPVQlc/20v83D98g1uDdzPF9RvvZTDgJl4Qdjq7pBOATQ==
X-YMail-OSG: 2ArPiaAVM1k.fKMUmDZFpyqx4K54WPCcH9ph144_iuUL5WdmRrABbqhxGv.fE5l
 BFunaQ0XZFErkWVRFmqgBlledbt5i3xSo4Too5L6VNyUkNWdPlwd66glchzewQvB0Pj8tgK5Sdqm
 1rNhggqyOoK0yWtjYIsg_nkf1e3KOJI2Vs7V_Vf2nKychseSQKlRbwBnCFkRjt72R_ib2rLSsHTb
 llasnSR7DZgFmpTlxA7LoH_Vw3QlQzWgZXCK9Yt9OgUzCuEBptc0BTWLLONfVKjSrowjMnFtvevq
 B_uFhOzRMD3YsAWnIMwAdV4A8aafm_LTwp550GiYyML.A9PGLSGsfEp2wKYUqH3WPpc_rm0Wk7XQ
 W3TIF.wXCBKQ__l.cf59irf2tezdJYuMcM6szxqzg_9lkupg_43bQfgWyCuz8i_nJQL6NbTNCPUY
 uv0nbkUbZlt5XUFE58V1HDzRJOdepekR_i1BvWYQw.WK.Mo3jYGwKU_0N_C74JUh2142cibw1pox
 MPbTFMUCdetXrEU174v1MIX.usO3x.qgOAcI2DvtarcRm1_JnSSPy86gKrjLFbIWx0xBRhLHubaj
 NvuvwhRtQketC6_fR5R6_lvbu5StSB1vSFuRkzL_k.Ob_lDEVGkPuw2JGfzXwZjTFiqSwE3NACr.
 RA4JpJ8qraEL.T1byXjq9qNyQ7VfdhhiIqw_hj.tzA6jCJpkmeebOwpN8iIy6bxdn7p_BA5o7mS6
 FjfLeGStLId5wniBuQJTmUeJGC1afTU7mij8HwluOQJV1Z0RrLWAbApgXfF3NLypkb6vxXd6VtMx
 .4y4KP.tRHIOWnvbFxmN62PCFBO0H_sWBZjJKdJN1kf6paZ.T6XBnb0JRdTGXrK5fxnhkF3CQaX7
 Yll_llXqYhUhM.Aj0fyRSBS0phom50AqDqDMpyCeM0Iw7hLLp4.eoURV.wmE4i6ruqlhuii03Ifa
 HrAP9iMD2Mfi0VC_jo71RVw5DuBan4WfOHUQsvOD9.TIxjNcz13gmGzRbFb.vcpyPEmuozx99F.8
 4xtGnf.lXZZ_Rn8Ep_oJnDGzm_2eQEQEwXt53uLtX8iqBpt4oEmfT0i6KE7pqLzN3DFjMT44uB0O
 9K9D15C8MCvipGRe4CIP3e_ijPmUxQf_oPwZG_TL7ZPS7wKTrLCEOYPEeLZen4g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d24739551c480912ea4720c6639d78e;
          Tue, 09 Apr 2019 21:40:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 22/59] LSM: Use lsm_export in security_cred_getsecid
Date:   Tue,  9 Apr 2019 14:39:09 -0700
Message-Id: <20190409213946.1667-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_cred_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          | 2 +-
 security/integrity/ima/ima_main.c | 3 ++-
 security/security.c               | 8 +++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 2d04687c3fa9..40aa7b9f3c83 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -381,7 +381,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l);
 int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1e3cfaf0ee5c..f5efa9ef270d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -374,7 +374,8 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
+	security_cred_getsecid(bprm->cred, &le);
+	lsm_export_secid(&le, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index e12ce930dfd9..69983ad68233 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1604,12 +1604,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-void security_cred_getsecid(const struct cred *c, u32 *secid)
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(cred_getsecid, c, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(cred_getsecid, c, l);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.19.1

