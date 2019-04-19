Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E7EC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E90A21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="POGRBH3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfDSAsL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:11 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:38937
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbfDSAsL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634889; bh=+ZoKPzrD2nR5EUY6GzTUfVN3wrTitv5qfxKbCyM9F3k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=POGRBH3lplR45oGTLBpDc9Pf8lf3rs1HrmVg9U/L1kRlB8+u1puTX8zBmRS+vx1y9Zlqg3P47anVAtQQ4ERM4wNMbbj+cNrTLD0STeivtAWgkbPUWMWsSm2sObB3sbTv+m2WhnYmpaQ9PK2iyU7wjhJw+3cNyCTyLVkF2ee/MXXS2ZceRE2qmRDT5/+HEAoG3WsslvezLryuAdVpzSpshlO9cvX4hVQxLSedsdXgAm2pmqOkL/dFxSOloC7gPKfWMevbC4JQzGUqQ4dY5hrO/BXVhbDladnbc3i39n6lsiwGuLHzZpoqb8kvODDfbU7SqL5KRwkxXHE/gJJPCLG/Wg==
X-YMail-OSG: _Sl8v3kVM1latTgedUUbPqrr67u0Zoy8gW5QIGg8LMJTLgyu16E7Z72bqwF22yZ
 0kKlalEmXhmwZ6HBHNvsWvUREi_3_JcgtuzbL6CxZYKoe5wapf2N5JNhma36PhJZUg0gcaNZYRkQ
 gJ0g99bDG2luvSQYx1giebbwzg55IZeWzmQeyqGqCezOlB8QrP4D6jRr21eULbUTC5jkrn7M.VxJ
 QKuw1WMfabdq0DkFs30ZTi8SGP00.Qidp5RZyJRznKItqFAqNZp22EIi6sNWxtV9Zi6eUVc.hA3o
 kDuiP9NiiTk1nvj2emhn4J6c46xzGuCQW44.3sewr8jIhY5SJJFajevGOfOtSRgFSKU5zDngfsfb
 x36gL2Eo7FcnKDe7ZLvtHx5z9l2tmd2Env5yL8XJIlonjqem8g_SIKyBGLGm7sul1Hkf3ytU9wf_
 rnAWFJxtHLd05Do2G9uwm8.stuiTN5sSYVSmmcUzXNOxWx9_QydLc5I8JdPcbxAYbqB2Md1WEhCX
 Yem.0rLnj0u39fUsalLD.ZFL7yUwgNu4PDAIcx9iUihpjWwMCVLuR8Ven.7lQ4pXxBuaBB10bd5I
 pGRBd1RChxc_0e3cObYECP.1EzNHX2_bhfAserszJaEUVFS4cBVH.tgcuYgdbwQ.YDJOL.yw.nNu
 WT5oRxTXADdmgG_GhSWQd_PorloR2hK_iPrPuQxNbQw9fFikiggAlY.XjRQNzHBWpa8M3ef5ZIKL
 6snO9xYz4WmWosbTSQWwrtvpJUy_jOx5_Ic.u.O4CPBUPb_89Dbd8xh5mw5eu9CaYMfVKaFpkExx
 urP2rBvWtYsV9JMoSZAZ1NIVT7TN1JmODdg3yCoBF_cyPQQZVeVVyOd.qJ0BvvlfRqALrUx1NHBf
 TLjPMIW18UpM0m2NHwdcf4lD.xmYOevQRS5UTEwWzUWBBeU9gMU6sXKZNvnO8FOJgxWM1VTmLi.7
 VceBDWCe8bW5vjH7BNkADFpR5xFP0cxe030FrrD0dNOwUoKAhY15UDbeeuoUQZJfTuSBbEDxoTo6
 5KMzOVvAeE6xGJuMgDkvY8C0rU6yU1FTG8gZBDWJZkv2vXGDlQpIlINoq_4L8Gdut1Wz5i2m.AZI
 YQZ0EeRG_dBOYNtFwtx9Jhyhl2om6RIBoJBpIM1Cvjasa.KDxTRtSHw0CN6ZrSafq3LLZiSQ7Wa4
 LzCDDqoe7OYaA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 354bec82e8db1938f39555b4d4e62c9d;
          Fri, 19 Apr 2019 00:48:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 47/90] LSM: Use lsm_context in release_secctx hooks
Date:   Thu, 18 Apr 2019 17:45:34 -0700
Message-Id: <20190419004617.64627-48-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 9f32865e7329..029d2f4fe48c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1989,7 +1989,6 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(struct lsm_context *cp, struct lsm_export *l)
 {
-
 	lsm_export_init(l);
 	return call_one_int_hook(secctx_to_secid, 0, cp, l);
 }
@@ -1997,7 +1996,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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

