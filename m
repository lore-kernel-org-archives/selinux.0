Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12539C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D468A21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iCueyj2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDSAq4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:56 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:45776 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfDSAq4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634814; bh=HePCWke2c6I7BkpqTHfPNmlfpR/ZgJTIEAfrAn5Ctvo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iCueyj2r597psoSjg4UIn/1BlnYOG280tmhy3pcEzIIedERL6FdOvcN6dPpTO4X8ZQCJy5hWBmgkFwfYjNikAsnzhyaJMJqnJ1X0NuzqqaL3gy05soEaXkp0LpK7oiLBlVxwthIgWFGWOgx37lrA7J0HZOLjr5CpCB1ThDRWv4eYwhgTud2+UKGRSMPtAOXks6LuRQIl56TpgHYu1NDP70pa+mt5Xka1Azm/s/5bfpRnTaGL3csAvP+Ns4RZQrmBWB/QC+gQHjg5VX+YhuWGYV7HUbu8RUcmoOgwo7r10gCJS5W2jWKI/jXu5pi6dAOpIvgZFqpYuaskSwG8ktfCGw==
X-YMail-OSG: hj3IKR4VM1mJnogt._vq0hDn78c7PIYjSchTDXGRNo37FV267oREUTdXgDbFQKV
 CGzU20BzwZkR4hvHvvMfJklGBENpWNO_tKvcK3b79m3_f8E73pJ3j90WmHwnq5NO.IYmU6MgotrJ
 wpmikZ9vQ8AJAX_Zx.eb9CjMnPfmMJsoWNl8KQmXqnCNoeNygmZynx0Xo3OQpw0Dt8dq2C8SN8WC
 IwzfXaFGb6dJIQDq.CPMrnXbsqucNxcFLzEFyHn4GvOHlWbGBKG6RRMF466Cmigk5688R8xMJQjn
 sA088iMbZU2nvm8B9sK0dTMmyTEHCXjWvFaD8z892zXjYjMTerhMTTd25KAYXiKesMy93oQDmgnK
 NWWDupWawh.VKK6SeygctQwdbd1qTv4s802JJc4rrZaGUcXuiEaVDnUs9Lv.ivUmbQoqSKEqG5ef
 4IihRk91mtoPcDa85E41hA6epLMrGbAyWuWVxlHyfOIEq3C8rtE9a7CYhT7pf7iq_53FiVlD9hY8
 Y5QUxSYjYzH7MEXwBAK6a8WYTY9DKgDxSUg4yDsWgHf2wbe8VKbc5Mj53p.gGBnwQ0e1eFuqfbzm
 v0BXetOfCEQNYgLYWxBFsEgP58S5z1nH1uTKCaseC.pIjnhEUVOw7Fx4b1NKt_W82N82ZKzTyqoI
 IbJpxWtcOhl7uASWxSoCCM.Ipo42LzBxVPDWOZO6nsTqnqIF7L.mibo75dcQp2KXGT2hI8FPrymK
 DG61bMC0aTgwt_Alt7JdQPTuNjh8bECFj4OuLkEggUoFyxwXymxfLy4HX.BwtDX8ATrh2ogNg.Qp
 tYp3DawexNxbH8TnycIvIwyGnkLjB2XMt9oSU7DTDYj8FUpRfjITh11daXZIvADUIyQnbODNl2Aw
 SxR51ivysps_s6ocy3GbBsChTVjMieIHEepOQPPKs.UERaXALu8UNiIO33TF.8L6UR0bS77yg.Ij
 mTiPjfMEBmcC0deUoVrjushMEALTxBJdLofQjVfRmdQFElV7eKFue4vu0A_CGrqyXw0rhDPXN_LX
 .41aTiokZuR10fdI6rKTn59SJD.S9iQc5ZdxgY4ErgbOhLF8wdwodHNkazT0t1g.RlO4yDlyHkes
 IojUP_HeGTo2dCey9jsFpjiJfD97VyX3C8LMXIakUkZFm1aRv80VDCyMT4_ztMshhPZXI8fTCdpa
 tmOx21tc0TwQw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db33df77ae90d094534f9c2fe92816eb;
          Fri, 19 Apr 2019 00:46:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 13/90] LSM: Use lsm_export in the secctx_to_secid hooks
Date:   Thu, 18 Apr 2019 17:45:00 -0700
Message-Id: <20190419004617.64627-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 11ace5c923bd..af0bcdf8fcfe 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1327,8 +1327,8 @@
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
@@ -1674,7 +1674,8 @@ union security_list_options {
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

