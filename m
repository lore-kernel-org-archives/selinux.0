Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C1C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04D126FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="htZMY2bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEaXML (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:12:11 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:36897
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfEaXMK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344329; bh=xCs5ko0ljATg/F1vIduV+zjbu+Bg+Z+duHwS3Dwapdk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=htZMY2bFVvilnMdblYjLwpd/KdI0rccUHWRfaPmOyn9YIWsk7f5nZzfy83NJO2n15loRdX7rhEaHgvObDQN0MyTMi5GlokCpQVCmJJHHmHjH5CUjGQXz1Mt7XrmaX/9aBG4VDeFrA0qxVx1nwaIS917nkxyuFY2uuG7az4laikOf99PskFWbKlqp1FPm6MDWtAzCL/hhRGOBzJlwPtfCRrwyWso5/h3/3hvzXpux/s5RzAYJNr0f9Aa6aFRrZq+2dB1xw7z4a2meB2wMZakXlhLCW5ggMt++vn8Afjn88OFxqDNzjkABQ5m0QqcOYkwUwjekaCamS60Jro0tgVcgSg==
X-YMail-OSG: _rWEuk4VM1kdH2smothzW_TzU9zmR1t0.8dYS71KHkWhPCURUD2gTiM2VVe67Q2
 SV4WcfeYCLE2L.bhW4Yfnl93qoaX2l1PUdvSkpz4Nlwb99wQwY3mUhIuCqQ1TNZ0oW_0blIwmBeM
 WzWu_h_tG1EOwUAlj9OFpFj03A.9Zb3W9oosbeSlWYni4eGUONqGlCmZ_RhvvtPlLt9iDJAvGhIn
 v15cWS9iUSFYiCIBzbOp3R7dZS7Ty8xBzwpixUZy9dM1ax21xD8sgXyzE2Ldd8P.Sav7DqlUyBjW
 yVQwAcO8Lw524LJF1GC0jVQsogfWZ.hqi_3CRj2un4C2bnQOZSwAMGm5ldyTTlE7OuxnZD4bYacI
 7QP_TV4Bws9iouAq2bHrdW0CqcCyE3.oJr7LJ301jCFVIXVDg_jLXqC2w.8UC6cBx96SIoXq4oro
 KUPjEd90lY5gz5trcblXXvtoXZX8cEx0Z6JADzV2d_q3iQclzGz7OBP6PXOB472fhBtTV1VKx3Bj
 ileOtDp9m7JNjkCFivd0E0XlFYAkkE.94hrbk.aqsfxosMSQcWPkLZKoQzmxryT78XG13ra5Gfuw
 TXKw7e9O2HesfdD5Ax4dw4pEbOGzQqxsUKc1Fui3Vb3T9j8iESJsvmSBsOnBX87WJ9TBp4DHTM87
 f.kfjsK5Ep.Efq6WzId.Ifraka1AaMqOquXIe26fcQQbqhsCEbpwlNAt1EpwGsA6d7rtKd.EaIWu
 4mL64JsPDpiFr6NMD3VuD2kQU13SDo061kUfvZ4Sqpn_RtqfO1A_wzMOWLxQ2BtudfCFTrP3OMsJ
 .i2Fil9Q_lER1JRqCyzZQum4LhLxTX56laSO0XmHVYNl8BJIO15KmguMy1TgOGB3NziM6os1WZIb
 e1qFr1VFQHdRQkcYc2OXtOl4wj7oqQzTwDj.v5pGz.CfRFQXBT0imH_usH9h3eX6GcmSsMI8Flw7
 IuRSTdKt_g_bic5LY7Xv0NKqSuo.9gVCycf0WhBIY.06kJkpovZmovwUgA.OYrT.Vth_38KjgfEy
 xu26UxLIU.cJld7G9wDP9wPj3RAyRwalWG9UYGQXq186QoQp9hSdr679QbwcrgU6muTJThcGBjMT
 OeTp13DHmtbR1Wk83aN6SrpXJDMXa8GzEYIsysj68fNJUcoRuAO9d02FCcjZ1ByDGHuMD_V0s7NB
 1.VDVoK0HpFve.kQAWDUZ2Tv4Y7j1TabTTqr5dt5fjfj4r7DtvucTlX5NaHKn_pKCFIVyZBEUqJg
 K.2ydqR25EogYVXz9MZbD0dVXQh060TSqsxrzrRFqwbVplx744rqHTOBncIk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:12:09 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ee29c54a0a05db0473b369e84cf14b31;
          Fri, 31 May 2019 23:12:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 12/58] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Fri, 31 May 2019 16:09:34 -0700
Message-Id: <20190531231020.628-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secctx_to_secid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secctx_to_secid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  7 ++++---
 security/apparmor/include/secid.h |  3 ++-
 security/apparmor/secid.c         |  9 +++++----
 security/security.c               |  8 ++++++--
 security/selinux/hooks.c          | 12 +++++++++---
 security/smack/smack_lsm.c        |  7 ++++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 433d98dcb928..0837c214cc17 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1324,8 +1324,8 @@
  *	context.
  *	@seclen pointer which contains the length of the data
  * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
+ *	Convert security context to exported lsm data.
+ *	@l contains the pointer to the generated security data.
  *	@secdata contains the security context.
  *
  * @release_secctx:
@@ -1666,7 +1666,8 @@ union security_list_options {
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
 				u32 *seclen);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
+	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+				struct lsm_export *l);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 03369183f512..5381eff03d4f 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -27,7 +27,8 @@ struct aa_label;
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index ab4dc165e43e..69d98a89db75 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -75,9 +75,9 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l)
 	return label;
 }
 
-static inline void aa_import_secid(struct lsm_export *l, u32 secid)
+static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 {
-	l->flags = LSM_EXPORT_APPARMOR;
+	l->flags |= LSM_EXPORT_APPARMOR;
 	l->apparmor = secid;
 }
 
@@ -111,7 +111,8 @@ int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 	return 0;
 }
 
-int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int apparmor_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsm_export *l)
 {
 	struct aa_label *label;
 
@@ -119,7 +120,7 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 				    seclen, GFP_KERNEL, false, false);
 	if (IS_ERR(label))
 		return PTR_ERR(label);
-	*secid = label->secid;
+	aa_export_secid(l, label->secid);
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index adf4cb768665..1645ebe06715 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,8 +2012,12 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+	int rc;
+
+	rc = call_int_hook(secctx_to_secid, 0, secdata, seclen, &data);
+	lsm_export_secid(&data, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 16d902158e8a..7dd333f133db 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6311,10 +6311,16 @@ static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
 				       secdata, seclen);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+				   struct lsm_export *l)
 {
-	return security_context_to_sid(&selinux_state, secdata, seclen,
-				       secid, GFP_KERNEL);
+	u32 secid;
+	int rc;
+
+	rc = security_context_to_sid(&selinux_state, secdata, seclen,
+				     &secid, GFP_KERNEL);
+	selinux_export_secid(l, secid);
+	return rc;
 }
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 809af981f14c..ecd636e5c75c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4456,14 +4456,15 @@ static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+				 struct lsm_export *l)
 {
 	struct smack_known *skp = smk_find_entry(secdata);
 
 	if (skp)
-		*secid = skp->smk_secid;
+		smack_export_secid(l, skp->smk_secid);
 	else
-		*secid = 0;
+		smack_export_secid(l, 0);
 	return 0;
 }
 
-- 
2.19.1

