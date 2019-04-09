Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5FAC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE032147C
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mGX5S2C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDIUAS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:18 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33173
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbfDIUAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840015; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mGX5S2C98JaTos0kBIGE03IzSTqe26DPdfCZ6mrhHRD3PcSfF6EgYrqUuxUsksU673rrHbWAkdIJLmmssXj4nsNcbJByVqYv28l8au5tdSctxbL5zTzC87GNv7c+KG9c3D/9o5wmU63ByP9+4vAFoKV+szMA2no/UnzAY1FEY1CWoAwjt9mvYVL0mAwZNYtXp3wl6UZoHSWZ6Z+TMFwvEhhMo/wdniay1gw0Vg2pwygw4ytIA2SZcCRlEpEVDtTN8HY03hdyzNRpGxeBGcASve46/gAxBdq3QF99OxqIUc3bTYuoam/y6Al0HQoVVt8QaMblvu8fn4oHnuJTKsVNKQ==
X-YMail-OSG: 1TYaXM8VM1l0xEvH1WAbuR.vUV59ubYsx4AFhu0AxVVf3IP3OV8ad9vEu8BddRP
 oUwMM7JLLNTdW1lAdi.umf_.ugPGBgP7KPguPUS3WMxKszx79ZmvgZcHZvFsoPUH2KTHWmK5CXN_
 3o.nwzUHtFETpmXfXKdHVvc2xu1J6fdYGjVzFZMDNKcNdy3nqTi2_OZ0E0wJDEq5np5T5lAzT89i
 xRKvr2CHpLb4RRi3ZR9pwk5ReGIOO8sXXaqalsKEWv4w3sWBOhGqfd.zKiQUomZ8yuZeEIWjV5zY
 HcHz8llMubnHpxFSAubQghfqIHD8.kuYvhEJy2dxpLbAMRw.D38rkrGuq3GOZuHSi42Y3j9e2KmS
 273qOiQ6TGOW8wah1MuApEvEJB5eEUUf7R57XtCdKJ7GZDqOpe9fq8FA7yjVssCSazp5ycki9U0_
 sAdd6bqawb5PaTSYAMzsPHVHmvWcKmfxr3tntUzK.sGTsvDfmWyqpKa3o7e1yn6L_lBud0KTkXmw
 Al7D_ZxI8B.MhG4LPrUUalaPOQq4g6w3.bZch9k5SB3PJ2eHXdVSxaPFjL2BuyG8K4j5NPnBQYw8
 Og_hiqRmOHZJ2XystrTolnk6yHW0pcfWLJ5HKA0o_By10Vs40o09qbdZo6.yLtG.ahVvzWHjoj6P
 2NTGQbOhHh11.Iw9F1AQrMSdhtcJeHOUvlnM6zXrEw.QVTuqzv9Fec_63PAxh6ALX1eRmlLw8Ixt
 IjV7fuiWboL9._Xl90pi8m4620lA18o52o41pWVpiR_B9YkzZCm08nd3g_ccO1ZS1lKrM6wnKxC6
 ZitF03zIr78AkovJdCOHZfx7F6.PFKp0yPFJl4b3Js9Qnyx2cQzFDwfv4zzMDJr_WNF1nuiSgeER
 F.aker40YgQayunquOGBf2_6OU3Dl3sovRD600fsTT95Iicgeww5t6sE2x1risbDf8YbukB_6Ar_
 _2j5gpQYiQhzV06PzSUT8bZxdYfoLxAXoT7ZrdEpICA.vLFQFEzsnf873kwMFfhB.e5doRnSjhSC
 V4CbdockqbIoX3nw7Adcjgtuv0rHoGzsmOf2zkYs6BGqaUAnjsNcXPhGSMwRLTn8egj4fQyvdYnv
 jD6yd9ihVsYjTHtvKm0Qz8tmucxm.sg1H7oq77Iz4PdqzJUXIjXyEeLzyhC0z
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24fceb1ba198cd68afe9603a17bf6fc8;
          Tue, 09 Apr 2019 20:00:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 22/59] LSM: Use lsm_export in security_cred_getsecid
Date:   Tue,  9 Apr 2019 12:58:47 -0700
Message-Id: <20190409195924.1509-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

