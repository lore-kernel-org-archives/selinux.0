Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A2C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E820672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="glhjHjo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLKWnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:42 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:43583
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbeLKWnl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568220; bh=4hwChtAwttRCpgqq8AqfChSxmv0QZcRu2QJKKXrAwIA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=glhjHjo976eP0Oexs/4TJVl02MqDYbeDweS4LVwn1YOF8UHetfazBcD5vQROhnoK0Y5yx7cWbxNvYKCTbJ+YlCCLw+ISzX0sVcQKwe0Jtdny44d0uIVPDkCnSHK11GZoVFzQEaQtDwQt9XQ+RHo/Ul2r0oADd9+naq3KoZofXfbL/MR6aGXpYl1FpImsOUitlqdZv2sXdeyc66dwQzKV+4k2Ecv64KxZqhrXhQCjXXZ5z07r/89r+s+gsl5ksb4Z2WOkIw4p8QjCioRd0jwbzGAU+CMCB931X7AqlIsoU2W4M6p2tSrLC4uBEwzNgPsp4rVB1Q2LnSXFUiPv9pbMyg==
X-YMail-OSG: 8M.vqnsVM1mwZqd3mYAwTrAjXYNin4XtXIKd3C_vJ0lAYkLY1sqcRB.fb_G3hS6
 o530P5Dxuwb9DE2n4510CKvwF5Si_PDK2tl5S1B5inC95pNgLn3KJ7kXqUq.uc8AIohUDfcDiO7y
 yePVKY4mAI_C20uBdcwy5OYFntzRMG2Rj10gXBQ1NFhsKMKodluB7jDyM5u5Ao4668B6K4hVr0FS
 ygQe41N3XNImftxLYBCxB5faIbWqH6UFtgQTvMe4e26w9F9X0uNLRpXBn4OXXbPHLI4tEkJt.ZV6
 _B5n.umm8rcxfUIicxO.Ru56oZdgdYT1b5KMAJ230ZA5Qj0pAX4uMLZSwzAO..hHmqPtfgovAB9p
 wyL2FEOXxP0HDeFDFo8VvAak2orqrGlaHJ9p6ZuVJBUINf1BHQVCY_Dpe81qY52zKIou98nvub6s
 .fxIxsNB4BEnSE4A7tkCo.sSkt_YitYW7v3rsOc3PYGqSGeOOCJ2kt4pxGJKD_eIV4Ft70yRZLpY
 VjjnjttC.F3yOduRggI4qEMbFOTkiTxsj1oGDzLhx1rnzB.BfkY3SO1OGkbVi8cYxeUTy1Lk1Pp2
 _3_vSfZRXYXs6oSMasDQSdvKK8Gm4BSoKWiAT1OOjvgGRCU3kbpwAuvNIYPJbJ8oyV78q1TZSkvn
 Iz7iaSh5sxXwTub8n_MBOQll_KV21uqRw9RscJU5h9gimLcW1IP_A4MaD5CNUaUdaBejROXMH9XX
 uWY2S8iQcCIewwRE92ceCqS.FOG1_UukQYXfoD.digiZXJ1e3yOXbS1Br4DrQBOKzzJi6JfBrEAs
 LPcrCNnQpgrheI61_yM24z6tTuGGCCym.XaPw_3pMie36Kl.DRC8J3xMPKtf8ru4po5_bV5pooFo
 iV15UDNOcIVzGt8mzhDybnA2ue7Cpink_qYWPlILh3gL9pGoHEYQi.m7kMpZxUmprr9lJWg6wlET
 ceJg_V1SOzcl4wLypcWEM1bLDJY.0Nv5IOFOfCTN0_WDqnQNOdfoUQai5ChaZwGlQlTxe_do2AgW
 n1_6aKybczalc4XIPGP0dEnFngmuzIJHiYT4f6TCWGYnZKtrBFmePOp5KvsG0L1UnPU0s4t7FyFl
 z9BU2UEsmIZFRErdMiR1UWNhRIyYtZ.6Ch4SuNA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 12/38] apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
Date:   Tue, 11 Dec 2018 14:42:48 -0800
Message-Id: <20181211224314.22412-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_APPARMOR_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=apparmor", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/Kconfig | 16 ----------------
 security/apparmor/lsm.c   |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 37dafab649b1..e8b40008d58c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1332,7 +1332,7 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static int apparmor_enabled __lsm_ro_after_init = 1;
 module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
-- 
2.14.5

