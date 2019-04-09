Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B59C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CFC2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tyMD3GTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDITTL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:11 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:43358
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfDITTK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837549; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tyMD3GTbyw/vdCcTM2ieqkO8uwXlmONh83yPKDMNBFGCtTUF3h17j9pgSfHkeG+pLnIOA0MuQu6RIdmmVeippFG0sG97DR9MmthFiZE+Ga2/QepaA+58xzUcTFblNZeOl1hfsJzJrZvvRVzZPvXQOnci0YPkBOxVpMON7mWFtX9rXBt/tI8UeS+/ts8u7f1EETj4Ow0J1FyufHF1Bzie3CE+ZOLy2f84rME/DsPeBhjL5z1OUuadMO4FTNioAEXAaaZflFX6ZskS0BmYwG9izdf8rfS1/0E4TRfd3AqGwBEv9eSOBz65rSOLa/NWuQUfz67wede3y4knhgz+mcJHcA==
X-YMail-OSG: KO0u5AYVM1m5IzRm61hJT081_F82jN2Rl7AqWyjGNDKV6aVxVtA53JiFZpDUadY
 MsLZ0C3UXSV6Ktz8WYKnR4wM20R55hkPLJcQCzQGcVOhcnZ7Kbl1hyJ418RqNuF.aIsXDKVe7fpp
 IqVJ7RdR5ZxEGUr9iyqkmD0BPRteBVeuZL2WzIki2E004wzYllrUePZ8w3KEc4I9D1pZRBW_4eCt
 .9Azwk134piaE5mLHTDwQ3bmrtfOGO1DUpn0b8YaUYGpxDPg1ZQc5KTQV.ru2.tjbKyGhWtfLNUR
 OVO5BczJCYJ8VKCkijUlIXhlRgvLKqq.04iM2Ter5xGKti70Cec5BrctRENo5ExDWpURqVz78alu
 .c0A1v7b1Nq5C7qG1hLJ5_UP5Q7G91c4MI_pNkEffnSQOIrf36No12wj2hU9DutzR205d8suo3Kr
 PZ.wJYODCAuq.kgZ_MkeT_TCXMLbzud1.ntfaxV1dJmZ2YJrHTdmTkH.1FBmn3nUMVpr_bSaLdEt
 G1jmuBtvpmGD08exa0EGWhQktrFWm4crQD2mbO3XK7gHZmqjLvNAdVGkKMU7nVUl2xf4CG2z7Wdi
 E_y0rritRmoiUurcm4AteRdtU8ZGPk45QJ0CCWob4MQa44pTPblyafUfMBHbZqxhRdX_Fsw8LbOv
 4pGGzqhvzw9mbPASKbDUwhduqtvQkJLhmU13_qCG15L8C.azvz.HYhNr9BQOCDwehBimolCzzSkU
 uii9l8xzSoKxyVQ9YZNZDnaj23Lrw18Y0q8E8qT2eTg53WIpPUsQNClOW5QH7dCQ9wLB6h78KEbN
 ZLPWRgbyyWNFNV.C.dtX.fYbG_OvQexWbCs.ZxxpgaEpmgLDz.GeRyqSuj..mIG26JeZBsFxZ0cq
 OOM0aiY57dWKArwzs.FV76ImSpb.pLDQxazwtcjxHurh5mTsSkBRBxJ0gcaCcPc.O.DCSrrqZRjI
 KGxEsRdLm8sa1mzBACf_SLipTA2vzFz6ItdWjBiulvvFrMVYVUpMNAqGj5VJ4O8w.qZPZDrxrWyj
 rjyJimlqkFW4D_gdwI68I7s.zwQqGLtOpA9BZR_aSQt9hwPWYoM9sV4P4p6uLtnGl74UlZpj8OUk
 UrZD_UWdfVA6KFUR5l6i4Y3EInSjnCnGV2kCgwbN0PFKRzPKRXW9psrk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 22/59] LSM: Use lsm_export in security_cred_getsecid
Date:   Tue,  9 Apr 2019 12:18:11 -0700
Message-Id: <20190409191848.1380-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

