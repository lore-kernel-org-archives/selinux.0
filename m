Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A9C10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7E2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FRWmnv8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfB1WTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:52 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:36383
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729473AbfB1WTv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=4mpagIDXm11/iyGeFHwFTRusBEV7uw7XCGP/FLtH+mg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FRWmnv8cbK6rKBYQg/zbSVJ/CIwzcqpophMLQXUf7cmLUIOE1v1x0P3mxLUC7NNwSXGm8/a22Ztr+gLxauUgcuBj0fA4N1jrG5SXskFygmnBBtgszHvuNdDxlG8uU1BO55SdOLTnLvzC5J7n8A7/nyqIA2R+3xzcrjr3sDhn/MqfrjdGjGr63eWCxiuWntdA2CYQE/vbVuJb7aCHI/lAE3rHASbT7cSh3z3bAkr3lsehq/CpKq/RZ+/L03Y8/u10zhzsG+XHDhDNX/wkYwyMm6zFuvBqOYaeVCddXKrBiQ51ew/fGW6kIxrMJw3l/4VgA+NFlFQxPJGPW9HlfdC1gg==
X-YMail-OSG: AoMkOqkVM1kZ_FqKo3AF.HxLzXVMn7TgS8f4qhGRvvx8x9ZbVZZg3uKtio_H7Rj
 FN8eUqFRIoRpnaVBAwOVqoiY8VBC2w0ogIKl3itZYMlVQh9KekYz9CAjjblNMgoSwiN1yhK5gliv
 KbYB2cbEF91QKrbzaqwNzLNND7pq0jitFF.U40drmQ1KBK.qI1PrM5ulYaTCDkZjiAW0pZ_YJ567
 iKlFHmpiGUYmlU4eR1fu.kqoR7OWPFn4hC7TOZiHKQsl7URpvagfWvWbKFg.gV82Jlcmz3o.rOu8
 DFDqz2oz4uYT8BGCVJKPngXH_Rr25lM6e1xLxU_mL.NSiumjFnkTHHM2ThsJXgi8YvG6ow39V54S
 Ci0AnLHPjbBrVqSsmJ4RKhgg3LJmeVt7lNbGj83TjibRh4wn84WWazyPmj77MObcnOz9kpp4vy9J
 IU5mbkKmf485OT5ZPkhu_yeExl5xJH73C_lE1oI4nbmqZWMzMUzmv5lebUApOQF8XaigsxlGdv5c
 3WKtfEZWsmx6OwcGTFXN3k7qk3AgmttSCyDj37AOhHGZ_JRKW1nnm0M46ypyp1jW_hwRMkw3swTa
 jdDsLcsgDcjyxUT4WnFaIeBNMLyc3SM1m0RtrOV8i0ePF9OijNo5GkqBGrVWSJOwWk.rHMJx.srX
 3NgkyPcAUDWwEJnfjz9kM.lXpNldtxl1vsWtzg3SQR3D1d5YMcqt_0wv5_0TIpfnDvoW.kw7gRJY
 7ZDOXvvSlB8nJmujVlIVaUe5ZjvLTAnM.KWnGuoNXLlJQ6ANt_TE5jRGylbSKh4Co0XtSd4KdDoR
 _8A_6P8zqY5h15qAHyd2GDiqfp5lC7a21NXeJoV_Qp28FRyfOTH6FDfaQmKPVwbzdhBhPLGT9ATt
 T6tvRH7eqYkxIpgqHSpzs5b2qzBojHNpC4h6Nwj6lxrd0Yazq5XNZ9Zna3FLAE.RYNxGeg8MUzK2
 _ZiU4g2T.Z1YdUbHkbgCg_BxHJsAL_Nr7El2qWPzt9rEXg5EL7EaI02_Cj7ec8vnhvmZ7072Og2V
 fLQLbGQ1lIWgaq5uPj_a0eKBdA7IZgIMfQ6phJf3ABfbmMQpwdTKwhrpq4QUPyVAbecDp5BAicrA
 ZiIzNspl1.fzEIkb.SCkaTvVmecpA9fmRQ4oAAZKq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 05/97] LSM: Create an lsm_export data structure.
Date:   Thu, 28 Feb 2019 14:18:01 -0800
Message-Id: <20190228221933.2551-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 13537a49ae97..a79fe8ef9d84 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -73,6 +73,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.17.0

