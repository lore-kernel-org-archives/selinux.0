Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB8C07545
	for <selinux@archiver.kernel.org>; Tue, 24 Oct 2023 21:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJXVjb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbjJXVjZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 17:39:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1020A3
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-773ac11de71so332489785a.2
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698183562; x=1698788362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV6wd0akEm8D1jwc3OAbX/cpERi3WI4MnifvYq0Bh4c=;
        b=FMAsIZe1yJKuxSHNmSkDG8rpuK8fPoyrDmDUiBUCda8DHSgEv+y0zKfZGn9fyRcG+S
         lMQ699NbZBEphkXe5KLSRB8lf+xtvU8PCG+PFy0wnm1b78tPQpdbsZLSvWGE6Jn8EBpr
         L41unPiRGZLQCjkDMhrszDB6M1716IBkwjDR0gkMVakxrdsLJ87pw2jg8nj1xcoiKV2L
         eZyzUVXaVCijccLzAsh2ipaQ/EJ0d9DePKilbueTC1fO61rqR5Q0PoRW2C2wD3Saussg
         TO5WKQy0BGWTWXuxumVU80x+Vrctl2PNfclKob6z9LonISiz6GZ4laOlPlf6detj9x8f
         aBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183562; x=1698788362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV6wd0akEm8D1jwc3OAbX/cpERi3WI4MnifvYq0Bh4c=;
        b=J6SOur/sB/090/XmUjbabnXa+9L+5FyNHJpa92gp1XOxO0qG3FONUScMWFGWl0QdUx
         B90cqxzKh7aXm8RUI8RuOOyK+H9fTjZOt3bImN2hERhL2IivpWb3u9drXbKHNuqLJVpL
         b1SMQ0o/+OtJYpYArhdu3STpA244EJZYU+284LNx1GF2c0kxvgQK+HZNWiEipvt9mnvB
         qzBEfSdQ/GDDC09r4+W/vBJbdn2cTPeMSg+lvCLCFrna0yGPoyTY3ioFPNyBin5P10Zx
         P68XlIXrL0QE1Lzx2IfBvrG/T6VHaVuKqjuCQIlYXIkEFQJudigYJxFAfVK9S1KcYugX
         Vwrw==
X-Gm-Message-State: AOJu0YxuSfr9WDMHs5KmY4zv9Ifb6pihfZLVEsJLfadsgHpUnM0/A58G
        nWKDfrtodd80ApMNnFUE2Qd1
X-Google-Smtp-Source: AGHT+IFZ4qQcNPvt/gJomhwy6hlaiFRx1+Y2XD0yA4YA5YbFoXG9urH7AUzsZDrlyOkCa8LtqMejVQ==
X-Received: by 2002:a05:620a:4088:b0:779:e90c:f203 with SMTP id f8-20020a05620a408800b00779e90cf203mr4127984qko.9.1698183562605;
        Tue, 24 Oct 2023 14:39:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a0b4300b0076db1caab16sm3714554qkg.22.2023.10.24.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:39:22 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [RFC PATCH 3/3] lsm: consolidate buffer size handling into lsm_fill_user_ctx()
Date:   Tue, 24 Oct 2023 17:35:29 -0400
Message-ID: <20231024213525.361332-7-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8479; i=paul@paul-moore.com; h=from:subject; bh=h/lckAfTZWGlyy8p82g+1YRIL1yzLy457ahSA/PaVv8=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlODip9GBf2e12iuV9/BlpReC0qCAIZkwCw9KHV HTih10RgwGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTg4qQAKCRDqIPLalzeJ c/p9EADaGs2B9RwQNY4hy4xuL1s0GOiXnxTNO26gq8/jSFHi0iKUWO9t53GYKuMwa858/E0SIkp Z79MUfelwSKEDlTd79bbzKc8Q3uR1sKo8nsTHp4SDMilzM3mKW0UjaYWH99G526jzg1+cwlK3ZU GwaONylO5S16HO1fqNH7zovkWC9m1SaqCu8paLbczURfcljynRGoUBdFc9U7KILHS0bZFUvHwbG aGeCjMRORvp4NL4PcQ85VaObGGhWFCHkcnEcsiDHpkAkx3xM6mSHrMvj4+rhVseoRgfUWYwEVP7 lPhGsMVmJh7k/75MWhj3mIW4s9AzZLrq3OfZgzYnPAuVjxXcUAo1ocKs65flYWdvCR3nL/mvmqu rYVCM/zbebJC31Uy5r8+c4eq66CQQuwV7HJtohxTlS3t/RHAD4Vi43C4j4HD7Uf1MdT9uIFtfJL X2XU3/BcIyN1PQ2DOCm90LIt9au96mCOe60QG2P4a9VvhetGTQQiQ5eRXJHjxULcw/phprkAEBi ccYAIyLrypzvDCi2BFrAQGeDKtMVakAZn42aoFoM+ApCSQLNyGFHZsJA8zOzsICL4d81wnLzycF ECv7+wSSlhfjDOD2FZBUdMbhosjktZDLgZkdbbxFjCbYQMud335zTRvyE5JuWcSRUkTTDUyzyDL 7mhT8S5DWw9kiPw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While we have a lsm_fill_user_ctx() helper function designed to make
life easier for LSMs which return lsm_ctx structs to userspace, we
didn't include all of the buffer length safety checks and buffer
padding adjustments in the helper.  This led to code duplication
across the different LSMs and the possibility for mistakes across the
different LSM subsystems.  In order to reduce code duplication and
decrease the chances of silly mistakes, we're consolidating all of
this code into the lsm_fill_user_ctx() helper.

The buffer padding is also modified from a fixed 8-byte alignment to
an alignment that matches the word length of the machine
(BITS_PER_LONG / 8).

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h   |  9 ++++---
 security/apparmor/lsm.c    | 15 +++--------
 security/security.c        | 55 +++++++++++++++++++++-----------------
 security/selinux/hooks.c   | 42 +++++++++++++++--------------
 security/smack/smack_lsm.c | 23 +++++-----------
 5 files changed, 67 insertions(+), 77 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 334f75aa7289..750130a7b9dd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -492,8 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
-int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
-		      size_t context_size, u64 id, u64 flags);
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+		      void *val, size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1424,8 +1424,9 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
-static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
-				    size_t context_size, u64 id, u64 flags)
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
+				    size_t *uctx_len, void *val, size_t val_len,
+				    u64 id, u64 flags)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5e16c03936b9..6df97eb6e7d9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -636,7 +636,6 @@ static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
 	int error = -ENOENT;
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
-	size_t total_len = 0;
 	char *value;
 
 	switch (attr) {
@@ -658,22 +657,14 @@ static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
 
 	if (label) {
 		error = aa_getprocattr(label, &value, false);
-		if (error > 0) {
-			total_len = ALIGN(struct_size(lx, ctx, error), 8);
-			if (total_len > *size)
-				error = -E2BIG;
-			else if (lx)
-				error = lsm_fill_user_ctx(lx, value, error,
-							  LSM_ID_APPARMOR, 0);
-			else
-				error = 1;
-		}
+		if (error > 0)
+			error = lsm_fill_user_ctx(lx, size, value, error,
+						  LSM_ID_APPARMOR, 0);
 		kfree(value);
 	}
 
 	aa_put_label(label);
 
-	*size = total_len;
 	if (error < 0)
 		return error;
 	return 1;
diff --git a/security/security.c b/security/security.c
index 67ded406a5ea..45c4f5440c95 100644
--- a/security/security.c
+++ b/security/security.c
@@ -773,42 +773,49 @@ static int lsm_superblock_alloc(struct super_block *sb)
 
 /**
  * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
- * @ctx: an LSM context to be filled
- * @context: the new context value
- * @context_size: the size of the new context value
+ * @uctx: a userspace LSM context to be filled
+ * @uctx_len: available uctx size (input), used uctx size (output)
+ * @val: the new LSM context value
+ * @val_len: the size of the new LSM context value
  * @id: LSM id
  * @flags: LSM defined flags
  *
- * Fill all of the fields in a user space lsm_ctx structure.
- * Caller is assumed to have verified that @ctx has enough space
- * for @context.
+ * Fill all of the fields in a userspace lsm_ctx structure.
  *
- * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
- * if memory can't be allocated.
+ * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
+ * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
  */
-int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
-		      size_t context_size, u64 id, u64 flags)
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+		      void *val, size_t val_len,
+		      u64 id, u64 flags)
 {
-	struct lsm_ctx *lctx;
-	size_t locallen = struct_size(lctx, ctx, context_size);
+	struct lsm_ctx *nctx = NULL;
+	size_t nctx_len;
 	int rc = 0;
 
-	lctx = kzalloc(locallen, GFP_KERNEL);
-	if (lctx == NULL)
-		return -ENOMEM;
+	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), BITS_PER_LONG / 8);
+	if (nctx_len > *uctx_len) {
+		rc = -E2BIG;
+		goto out;
+	}
 
-	lctx->id = id;
-	lctx->flags = flags;
-	lctx->ctx_len = context_size;
-	lctx->len = locallen;
+	nctx = kzalloc(nctx_len, GFP_KERNEL);
+	if (nctx == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	nctx->id = id;
+	nctx->flags = flags;
+	nctx->len = nctx_len;
+	nctx->ctx_len = val_len;
+	memcpy(nctx->ctx, val, val_len);
 
-	memcpy(lctx->ctx, context, context_size);
-
-	if (copy_to_user(ctx, lctx, locallen))
+	if (copy_to_user(uctx, nctx, nctx_len))
 		rc = -EFAULT;
 
-	kfree(lctx);
-
+out:
+	kfree(nctx);
+	*uctx_len = nctx_len;
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1fe30e635923..c32794979aab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6480,30 +6480,32 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	return error;
 }
 
+/**
+ * selinux_getselfattr - Get SELinux current task attributes
+ * @attr: the requested attribute
+ * @ctx: buffer to receive the result
+ * @size: buffer size (input), buffer size used (output)
+ * @flags: unused
+ *
+ * Fill the passed user space @ctx with the details of the requested
+ * attribute.
+ *
+ * Returns the number of attributes on success, an error code otherwise.
+ * There will only ever be one attribute.
+ */
 static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 			       size_t *size, u32 flags)
 {
-	char *value;
-	size_t total_len;
-	int len;
-	int rc = 0;
+	int rc;
+	char *val;
+	int val_len;
 
-	len = selinux_lsm_getattr(attr, current, &value);
-	if (len < 0)
-		return len;
-
-	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
-
-	if (total_len > *size)
-		rc = -E2BIG;
-	else if (ctx)
-		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
-
-	kfree(value);
-	*size = total_len;
-	if (rc < 0)
-		return rc;
-	return 1;
+	val_len = selinux_lsm_getattr(attr, current, &val);
+	if (val_len < 0)
+		return val_len;
+	rc = lsm_fill_user_ctx(ctx, size, val, val_len, LSM_ID_SELINUX, 0);
+	kfree(val);
+	return (!rc ? 1 : rc);
 }
 
 static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12160d060cc1..99664c8cf867 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3642,28 +3642,17 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 			     size_t *size, u32 flags)
 {
-	struct smack_known *skp = smk_of_current();
-	int total;
-	int slen;
 	int rc;
+	struct smack_known *skp;
 
 	if (attr != LSM_ATTR_CURRENT)
 		return -EOPNOTSUPP;
 
-	slen = strlen(skp->smk_known) + 1;
-	total = ALIGN(slen + sizeof(*ctx), 8);
-	if (total > *size)
-		rc = -E2BIG;
-	else if (ctx)
-		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
-				       0);
-	else
-		rc = 1;
-
-	*size = total;
-	if (rc >= 0)
-		return 1;
-	return rc;
+	skp = smk_of_current();
+	rc = lsm_fill_user_ctx(ctx, size,
+			       skp->smk_known, strlen(skp->smk_known) + 1,
+			       LSM_ID_SMACK, 0);
+	return (!rc ? 1 : rc);
 }
 
 /**
-- 
2.42.0

