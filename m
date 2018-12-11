Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B5C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F220672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eRQFQuGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490F220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLKWsV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:48:21 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:35310
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbeLKWn1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568206; bh=ieQHIxYO98CPw1EUXfmqp0bOZIm9J19Fh09JZ7LQgB8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eRQFQuGcyZghqdupBpXYiPgrqB+y2vGEcArRJGqskEbjVg24wOGTR6fW6P2yYuV0oPpjbtmWm+oMPErb+pcVkNWpWwvvf+VcOUTWyuNRvbpdXMzDVLeGWSZZZOU+9+E0rvVp9ma4ZLQZusgE5KmZ3A7cb5MDyQf4kLtE+1uAz1paX/gbO9De7VzD1Cs4zRAcjZgJQ/pdBWH6mDb8IBl2/zsdLejKH7MI91IGEpvTYmYbvWidCP5qnTaFL21mUKGTzkGtJbOspE3KXDOQHQWG2/jDkxt6eLHb64iCto/Tj3Xpb5z6J0nXls6tqZsqJWVHTJ3ssqAwsHviienEQhnC4Q==
X-YMail-OSG: ENYqozwVM1lH_QwafVp2OrogqWa4lElzn3.grfBT4mdAEvBn32aHIuTdGOLrBv2
 hFSsYX7F6zsb.Qly35jADevDun.jtC17NDkcjO8qFIJlInKgpBY4RwAfpYfoFbYWzSLENuLMIZLO
 ONxz7dgKik3Iag1A5K_i0aqCvvQvYY_vsW2RcSPWraKT_11Y2VAAq5Sv8SLVK2tqo.o6WVRPwGAe
 enm5IupFBDLq4j.EQ25udNUN0tt0JRlTXutuY_0Ob8yRBLuVSx9TfbgqaNF9Mc_5cQV5TZscA_dn
 gCyPF8JgFKM9EN6PDZXykIr5gIyiUpFtqqzIpRFzEDtVhDAy5mIoHJTCx2WmYS4kWtV3sOf0ALqq
 0JzVAJKaBEyFixeHbU8aWLeNvEU8QLzAgW3UwbaFJ.50iZL42HL0kNZJbWYgEIkvqwGeBt6KGtB5
 JChfxxa21_LXV7AQPHAg_VXzCWdL4iqWpZDZQg7kqkqd3lsMzYlp9yKaXtQzov_RwUiy.F_ewe2v
 gNKyhGXO6WHrHH0phNT1hJew07LP1_e3R5UueOvEe3c.5tyoWkb3bcIpIt6XYKTTNg8VTK8dXh6Z
 9qf7VuFnOUAazDBdSzWakEf10Y5haJuZMXOnGnvgPXWw7QTKAWn1qUEwlFctswdM3rZdNxY8P1G1
 ZXRiF3JawYlIhJgB9CNhBVrJJuCdXP3udMkUtCayYYo.wXLaZo5b4xIHdWzhDH_ldIMcrXR3AVGL
 ikQ4kolJM_H2q2EfzeWO9UO3TF0HT1qxlh7llbf0O862TpVTbz42KnNxiww6Bk8Na6iOXGsgKPuZ
 Giy9zuyrSkkCk_IArLcEFOqN.QriTCyJ2GE6YFvXXfCkvKCu9vWjUPEUeugDoUYdSgaaozqwiT5e
 YQLjk_Eto6QO6vn_PQtib.BS.qF4Uyg7q0MdLPHXXR2..APMrvypqhV240wJyIuO38mlH7Kmk_rn
 nQCu02uUGZrDW897z_E3W5YkpKGOsa6lysDXzriPv9osDd1.6s8OOEeNQbg32STkDuYRQoiwXE1L
 zGIOL0EKrWbxhs.TNFvSbTTXqBXqXdfiBd8pZ8w5euDSDpzL6vw4d_T6QJb7auJvK.1ZJzhOmZ6X
 XCqLWkb8Xc6ZKyD12qYcPpV8OOt6.qcWJxF9APdE1I1lOew--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:26 +0000
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
Subject: [PATCH v5 02/38] LSM: Provide separate ordered initialization
Date:   Tue, 11 Dec 2018 14:42:38 -0800
Message-Id: <20181211224314.22412-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This provides a place for ordered LSMs to be initialized, separate from
the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
ordered_lsm_init(), but it will change drastically in later patches.

What is not obvious in the patch is that this change moves the integrity
LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
list, there is no reordering yet created.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 04d173eb93f6..0688dfd57e95 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info *lsm;
+	int ret;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
+			continue;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			continue;
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
@@ -87,6 +105,9 @@ int __init security_init(void)
 	yama_add_hooks();
 	loadpin_add_hooks();
 
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
 	/*
 	 * Load all the remaining security modules.
 	 */
-- 
2.14.5

