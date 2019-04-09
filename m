Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9462C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895C20820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p+aom6pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDITTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:31 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:39842
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbfDITT3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837568; bh=0HvNAEM5ldRD+uctL0wTIJl/wIYr3ZZyu0EQxH10SGs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=p+aom6pjC1JzX6JiVZfl0TQzgfWBBrpeEQ60N2n+rKjQUgnyS13ZZpefXKWIV1GEy7suAUMWTT0G82mYzTYuZFb4HAPjCQqqZJZ8KX9eSrQcQ/GhQnmwPTkTSssJa3IS6dJI1ZCrtRe8E1jjTU3Pk6QJcE90ajR8PR/3IyrNprcH0oNSFGHFiZvhpPlepM77qar/D47iZ/lziNgtF9jFaacycr+Xf+leT4hoQk7OP83NpeitcMZuz7fWLCv+bdBUXoZdiqFhHQzfUaNLH1BFc9RXFiJfTYQQ2eyME2MJGLQCabpnYk2YuIL6P3NDLrdDp5N96EPTBwVZQfjCaf0shw==
X-YMail-OSG: Gic.WfUVM1kEn1A6fjoE3k8y3p2cGjSvzYArcm2vp8skCFMlWuMJ0m5pW29EoHX
 ixjrmcCwHfJTP2ejO5JeupUXkdx5aC6qvseeIIb7wcGspin7.3PGYkscRwaGe5QhpbGbLzZWSLnB
 f8ov8vqWZcjkcRU7IkpdItyw5Mj7U7rza2waKTAO3u74ooU6_6auCccXINinC37hd4G3JB3vmIFz
 WqHHPbSirJhELofzX1DirStFdUyO6CD5RcdB2axYiDXapfGaX6nAc.t5NwOMhpyMMmeN7Y5xq0Au
 LRRhYzEoOvUnno1JhXIBSye2xDQ6zpTODCOtat_TctBoinaMjUjByM9UVLXmeG3kdS2JQv.EZ35G
 y0M.uRVQ4Xt5cNAgyLDOcZ8tMaSx3dVqdOrvjlqay17cHdfV3CdhK9pPdVeSjteL_Dh.coSsJC4S
 nu3apRJKUPn4SohemnmDQ0OCZXJUpSVY2bMfwqAKo6Qs5g9GYts6AuNvGYmCcOdJ0MOP2yIVVGH3
 .G0Q_PuAVfQkq_gQkHKdkmp4prFfDAMoR6B1lcBzxlAFw0NSVMaEZWGsd2zLww0G2gJmKR91CjBV
 jT0LYZtnB9ZXF1Y7vMuO5ZIpzjjjor1FkYH6ie86LfO7P9ogBZouQo0Y3wZ4qtHXHBbrOeQUkEdZ
 lIe2xlf7PcgRaIHltwl9Q_FJ79uOnhEGm322s4oAlaHcsAhLY2RxPe8kGxQSBntgBHs.lyNgU6xF
 VU_VnWANUcRtQD36gXMz5gVy_en5QOH9etPcfa89fOOoPD6YHR8WULDbGq5vU9TITeggkJndV682
 VCB6DiTvXIYqRWnuM5dvdz_tRvkow7QBWu5e0fQFsZ6__MB1VpxeFbm0znd2uxH8yiZ4tmCsAQem
 K1Qya9VoB3UwwZ9TdKbhgUU5dIrz3zYUgGycSOLwE.qTuJpkueGY1qnwrc0DWfaU9Jp5BmZdZ5yX
 Qj_wF7WXF4Vdh.W9Irye.4fu_izqIkoTGwQQnwA2qTdSUdjYx2YXylDVO7O8thDQPVf9Rn6SDjhw
 gM1h.coPmq_AYnxIZjHm6Xdb1vl9DZ.b2nbzcivOA8cKVPQnJ55X33zc55sOCf4JSDf1v5lAmF.o
 jC0hwyrX6voJcTmadLq85oRD56rPXIlWWzwI938wpGXQisJnZ1c29x.gsCY37
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 47/59] LSM: Use lsm_context in release_secctx hooks
Date:   Tue,  9 Apr 2019 12:18:36 -0700
Message-Id: <20190409191848.1380-48-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
index f60ec98596c8..11bfa0a4f188 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1332,7 +1332,6 @@
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
  * Security hooks for Audit
  *
@@ -1671,7 +1670,7 @@ union security_list_options {
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
index f51ea4a134ae..149cceb5e366 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2004,7 +2004,6 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-
 	lsm_export_init(l);
 	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
@@ -2012,7 +2011,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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

