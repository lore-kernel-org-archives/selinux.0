Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148CC2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oaequ1lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFBQyL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:11 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:34086
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfFBQyL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494450; bh=QOEIKGYoz1Vdbj2R6mhpXvN+kMT3nkCZkTlG/jPsC/I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oaequ1lwRc3BlCS+iBkoNGi/7ASEo2Cg8sPMNdtjt2r3sSRmN2v98+Bv78SsFaCo4ge2odqAvB/sdGBxluuOvIPAqL4PPgd2Qh+veVNSmXtpiz9DV/SA+C9rjSqE2RmDnhJ07TH3RhOWdmSs8YGQv4lAm1OM+VqBGJ5ogpS3AbpNE4yTP0eL7PUQf3ydZYoKGNGnWPJ+0u2ITxeIiT1MwpMSfvCxGnCAqGCzrPBTrBu2hURWIOYyrjHSPpgI6uWXEfmD1wylN3NX83XJ/u5ILHiNRKChnyqp/oeutu/pXyutOo+IIH4tY2Tgfw8TKcQP8Ft/lRetChTz2VwffDAnbQ==
X-YMail-OSG: Oee7XoQVM1l3MjDZLYWqXsG_ru3zbOf0p.VkGlu3ZCqpvdnsrBF2_.ObnWEaEhN
 TPqB.gl95lHd22BQa4pi_KL5FCnB26qvS4HECn2YxsV2GHK5YJjkl6LC6pJZDZhogWLnvJ1eLE7o
 WqCimYT2fYGO1IGiXTPHOvbhHC5fYN6f32xgm.AALm3orGBcJG8aewqsDtuvYEoZV0erhOjeH.Wq
 NHSmS22oOcgUCx1iRFXR5iU2dFpQsjNQSPVrmMARcZLnQr0wZwQ7iINHe5CiqsSHux7JcSl.nulJ
 fF5kC.T5GTWZxeQ9Oz8_xHKJDlK9jq3eeImLWGvgZa_yUE0MdND15dio7AA3mQ5zy6D_1NWHlBIK
 c6XSd80NjJMed.IimTcVrlmCtUCwmu6uZLPxfpbqEmN4tVBnVIweEwR9S6O2rhjwH.9J4XUhk8th
 O4vFB0VOuvL7a8DYbBntKZzdDOOWGpaoi82cZfbRUDYpMwB7j2g1MIiSucJ0kWpbXbJvbrf99Myr
 759ZlIp56BO1kTZvdze_bLgZBf6hn3t4maUTS0cVttvXKnGlAGL9hxC5p6b4VieMRQ9.fVabeciv
 216iE34Lz_q6fuKbVPu6EZ4JvGdItAeEA5P9NPlB53wem9.XxdUGEvvZQW_LrTEfeaFA_cIYjDHJ
 QRm1cgDpUOsp.A5m8DynWGEUmPXXXbJj8d9JvZjNSG92lZVAcTn9n8B2l8iu9Y853.J2NJKbEhtF
 udLoPa7zRP5sXvzvEZgHF0oTHmnRKTLRqp.KHvS6rC2dlWGDWK7jdf_ON.LuJ5sn1PvRf4grwmNa
 .MhAQeMG3diizquEEYkWY9xGEsZ5DXwoEjc3tF5UlL4tFvD1dOkAw7poMHf3WmBJsdYz2GSl7ogn
 6FhKs.VHoeO9OJ2JWF_JZ8eiXSMFbQtqb4x8bE.3wADkcwnuHQdXwZsY62KgUtnjkQkht4qDDe7e
 ZIHnaON8QQftixS5y5OZRylImBaZGhqD81kyFirIpchDsMaPDoSO4R_ZkQeIbdGWchIf8rdmEj.f
 nTIVccMQozAlAsPLXyslMWr3FkmjPzWgyRi9fovEv9v9WYvdc8MiVPY7YbCdUwThV7AEL_ldOlDH
 5jrhGuM7OkuugTyS5Epn7mXzJV41Dc5HYNi8bYI7d73TDJI5a_U7uTMlLuhrdaiHUMcCKPlhEMtD
 Y7nb8FD7K1_ensGfg29l8n1.YsWoF3T4qTURzllETlNrsWwoFiEtW8E0T9rzNVxwhgESe61jcgiz
 PuZbuB6.VmzBIrwRlixEGHzazP.vkgVTPjXVIs.RT2Wvx_LqP_bejJg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:10 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e9ca3210f73b95a606016904e284b22a;
          Sun, 02 Jun 2019 16:54:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 51/58] LSM: Use lsm_context in inode_setsecctx hooks
Date:   Sun,  2 Jun 2019 09:50:54 -0700
Message-Id: <20190602165101.25079-52-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/security.c        | 6 +++++-
 security/selinux/hooks.c   | 6 ++++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d1235a3cd8e9..088985d10a69 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1383,8 +1383,7 @@
  *	operation.
  *	Must be called with inode->i_mutex locked.
  *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @cp with the security
@@ -1661,7 +1660,7 @@ union security_list_options {
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
-	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, struct lsm_context *cp);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index c8ce190dcdda..9d09c774a1e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2008,7 +2008,11 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_setsecctx, 0, dentry, &lc);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0e347a26c3d8..af0d98f4dd37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6356,9 +6356,11 @@ static int selinux_inode_notifysecctx(struct inode *inode,
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int selinux_inode_setsecctx(struct dentry *dentry,
+				   struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, cp->context,
+				     cp->len, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e00346799cdf..4570e8cac1b3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4480,9 +4480,10 @@ static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 				       cp->len, 0);
 }
 
-static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int smack_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, cp->context,
+				     cp->len, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
-- 
2.19.1

