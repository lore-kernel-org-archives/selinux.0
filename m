Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FC29405
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469406; cv=none; b=jFMQSpLDbbT3hHb9sz1Vu8L/8gbZ3RLmlARr4ViePBTayXBt8c7GVe9fxckFamkiPDhy4DVqewrX4YWjzfYpH+32athaIUYj5+m8IfWhc0YRgwm6/bSCpbYfsPStVlLeC96U3y/MZucNCD8SJViT6mdhoNhKKLl9lQ1bhnp8H/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469406; c=relaxed/simple;
	bh=wVKZTU8QduD/YoqCxknBFYBM1xghK/W3DkyWYcnlCXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0epk/WqQ9iqtgPwte/hwf13qeJclFd5ps1H2qusfd3/ZqjIymUg7UxCAg06olrlL6R1Vpov8ibXo1Y04QYUIlwWDqkBB35R2+NfAMpq3NeyJh18ysQS9lIgJpoDnbePo+VosFe2wZFExvCGNrex2lXSwdbqkGBAHHGf1r7WX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al8rcsT7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al8rcsT7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e501244f5so2498185a.1
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469402; x=1784074202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5qyBInWK86Cj5RlS39HOe6xOt5ZDCmtrgxtbDwxiS44=;
        b=al8rcsT77FzZmdueS1wFoKpcFoaR32WSUXJ2mgMdy9M6eVnwW1dxjrGt7eBz1Hufpg
         Zj4W6Svm++tvnEKbxiIiiqvFjFWxWguTtbpqqq9fu8TOfrJwuFkp0psVXsmYBcDT1K0p
         XPDhGtD7mgO527+1+jCtEEf6ewH6uE6IqaVR7Dv9AncW9UTclGT+6IBPs1+yZtkX/mcX
         juwxJUM3/jFsI1ycfGUzzjiuqg3ERgrHFNi39QziCXvO6k/SL6FcHZF4b60+xtDLpFNx
         DD+VPGSoICHx1oAkc4hJxq0d0zzCaGBSjDda+8lGasV6tw623GevEQgy4v/5f3dljE/A
         6aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469402; x=1784074202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5qyBInWK86Cj5RlS39HOe6xOt5ZDCmtrgxtbDwxiS44=;
        b=Gxi7gQ2BcHjD/xXrbcJGsc6lwpGNF6AT8O4OBiy4CjfGA2WJERdWjTrljIDfVUkdUj
         jJG3cLvzi9ADQl5/1OZ2kIlLy+Pj8Y3g3px6PqBRkn1dRln56yw1clV8la7v9QBFYfFc
         DzPhD6VtfQLSrkHkqnu8Mw3FPVpG46MlPqm6ZJw32GBGBAi3w0lyl4C9rda32SbRuG7g
         aqxJhbQvsd3TA7MK7ru/2O7iGmyNU9/4BPMpRxKOzeDn2HE2/EZbC7eyRgAYoIk79Yta
         aqprt2aPr8duYwi72WUItfaTnPtXuDMrxCvLZLoRxr/hRzIP9V/TyHniGHaO0lTM8P8K
         bY7A==
X-Forwarded-Encrypted: i=1; AHgh+RraVRrhCPNtB34p9440q3Eygm7y40eQu3vhDpaPs1Jz7beks0D1sj4qoxBkkDb0eQtwvta9U0xN@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIe05MK6r92MGMnMdtPC7f0hFX+9vIp2vn0t2wIe1xozfRzpS
	aUZwNViwbWJAS+uoo+Nz9eV6p02w57VVhXWcuu40snfrmjQQn75z+OZA
X-Gm-Gg: AfdE7ckdCE4ny8t6xpdbf5vrGh3YRPQBuPblqqIX5I77huyk9/YcpA5m0IUJ5LR4RpZ
	uc+2ipMmVUNATuT4emeFRJHrXIcC1hEqJ/DQc5mpNeqIvQDH4zlqzXiYjoCOJiVPcN2F3HfCV6K
	wioVBIr+brbAJkz4fkw+WmSSaxVAEiOPT9xSD42xSevA5BlTKabu0UFjJaClQCWpNXPLMBjYRrZ
	C8MsG3kTfWuTUNztY3d37Evf+In3yJZIx0an3YpjoT7Z+WHluZt+lcfc2t09DlwwkPQoTTiO7Fo
	HLBOg+weIFzxAzrNTg1Sbyed+arINs30MhQ2Cl2xiO2KC5RNB4Z1uP85CVbuiXpKSsk7ebo33EK
	zWtovoBMCtoMbBLymCpBKk0W5FI8M9m4eM+NTSa/pbikz31uKo6zrFLhignGdgBR72RUKBJXXlP
	41Lf4pFfom0Xc1tF8yDFNv14FStpRA6VCzF2IUDgPkafuXlX1xEUA9/nWv9/xOBA8/1ZU9jFK/X
	dRLFislY+/cjY4=
X-Received: by 2002:a05:620a:2b42:b0:92b:440e:5d53 with SMTP id af79cd13be357-92ecf5b48d9mr6215185a.3.1783469401526;
        Tue, 07 Jul 2026 17:10:01 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:10:00 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v5 bpf-next 1/3] security: rework inode_init_security xattr handling
Date: Tue,  7 Jul 2026 20:09:54 -0400
Message-ID: <20260708000956.46138-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708000956.46138-1-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
programs atomically label new inodes, rework how inode_init_security
xattrs are managed.

inode_init_security receives the LSM xattr array and its count as
separate parameters. For better compatibility with the bpf verifier,
update inode_init_security and its callers to consolidate these
parameters into a single context object: struct lsm_xattrs.

Also, add security_lsmxattr_add(), which claims a slot in the
inode_init_security xattr array on behalf of the calling LSM and
fills it with a copy of the given name and value.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/bpf_lsm.h           |   3 +
 include/linux/evm.h               |   9 +--
 include/linux/lsm_hook_defs.h     |   4 +-
 include/linux/lsm_hooks.h         |  16 ++---
 include/linux/security.h          |  15 +++++
 security/bpf/hooks.c              |   1 +
 security/integrity/evm/evm_main.c |   8 ++-
 security/security.c               | 108 ++++++++++++++++++++++++++----
 security/selinux/hooks.c          |   4 +-
 security/smack/smack_lsm.c        |  27 ++++----
 10 files changed, 148 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index dda272d78f01..374c50801a8c 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -21,6 +21,9 @@ extern bool bpf_lsm_initialized __ro_after_init;
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/* max bpf xattrs per inode */
+#define BPF_LSM_INODE_INIT_XATTRS 4
+
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
 };
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 913f4573b203..528f360f3308 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,6 +12,8 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
+struct lsm_xattrs;
+
 #ifdef CONFIG_EVM
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
@@ -21,8 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count);
+			    const struct qstr *qstr,
+			    struct lsm_xattrs *xattrs);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
-					  struct xattr *xattrs,
-					  int *xattr_count)
+					  struct lsm_xattrs *xattrs)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..5b2de7865ce8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
+	 struct inode *dir, const struct qstr *qstr,
+	 struct lsm_xattrs *xattrs)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..7afe06a8d4c6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -200,20 +200,18 @@ extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
  * lsm_get_xattr_slot - Return the next available slot and increment the index
- * @xattrs: array storing LSM-provided xattrs
- * @xattr_count: number of already stored xattrs (updated)
+ * @ctx: xattr state shared by inode_init_security hooks
  *
- * Retrieve the first available slot in the @xattrs array to fill with an xattr,
- * and increment @xattr_count.
+ * Retrieve the first available slot in the @ctx->xattrs array to fill with an
+ * xattr, and increment @ctx->xattr_count.
  *
- * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
+ * Return: The slot to fill in @ctx->xattrs if non-NULL, NULL otherwise.
  */
-static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
-					       int *xattr_count)
+static inline struct xattr *lsm_get_xattr_slot(struct lsm_xattrs *ctx)
 {
-	if (unlikely(!xattrs))
+	if (unlikely(!ctx || !ctx->xattrs))
 		return NULL;
-	return &xattrs[(*xattr_count)++];
+	return &ctx->xattrs[ctx->xattr_count++];
 }
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..647f7b88358b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,11 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+struct lsm_xattrs {
+	struct xattr *xattrs;
+	unsigned int xattr_count;
+};
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
@@ -401,6 +406,9 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+			  const char *name, const void *value,
+			  size_t value_len);
 int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
@@ -895,6 +903,13 @@ static inline int security_inode_init_security(struct inode *inode,
 	return 0;
 }
 
+static inline int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+					const char *name, const void *value,
+					size_t value_len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_inode_init_security_anon(struct inode *inode,
 						    const struct qstr *name,
 						    const struct inode *context_inode)
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 7b98f5d1e2be..8f8c3de3035f 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -33,6 +33,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a..b7158fc63543 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
  * evm_inode_init_security - initializes security.evm HMAC value
  */
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count)
+			    const struct qstr *qstr,
+			    struct lsm_xattrs *lsm_xattrs)
 {
 	struct evm_xattr *xattr_data;
 	struct xattr *xattr, *evm_xattr;
+	struct xattr *xattrs;
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	xattrs = lsm_xattrs ? lsm_xattrs->xattrs : NULL;
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1087,7 +1089,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!evm_protected_xattrs)
 		return 0;
 
-	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	evm_xattr = lsm_get_xattr_slot(lsm_xattrs);
 	/*
 	 * Array terminator (xattr name = NULL) must be the first non-filled
 	 * xattr slot.
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..261f68e17cfd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "LSM: " fmt
 
 #include <linux/bpf.h>
+#include <linux/bpf_lsm.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
 #include <linux/export.h>
@@ -1333,8 +1334,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const initxattrs initxattrs, void *fs_data)
 {
 	struct lsm_static_call *scall;
-	struct xattr *new_xattrs = NULL;
-	int ret = -EOPNOTSUPP, xattr_count = 0;
+	struct lsm_xattrs xattrs = {};
+	int ret = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1344,15 +1345,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 
 	if (initxattrs) {
 		/* Allocate +1 as terminator. */
-		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
-				     sizeof(*new_xattrs), GFP_NOFS);
-		if (!new_xattrs)
+		xattrs.xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
+					sizeof(*xattrs.xattrs), GFP_NOFS);
+		if (!xattrs.xattrs)
 			return -ENOMEM;
 	}
 
 	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
+							  &xattrs);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 		/*
@@ -1364,18 +1365,101 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
-	if (!xattr_count)
+	if (!xattrs.xattr_count)
 		goto out;
 
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	ret = initxattrs(inode, xattrs.xattrs, fs_data);
 out:
-	for (; xattr_count > 0; xattr_count--)
-		kfree(new_xattrs[xattr_count - 1].value);
-	kfree(new_xattrs);
+	for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
+		kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
+	kfree(xattrs.xattrs);
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+#ifdef CONFIG_BPF_LSM
+static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
+				    const char *prefix)
+{
+	size_t prefix_len = strlen(prefix);
+	unsigned int i, n = 0;
+
+	for (i = 0; i < xattrs->xattr_count; i++) {
+		const char *name = xattrs->xattrs[i].name;
+
+		if (name && !strncmp(name, prefix, prefix_len))
+			n++;
+	}
+	return n;
+}
+#endif /* CONFIG_BPF_LSM */
+
+/**
+ * security_lsmxattr_add() - Add an xattr during inode_init_security
+ * @xattrs: xattr state shared by inode_init_security hooks
+ * @lsm_id: LSM_ID_* value identifying the calling LSM
+ * @name: xattr name suffix
+ * @value: xattr value
+ * @value_len: length of @value
+ *
+ * Claim an xattr slot in @xattrs on behalf of the LSM identified by
+ * @lsm_id and fill it with a copy of @name and @value. Callers can invoke
+ * this function from non-sleepable context.
+ *
+ * Return: Returns 0 on success, -ENOSPC if the calling LSM's slot budget
+ *         is exhausted, negative values on other errors.
+ */
+int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+			  const char *name, const void *value,
+			  size_t value_len)
+{
+	struct xattr *xattr;
+	void *xattr_value;
+	size_t name_len;
+
+	if (!xattrs || !xattrs->xattrs || !name || !value)
+		return -EINVAL;
+
+	name_len = strlen(name);
+	if (name_len == 0 || name_len > XATTR_NAME_MAX)
+		return -EINVAL;
+	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
+		return -EINVAL;
+
+	switch (lsm_id) {
+#ifdef CONFIG_BPF_LSM
+	case LSM_ID_BPF:
+		if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=
+		    BPF_LSM_INODE_INIT_XATTRS)
+			return -ENOSPC;
+		break;
+#endif /* CONFIG_BPF_LSM */
+	default:
+		return -EINVAL;
+	}
+
+	/* Combine xattr value + name into one allocation. */
+	xattr_value = kmalloc(value_len + name_len + 1, GFP_NOWAIT);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	memcpy(xattr_value, value, value_len);
+	memcpy(xattr_value + value_len, name, name_len);
+	((char *)xattr_value)[value_len + name_len] = '\0';
+
+	xattr = lsm_get_xattr_slot(xattrs);
+	if (!xattr) {
+		kfree(xattr_value);
+		return -ENOSPC;
+	}
+
+	xattr->value = xattr_value;
+	xattr->name = (const char *)xattr_value + value_len;
+	xattr->value_len = value_len;
+
+	return 0;
+}
+
 /**
  * security_inode_init_security_anon() - Initialize an anonymous inode
  * @inode: the inode
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..6bba6b212e17 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2962,7 +2962,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       struct xattr *xattrs, int *xattr_count)
+				       struct lsm_xattrs *xattrs)
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
@@ -2992,7 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	xattr = lsm_get_xattr_slot(xattrs);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..4501078430ca 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,10 +981,10 @@ smk_rule_transmutes(struct smack_known *subject,
 }
 
 static int
-xattr_dupval(struct xattr *xattrs, int *xattr_count,
+xattr_dupval(struct lsm_xattrs *xattrs,
 	     const char *name, const void *value, unsigned int vallen)
 {
-	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr * const xattr = lsm_get_xattr_slot(xattrs);
 
 	if (!xattr)
 		return 0;
@@ -1003,14 +1003,13 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @xattrs: where to put the attributes
- * @xattr_count: current number of LSM-provided xattrs (updated)
+ * @xattrs: where to put attributes and update count
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
-				     struct xattr *xattrs, int *xattr_count)
+				     struct lsm_xattrs *xattrs)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
@@ -1057,21 +1056,19 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (S_ISDIR(inode->i_mode)) {
 			transflag = SMK_INODE_TRANSMUTE;
 
-			if (xattr_dupval(xattrs, xattr_count,
-				XATTR_SMACK_TRANSMUTE,
-				TRANS_TRUE,
-				TRANS_TRUE_SIZE
-			))
+			if (xattr_dupval(xattrs,
+					 XATTR_SMACK_TRANSMUTE,
+					 TRANS_TRUE,
+					 TRANS_TRUE_SIZE))
 				rc = -ENOMEM;
 		}
 	}
 
 	if (rc == 0)
-		if (xattr_dupval(xattrs, xattr_count,
-			    XATTR_SMACK_SUFFIX,
-			    issp->smk_inode->smk_known,
-		     strlen(issp->smk_inode->smk_known)
-		))
+		if (xattr_dupval(xattrs,
+				 XATTR_SMACK_SUFFIX,
+				 issp->smk_inode->smk_known,
+				 strlen(issp->smk_inode->smk_known)))
 			rc = -ENOMEM;
 instant_inode:
 	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
-- 
2.53.0

