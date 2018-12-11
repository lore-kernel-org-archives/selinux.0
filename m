Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68AC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF5320851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DwEGluDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLKWnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:42 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:38759
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbeLKWnl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568220; bh=a++z2bUg74Xtmo8a+aMA0NUOSVK7svmlbVVJIsC9OCg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DwEGluDT77Omo+R6s/jjW4wD/FSRBNAWD9giQ4ZkVsURZdaqjOQYWwex/oxohw61ZnVd67m8/qTQHz5QdwLVdVUiy8UeaaOJyd1xQ69Tga9gCxF2cypWwFeUrHAnaFTXS4/IJfvxAcBUkoRqApaP4exSS0bPt9Lp2qYnFmj+XByPR1YVbOV9WnvabvMK2uepdK3lAF/17wDwYbu/HwC26SCiMBcwDWDpJsj556P5JvwI/sX2xHvOu+le3eelw6lrEoAZWw7DOt7mcZjQf9fR5JrV7VCsfyL5Wk4LMbB3w6Jbm6CgnhlLqNa8oaI3YOSMFA00oaF1wii7LPYF7CrFBQ==
X-YMail-OSG: .cfjY9QVM1kdj7XDqF8gYjCvTdRL_BB4SG3ip0BrPkZDlwL3F3dwvGoMySs8_0c
 fNNG7VkW_DIMO6_xmaNkOwwDJsDgXgiL5IIxH5WUd9SRGaXBTwEtG2W7yEWZcvbr7dkAV_WFQ1jH
 m7VhR.htBkM8eoBHGOi8nrRt1hJvztqEnRTmlfrv0avr_zgSddf0_yKiIFhPyTcnSnEcGdF3b2BC
 Ojwo_X4Q45Pl5IjIqtAYYXttiI52ad.GIDAiRuQT2VlZLkYKNcKfYPGP1w3sdbpBODx2S0lkTbTa
 NqjiEe_wsaEfVQYIcDEGJ5WxisYsO_O5D90vXFZBWspAGsSSYaxdluBX20pG1cDPIMHxQvQipd6C
 TQ.T_bp5NldHqgCWOe2su29fbe2SVWUqOBFOqcbAIlCkl2JrNqSzBsVj2oi5MdVnLQbTMSiIrqsg
 jWjPDHRmPEEJHlDZjxXYcxv3dcNv4oV4jKMkTY5JRUvRaQeM6Ldw2Nd7r7CTi4BVSqc8efsbA24.
 qpheWWbDiimM7pXtMUhaUleHfSdYDwp99dyczi6ZllYOqkyVfqKStP6F8oyLPgdGF.pua5dEmG2r
 IU71rpRNeWpJ00WZvutsJ85b5roq8nYjSbYjxcI0eLgs2zx487_148VP4NQ9wkRJ56r158WfnQ31
 i4axlw8ehykQKh3kz4Uc8rkjJXX0l1.jk.vzr95NUyqFGAkFUgFcmOretXdvF8UXzWuDDu_7IKqP
 6Cz3JzJ2k_jHGI.brIG5ti4WG5iVGzn.2WXfTAA67gwlOFx7XS0ucE_McWedllAIMvP953LHUdB3
 baRnwVShF0HlyvibazAUFWTBsGjgyhD5h4vAsmX7leyklWLBgaV8U__rtIRbtFb7se7sKStCF73g
 OugWk7FLQjKKmBHL9EMWD8GI.8lj8gtJbzJQUtXqRLFYr5jh55jOkJQIISOyi4Y9Xyg8vNO8NAhg
 nh6TR7chlpvPmluaMgFnXsGx5XnPDuMUJHpHU3ezMKawUVBpI5_L3MCaw3XRfgI87FtC_3Ubpcjn
 MzJC4j4BvGTqKqJ5nfI4RHuypBMxeK6VfJy9Gv46BmFycBtOnZkJ.tTI4nV8CMOxZ9u7xjNxnkMf
 J7lDduow9n4ahlyktamvrEKilpLCMFd2rf1LQpynRBUU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 11/38] LSM: Separate idea of "major" LSM from "exclusive" LSM
Date:   Tue, 11 Dec 2018 14:42:47 -0800
Message-Id: <20181211224314.22412-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In order to both support old "security=" Legacy Major LSM selection, and
handling real exclusivity, this creates LSM_FLAG_EXCLUSIVE and updates
the selection logic to handle them.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    |  2 +-
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 272791fdd26e..7d04a0c32011 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
 struct lsm_info {
 	const char *name;	/* Required. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d840c1ef3e4d..37dafab649b1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1722,7 +1722,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/security.c b/security/security.c
index a7889885585e..0009ef6c83fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -49,6 +49,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)						\
@@ -129,6 +130,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
 	return true;
 }
 
@@ -144,6 +151,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		int ret;
 
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive chosen: %s\n", lsm->name);
+		}
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b81239a09dbb..3687599d9d16 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7199,7 +7199,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 56a114c1d750..849426ac6a6c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4888,6 +4888,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a46f6bc1e97c..daff7d7897ad 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,6 +550,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 };
-- 
2.14.5

