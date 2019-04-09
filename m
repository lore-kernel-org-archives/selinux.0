Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62095C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA12084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W39znsNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDITTG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:06 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:44097
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfDITTF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837544; bh=seyjgce0pdmEa+cpaRVpjQK9OBPNuMErUFViqdarFKQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=W39znsNHmeAtKxtyrmJ8sebLQVYPCZYvQohm3r7gB7/erChVHhvAhn/4PM6vadZPchXvJBH6THEb3NcN4hGJNHGS30phU2wvYUEQj69+CxX7dxzbn3UKhRNcfYB6nDZ9D9WGretAjuUY9cdAl7A5bLeZjw0nq22M4dy7w+UZIZZhPtzlcWVgbhhW/Picg5atdN1tugobQ2x6zc4UEAVaTFK9U2vNTe0XbD1/vLLoTFpnOoG6CDFdTHGWzl1socDr6XrcNsckYIXNsdABWqgi+pq+9xP46S+icYHEw7arpYh1f/HDcO77DNlXl5D8cjTtg7dUwwW8qphhfZS9B6QUrQ==
X-YMail-OSG: 8.o8Ta0VM1mR2TQK.dId253YLUOoKj2ZfmDi9Wtg41h0Vqw6TAZvNpnIMQVKhxw
 f_.FgRMgdgCkzQN.NjNpeq81kFa3WrMZJP2hJG7yUFj_1Aw6a4lzTthygkbE.bw5EP7Hq68CmAC2
 67HwAkAYlNyx2Cn3QKFMmGOle6aTbUs6ifFu7IJnWY8dYu9dm3FBQUP3BdjRlW43QTcbRQPEyvpb
 SLNhu9y5QX6QqwfPuUgUR49XSA9t1a9my6GvKc8SuDF3Vaz2jTGI2tN3pYWt.dYt6aMeModyPjW3
 Q3wszGehQ7iYDzbbyOVVHcrZiQ7r7bgr9slbYGZrcpqdTKjFAxmW6SfcaGhUvmTkuScau4RPPnhN
 .zh411I7AxmNP7OkVE4Id3oln6kfGfs.WlvqF60RM0Ca352pNtWiMc5g_lmJ_F5t39GK.NBBrcFr
 KHaZZ9FytBXw19IfQ8nZ29A5mdCkVSHFn4Fqejp9qfKxPGXh.M5Kq11r5K0IMVyAD4h9iErcvoPd
 MNzW5JXLaqFWJ5SQvaEZKMpX914gCoi0j5PZodwrwSmoMIX1PoN9PcqMuQb2.gKFXq.OXbaqC08f
 ZGKw83S2jRHx8RUmMKeVb9pIefCM45LP9DA8rZwlWG2cOxzdNniQM0Nyjrq4Pgf3GJioQjaJCLt1
 kdjPwaBlTWfS2HQJ5W963qTStyCk9KQcG4ayp88OJWMFaPE0BMpLBPNzgA3urk.z5s_2XpJ_SwAW
 1LsuRml.sYC8_0NEgnSgsss3LCNb11ZOBkUwO4wH7h88OwV5YZRPetxpH5OnDR9XEmtKU23qVqAe
 fC3IBnEloQ1EMGVoJd8pRXK3JiaX7qjIKo3.MiLjQaVHsSGbZphFjVU7BDQLvpPKRcvQMjchpqcF
 Eea4zivBv2thpV8qZw8JJrZTufwUsLreZvXYbjO7KTD5VuSK85xPsKEx1z8PXjlW8A9oiRsimB8X
 ACM2WKwaEarhey0o4Fd_dv5A2UJXqi3FtOSVtzhlLIYWyQf0MCqvL6PNEqiSsX9zrQW5AH3YADQ2
 IJrGOgEkjA_r2RFWXWzr_mjIeW8It8MyWgs.eYj3RXOhDMXIm8_qfLi1gmNdSWmIXCyXOUEDRQ0f
 iSXv7DRBgbG6whH_PWESMmF7dd0F7qVuk2WmspfB5BlVth3iT.gszsJI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 12/59] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Tue,  9 Apr 2019 12:18:01 -0700
Message-Id: <20190409191848.1380-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secid_to_secctx hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secid_to_secctx()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 5 +++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 6 ++----
 security/security.c               | 5 ++++-
 security/selinux/hooks.c          | 6 +++++-
 security/smack/smack_lsm.c        | 9 +++++++--
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 690ab020508e..11ace5c923bd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1322,7 +1322,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1672,7 +1672,8 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
+				u32 *seclen);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index c283c620efe3..03369183f512 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 1546c45a2a18..ab4dc165e43e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,15 +81,13 @@ static inline void aa_import_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct lsm_export data;
 	struct aa_label *label;
 	int len;
 
-	aa_import_secid(&data, secid);
-	label = aa_secid_to_label(&data);
+	label = aa_secid_to_label(l);
 
 	AA_BUG(!seclen);
 
diff --git a/security/security.c b/security/security.c
index 60dd064c0531..adf4cb768665 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,7 +2002,10 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
+	struct lsm_export data;
+
+	lsm_export_to_all(&data, secid);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
 				seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfd0f1f5979f..16d902158e8a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,8 +6301,12 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
+				   u32 *seclen)
 {
+	u32 secid;
+
+	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
 				       secdata, seclen);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a3776501965d..809af981f14c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4433,9 +4433,14 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
+				 u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp;
+	u32 secid;
+
+	smack_import_secid(l, &secid);
+	skp = smack_from_secid(secid);
 
 	if (secdata)
 		*secdata = skp->smk_known;
-- 
2.19.1

