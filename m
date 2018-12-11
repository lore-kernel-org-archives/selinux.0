Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A75C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3632820672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="talstdGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3632820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLKWnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:42 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:40507
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbeLKWnm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568221; bh=nX5WCNeB8OL6sK73++PHBplL0xdzgmOCeH2n6KH/tEc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=talstdGDTIzNpdb/6kj6dvbvBT0bG7yEUVMolB6O4CCsrysysN/ZzZsEb3jjPi2SZQ+kqzwD9p3GHtPA3CjeNaNcyYld8HLa6OT78MOkxXsgOUnQ2YqMKVfzd3jYNB7CWVitYre51QBzptQhL2JYbYBDdw+6OykmZT1gIRIiI/LlOtM73Yw76G27AACkT88wbybGOEdPL2kZy3NsRrfxeEajiattGQ3l4OiAGt+cwHfgHl++MSNDP8yGMXu3Wr+MsJBzMw/DLq8EFvDL8X2KtBDvbb5I0UGkwUUYF3E0j3G+9/XxB0Yb/4CVylz5ryU3qWQ2wlyIEFS+1sjf9y01tw==
X-YMail-OSG: X34MAtYVM1mw0hTnuj1CSbNj3v1TQk54TZVx2uZeIF8zUAhPREgzLiqfTIjkFKh
 qq4AxUjhBdJCs24G3za8pbm6aTQMPYuI6rW3_NpeHyA9vdZbwUP81sQgPjgZyl.ln_jBwNVc6WLZ
 3Ehh85vVYqsBF27WBw6LBtZlB8yerjmbFHx0r7b4q7_ORX2HZpcyb.kn0LN3uZ0fKu8UmpnTOWN6
 gtazAmI_lA.sMOTprwzUVpLf5sKFZD0lBVH5IcDFKDF4PgNzOV1BNa_kXV4uQvpQELpr_9viCgSz
 d9SZsZSftCJ1IzCAyxs8MtsWKX8bfpHvbnwcdj_pe_4LUzNwdzcl7QqdpgO2tyznBpmBKo85niSr
 gwlA2mFKEHjdpo8BAX3XtKIL8U91LRe.cFc1bW7U8O7za6no9Svr1CwJ0myStp4K97tmYVtIGHrl
 nPYWxLDg.F8b2jlK.UHn9.DlIfh3g4w3T0gKmcXSh610IrB2YizCJSRvT1D6FwOyyLPCoDU2E4kG
 PfXYgXMnVOa_9i27dMA_HeZk8qcWdtGZpLGs1yiyAkkAC5Z4cPrtpK0oErBmYiACupBUq_GQi8eI
 Wstu6klGItMvc2NQWmveXGwCUU_iWyzUbk3cP30hU7EH5wXUIErb.GCC4eUcIE0_KWfdJQlmRs_n
 M4UNW3ujiZvlzlPePd8jvKDMtn1U2hoH7AVCDQVXijyRQfVs8VusvyllWd4z3jFzw09DZxXCm.1K
 nON8j559audz6c7.gpnCL00ZKsMhAl8ezfEQipkwd2SydhdXcYDh.K5M9NMYWBGvJ7R0HyPbBPB5
 fIiYM9N5IOVGgmK8YUibS5LD0eicPCQJA2XJERbrgJBkwBouq5MZD1Yu1whSWaMd2hdduWcxirZR
 5N72rqa8er8PDtOk59_bAOJiub2UIZNcr5WRyD2Aw58YgnZxzdi8b0E8YIGMeF78mBHePlhFjjkZ
 rFLfJeiYNZu9IdEyzHeiz9oYgy2YNkwsyy9t5vVoZ_Bd.KzqWjh_MotpHKC2PH0jvfxS.bW95z1K
 .mYMnQZVWVWFHqKeESsoYffPLSV_EU6DlY_xhhl2g.RMCTLz7VeDPQhlmEdXmmIq_S.roAZyUJ9z
 bnCpayFcksTJ9d7LIEV0NBYEH5SxWuUBpewBwTsP26rM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 13/38] selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
Date:   Tue, 11 Dec 2018 14:42:49 -0800
Message-Id: <20181211224314.22412-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_SELINUX_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=selinux", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/Kconfig | 15 ---------------
 security/selinux/hooks.c |  5 +----
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..55f032f1fc2d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -22,21 +22,6 @@ config SECURITY_SELINUX_BOOTPARAM
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_SELINUX_BOOTPARAM_VALUE
-	int "NSA SELinux boot parameter default value"
-	depends on SECURITY_SELINUX_BOOTPARAM
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'selinux', which allows SELinux to be disabled at boot.  If this
-	  option is set to 0 (zero), the SELinux kernel parameter will
-	  default to 0, disabling SELinux at bootup.  If this option is
-	  set to 1 (one), the SELinux kernel parameter will default to 1,
-	  enabling SELinux at bootup.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3687599d9d16..edd5b8dd3e56 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,9 +120,8 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
+int selinux_enabled __lsm_ro_after_init = 1;
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
 static int __init selinux_enabled_setup(char *str)
 {
 	unsigned long enabled;
@@ -131,8 +130,6 @@ static int __init selinux_enabled_setup(char *str)
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
 #endif
 
 static unsigned int selinux_checkreqprot_boot =
-- 
2.14.5

