Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9877C28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E10243C7
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="b2lE4dr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFBQw2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:28 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:43025 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbfFBQw2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494347; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=b2lE4dr+Q14NzwuX65FI+K0VFVCfB5mWEdMlBBIXayfvtxLNXohQllbmC7m47iDJis4t09i4zmRe5EDtQBFy5BQWvC4XK9DFLlWAQM0fsyzk1hYUEGH7YZc0vfyHzjl7gu/KVConH7ZR3Gu2eKZL0JyxL3KGBn1TQQ6PNr9fvTG3ZQWwEo0KF8GW6mTZnIKH7zqYoGB2QJ++lWkVKtp5CrLLBxMVp1SZQJffWI5pptB/Szb9ujgIe1UePBwbha3uLvXleDo+ZSGol45aRMpoO89rbgdnely94kP/RtFj0uUPEEgvvz7yg1t6RYIKedH23xKYzx0pFQzY8B3jOXQaEA==
X-YMail-OSG: qqeJGaYVM1mE.zRqwBtPCTnpFdW8duBtY2n61MTVjHPXYEYee10QXEmWksl52Gl
 1o.U.s6BbIU9swYVcA3oJkQnaEflMu_wyALu4zOPBrp.5Q0CXkI4rChKWczRmOHt9Gx3rvuQaTtu
 y2zdejHsTtUgVhFdKyCnob04NxJgRI5GmtOtVunYyQo9dR5DiUXo4l3rzVxXRLwzc5n9fsjFwzoe
 rwu2JM159vg5zfpN2OE6irgsDSN0LgcvUv2Q6eS2vzKEtOB2iWYaxkNuz4ZWMPUuO4WyvGDtXVA7
 sSPY12VNRn8B.rMPfZ1E7.RNAU_3umW3j.SaC8dzkbgyp7A5JTuyTHlveoi7NC_n7HbqweQPPBLU
 6qW7pFvVGMaRpOs1VawO0kLwM96YgVD6EaZ.JZiqpogSIGo0kAF2k.xiebT2AjpGbWDeE9N2f0Cc
 e6Y2UlBa5Q5dn28qYp2sEv8eWlqZ2QsiP9vIIM2us6kBxiOQrYijsz7f44.jZSU5SDB5NJxdTJ8r
 ZFC8bGb6O_HENysDpBp1a4liOwMdEmRDO2WC.sSUUj33DGoVDqtSHUCroIW.kjPUijzpheOy5A.D
 XRZx_vhy9JpCYe_7AOVoeWEcgDHaAsjLOlfqR7n7gmcvncqR_HtfDktVayhs4dDdbq03mpQOJvZd
 M_U31Ha0bWBBQ_vkCJhuzdngBeJU8iyhiK4GTMrc5_L1VDop27sr5p_vfH1NsTl8mTPm08gc1dqw
 N5Cg8wy.wenTxQQoYuh.ACGQHONshwqHspdMCzzhmxH9N3fYjJgBSbPMnJMXG8yDcgxHRw77Ingk
 IQFrBKM_HNWR6Mxri7vMCe9ciYZwzxMCTwTlxjYTZtAhGfEVzg8jR82rFXL3a54AJiwmYs1jXYZx
 WcGBBr1meuiuI4I2a8ADEZx4IeDuvbvYE_OEJHpX7DLg_AT18Vkmv19AeO4M4_5xySOc2PsqcT5C
 fidgd8sUhRNEBpGtruKUS07fkR7mpoLc3AHcnblvghYGaGra.RQxXVazYDyzQqln4dW1OAtVTooL
 kkxyoD47h78UkoMFVMGOdLkRczw0sZgFYqaxczjw5nYcZGyPeXQiM_6hD6Yo2n07lciy.O.E3vGc
 Sj26dmvf26lzZOvf1.EdE1j5rIPwWB8gEFHy4tpVuPq.0rzRrjpDDGsmC_1niFi.t1YNyxBdDV8L
 KzBsk6s7yuqSYBWEfQyHcEJ8zK6Y2GHgPwMuIT9MwkBhGYrfe0lNvHFZZVyIR.OrYvOIG6po2X1d
 OdqYBIq8ULVQZqCEo9IEmjg94Pj2TYrbqB9jGapjhV6umC5P_XLGB_XLA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0b498552947f6b5133c1cce9fc77f09;
          Sun, 02 Jun 2019 16:52:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 21/58] LSM: Use lsm_export in security_cred_getsecid
Date:   Sun,  2 Jun 2019 09:50:24 -0700
Message-Id: <20190602165101.25079-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

