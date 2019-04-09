Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188A0C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3D120833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OuBYy2h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDIT77 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:59 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:39870
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfDIT77 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839997; bh=seyjgce0pdmEa+cpaRVpjQK9OBPNuMErUFViqdarFKQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OuBYy2h5d5CyiWIQnn9JJTQ0DezJ04YcqMAMYErvVj/DEeIoZ2xTDTRHUspsw8CqeFmcToxFCnsbLoNii6XQL/FHwAT58VIqh5J/vlkgr5/+0P3tRtqvrz0GArH5D4CuhMFSvCDURUFtizNoVxt/3Z9p0/nfOFpcNOpmMDPCOHavcQMmklDLSVOEhG6lYWICUrrByF3O+otuio/e8pkm5WJM4CeHAWTiPGcOY0vstRUl3p44laYzHg8eYDItYLvRUFPQmU3SBfWkP1OWtMX8RWFtXLrO+G9x+22wwdNeMhwmSvwfjzpiYGU+CLr22pvIZyz5kYeQzrzi6CncQfaDPg==
X-YMail-OSG: pIj3yDIVM1kbIO0tsN90vP4xCQRnwCV676sWoCipCt_2HewSpuTF.vjQbjEgwsG
 cWazR7wu_I.3vX6wYfXGNjlkBwxQhlzjt04xg7pCvlsM4_N0NT9GRMgCPZZjr7gZH.vu48QnKElp
 sckD0v3hveMPXqxpYIwXzywbXJ2HaDwNYJTJh4Pfq1dLQseOA9nLaYHFTpw4NJAXxuyFuv.GBU5Q
 G2ioQXzn4d5DMtXrNJyNwKbK2SnSIMyoe99yDZ3PT_M9WSh.zgh9kUdltL147zpeYE9EKZEps0CQ
 Akr2wC5eKrQbVQIyzcTC2Y7Ha8XefwDc.DI910NTGA1FsJFpgluvFCD91VDS45PlZp8y2i19mWAU
 sgZStIDaFHbizPZe2isdmkseTOJG74ESsuDGltbu1XL3Xknk7SNjMCpyCD4X94wyXo8_t_uCLriN
 0u0X3FUOa9x2rFX4AZqQzuSB6ETOQkcuiRWgxD9BptM4kVIibc7cs1PGTtAapeIGMPifbJVQ0N3w
 hypvoB9Q46pkQZHNxqDdhbv4ZHsBWbqxOFu63jAQKkSIAF7NvwMe67EDzoFmlGSgiHN9l5wSjrg5
 7mZeZs4M1vt37DNXYxLsASCU6pM0k1KPQya4zjmSMHxMsOuLfl5Kycfn_0P2PJCRJ1AH_lNCTZyo
 WVeV0Yib9fve2Q8auHdgHe.u3OAwCYyCwMdeMpsMMPRlBbwoK7e0kDaJYTtbAXHrDDktOmE3SLih
 9yMx.R1oNso8JRvo1i8u7Md2GWp_yItrzJCtw4ncsOS_3Vf.29zE5n1LOhbGMdwliXbgn5usjQzM
 HHatet8qOVC544KnbHqIgd_797lGbPHtm7yO8ueDBS8Bm7Uc_6dQFV3mxG4SlyXAVKIvb_b6Cptf
 n4rq2syAybZVKcK3U6jFoQuiy0EYNwKDwo6PDoMubicf_uKBz9ffnE7yin.WSe9xw4onhAnCIRjE
 V2pD6V6V.I9BZnZu6yijhPGp876Qw0aozmoMhgVKS_v0IWiFbCCgvCxE01WOaNaNBrtiYR_C9pNr
 pUs7uoXxQBl9X8Jo0Z5UMve6gELigPjs7HVQI5xgFJXirkyhmekqENdQUJtHZKzqXqD8V2XQc6vn
 dV7Irp0NZoLTU5tNCFs_DlBuKpn3iF1MoPwYVjAVzFUMGoRiIhzUND7rb.dU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:57 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 552806e231f63bbc1dbaec1014ade557;
          Tue, 09 Apr 2019 19:59:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 12/59] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Tue,  9 Apr 2019 12:58:37 -0700
Message-Id: <20190409195924.1509-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

