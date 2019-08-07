Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C0C32754
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D009821EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OYmO7Zv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfHGTpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:45:02 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:38691
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389251AbfHGTpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207100; bh=k9N3chrEZiO+tPYw01Y1AA3KVSgvFnK+7jxWKSFUapg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OYmO7Zv/IJxOO/NomTWl3V17QS+B7P837AWC47muAdRECPfoNmPQ/v1to2xgiT+C6dGAU65Le7YyScUN/i7ZzvGa6PLdpxpz7GfHc5c53DfAZRE+24eJsgxfw4P4iJZFhwCY/Av9U+Me2/g6BTfXIhdZp0TOvgleLgSMVAQLDbiZzmyVNbKeUPP006CCzICkfUr38dBHSNOYylI9RqsPzfqPTm+ZEsjAcPhVKtsjHRLXhN8HAvW5lAlQ7Hngw9/+NQWvRnOLICuwlR9qbSvSP7GoLCCjorLWXLGw6rQ7GdvsHcjOKMdbBWgwvnkCeaixJgbaIIFeInnqkPF6XItNFQ==
X-YMail-OSG: 9PSwafsVM1mhhd921bQdJj_yhbzcKOCpSstPXVzZ6bKi2NJ3IfQ3fUfPzMvTpG7
 EPWQ4Ww90IlpdieWP9LksQuxG7O48OnpajGhcvB8MfXUHHGsvbFDEMmOg0wYA7lNeUM37zmhHlbx
 _U91I.XV3Vezq3091PJMCV5i28G3_nkcz5OhM7upBI9ZNDTMQfaf7Vgt6._sBpZwTzLkCGtV2qn5
 tmlbyYL.YL0VIYV0vHNL0MjHB_TyW3Zw0O3Oo1bQzXrXd2m1dlwYDcpWHlEwHHQR6d_KnhqOFAdD
 R5qQ_QDWMIPkcTKCo2OvLjnkqtItE7cUN6g1EmAlnSSBsEXJloAjS05.qAVrAwLevSADY3B03IAk
 AxIVK8SwX1TLDdads6zjJWHVbu77fpzU93SljNwe2dXgOA588p7DKQhoKCKGyBZUxzlQbLjFZndY
 d.a6yrgsQ1PS_WbMeifE1SOwiB15t52czS7XoqlBO4_djY4iI0xnOaMuVVy81qa2kGidiJLDsb5r
 JRcojG5g1I_A9daxOV0J9FboT0qaQz3WskdsEN.Ii2LJ_jf25xJIVtRudpPAOJu7GSWqopif8ecI
 YsK4kgMm0sKePwoSG_.rQ91FrAVmWXJgsZtAr9puhR8_MUnMndRoGSBbIDdAlT6QGFFvHMnsm42c
 48Gefa2bE2i.Pt720hCA_u614uN4h6zbt5xYUMXnubNbq_5q3wJDxb01.yqEaKHcNAfolwfJU_vX
 gaENdGMwPVKx1OB5IrupPfCphZoix12WAYH_HsRyEVUKKH8xKtn62zxyGk5feJ5EcpD8Dqv6i0L6
 zzZdZ004b9AHJClSVJFRvN6yox9CSl276UbEKZyziSme03Zb6pr3S5RSCzo6nbs88RRAhK2dnCXF
 .FoDv7xG3aCRYPjBhRB9PXa272yLBe3UxqQth6vcgNiIvHqGd6knVy.5FMdbx8lASxbAd580BCWn
 wDWZEsUoGiVWoFE2XuZcUpgrTgBzrx66ifyZL.14tSNZeWWbxcEM930G3Xat.ZZLsFZnhKq9m8rO
 eAuKfzcPGj99U8LV5bjg42m_JjILXHQExHTPq41nsfUJWwTZP9NouWUjgvBjwa_IdkOIbhPuWOh6
 xrOs9Rxd6Z_lkxi59KLGNS8iVM3xOnaqK013aIXuNXOZZB0PgQdAOqCeqGBpI91b8NrD5GP3NR5l
 TPwfHsttCvS_w5DoX3QK6yDhkJOJ9_2rcjuBXlI1RYWSs39cUNYWx2b4EdT7s9c9FnmkDbdOfETT
 vHnCcJFn45794JkUP_hf2zEGM3HmMF8f1MzvlGyUuwnD7LYmpwoAnLAiuXgs9r92lEWWl4n94Skg
 5pMThm9Lncz1C4Zs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:45:00 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 47b71907c10558f94678ade4ae66d1b7;
          Wed, 07 Aug 2019 19:44:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 25/28] LSM: Provide an user space interface for the default display
Date:   Wed,  7 Aug 2019 12:44:07 -0700
Message-Id: <20190807194410.9762-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create /sys/kernel/security/lsm_display_default which contains
the name of the security module used when no display value
has been set.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/inode.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..538a4d6796da 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -321,6 +321,22 @@ static const struct file_operations lsm_ops = {
 	.read = lsm_read,
 	.llseek = generic_file_llseek,
 };
+
+static struct dentry *lsm_display_default_dentry;
+static ssize_t lsm_display_default_read(struct file *filp, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	const char *name = security_lsm_slot_name(0);
+
+	if (name == NULL)
+		return 0;
+	return simple_read_from_buffer(buf, count, ppos, name, strlen(name));
+}
+
+static const struct file_operations lsm_display_default_ops = {
+	.read = lsm_display_default_read,
+	.llseek = generic_file_llseek,
+};
 #endif
 
 static int __init securityfs_init(void)
@@ -337,8 +353,10 @@ static int __init securityfs_init(void)
 		return retval;
 	}
 #ifdef CONFIG_SECURITY
-	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
-						&lsm_ops);
+	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL, &lsm_ops);
+	lsm_display_default_dentry = securityfs_create_file(
+					"lsm_display_default", 0444, NULL,
+					NULL, &lsm_display_default_ops);
 #endif
 	return 0;
 }
-- 
2.20.1

