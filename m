Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE3C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E12F2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sWZ1dlFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFBQx7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:59 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:37760 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfFBQx6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494437; bh=4I+6H6t4R1PSAbDphFTCodzdmZKek818TwRA7drv09Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sWZ1dlFac+a9Ji9YB1k9J6v/VGE73nWJC5e7a/pvB2nsOgBiKbq84bklBqEJ7CLoRXPDnpWwgw8agGGr7VDjme9Hb8DX1OTVy2R2TfL+7r1wO39Z2bfyHdTlOJm51XEI5ZBCQ11//fH/u9dBQ9PfoFxa9O8z+dK/bnyKDIAmd4eNm7YRZIuZKjXdUoOuPMgvbnZKoMnAuOetnG4FZD4NxBYSgfHnv5q0+oDQ012sjDpuuBMe1uic64QpNCNytO3roQOcp5kTtrt6prD9uZOFWFobTh7f8vv+C+GUWoNIhKHuoMC9Y/yfhof85vRjw149V4zRGfxa/4keBy8yXPFbkA==
X-YMail-OSG: DH_JqVYVM1luYh81aalqSyRYHd65wPq09e8PVUVPque9o8KRevgfj3yiWnEyQYt
 CWCsMHWeN0hHGAUpnXLF6MTp08b8XjxvwsRFSamAHVTZnaDBzBukcX6Z4JvBMR_K7e0V87HtRk3k
 UHX1L1dti3jrI0v.V_Mt0RoMoQraoVNO1kjwTgxOVkQkQidXOSQbn1mtT10rsdbZss2ceBuG.k_j
 AGaQYev_FhdsbxxXQRSIUuMBJb5QZA5styMxTxaTjzZXyGYNpirmvEVwJz6ZuuGYOR0ZTPB_n7mT
 ULeEmshwe70HQktJhp0qc30_Yi2.MDKny4Y1w0F3t2Mm0jonn6nHSd6SSx3nn.1GEp0ITPkzeWmk
 n._QYLXRKnuPzrfW7MD26kcyiRrqp2pCxMMHYapnU8yVK1ipkxhMGSUOBzrH.Gr.88WQIS6P38RG
 fXwTcWSpXaQa3D0v66Qsh7X3ruTPcHr5UKHaf..6SDNCBJzj2Vphi81KAhRDRdkMbCIv8KyccrbH
 M7uBpQ5Q_8Fp3ezlRaJvkhOnuZ7UmnQqs8jlBoHQSFLaVRLcItju0p_MR4Sw_UL7a.5QVfRHCHFT
 l3k84Z76OI6ZlFPl_wN8WLki7YClK22nNsz10yQ5.qlpb3kyEMyWI7StIj3GdlqBQ9QLj5GOFn_M
 zuWNycHxUKNuN2et5S_M4JdqbcHJvnSz0mwqoAvGBX6ozlEQ3Fu1PphiF9WHdwW5fpd_6wIRflzX
 _EA9PZzKSIF6hONu8HtuiZbKvNPa_DV6OG3ha9nscR33FtAoSELstLR7fM1WPVPUUR4LEoFh__5N
 cDTMKM_Fulp_Ycu1XcXjZGi7sUH_UUZNuyTieMofGgQ0dr4C.vXRfQwswb.h7b3iof9W4tzkwWe0
 uwjczVWS6GdA7c3NSJbTeWBZH6rc9pJ2_w3yHcQl5wkaw.yOWBxKInJID5y25kcSNwG81IQciYMF
 Mjtj1fXveh7Xf2959mSNdTBY_sbfpkGvuu0euX40V8UkHAMNwGaGJ8xjCtuKkOMZ7SkOsR3WwtbX
 PFzwdoIFnk0UDe_K8i3FD_qBh.d.uFz9pmwE1cSwmRF3wo5ohBUFw8tR_uFPv1JA6YJGtXLn8IA1
 0OPN8hM7p_lMyegMXNjtPPkkDftLntPRcXty9mmzimPnaw0In8a0Iu4F_5cdioaHdVAhOHH6eRRu
 TfymI4WWFdNcNxoxIWEIuHhNT.zFbBa9NC7KhECZAs9Hg_U7IAuehh_BxoW5HeRjS8uzseSt2YMB
 EvkBKhXsMO2qGDyProcPUHYniq18TQkyWdiFUToT5by2Y8nMeeklWErQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:57 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 378fb4b825ee861f1e4674117ce93fdc;
          Sun, 02 Jun 2019 16:53:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 46/58] LSM: Use lsm_context in release_secctx hooks
Date:   Sun,  2 Jun 2019 09:50:49 -0700
Message-Id: <20190602165101.25079-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 security/security.c               | 6 +++++-
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d4ace7af4950..3a779a0f9e15 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,7 +1329,6 @@
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
  * Security hooks for Audit
  *
@@ -1663,7 +1662,7 @@ union security_list_options {
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
index 44a4402073d7..029d2f4fe48c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1996,7 +1996,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
index fe09905d013c..332296f69f76 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6322,9 +6322,9 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
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
index 3d24503029e5..cf27905ccaa5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4468,9 +4468,9 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
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
2.19.1

