Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8FC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E31A2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="skNT3rN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDIUAp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:45 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:33486
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfDIUAp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840044; bh=vbPmsKchcYujFbsoTOZdCYFpnfZ1qp/ZBXWOn5HufTo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=skNT3rN5PMNY75+Sb+FkJeoRhwGSO1L1kQqu0GbTWCAT9rxUf6s0aRHFZBOtL4S0hSVZEDQR4xPi5T+2tvkCr6y7A5O6NejDyo/ynD6ROi/2SpglNg7AcouVDtEGCm2mceaMnhBKwgP/4vWx1tB4fD5v8s9fzsI+J5n/V7LbB7cSJSCNBn7wdY+dDuNUThskRNMmQQw+0MSuS0OAsW9VtsEyce7CjkteBY/9P7OsS4ZUfY9YX/QlORQAQ7L9hlPk2wp//V01jiyaQOXn7z7Xi9DWgIkHJvxY1NVZEPVn4peJrlu5ltkLcdZykkGodUtJqMriKuIEEE4TnX/JwjFHTg==
X-YMail-OSG: 0UsiTCMVM1klbjG04S0zcQ.5UCfJxo4Rpfobx08qOPiu0gHEImzI6jB88tKywXn
 rdknZ0EWEQmMByB_zOyy33ss_EcL5QnDbKhxZ7Oq5WbGgLEh44ZW9mkmMEbS2qsHFLgDGZvTtVTe
 JZD1MF0WxzpRW6ZF3JciVJmabqZsrKiKq6Z5XsAkUAXTGrUfugXmccRpLUivzGo9m3p2gg3kiyGm
 euvR8frLkwtj5xXHM0zCSejDPsWaD7UbI87HoZA44DZr1VH5Wo97OugpSUyqQFK976w19TNWxete
 ORWyg..wWNmefRrKHfl1bcjXebCCIKZmu.qLq7iLS8JachHZAXAH1HCF9rHMeSbVJjteIDrHVvRJ
 5rSYKj0ri6Q8Gt.6VvsqYyAar9KsP.tjiYWIFbABFKUl_9Nc7JRDwZpQo4KrFlY.pXVFf12HJz_E
 T1fuC1Fy8fh3oOm5HpQxbJ7qOrrMO90gD7Q8smrizwly_gR9R7whBitoIxu3USKxWQVp.itPHhqI
 hGQXXZpQzhXI4VTTbTZUEsuFhvZOmgv1RQsE_r2S47I6xgW_FTYiC9w7suM1A_ohwo1DLd00fA5w
 NJjc9gJ4jddOGan0CQNEhx2oBLfF3mt0qKqG.GN192NLbJXHP5gI3oWm_CeDbRFjARChZkmFYNJy
 16qU_HQl58ZpDOKu4ca.aLd.ucUYnIloRhuJ91w3DXcRWy_9CU51IGS3JFEVf_CFcVFPDvanWpyx
 O88wNG2m7OJ4fa55oHVVrVlwBGtpD7WZdCuZ6TkWuuVevLQ2lWz3b2_G4.Wu9kFq28ZVUBC3uZWy
 THsp9v_FZdsfKIrgU1Fq2xVowZklOZh3G9OQd3mX6lbdYVPqsLXBIxbnDmfcLgGy4QD7CLeyBbww
 r9ZKNC9M75zMCTQoExg_0UADWj6hUEclprHOANVY8ojrIHWJS3vMkCXyaPRo6FDl8KWbR4HfncCm
 5ieMljmaSfB5wU0xFiMlcX._deCb5CVSQBOoFzkp.6j4w7Waq0G88NpH42C_F40nPU8Pa7TWXr6s
 YXYqqXLOAlF3cXCu9TI7Eo_KqAXJ138Qk0Z3gckaNxxKN7vO6dPDipCbV7Vb0fC8gtIanDESQV6S
 AOxwtItoQSSvJYulxqPKk4Sb7W9.npcqel.mxjlqwB0Zy5xwxnOjz1VCXbm0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 37/59] LSM: Create a data structure for a security context
Date:   Tue,  9 Apr 2019 12:59:02 -0700
Message-Id: <20190409195924.1509-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A "security context" is the text representation of
the information used by LSMs. This provides a structure
so that the use can be made consistant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6c44aca19c65..8dd21133ede8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
+/* Text representation of LSM specific security information - a "context" */
+struct lsm_context {
+	char	*context;
+	u32	len;
+};
+
+static inline void lsm_context_init(struct lsm_context *cp)
+{
+	memset(cp, 0, sizeof(*cp));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

