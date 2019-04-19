Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B2C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628F721736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JXooOy0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDSArO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:14 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:40081 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfDSArO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634833; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JXooOy0Gjmy9yTqmkwjpTcIMSphpchQMXDSGcYKHkeUAgS3I2kGez0Eq3mVQqWCqLS1SsjaBt49yE4yeev5th4l1zxtVC0JljbjnKtLRSqj41Tgf0C7mIsYnFqevc79xRzfSdQPzhHTUmtmpEMurxoWbUC/2uZYL7xExJk4Kkj8YxYpyO9CTQ5ImotkG25NgxEOCLUXNxwxD24XZVoqIbvmidjaq6hntsFrdndYIzTFDw3ZQvTF3/uftDC9Avh5HmZ7jwrYA73W20hnpUxC4SlZSMwT5yBZswYfMYwaHbOXeHRzfyhDH2/qAH0gXUx6qd3Y1fS/460L1xTg7B0yNsQ==
X-YMail-OSG: x3R.wYYVM1lkhlXgxIjbdJSorU2yQGdavVal31jPljQTGintexuqlZVq5zcEkgA
 EfuB4gVFe.vzwm6MCNimRR8YHYX1dRAst9sQe5k1Lx_FZ6c94bLR1fSJHpjZb8NU5paNgDv2uSvR
 .hggxflOWbNEbueO2BhozPXEMcJ2kC1_z8xvpEdD0lCHR66QJeeLxdnx0KyOiXAyyBgfuYKWeak6
 PhYKh8OAoHWCSw67U0fYrVUvThvz9H5RYl6C.9OpuRQDzHLX4i6We7i7xc_nRNgrM30RJvI2tJXn
 YM5q1tmw8p.zlQskrpKrRVsOYhBTlE4tKS7DBgI6ko81T5tl7HIHaVZDPM0HjoniAhr.dGuuOOrT
 uUED.L4.y0wamrEvPiziHJTEjup53vWttFSZctjvXJmAiaZe5M_D009IpzCVQJUAEaFbtIw3OLk_
 Elc3rPvGwfVbs4FDT88qq_zb8HLQRAsDRAx1oWWVtcssDoRpr1SrIdJLiDK9Dh4Feabj6Dq7O6A6
 2uDiEerwVzz.pV1Tn3jkrWQhf2Mz4MSjbQ_QQzTWGfE.sbdxsZdVev1cut3Zhg8JcP77_4pxPh0n
 nUUe2sDGR1Pt7RIBDolLZHE1jDB5LhNJds87xmoD.6pTNVNjs8ANiCcANdzR26quute.vKIv04aV
 4mTCLv.THZ9BfThypoLb_rr.qwxozeQb34chyu.F3QsOxmo5GHYcAtzOMf01wb2ZQJjm8VwbMxpQ
 uhw03YK4HJHecKcAdAlR0BuGW3rMQjsiLV9R49lYRakvYVTZWWzQODRWiUoRGtVJf7GjeNyvIUsW
 BQwVCenuxvyM1muEiykCagWxaJFO8qG5Ku076fk4aMbDVF4ieB4Yl7gMUlDzD35LMQFwkzqhIyjH
 3KQdevHo7kglTYvwjxWZVlIlwmDcpLt5suTcycCJNPgnrET5DkbKwkUfZNjvX8d8ZunM9Y6SgniC
 OhUcsuxbZFzZ8Sa.mSIfGw3j_mPnDm.t4avjEuOBuH3TzwzTdMjEP_5OnOeGdI65oZoSJTyu0zdr
 iWeRSnkAIZl.YODAbcmZKr4gdrXuavQHqtHs.NMM8M8.X73sV_P4ubsBpnXbc4mnng2_epjHz719
 JZkq2Ce.y00EebCBo3rGPeNqX4pz1v2tq2TkymOjHFWdsmRyBJ.sZ_aSRznOY2pA8f3aU9AHeROb
 6mwwpK5K9yQAc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b98cff5dd7fb51e7c7719cd11eecc1a;
          Fri, 19 Apr 2019 00:47:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 22/90] LSM: Use lsm_export in security_cred_getsecid
Date:   Thu, 18 Apr 2019 17:45:09 -0700
Message-Id: <20190419004617.64627-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

