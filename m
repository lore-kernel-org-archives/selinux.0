Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6D34C9AD
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814861; cv=none; b=EHDgrbNsOWTzx1gY1Fb3hCCzGn3pYPq4xVNRIUT5RmtG8I0NzICRP/MLa0jby5k5aIq0bRSFoyA7jecLapRQRpbH6ZConjU7seRsweQx2pSWet8BECyad+GP2/zKfLc0w5IuSJoN84BIAzsYXLWOAn7KiT4q2Xkxk5Oml/hFpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814861; c=relaxed/simple;
	bh=oY3tJykEWVtZGnzkyhB8esd7SLcuIb+a25ZQ5M8QrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOkwCWRy3gZZKdOvX7xLKSyKpX7rWGaUUMquwDQ3DQkqSj7XcX64D3cNJyRqxKAcM+yIJNaq80mg693ed29j8a5Q/x/hqZNiR2nCZoFjIXBXnw+eDuf+sLeDG5NLiVs4vmskpHPEN2H52hOny/NT/bcD3bSy1lzl5jCPM9KMEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA4HMgu/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA4HMgu/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91563abd6a9so79401385a.3
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814857; x=1782419657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa1V4UsdYs/kfzalQNrhOHmAoxBrvRRgzsi/P9omcoc=;
        b=GA4HMgu/+RTSbbGi6JaRBKZA95iPxdl0fM5d0LOBu94GSZLlrT+HIIrCy7mFHEgi4+
         cg/ViOyUrcSS6y9xIZOnX07WPlEC8JcWEhShs+NDTuJK/IFyiVQlb510Ttto/xmlY4h3
         kBwD5KxiRCYGU59E4VO1+U8KB0su627MfdJYTjeVy61sS1DSdfnioxhs3xCMcJRLonj6
         Gil/k4u9RYCjwd3OQFHMFi3c8yl5PYDIumxCXCFzc2s7nlbReFdZgjUugfsFT0I4JzwS
         xBPkSyP0RuYG/SgaOz53flRV9lPJ2UNNprrw/VyeUK8xVKhh6WrSMozu7btfAi26Zk/m
         B0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814857; x=1782419657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xa1V4UsdYs/kfzalQNrhOHmAoxBrvRRgzsi/P9omcoc=;
        b=cxWVhq/7i5eNuTV1RpO8/cAn/qSkHEpOcgRI9cQvMDCOueE6MHkqMkbIzVnz2RHL9U
         U+Pcsej0Fj+/aRNjEDh8D3c8NHBDpdM8Iqu0mV7ApALeM/Vk6UvIFu3HlrGzLM/++ZGg
         hTOyZqClasdByBdEerNDMAbdBuF81sSl0XjjS19+8/m2p/vkRq6kbb8ZrWMlihd3rMrE
         alwPv2PiqSKsCo4Y4725NrBvRMUCJSixZia+nSChEHdA+6SN9awh1kiXPkigEi3NSQLo
         w0Pxb1YbshLz5jJwTyM6thv9P/mgpvPFaQMiTdXkOVDIxF9Yx+hdamBTezkKPcNg+ztL
         dl4w==
X-Forwarded-Encrypted: i=1; AFNElJ9dso7w8mpdv+/gZufN3qumdwxvbkfLJjC0pkiKvcxcHdmIR/3w+oIi6LYGJqrH2AH3EpY82EH5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1E9JZjtOaLwfJhA6fqjDti0RuaZCZNwhmOYiSJgDDnZM0Ks9b
	uOySTX+4//kqY1znqGIjnpWN+br179c6hnpJsSdrK5BJj+1YEdQZc/Xd
X-Gm-Gg: AfdE7cmsUjQwbK/JnsHEjwEdZUW0JcHgEAm58n5DAXyxOgPQHhiKJvNQeP1JNM7kg81
	rGSnyIYvOFC0I6a7pwYekpNCAud3P62HqyxsnXBhZQdh0u7EPgoRmAxvfDzQR2aqOOT/IMNQRA8
	KoX2e56WLzL5b8M+WOhncKtnKJWfR//vht19eGplUrzuBWc1QzUmOKrnYMwqHYMqZMgCAh8LMD7
	x2YRhIyBbb8srdKZNrtVclsH/Fw4K86eHMWUm/r/Q86cKWJzptHnNFIHKSUqDIsWsc2n5FHcs9C
	12TeCdaSQ4bIljDUUcJBIB+A7gWtvv8weOxUTJOiXykZczQrvkPO8DwUcogIPZpYo7UjYpd41M7
	HyLNluasGV/1bCwtZgZ4rCI3u6TLuUGER2K84n5cc9lt7duKuNGHZBRAk/oeZgSdMJe8WbtsLce
	dTKh9Fm3eWBriLm6uRfnbT5ylTKG/OHLWjPfs60iRLS16fAZrDyVM8VJvD0OVtTUdP5CMsXbXeE
	FvdtMAEqdwOrxQ=
X-Received: by 2002:a05:620a:6606:b0:915:f96b:8f5a with SMTP id af79cd13be357-9208ccfe43emr111613185a.36.1781814856894;
        Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 18 Jun 2026 16:34:10 -0400
Message-ID: <20260618203411.73917-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618203411.73917-1-dwindsor@gmail.com>
References: <20260618203411.73917-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using lsm_get_xattr_slot().

The inode_init_security hook previously took the xattr array and count
as two separate output parameters (struct xattr *xattrs, int
*xattr_count), which BPF programs cannot write to. Pass the xattr state
as a single context object (struct xattr_ctx) instead, and have
bpf_init_inode_xattr() take that context directly. Update the existing
in-tree callers of inode_init_security to take and forward the new
xattr_ctx.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant.

Because we rely on the hook-specific ctx layout, the kfunc is
restricted to lsm/inode_init_security. Restrict the xattr names that
may be set via this kfunc to the bpf.* namespace.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-
 include/linux/bpf.h               |   1 +
 include/linux/bpf_lsm.h           |   3 +
 include/linux/evm.h               |   9 +--
 include/linux/lsm_hook_defs.h     |   4 +-
 include/linux/lsm_hooks.h         |  16 ++---
 include/linux/security.h          |   5 ++
 kernel/bpf/bpf_lsm.c              |  10 +++
 kernel/bpf/trampoline.c           |   3 +
 security/bpf/hooks.c              |   1 +
 security/integrity/evm/evm_main.c |   8 ++-
 security/security.c               |   7 +-
 security/selinux/hooks.c          |   4 +-
 security/smack/smack_lsm.c        |  27 ++++----
 14 files changed, 166 insertions(+), 38 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..7abc3f3d1a67 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/kernfs.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -374,6 +375,97 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
 	return d_real_inode(dentry);
 }
 
+static int bpf_xattrs_used(const struct xattr_ctx *ctx)
+{
+	const size_t prefix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
+	int i, n = 0;
+
+	for (i = 0; i < *ctx->xattr_count; i++) {
+		const char *name = ctx->xattrs[i].name;
+
+		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_len))
+			n++;
+	}
+	return n;
+}
+
+static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
+				  const char *name__str,
+				  const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	size_t name_len;
+	void *xattr_value;
+	struct xattr *xattr;
+	struct xattr *xattrs;
+	int *xattr_count;
+	const void *value;
+	u32 value_len;
+
+	if (!xattr_ctx || !name__str)
+		return -EINVAL;
+
+	xattrs = xattr_ctx->xattrs;
+	xattr_count = xattr_ctx->xattr_count;
+	if (!xattrs || !xattr_count)
+		return -EINVAL;
+	if (bpf_xattrs_used(xattr_ctx) >= BPF_LSM_INODE_INIT_XATTRS)
+		return -ENOSPC;
+
+	name_len = strlen(name__str);
+	if (name_len == 0 || name_len > XATTR_NAME_MAX)
+		return -EINVAL;
+	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
+		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
+		return -EINVAL;
+
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	/* Combine xattr value + name into one allocation. */
+	xattr_value = kmalloc(value_len + name_len + 1, GFP_KERNEL);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	memcpy(xattr_value, value, value_len);
+	memcpy(xattr_value + value_len, name__str, name_len);
+	((char *)xattr_value)[value_len + name_len] = '\0';
+
+	xattr = lsm_get_xattr_slot(xattr_ctx);
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
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattr_ctx: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, negative error on failure.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -385,13 +477,25 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
+BTF_ID(func, bpf_lsm_inode_init_security)
+
+BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
+BTF_ID(func, bpf_init_inode_xattr)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM) {
+		/* bpf_init_inode_xattr only attaches to inode_init_security. */
+		if (kfunc_id == bpf_init_inode_xattr_btf_ids[0] &&
+		    prog->aux->attach_btf_id != bpf_lsm_inode_init_security_btf_ids[0])
+			return -EACCES;
 		return 0;
+	}
 	return -EACCES;
 }
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..f14bfcda78db 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1752,6 +1752,7 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_limit; /* max concurrent attachments (0 = unlimited) */
 	u32 attach_st_ops_member_off;
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 143775a27a2a..b655c708818e 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,6 +19,9 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/* max bpf xattrs per inode */
+#define BPF_LSM_INODE_INIT_XATTRS 4
+
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
 };
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 913f4573b203..0aa151288b36 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,6 +12,8 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
+struct xattr_ctx;
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
+			    struct xattr_ctx *xattr_ctx);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
-					  struct xattr *xattrs,
-					  int *xattr_count)
+					  struct xattr_ctx *xattr_ctx)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..f62780fbeb9e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
+	 struct inode *dir, const struct qstr *qstr,
+	 struct xattr_ctx *xattr_ctx)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..710e48caaeba 100644
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
+static inline struct xattr *lsm_get_xattr_slot(struct xattr_ctx *ctx)
 {
-	if (unlikely(!xattrs))
+	if (unlikely(!ctx || !ctx->xattrs || !ctx->xattr_count))
 		return NULL;
-	return &xattrs[(*xattr_count)++];
+	return &ctx->xattrs[(*ctx->xattr_count)++];
 }
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..1f8e84e7dd7e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,11 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+struct xattr_ctx {
+	struct xattr *xattrs;
+	int *xattr_count;
+};
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 564071a92d7d..86a8e188b900 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 }
 #endif
 
+BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
+		   bpf_lsm_inode_init_security)
+
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
 {
@@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 		return -EINVAL;
 	}
 
+	/* bpf reserves a fixed number of xattr slots for itself.
+	 * Set the attach limit so the trampoline rejects excess attaches.
+	 */
+	if (btf_id == bpf_lsm_inode_init_security_btf_ids[0])
+		prog->aux->attach_limit = BPF_LSM_INODE_INIT_XATTRS;
+
 	return 0;
 }
 
@@ -315,6 +324,7 @@ BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
 BTF_ID(func, bpf_lsm_inode_getxattr)
+BTF_ID(func, bpf_lsm_inode_init_security)
 BTF_ID(func, bpf_lsm_inode_mknod)
 BTF_ID(func, bpf_lsm_inode_need_killpriv)
 BTF_ID(func, bpf_lsm_inode_post_setxattr)
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..b41b02173e24 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
+	if (node->link->prog->aux->attach_limit &&
+	    tr->progs_cnt[kind] >= node->link->prog->aux->attach_limit)
+		return -E2BIG;
 	if (!hlist_unhashed(&node->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..d7c44c5c0e30 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a..e0a05162accc 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
  * evm_inode_init_security - initializes security.evm HMAC value
  */
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count)
+			    const struct qstr *qstr,
+			    struct xattr_ctx *xattr_ctx)
 {
 	struct evm_xattr *xattr_data;
 	struct xattr *xattr, *evm_xattr;
+	struct xattr *xattrs;
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	xattrs = xattr_ctx ? xattr_ctx->xattrs : NULL;
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1087,7 +1089,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!evm_protected_xattrs)
 		return 0;
 
-	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	evm_xattr = lsm_get_xattr_slot(xattr_ctx);
 	/*
 	 * Array terminator (xattr name = NULL) must be the first non-filled
 	 * xattr slot.
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..8f82a1352356 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1334,6 +1334,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
+	struct xattr_ctx xattr_ctx;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1349,10 +1350,12 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		if (!new_xattrs)
 			return -ENOMEM;
 	}
+	xattr_ctx.xattrs = new_xattrs;
+	xattr_ctx.xattr_count = &xattr_count;
 
 	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
+							  &xattr_ctx);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 		/*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..faa8a6b9c45b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2962,7 +2962,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       struct xattr *xattrs, int *xattr_count)
+				       struct xattr_ctx *xattr_ctx)
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
@@ -2992,7 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	xattr = lsm_get_xattr_slot(xattr_ctx);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..8ed5648a0116 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,10 +981,10 @@ smk_rule_transmutes(struct smack_known *subject,
 }
 
 static int
-xattr_dupval(struct xattr *xattrs, int *xattr_count,
+xattr_dupval(struct xattr_ctx *xattr_ctx,
 	     const char *name, const void *value, unsigned int vallen)
 {
-	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr * const xattr = lsm_get_xattr_slot(xattr_ctx);
 
 	if (!xattr)
 		return 0;
@@ -1003,14 +1003,13 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @xattrs: where to put the attributes
- * @xattr_count: current number of LSM-provided xattrs (updated)
+ * @xattr_ctx: where to put attributes and update count
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
-				     struct xattr *xattrs, int *xattr_count)
+				     struct xattr_ctx *xattr_ctx)
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
+			if (xattr_dupval(xattr_ctx,
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
+		if (xattr_dupval(xattr_ctx,
+				 XATTR_SMACK_SUFFIX,
+				 issp->smk_inode->smk_known,
+				 strlen(issp->smk_inode->smk_known)))
 			rc = -ENOMEM;
 instant_inode:
 	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
-- 
2.53.0

