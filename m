Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6502F12B4
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868425; cv=none; b=LGdTercc86U93wFForsasFwwjd+Gog6Z7Q1iV9WDNs8vcEa/tpCfUqqvCkpyQqM7lPs7GqqtrZuQEzzSTsQ8VwElfyj5SWaKFDG/sgw//Mfwg84PaZxWsspMSXoBV6FMmp803ZMLD66xj8yJPGPPyfrheMAwCX24MiruThOHmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868425; c=relaxed/simple;
	bh=0W/XxKYDrKobOHY6fFsfH/V5rMKJYQxJcVMeczmlZng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPeat9a6neSNSEMXBMr98w9sOkxipC+zS8DlknILqS0pYBLvaPOYVIgQNyigY+XTjc9G73YLAyEdmbWwjUmNjs9vmmOmH5oXAGox4H1+ywL/62P/sT+r9B8xGY2VZkliZJA9d6DHzlHygv1+4iu/PnXOBo5bf0S4M/L40Rxld2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KALOSBV6; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KALOSBV6"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b3016c311bso117296785a.1
        for <selinux@vger.kernel.org>; Thu, 04 Dec 2025 09:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868421; x=1765473221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKvN4QKyYta3+eJYv2mHJXjGsDSNiqnwRkmAi8GriWU=;
        b=KALOSBV6bx3c3r9LoSkl7btUilgvvHYtBX6mdyfqWj9b60bSR0CUoixMDYSyjBtnLv
         RWN9fOCGY0CVSEs+v+e1grHHIb78OMnyQkEWx7aJZJqKeNnbfXCtScSiHQaM/TqrgG4b
         m0exhMG0c/iy88ovW5AGjVwUpGBSw90ods0bxjI0N3pyXx8lYKTDdjitNrNbS6YDLGGQ
         7cNP3sTUqZ9AaGhr5toAOOpYau6azrYcUN2R4+DulI1Hvyutygcypvwvcf0UwCs70nih
         y1fE8KLVy+BnaVndEaQdWwOpG3q5+ELeus5Ox+o/zTuLeDmaIw1YHbyLss/5IX80SXxS
         F3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868421; x=1765473221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKvN4QKyYta3+eJYv2mHJXjGsDSNiqnwRkmAi8GriWU=;
        b=IXxofBE1yO33x9RW/z4a4sxkHl2oMgEB+K5x5LwCITvIP/EwOtEb/tW3NENE6MWVPt
         rUmyo+LdJ8b4e7jxkHmvESRAZeRm3CUJMoe0F2hwSo0ulR0KIgEqTyMkVx1YVVDvLVB2
         Afz1tV2zHDQqAlNcZ8pA5PQCLjfnZn5dgh1HN+SbDGY2PX5sYpP4oAZeeaBwlC/R0lpz
         th0XQOpcvV0jWEA/TNxaZWaisoFw7vZovVXf5KYJfW7/uEpUfNLPa24iQnY62+1JUnvT
         ffgNa1XnHSawYUxCEFA0QJMdsqwlqEJs1QDOxQgIEzcR7CxjZCXZUEZjDEKvL6QFO0Ny
         q0Ug==
X-Gm-Message-State: AOJu0Yxtc9QcKFxAaw47JTbpKeyxDTPfwQlptSUi525UMGo97W9Z+rkR
	UXbupha8EwM8/Ohlq18uR8pi3I4il7N+5P9JRs50FKGMjDAunqrI0TCdJDvrtVoJ
X-Gm-Gg: ASbGncsu1fSOoltHo3zpy8ZX+i3Pfopl9u+PE1JDQVP3eAMH7KMzOphJ5Mmt21uEEhO
	/cqTzgP3syN/rNR32Fx5XSDEGdXxtlNk3Nf+/K04B4RcE7n42K38ZyKydxa/csGoSy7H51g6T8e
	PCssVjupcGIIMd96+LZ8KJBGb73MS5FPhYMPmnpp5vPeE6ZTXF+pusmXZiP8GNQdg4Yrl/8UvfD
	PQTxvsgiLW5Br34lNtNpm9iAN4ofXmCuWLF7SqxohTa9DQZWBdtUFI2NavXE+Y5FmliHa3pQxUn
	iSUGCu7ZeMjh71u/v1+RCgFvkQ3MX8p8QumKqZEWuLt3zhlH9jt0czMgDC+2OUrq+gPI9j5f2vj
	h9H0/MbnhgDFAHR9Kb7dVxQvdOFlVovEY89yJK0nj2c83pze7aPW7x3m+q8ZR1Fq4mELT8xM6iL
	Em6BJ/Ue6dY/DBAgk6czxsksgzRChNI6thA7hlhKi0yS7veGfPH+1Q3L3GVHeAVLYfB4OXa2rEq
	9BzW2Y8xAogyhkH7nXmoqimHg==
X-Google-Smtp-Source: AGHT+IFnyvsksrH4P5OSUy5JEH/PNakxNJTOaC26RzevCJtbIZOKfMDlXq4K1SFyWtgNRqlSd6C2Hg==
X-Received: by 2002:a05:620a:4489:b0:8b2:f1f3:9021 with SMTP id af79cd13be357-8b5e47cf477mr1019788085a.5.1764868420513;
        Thu, 04 Dec 2025 09:13:40 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a7a864sm174938685a.26.2025.12.04.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:13:39 -0800 (PST)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [RFC PATCH selinuxns] selinux: optimize context string handling and global sidtab
Date: Thu,  4 Dec 2025 17:12:22 +0000
Message-ID: <20251204171222.12148-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Changed context structs to always hold the context string.
Context strings must always be held in the global sidtab anyway, so this
avoids needing to frequently allocate and free the context strings.
Context validity is now determined by the user field being set rather
than the string field being empty. Removed sid2str cache since context
strings no longer have to be generated at runtime. Removed unnecessary
string copies in the global sidtab, and updated callers to avoid freeing
context strings. This makes accessing contexts quicker at runtime at
the cost of some additional memory overhead.

KASAN and kmemleak were used to ensure that the patch did not introduce
any double-frees or memory leaks.

Performance data was collected to measure both the performance gain and
memory usage increase.

We used the following command to test runtime for an operation involving
heavy use of security contexts. Other performance measurements like
kcbench showed virtually no change in runtime. This command accesses
file contexts many times, calling the relevant functions to
produce/retrieve context strings.

perf stat setfiles -n /etc/selinux/targeted/contexts/files/file_contexts /

The command was run 5 times and the results were averaged.

Without Patch:

Average Cycles: 13972133072
Average Seconds (Sys): 3.6534178

With Patch:

Average Cycles: 13713806342.4
Average Seconds (Sys): 3.3724038

The command ran ~8.33% faster (in terms of sys seconds) and used ~1.88%
less cycles on average with the patch than without.

We added some additional code to the sidtab_hash_stats() function to
print the total length of all cached context strings and measure memory
overhead.

Without Patch:

entries: 378
context length (rounded): 0 (bytes)

With Patch:

entries: 378
context length (rounded): 21792 (bytes)

The patch used ~22 kb of additional memory.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 security/selinux/Kconfig           |  11 --
 security/selinux/avc.c             |   4 -
 security/selinux/global_sidtab.c   |  19 +-
 security/selinux/hooks.c           |  33 ++--
 security/selinux/include/context.h |  19 +-
 security/selinux/include/sidtab.h  |  29 ---
 security/selinux/selinuxfs.c       |   7 -
 security/selinux/ss/context.c      |  14 +-
 security/selinux/ss/policydb.c     |  10 +-
 security/selinux/ss/services.c     | 301 +++++++++++------------------
 security/selinux/ss/services.h     |   5 +
 security/selinux/ss/sidtab.c       | 101 +---------
 security/selinux/xfrm.c            |   1 -
 13 files changed, 163 insertions(+), 391 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 76d12be7bab6..e26ad833183b 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -58,17 +58,6 @@ config SECURITY_SELINUX_SIDTAB_HASH_BITS
 	  chain lengths are high (e.g. > 20) then selecting a higher value here
 	  will ensure that lookups times are short and stable.
 
-config SECURITY_SELINUX_SID2STR_CACHE_SIZE
-	int "SELinux SID to context string translation cache size"
-	depends on SECURITY_SELINUX
-	default 256
-	help
-	  This option defines the size of the internal SID -> context string
-	  cache, which improves the performance of context to string
-	  conversion.  Setting this option to 0 disables the cache completely.
-
-	  If unsure, keep the default value.
-
 config SECURITY_SELINUX_AVC_HASH_BITS
 	int "SELinux avc hashtable size"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b1d6d91c9f38..019c789eadc2 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -744,8 +744,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 
 	trace_selinux_audited(sad, scontext, tcontext, tclass);
-	kfree(tcontext);
-	kfree(scontext);
 
 	/* in case of invalid context report also the actual context string */
 	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
@@ -755,7 +753,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 			scontext_len--;
 		audit_log_format(ab, " srawcon=");
 		audit_log_n_untrustedstring(ab, scontext, scontext_len);
-		kfree(scontext);
 	}
 
 	rc = security_sid_to_context_inval(sad->state, sad->tsid, &scontext,
@@ -765,7 +762,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 			scontext_len--;
 		audit_log_format(ab, " trawcon=");
 		audit_log_n_untrustedstring(ab, scontext, scontext_len);
-		kfree(scontext);
 	}
 }
 
diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index e1acf6607788..67cecfd5c51a 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -53,19 +53,7 @@ static int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 		return -EINVAL;
 	}
 	*scontext_len = ctx->len;
-	/*
-	 * Could eliminate allocation + copy if callers do not free
-	 * since the global sidtab entries are never freed.
-	 * This however would not match the current expectation
-	 * of callers of security_sid_to_context().
-	 * TODO: Update all callers and get rid of this copy.
-	 */
-	*scontext = kstrdup(ctx->str, GFP_ATOMIC);
-	if (!(*scontext)) {
-		rcu_read_unlock();
-		*scontext_len = 0;
-		return -ENOMEM;
-	}
+	*scontext = ctx->str;
 
 	rcu_read_unlock();
 	return 0;
@@ -197,7 +185,6 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 		spin_unlock_irqrestore(&global_sidtab.lock, flags);
 	}
 #endif
-	kfree(scontext);
 	return rc;
 }
 
@@ -225,7 +212,6 @@ static int map_ss_sid_to_global(struct selinux_state *state, u32 ss_sid,
 
 	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
 				   out_sid, GFP_ATOMIC);
-	kfree(scontext);
 	return rc;
 }
 
@@ -318,7 +304,6 @@ int security_context_to_sid(struct selinux_state *state, const char *scontext,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
 	return rc;
 }
 
@@ -366,7 +351,6 @@ int security_context_to_sid_default(struct selinux_state *state,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
 	return rc;
 }
 
@@ -405,7 +389,6 @@ int security_context_to_sid_force(struct selinux_state *state,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7003a3f96ead..4def6a70ca6e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1096,7 +1096,6 @@ static int show_sid(struct seq_file *m, u32 sid)
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
-	kfree(context);
 	return rc;
 }
 
@@ -3005,6 +3004,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	u16 newsclass;
 	int rc;
 	char *context;
+	char *value;
 
 	sbsec = selinux_superblock(dir->i_sb);
 
@@ -3031,7 +3031,12 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 						   &context, &clen);
 		if (rc)
 			return rc;
-		xattr->value = context;
+
+		value = kstrdup(context, GFP_ATOMIC);
+		if (!(value))
+			return -ENOMEM;
+
+		xattr->value = value;
 		xattr->value_len = clen;
 		xattr->name = XATTR_SELINUX_SUFFIX;
 	}
@@ -3710,11 +3715,10 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 		return error;
 	error = size;
 	if (alloc) {
-		*buffer = context;
-		goto out_nofree;
+		*buffer = kstrdup(context, GFP_ATOMIC);
+		if (!(*buffer))
+			return -ENOMEM;
 	}
-	kfree(context);
-out_nofree:
 	return error;
 }
 
@@ -3865,7 +3869,6 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 
 	rc = kernfs_xattr_set(kn, XATTR_NAME_SELINUX, context, clen,
 			      XATTR_CREATE);
-	kfree(context);
 	return rc;
 }
 
@@ -5550,7 +5553,6 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 out_len:
 	if (copy_to_sockptr(optlen, &scontext_len, sizeof(scontext_len)))
 		err = -EFAULT;
-	kfree(scontext);
 	return err;
 }
 
@@ -7023,10 +7025,18 @@ static int selinux_getprocattr(struct task_struct *p,
 			       const char *name, char **value)
 {
 	unsigned int attr = lsm_name_to_attr(name);
+	char *context;
 	int rc;
 
 	if (attr) {
-		rc = selinux_lsm_getattr(attr, p, value);
+		rc = selinux_lsm_getattr(attr, p, &context);
+
+		if (rc > 0) {
+			*value = kstrdup(context, GFP_ATOMIC);
+			if (!(*value))
+				return -ENOMEM;
+		}
+
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
@@ -7083,7 +7093,6 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 static void selinux_release_secctx(struct lsm_context *cp)
 {
 	if (cp->id == LSM_ID_SELINUX) {
-		kfree(cp->context);
 		cp->context = NULL;
 		cp->id = LSM_ID_UNDEF;
 	}
@@ -7202,7 +7211,9 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 				     &context, &len);
 	if (!rc)
 		rc = len;
-	*_buffer = context;
+	*_buffer = kstrdup(context, GFP_ATOMIC);
+	if (!(*_buffer))
+		return -ENOMEM;
 	return rc;
 }
 
diff --git a/security/selinux/include/context.h b/security/selinux/include/context.h
index dd3b9b5b588e..cff6d2329ef5 100644
--- a/security/selinux/include/context.h
+++ b/security/selinux/include/context.h
@@ -31,7 +31,7 @@ struct context {
 	u32 type;
 	u32 len; /* length of string in bytes */
 	struct mls_range range;
-	char *str; /* string representation if context cannot be mapped. */
+	char *str; /* string representation */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -160,15 +160,10 @@ static inline int context_cpy(struct context *dst, const struct context *src)
 	dst->user = src->user;
 	dst->role = src->role;
 	dst->type = src->type;
-	if (src->str) {
-		dst->str = kstrdup(src->str, GFP_ATOMIC);
-		if (!dst->str)
-			return -ENOMEM;
-		dst->len = src->len;
-	} else {
-		dst->str = NULL;
-		dst->len = 0;
-	}
+	dst->str = kstrdup(src->str, GFP_ATOMIC);
+	if (!dst->str)
+		return -ENOMEM;
+	dst->len = src->len;
 	rc = mls_context_cpy(dst, src);
 	if (rc) {
 		kfree(dst->str);
@@ -191,9 +186,9 @@ static inline void context_destroy(struct context *c)
 static inline bool context_equal(const struct context *c1,
 				 const struct context *c2)
 {
-	if (c1->len && c2->len)
+	if (!c1->user && !c2->user)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
-	if (c1->len || c2->len)
+	if (!c1->user || !c2->user)
 		return 0;
 	return ((c1->user == c2->user) && (c1->role == c2->role) &&
 		(c1->type == c2->type) && mls_context_equal(c1, c2));
diff --git a/security/selinux/include/sidtab.h b/security/selinux/include/sidtab.h
index 2df3ac0df935..5fd841f6c33b 100644
--- a/security/selinux/include/sidtab.h
+++ b/security/selinux/include/sidtab.h
@@ -32,9 +32,6 @@ struct sidtab_entry {
 	u32 sid;
 	u32 hash;
 	struct context context;
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	struct sidtab_str_cache __rcu *cache;
-#endif
 	struct hlist_node list;
 #ifdef CONFIG_SECURITY_SELINUX_NS
 	u32 ss_sid;
@@ -107,13 +104,6 @@ struct sidtab {
 	bool frozen;
 	spinlock_t lock;
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	/* SID -> context string cache */
-	u32 cache_free_slots;
-	struct list_head cache_lru_list;
-	spinlock_t cache_lock;
-#endif
-
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
 
@@ -160,25 +150,6 @@ void sidtab_destroy(struct sidtab *s);
 
 int sidtab_hash_stats(struct sidtab *sidtab, char *page);
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
-			const char *str, u32 str_len);
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
-		       u32 *out_len);
-#else
-static inline void sidtab_sid2str_put(struct sidtab *s,
-				      struct sidtab_entry *entry,
-				      const char *str, u32 str_len)
-{
-}
-static inline int sidtab_sid2str_get(struct sidtab *s,
-				     struct sidtab_entry *entry, char **out,
-				     u32 *out_len)
-{
-	return -ENOENT;
-}
-#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
-
 #ifdef CONFIG_SECURITY_SELINUX_NS
 #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
 extern void sidtab_invalidate_state(struct sidtab *s,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 72a6fa8a91e4..637ab4ed101e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -835,7 +835,6 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	memcpy(buf, canon, len);
 	length = len;
 out:
-	kfree(canon);
 	return length;
 }
 
@@ -1208,7 +1207,6 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	memcpy(buf, newcon, len);
 	length = len;
 out:
-	kfree(newcon);
 	kfree(namebuf);
 	kfree(tcon);
 	kfree(scon);
@@ -1274,7 +1272,6 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	memcpy(buf, newcon, len);
 	length = len;
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
@@ -1348,12 +1345,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 			goto out;
 		}
 		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
-			kfree(newcon);
 			length = -ERANGE;
 			goto out;
 		}
 		memcpy(ptr, newcon, len);
-		kfree(newcon);
 		ptr += len;
 		length += len;
 	}
@@ -1426,7 +1421,6 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	memcpy(buf, newcon, len);
 	length = len;
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
@@ -1933,7 +1927,6 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 		return ret;
 
 	ret = simple_read_from_buffer(buf, count, ppos, con, len);
-	kfree(con);
 	return ret;
 }
 
diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
index a528b7f76280..47cdec24f85d 100644
--- a/security/selinux/ss/context.c
+++ b/security/selinux/ss/context.c
@@ -16,14 +16,14 @@ u32 context_compute_hash(const struct context *c)
 	u32 hash = 0;
 
 	/*
-	 * If a context is invalid, it will always be represented by a
-	 * context struct with only the len & str set (and vice versa)
-	 * under a given policy. Since context structs from different
-	 * policies should never meet, it is safe to hash valid and
-	 * invalid contexts differently. The context_equal() function
-	 * already operates under the same assumption.
+	 * If a context is invalid, it will never have user set
+	 * (and vice versa) under a given policy. Since context
+	 * structs from different policies should never meet,
+	 * it is safe to hash valid and invalid contexts differently.
+	 * The context_equal() function already operates under the
+	 * under the same assumption.
 	 */
-	if (c->len)
+	if (!c->user)
 		return full_name_hash(NULL, c->str, c->len);
 
 	hash = jhash_3words(c->user, c->role, c->type, hash);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 91df3db6a88c..f0890f4c158e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1066,6 +1066,8 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
 {
 	__le32 buf[3];
 	int rc;
+	char *str = NULL;
+	u32 str_len = 0;
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc) {
@@ -1089,7 +1091,13 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
 		context_destroy(c);
 		goto out;
 	}
-	rc = 0;
+	rc = context_struct_to_string(p, c, &str, &str_len);
+	if (rc) {
+		context_destroy(c);
+		goto out;
+	}
+	c->str = str;
+	c->len = str_len;
 out:
 	return rc;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index acbb91e18b38..242b47af0991 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -75,11 +75,6 @@ struct selinux_policy_convert_data {
 };
 
 /* Forward declaration. */
-static int context_struct_to_string(struct policydb *policydb,
-				    struct context *context,
-				    char **scontext,
-				    u32 *scontext_len);
-
 static int sidtab_entry_to_string(struct policydb *policydb,
 				  struct sidtab *sidtab,
 				  struct sidtab_entry *entry,
@@ -464,11 +459,8 @@ static void security_dump_masked_av(struct policydb *policydb,
 	struct class_datum *tclass_dat;
 	struct audit_buffer *ab;
 	char *tclass_name;
-	char *scontext_name = NULL;
-	char *tcontext_name = NULL;
 	char *permission_names[32];
 	int index;
-	u32 length;
 	bool need_comma = false;
 
 	if (!permissions)
@@ -482,30 +474,21 @@ static void security_dump_masked_av(struct policydb *policydb,
 	if (common_dat &&
 	    hashtab_map(&common_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
-		goto out;
+		return;
 
 	if (hashtab_map(&tclass_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
-		goto out;
-
-	/* get scontext/tcontext in text form */
-	if (context_struct_to_string(policydb, scontext,
-				     &scontext_name, &length) < 0)
-		goto out;
-
-	if (context_struct_to_string(policydb, tcontext,
-				     &tcontext_name, &length) < 0)
-		goto out;
+		return;
 
 	/* audit a message */
 	ab = audit_log_start(audit_context(),
 			     GFP_ATOMIC, AUDIT_SELINUX_ERR);
 	if (!ab)
-		goto out;
+		return;
 
 	audit_log_format(ab, "op=security_compute_av reason=%s "
 			 "scontext=%s tcontext=%s tclass=%s perms=",
-			 reason, scontext_name, tcontext_name, tclass_name);
+			 reason, scontext->str, tcontext->str, tclass_name);
 
 	for (index = 0; index < 32; index++) {
 		u32 mask = (1 << index);
@@ -520,10 +503,6 @@ static void security_dump_masked_av(struct policydb *policydb,
 		need_comma = true;
 	}
 	audit_log_end(ab);
-out:
-	/* release scontext/tcontext */
-	kfree(tcontext_name);
-	kfree(scontext_name);
 }
 
 /*
@@ -745,10 +724,6 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
 		  o, n, t, sym_name(p, SYM_CLASSES, tclass-1));
 out:
-	kfree(o);
-	kfree(n);
-	kfree(t);
-
 	if (!enforcing_enabled(state))
 		return 0;
 	return -EPERM;
@@ -938,8 +913,6 @@ int selinux_ss_bounded_transition(struct selinux_state *state,
 				  "oldcontext=%s newcontext=%s",
 				  old_name, new_name);
 		}
-		kfree(new_name);
-		kfree(old_name);
 	}
 out:
 	rcu_read_unlock();
@@ -1269,7 +1242,7 @@ void selinux_ss_compute_av_user(struct selinux_state *state,
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-static int context_struct_to_string(struct policydb *p,
+int context_struct_to_string(struct policydb *p,
 				    struct context *context,
 				    char **scontext, u32 *scontext_len)
 {
@@ -1324,16 +1297,10 @@ static int sidtab_entry_to_string(struct policydb *p,
 				  struct sidtab_entry *entry,
 				  char **scontext, u32 *scontext_len)
 {
-	int rc = sidtab_sid2str_get(sidtab, entry, scontext, scontext_len);
+	*scontext = entry->context.str;
+	*scontext_len = entry->context.len;
 
-	if (rc != -ENOENT)
-		return rc;
-
-	rc = context_struct_to_string(p, &entry->context, scontext,
-				      scontext_len);
-	if (!rc && scontext)
-		sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_len);
-	return rc;
+	return 0;
 }
 
 #include "initial_sid_to_string.h"
@@ -1425,7 +1392,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	if (only_invalid && !entry->context.len)
+	if (only_invalid && entry->context.user)
 		goto out_unlock;
 
 	rc = sidtab_entry_to_string(policydb, sidtab, entry, scontext,
@@ -1573,6 +1540,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	char *scontext2, *str = NULL;
+	u32 str_len = 0;
 	struct context context;
 	int rc = 0;
 
@@ -1600,13 +1568,13 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	}
 	*sid = SECSID_NULL;
 
-	if (force) {
-		/* Save another copy for storing in uninterpreted form */
-		rc = -ENOMEM;
-		str = kstrdup(scontext2, gfp_flags);
-		if (!str)
-			goto out;
-	}
+	/* Save another copy for storing in uninterpreted form */
+	rc = -ENOMEM;
+	str = kstrdup(scontext2, gfp_flags);
+	if (!str)
+		goto out;
+	str_len = strlen(scontext2) + 1;
+
 retry:
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
@@ -1614,19 +1582,24 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	sidtab = policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
-	if (rc == -EINVAL && force) {
-		context.str = str;
-		context.len = strlen(str) + 1;
-		str = NULL;
-	} else if (rc)
+	if (rc && !(rc == -EINVAL && force))
 		goto out_unlock;
+	if (rc != -EINVAL) {
+		kfree(str);
+		str = NULL;
+		rc = context_struct_to_string(policydb, &context, &str, &str_len);
+		if (rc)
+			goto out_unlock;
+	}
+	context.str = str;
+	context.len = str_len;
+	str = NULL;
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	if (rc == -ESTALE) {
 		rcu_read_unlock();
-		if (context.str) {
-			str = context.str;
-			context.str = NULL;
-		}
+		str = context.str;
+		context.str = NULL;
+		context.len = 0;
 		context_destroy(&context);
 		goto retry;
 	}
@@ -1713,30 +1686,25 @@ static int compute_sid_handle_invalid_context(
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	char *s = NULL, *t = NULL, *n = NULL;
-	u32 slen, tlen, nlen;
+	char *s = NULL, *t = NULL;
+	u32 slen, tlen;
 	struct audit_buffer *ab;
 
 	if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
 		goto out;
 	if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
 		goto out;
-	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
-		goto out;
 	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
 	if (!ab)
 		goto out;
 	audit_log_format(ab,
 			 "op=security_compute_sid invalid_context=");
 	/* no need to record the NUL with untrusted strings */
-	audit_log_n_untrustedstring(ab, n, nlen - 1);
+	audit_log_n_untrustedstring(ab, newcontext->str, newcontext->len - 1);
 	audit_log_format(ab, " scontext=%s tcontext=%s tclass=%s",
 			 s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
 	audit_log_end(ab);
 out:
-	kfree(s);
-	kfree(t);
-	kfree(n);
 	if (!enforcing_enabled(state))
 		return 0;
 	return -EACCES;
@@ -1792,6 +1760,8 @@ static int security_compute_sid(struct selinux_state *state,
 	u16 tclass;
 	int rc = 0;
 	bool sock;
+	char *str = NULL;
+	u32 str_len = 0;
 
 	if (!selinux_initialized(state)) {
 		switch (orig_tclass) {
@@ -1943,6 +1913,13 @@ static int security_compute_sid(struct selinux_state *state,
 	if (rc)
 		goto out_unlock;
 
+	/* Set the context string */
+	rc = context_struct_to_string(policydb, &newcontext, &str, &str_len);
+	if (rc)
+		goto out_unlock;
+	newcontext.str = str;
+	newcontext.len = str_len;
+
 	/* Check the validity of the context. */
 	if (!policydb_context_isvalid(policydb, &newcontext)) {
 		rc = compute_sid_handle_invalid_context(state, policy, sentry,
@@ -2056,19 +2033,14 @@ int selinux_ss_change_sid(struct selinux_state *state,
 
 static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
-	struct policydb *policydb,
 	struct context *context)
 {
-	char *s;
-	u32 len;
-
 	if (enforcing_enabled(state))
 		return -EINVAL;
 
-	if (!context_struct_to_string(policydb, context, &s, &len)) {
+	if (!context->str) {
 		pr_warn("SELinux:  Context %s would be invalid if enforcing\n",
-			s);
-		kfree(s);
+			context->str);
 	}
 	return 0;
 }
@@ -2089,114 +2061,32 @@ int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
 			     gfp_t gfp_flags)
 {
-	struct ocontext *oc;
-	struct role_datum *role;
-	struct type_datum *typdatum;
-	struct user_datum *usrdatum;
 	char *s;
-	u32 len;
 	int rc;
 
-	if (oldc->str) {
-		s = kstrdup(oldc->str, gfp_flags);
-		if (!s)
-			return -ENOMEM;
+	s = kstrdup(oldc->str, gfp_flags);
+	if (!s)
+		return -ENOMEM;
 
-		rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
-		if (rc == -EINVAL) {
-			/*
-			 * Retain string representation for later mapping.
-			 *
-			 * IMPORTANT: We need to copy the contents of oldc->str
-			 * back into s again because string_to_context_struct()
-			 * may have garbled it.
-			 */
-			memcpy(s, oldc->str, oldc->len);
-			context_init(newc);
-			newc->str = s;
-			newc->len = oldc->len;
-			return 0;
-		}
+	rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
+	if (rc && rc != -EINVAL) {
+		/* Other error condition, e.g. ENOMEM. */
+		pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
+			oldc->str, -rc);
 		kfree(s);
-		if (rc) {
-			/* Other error condition, e.g. ENOMEM. */
-			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
-			       oldc->str, -rc);
-			return rc;
-		}
-		pr_info("SELinux:  Context %s became valid (mapped).\n",
-			oldc->str);
-		return 0;
-	}
-
-	context_init(newc);
-
-	/* Convert the user. */
-	usrdatum = symtab_search(&args->newp->p_users,
-				 sym_name(args->oldp, SYM_USERS, oldc->user - 1));
-	if (!usrdatum)
-		goto bad;
-	newc->user = usrdatum->value;
-
-	/* Convert the role. */
-	role = symtab_search(&args->newp->p_roles,
-			     sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
-	if (!role)
-		goto bad;
-	newc->role = role->value;
-
-	/* Convert the type. */
-	typdatum = symtab_search(&args->newp->p_types,
-				 sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
-	if (!typdatum)
-		goto bad;
-	newc->type = typdatum->value;
-
-	/* Convert the MLS fields if dealing with MLS policies */
-	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
-		rc = mls_convert_context(args->oldp, args->newp, oldc, newc);
-		if (rc)
-			goto bad;
-	} else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
-		/*
-		 * Switching between non-MLS and MLS policy:
-		 * ensure that the MLS fields of the context for all
-		 * existing entries in the sidtab are filled in with a
-		 * suitable default value, likely taken from one of the
-		 * initial SIDs.
-		 */
-		oc = args->newp->ocontexts[OCON_ISID];
-		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
-			oc = oc->next;
-		if (!oc) {
-			pr_err("SELinux:  unable to look up"
-				" the initial SIDs list\n");
-			goto bad;
-		}
-		rc = mls_range_set(newc, &oc->context[0].range);
-		if (rc)
-			goto bad;
-	}
-
-	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(args->newp, newc)) {
-		rc = convert_context_handle_invalid_context(args->state,
-							    args->oldp, oldc);
-		if (rc)
-			goto bad;
+		return rc;
 	}
 
-	return 0;
-bad:
-	/* Map old representation to string and save it. */
-	rc = context_struct_to_string(args->oldp, oldc, &s, &len);
-	if (rc)
-		return rc;
-	context_destroy(newc);
+	/*
+	 * Retain string representation for later mapping.
+	 *
+	 * IMPORTANT: We need to copy the contents of oldc->str
+	 * back into s again because string_to_context_struct()
+	 * may have garbled it.
+	 */
+	memcpy(s, oldc->str, oldc->len);
 	newc->str = s;
-	newc->len = len;
-	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
-		newc->str);
+	newc->len = oldc->len;
 	return 0;
 }
 
@@ -2835,6 +2725,8 @@ int selinux_ss_get_user_sids(struct selinux_state *state,
 	struct context *fromcon, usercon;
 	u32 *mysids = NULL, *mysids2, sid;
 	u32 i, j, mynel, maxnel = SIDS_NEL;
+	char *str = NULL;
+	u32 str_len = 0;
 	struct user_datum *user;
 	struct role_datum *role;
 	struct ebitmap_node *rnode, *tnode;
@@ -2881,7 +2773,18 @@ int selinux_ss_get_user_sids(struct selinux_state *state,
 						 &usercon))
 				continue;
 
+			/* Set the context string */
+			rc = context_struct_to_string(policydb, &usercon, &str, &str_len);
+			if (rc) {
+				context_destroy(&usercon);
+				goto out_unlock;
+			}
+			usercon.str = str;
+			usercon.len = str_len;
+
 			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			/* all done with usercon, free it */
+			context_destroy(&usercon);
 			if (rc == -ESTALE) {
 				rcu_read_unlock();
 				goto retry;
@@ -3302,8 +3205,8 @@ int selinux_ss_sid_mls_copy(struct selinux_state *state,
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
-	char *s;
-	u32 len;
+	char *s = NULL;
+	u32 len = 0;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -3348,25 +3251,27 @@ int selinux_ss_sid_mls_copy(struct selinux_state *state,
 	if (rc)
 		goto out_unlock;
 
+	rc = context_struct_to_string(policydb, &newcon, &s, &len);
+	if (rc)
+		goto out_unlock;
+	newcon.str = s;
+	newcon.len = len;
+
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(policydb, &newcon)) {
-		rc = convert_context_handle_invalid_context(state, policydb,
+		rc = convert_context_handle_invalid_context(state,
 							&newcon);
 		if (rc) {
-			if (!context_struct_to_string(policydb, &newcon, &s,
-						      &len)) {
-				struct audit_buffer *ab;
-
-				ab = audit_log_start(audit_context(),
-						     GFP_ATOMIC,
-						     AUDIT_SELINUX_ERR);
-				audit_log_format(ab,
-						 "op=security_sid_mls_copy invalid_context=");
-				/* don't record NUL with untrusted strings */
-				audit_log_n_untrustedstring(ab, s, len - 1);
-				audit_log_end(ab);
-				kfree(s);
-			}
+			struct audit_buffer *ab;
+
+			ab = audit_log_start(audit_context(),
+					     GFP_ATOMIC,
+					     AUDIT_SELINUX_ERR);
+			audit_log_format(ab,
+					 "op=security_sid_mls_copy invalid_context=");
+			/* don't record NUL with untrusted strings */
+			audit_log_n_untrustedstring(ab, s, len - 1);
+			audit_log_end(ab);
 			goto out_unlock;
 		}
 	}
@@ -3970,6 +3875,8 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
+	char *str = NULL;
+	u32 str_len = 0;
 
 	if (!selinux_initialized(state)) {
 		*sid = SECSID_NULL;
@@ -4007,8 +3914,22 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
 			goto out;
 		}
 
+		rc = context_struct_to_string(policydb, &ctx_new, &str, &str_len);
+		if (rc) {
+			ebitmap_destroy(&ctx_new.range.level[0].cat);
+			goto out;
+		}
+		ctx_new.str = str;
+		ctx_new.len = str_len;
+
 		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
+		/*
+		 * Done with ctx_new, free its allocated memory.
+		 * NB we cannot use context_destroy here due to
+		 * level[1] being aliased.
+		 */
 		ebitmap_destroy(&ctx_new.range.level[0].cat);
+		kfree(str);
 		if (rc == -ESTALE) {
 			rcu_read_unlock();
 			goto retry;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 8696f9300529..e53c7d677359 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -45,4 +45,9 @@ int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
 			     gfp_t gfp_flags);
 
+int context_struct_to_string(struct policydb *policydb,
+				    struct context *context,
+				    char **scontext,
+				    u32 *scontext_len);
+
 #endif /* _SS_SERVICES_H_ */
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index eea37f78bec9..36e76f80fb9b 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -21,14 +21,6 @@
 #include "sidtab.h"
 #include "services.h"
 
-struct sidtab_str_cache {
-	struct rcu_head rcu_member;
-	struct list_head lru_member;
-	struct sidtab_entry *parent;
-	u32 len;
-	char str[] __counted_by(len);
-};
-
 #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
 #define sid_to_index(sid)   ((sid) - (SECINITSID_NUM + 1))
 
@@ -48,12 +40,6 @@ int sidtab_init(struct sidtab *s)
 
 	spin_lock_init(&s->lock);
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	s->cache_free_slots = CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE;
-	INIT_LIST_HEAD(&s->cache_lru_list);
-	spin_lock_init(&s->cache_lock);
-#endif
-
 	return 0;
 }
 
@@ -90,9 +76,6 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 	if (rc)
 		return rc;
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	isid->entry.cache = NULL;
-#endif
 	isid->set = 1;
 
 	hash = context_compute_hash(context);
@@ -248,7 +231,7 @@ static struct sidtab_entry *sidtab_search_core(struct sidtab *s, u32 sid,
 			entry = sidtab_lookup(s, sid_to_index(sid));
 		else
 			entry = sidtab_lookup_initial(s, sid);
-		if (entry && (!entry->context.len || force))
+		if (entry && (entry->context.user || force))
 			return entry;
 	}
 
@@ -520,9 +503,6 @@ void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
 static void sidtab_destroy_entry(struct sidtab_entry *entry)
 {
 	context_destroy(&entry->context);
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	kfree(rcu_dereference_raw(entry->cache));
-#endif
 }
 
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
@@ -570,85 +550,6 @@ void sidtab_destroy(struct sidtab *s)
 	 */
 }
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-
-void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
-			const char *str, u32 str_len)
-{
-	struct sidtab_str_cache *cache, *victim = NULL;
-	unsigned long flags;
-
-	/* do not cache invalid contexts */
-	if (entry->context.len)
-		return;
-
-	spin_lock_irqsave(&s->cache_lock, flags);
-
-	cache = rcu_dereference_protected(entry->cache,
-					  lockdep_is_held(&s->cache_lock));
-	if (cache) {
-		/* entry in cache - just bump to the head of LRU list */
-		list_move(&cache->lru_member, &s->cache_lru_list);
-		goto out_unlock;
-	}
-
-	cache = kmalloc(struct_size(cache, str, str_len), GFP_ATOMIC);
-	if (!cache)
-		goto out_unlock;
-
-	if (s->cache_free_slots == 0) {
-		/* pop a cache entry from the tail and free it */
-		victim = container_of(s->cache_lru_list.prev,
-				      struct sidtab_str_cache, lru_member);
-		list_del(&victim->lru_member);
-		rcu_assign_pointer(victim->parent->cache, NULL);
-	} else {
-		s->cache_free_slots--;
-	}
-	cache->parent = entry;
-	cache->len = str_len;
-	memcpy(cache->str, str, str_len);
-	list_add(&cache->lru_member, &s->cache_lru_list);
-
-	rcu_assign_pointer(entry->cache, cache);
-
-out_unlock:
-	spin_unlock_irqrestore(&s->cache_lock, flags);
-	kfree_rcu(victim, rcu_member);
-}
-
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
-		       u32 *out_len)
-{
-	struct sidtab_str_cache *cache;
-	int rc = 0;
-
-	if (entry->context.len)
-		return -ENOENT; /* do not cache invalid contexts */
-
-	rcu_read_lock();
-
-	cache = rcu_dereference(entry->cache);
-	if (!cache) {
-		rc = -ENOENT;
-	} else {
-		*out_len = cache->len;
-		if (out) {
-			*out = kmemdup(cache->str, cache->len, GFP_ATOMIC);
-			if (!*out)
-				rc = -ENOMEM;
-		}
-	}
-
-	rcu_read_unlock();
-
-	if (!rc && out)
-		sidtab_sid2str_put(s, entry, *out, *out_len);
-	return rc;
-}
-
-#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
-
 #ifdef CONFIG_SECURITY_SELINUX_NS
 #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
 static void sidtab_invalidate_state_entry(struct sidtab_entry *entry,
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 92fb31661e54..538d41c2b0a2 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -376,7 +376,6 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	x->security = ctx;
 	atomic_inc(&selinux_xfrm_refcount);
 out:
-	kfree(ctx_str);
 	return rc;
 }
 
-- 
2.51.0

