Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBCC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E5220851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jmGhbXad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfB1WUg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:36 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:37681
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731609AbfB1WUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392421; bh=TKbttd+wVwKI8Sg8S2yZETLloJ+fHFodAjCzqzLtkW0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jmGhbXadl+yNqhk+i5qFD26EJwkiITNzQxs+9Q2MfMEV3n0ArBMlZXhIXC5xatowGSTWcu5qa7K43bDp5WrB0cPJYdtDmkaKJEn8KQTZ2AjwzmaIOS8HeW+9Kjf7Q+jDphrKNrDPDKzk+yo5iTkd/GoGJy+5uvLp/ZKimbg4fiGbM+zwCTGH0lROvFAV+BiAUSBXzZgnhz0sfYjUy+y7mD52sjSYzbfx4YO+Hu3xzFeFrQhgGgXpeuHpC5eLfFkURWhGDsdDyvdUhWZD/TMq+hrfB35QeLSo9SG3E/fvZOHpB1fg69yYej5u0xc/h9wUBOK4BwdGtnvUrONm1lVzgA==
X-YMail-OSG: neRnKsoVM1mH002KiHE2i_RNH.1vm_AHLCNz4Ok87_8J_AK9gabmmrXuiYLYDb9
 UnnwE7pIh3pHGj7Ef8nSL6Z3b3WUPXPibmWfqXzZS1kk9nbGwyKqUb5iz.CeoDnsoAvbH.NqSkgs
 CsCuctMhuuwHIa3CHGpB_OgsAQCseo9y4uy5dXQElsqvB5FSMk1hig15ZDmCQLyLUvI_6NpcFanI
 MHdVbZjD44wbj.H5iYZKqU3rF45TlmE92CKC_CKgc0SCfouP6Z1J8jT_1acmADUxXNGkIHt2f3fH
 2mXwORIl5iNrszzBvVRrtLgmf3m7b_YD2jbh9RKrxSjnN0D.u5Dk0twXkZxkJDHhGubiKuYOf91h
 XEwEJbKVsKpEoj.V46Gzz8sDnFAMS41ixTHt3d4hZ09Jl9oTtKuLKE1IoR6lgEKmEFja5YgrGw2U
 GdIzdfJDYGbuB2_POcnwe5WV0m5NI8sSP77Q.YGyBFMEpiO7ouQocXzVMWGzQWCZ_j8zceoavxMK
 D2MvthIE4BZZ7imTaVxf8Gu_o04wv3eM9xhoIwSnEIFXi6Oq6o45SJQ0AUsA278GaU3mSMHkbgzJ
 j2bPQfhjTPft2A8Q.0gl13t58RGxm_Dj.geIqWh3NogpiqTPPc5uInXdXeX84XzOQFuVwAdppbSX
 sT5ooayatSkt9DGdfDml_OAkn_8.oEcalDyV_NQdaS7_t7QWGDGGAkn72cT9NoASuN0w3r8kzPTQ
 r_KpgZTr2R3IlGF95ifzC_W2bolnysxR_Sl.3iNdzUZfrKv9n0sErtW.fIz4CLCE1KFlErinwvY.
 QJi4p7iWs1SRIFnZh8OsvHoK59Ds_wlNsm4RBEgm5D9fMBZUSf2QiFl7XeuRTj8EA5j1z1hUavfB
 FWhEZhDjQdwgHntaeIMoV_cdbf5bP0saU6Qz1K6wyHHFdSo2EZtG3P2yVdQd2Ay_G0JXKSXD3iAp
 DQAGOrE0zdizvGU.BLFKkvwYPSJgNyXSAWLjOW8lt6wRSxfXg7YC7U0bLSSbKTl.b6mErW.OXe9R
 zVWcJdzmB1dgCKsI0A7ut6laqDLpYVulM_fwVezblj.TWjhJkgDrehFenPLwgbMqo78lW.XDUkON
 QzfZkVywFZmjnkgyrw28x6QGSje7YwRFayampRuasrzxZHx4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:21 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 53/97] LSM: Use lsm_context in release_secctx hooks
Date:   Thu, 28 Feb 2019 14:18:49 -0800
Message-Id: <20190228221933.2551-54-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppAror to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 3 +--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 4 ++--
 security/security.c               | 7 +++++--
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 29e52aedd6ac..2f07be4b9800 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1316,7 +1316,6 @@
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
  * Security hooks for Audit
  *
@@ -1653,7 +1652,7 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(char *secdata, u32 seclen);
+	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index acfcf99bff0e..a780e56d4f5b 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -29,7 +29,7 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const struct lsm_context *cp,
 			     struct lsm_export *l);
-void apparmor_release_secctx(char *secdata, u32 seclen);
+void apparmor_release_secctx(struct lsm_context *cp);
 
 
 int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 35df38592b6e..46c8b9a67ac7 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -123,9 +123,9 @@ int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 	return 0;
 }
 
-void apparmor_release_secctx(char *secdata, u32 seclen)
+void apparmor_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index dadb1cb72920..4dfe053ced5b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1990,7 +1990,6 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-
 	lsm_export_init(l);
 	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
@@ -1998,7 +1997,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_one_void_hook(release_secctx, secdata, seclen);
+	struct lsm_context lc;
+
+	lc.context = secdata;
+	lc.len = seclen;
+	call_one_void_hook(release_secctx, &lc);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8b8eb5115d6d..ea9603b63f77 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6215,9 +6215,9 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
 	return rc;
 }
 
-static void selinux_release_secctx(char *secdata, u32 seclen)
+static void selinux_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 26cf42ddba0e..332ac71e8a41 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4383,9 +4383,9 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
 }
 
 /*
- * There smack_release_secctx hook does nothing
+ * The smack_release_secctx hook does nothing
  */
-static void smack_release_secctx(char *secdata, u32 seclen)
+static void smack_release_secctx(struct lsm_context *cp)
 {
 }
 
-- 
2.17.0

