Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C0C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425D20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Nd3+0tmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0425D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLKWsG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:48:06 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:43862
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbeLKWnb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568210; bh=JvRH+2Ag1ZV3gWKymKYx9zUOfLPMULIq3qNH78/+H6A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Nd3+0tmLcQUq8I/hJ3B4D69oTyIuAJc1frE2Z5Fkg0WkGdpOqHn2ydwge0wfNl1wXb2UkPg99QIrVY4MQmopyl2F6rmAUuZNoevb9i7Z9fK1mOQ58NfidHxppsSL1zEohbmLzd1zvsN6jDfOpipsUzuYtmDjRjFBt1GGVoZt3Ylr852fNXw+4rEGGwgWtRRBNbSVqUHJfqtyqinjnw1K+f3nF2LF8O1PXLHAMP75LcEACeRWHmbWk+74l8TJTgD1tZ+C6gDDqmFdzYlJ5sqz1dKMi6W/jXeRScZSkBg1zyBWEnTYGMaAymZCVLNdJqyhAXzm7ja+ndeq/WToqRGXsw==
X-YMail-OSG: Ws_x4WEVM1md3a3ZVahzQ.cZKQbFH3vUYvf9a1Es9hPfCmiPSVpISgEtgnxNG9P
 UzuIn31bU4I8ocS0AyEfm5QECsBfFq_YsTmfd5F34OzJqMMOzHrYD.Ga7GxrHWQgVXTApzJMUaJR
 xY9eV7I72qkEV9YodXm_j7wiQNvUYbXKrXkaezzCCUMrUtVJYzTBVCq10Cf05K0YtpQhVLIoAaAi
 JasRTq_GwhE_m4sgZpSaQIOdu5DJYkRhx8QChmOx3laN409eKtofnhR9QFEkEGv0PpDn3Kns0PCE
 oOYH_eEXahbEXyVj0Xm9Bp7VYN6tB_RA105MZCPHU5Z_hNDr5JoYt6dwG0Ppan0JS7N1VWQIX2yi
 Rrlinm1nNYZzhOFyg1jIV8AQtCcGsMAGkAVRHM9SBTT0io5Q3wGEFSUm0_mde5KOWAIlvzTKjR.z
 pc29eQ5.J6Xv7lhGJV9Z9LPMb446tByFHHliDQPC2qbmsd1JzfdRi.3ynkKngJNejgsyYNicKf86
 smomV0c0mANqnA6B09Bhcx_Z5YNop9HUKvwDC992iSOVWLgkI_dCPPsx9XZlZajhq8WvV_XjwugH
 Ppw.HtKd.Wpq3yPjPzem8n0FdaCWITNa7rcarYhTv9WwE2p7W8bubQbzy_4hTsp8Pr8gh95MDg.v
 dT.I7KSZsT_NKNHgv9ZKMdZVdQ9zRZpqzbJUBOgc0bCFqlKpxa51EcfUoN7Ddc_MbDtwykzh8_Mo
 9.g5UpfXsiQKs5TEAg_S5nI_JGBHnyJURIQpo54KmqWxQHjxJ8ggauua55vHc5GjJYk6Ssk6AiIN
 SIjGjx48YgrrNiJO12ubPcieNUcYhWlCbEEfnzVQHcJnzChYd.EqjnyyXnRVwNnRlQkBymJ50jnA
 IpQVKLflseeubdSJDdz.FWkFgkQHDsvnHqjBEBY_cGLlYpXxkDKi2DW0dfOSqs0n1z7CvWr2oB32
 ULMLoaCjmKi35hkxavT_uAIUcjYFQbn_suTsps7tlgCJhLs0KZqpYThbUHmrzUT.PB5QhTHxkJhs
 jxJxukexkfqxfN13FBEpYXtBlNBvkbdimNCAOBuSvylZCjBiisHCDuWF_PylD1zpklPVmvaBjF6U
 Xzz9K68hL03fB6eXJ_bOf0SDyZ1IkWVqI_opaTQdp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 03/38] LSM: Plumb visibility into optional "enabled" state
Date:   Tue, 11 Dec 2018 14:42:39 -0800
Message-Id: <20181211224314.22412-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This should be an "int" to include
handling any future cases where "enabled" is exposed via sysctl which
has no "bool" type.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 63c0e102de20..4e2e9cdf78c6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
+	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2edd35ca5044..127a540ef63a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1332,8 +1332,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1729,5 +1729,6 @@ static int __init apparmor_init(void)
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 56c6f1849c80..efc0ac1b5019 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7210,6 +7210,7 @@ void selinux_complete_init(void)
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
 
-- 
2.14.5

