Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC6C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5E2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m2IXsNf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDITT1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:27 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:44686
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfDITT0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837565; bh=C4pqK0cCjqPg2OjmA/YdWF8k0OBv4qNwJVjWV8L6d5Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=m2IXsNf2mSNaYs7BNQYtP4Vrt96zZ8VB/FLvck8FOMlk9Yf7ijF3UNhY37CvAXG193ClRX13yBeghXERrrmMHTCzzgFgzdC6OQYII1G6+DWeFtDxzQr1TrQCYkE4TtFSj8B+mFL0t4Yi9s0LJOzDp0RlUI4TlDpfQHnZclSIHcOCYi/riAuWMZeM3KVLLfC0vwZ/Z6PZMaLMqMSdi3F0NEeF8aRoXg9In+eudhItJEwFYdvV6G0Yv4E/ftQaxSoyqsRB2JYcawyPwQ5XnPzqNdcjJzwp/K9ksQ7Wjdux3+/g8iX7Q4EOlj1JwQilm5c+L4BB5tUCLVKOiaJkFqSU2Q==
X-YMail-OSG: 7KO6wxIVM1kx6RwX752JdzRAYMoQpghNX5skGRffYenkRt3BkCY4_c809plkB5J
 XFb9ZTx7JE9uT7Jn9sjvWAtQ8UWxGWqP4ZJe4LVzAnZ_rhyDfpqmvqbBgQwgL6.v2WmuGn4Wwe3N
 57bmqi9DcErZRqD1UtLqftSRtBc3h9iZ3LipgvwYev2XZeUpsoqLVTY4w7EDU9r6Xaf2PkSTdIyM
 gRl5k3U0I0HW1ilw8Y_j3Ab_BehtzV2vwo4vHFK0o42svisntF01dTfVWS3Nf645ur9dJs818soq
 BmD5PLLCpPh7.7dV191cj6Hq9n7zQEYZVY6tgv8dklx8s0M4gKEzTwUAK8pMY6pI7R8svmy204le
 RIBVouIDKs_ahrg7pn8DssM_3HOsi6pfVKwverqFg4S7XWanqwyrLQPeYMty1jCiM6vrICgCTGFr
 AkEtvxq0xA5okkfL.80j4vHM8T_8U5wy0r0uBDiBMhsF5JVaY09Xn21.rRh0Rfaq_cUYOQ8R9zJQ
 ZVmm7XJaFIL5ceIgCWt14OexVV1XeMDmTuiJ.LPs7490.jJmvRZ_f0Q.irX8dLsl1NGcEliz8.rS
 tnJ506RGJ.NT5iWbOnIMxV0J42ed856J6qJ.vjc5dNsDZ9Vct4BPrT1JrLpMr1QGZ60KKM6elBMS
 OonczCWOsj7lJW6Exdli3ZfoISuA3Q0NqJ1AIESteIChxvhqZYBwc1o4VOq7tTQTRBl3X4blNZ5x
 xUxUP6BqKkkZ3IaTnAe31xCoCsiTGzs9w6SuRJToZhBrsWgl3wm_B5rlzLsmd8WY3U6xvagk3s6I
 4nsaWlAMqHz0lBsQfJ5IaDpBCxDVXH6cI1rd1N0hcas3R2wuz8q_DbPsubKe5vqBWlN26eJPAo9.
 gDBZyCubh1_xiTQzAiCO3J4UioJoch_Kmoxxu4kFal3XXq522_Hl9MBSJWbcZFVRhG.Vj9uypUy5
 EdovcEPUEmonZSpsGnAxSVaQ0ympFZJqwYd.M3GiWgXagspOvtYsqta8SUUV2ufGco3YgRGSj7Eu
 Qum9kMYHgN2dfiPYBgm0nPoFzal4sKgZugLwCcleS.lb.8MyifVhBEzoUtYh3sg3bKFk0ocIpo1h
 Eq4Z__LfOfYaISxsQCakQC8lFIZxnHQ_U4jSaqwYVYxi0KszhFsSKf2bRg6ZF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 42/59] LSM: Use lsm_context in dentry_init_security hooks
Date:   Tue,  9 Apr 2019 12:18:31 -0700
Message-Id: <20190409191848.1380-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert SELinux to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  7 +++----
 security/security.c       | 10 ++++++++--
 security/selinux/hooks.c  |  8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3344d18ba9d0..f60ec98596c8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -166,8 +166,7 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
+ *	@cp pointer to place the pointer to the resulting context in.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -1500,8 +1499,8 @@ union security_list_options {
 	int (*sb_add_mnt_opt)(const char *option, const char *val, int len,
 			      void **mnt_opts);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
diff --git a/security/security.c b/security/security.c
index ecaabc820d87..5e35adb43d65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1032,8 +1032,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+				name, &lc);
+	*ctx = (void *)lc.context;
+	*ctxlen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 633d62b97e90..fe09905d013c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2813,8 +2813,8 @@ static void selinux_inode_free_security(struct inode *inode)
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2826,8 +2826,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
-				       ctxlen);
+	return security_sid_to_context(&selinux_state, newsid, &cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.19.1

