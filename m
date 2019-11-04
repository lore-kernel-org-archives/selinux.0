Return-Path: <SRS0=nnTv=Y4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA3CA9EB5
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 19:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EF420848
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 19:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uws1PcPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfKDTPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:15:46 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:35997 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDTPq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Nov 2019 14:15:46 -0500
Received: by mail-wr1-f73.google.com with SMTP id c6so10876167wrp.3
        for <selinux@vger.kernel.org>; Mon, 04 Nov 2019 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KiBQ1lXY/n0VLToIzsJw3OCJYRI+VCO29l43CwE84n0=;
        b=Uws1PcPgPy9ei5BzC0CxJgfOD1N2sCEGDNb6qUGCUWgor9nP8aGcxYW+NGe0WEpT3D
         w0nUFBJhkcl7/racNkma9uPqP6k+xOt+u3p2jQcrlotucIqlAEh7JyojzVn09ZMOnyx5
         /HQ4rAqeFMCtgihyOCoY/tbFJbNdPz/D9h0i8vVVQrbD2NdBPD38TFqg88ISqmOab8l6
         gs9F/6v7UhO32cu56saK/ypRZ+f53Me9eRmNidiHfrPm8Po0td3ENcPQlav3DIm+nN7l
         y+RPXOQZfyGrjhM4WlFnZfBlXi+32raZeK/4LOlAJsrqGRT7J+IIRn5ufQythS+uFQDU
         JHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KiBQ1lXY/n0VLToIzsJw3OCJYRI+VCO29l43CwE84n0=;
        b=uF8XCPzmGbTkstCWvLk5YIBFkvIn/7orexEbdCWQyvRmSEEGVToA+GSMF6YViDKpWR
         ITf6pwgLsqNx2EQj52Ij/lkBj3wJKynaMDqovgSvd9MXYAZzb0fKWFA4YKN7Tai3BSr1
         0C6H6st1PI9oTQ8Ik8L/lqlaCElJHiIS9UY1FNeXQEyty1BQ4+MStJFYCXuR5TEmcqn4
         QKte1Csto9SbKQg0b5opz86/mBeu9HgnOW0YLGLpxLBBh0fl5hvT04VBe/p7I88rzDT0
         B1oYGufl/vKaeBsAQSxxZ/d7vxd/xpAfou8IzO86y2Kn+kunkfZhhdqlV5MZEIpGuoeR
         2nyg==
X-Gm-Message-State: APjAAAWOvC5P4UAR+fvzaT4eAyxN9+QFI/pvu33ZZvgxbeYaA+7OqPub
        qBjG582sFmSjA2mbLuVqdgQN/JNRuszLBxMxHJD5/pzCCO90k/okOuAhEsBjKQYmIs56eEfhKSz
        YcnjhvpI/PCAvURoX8U4jbeRRyTjk04kRjjwQEqzDEKy7Vzsk+nUtXO/0eKzW
X-Google-Smtp-Source: APXvYqwoOq0HzGQ+6rJht9FEgNypBS9QLkksCGvMMk5if1MyFwotHZzI0MmLEfaTytQs7mMd2csoMn8FDw==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr13198731wrw.206.1572894941242;
 Mon, 04 Nov 2019 11:15:41 -0800 (PST)
Date:   Mon,  4 Nov 2019 20:15:35 +0100
Message-Id: <20191104191535.23642-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2] selinux: sidtab: reverse lookup hash table
From:   Jeff Vander Stoep <jeffv@google.com>
To:     selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This replaces the reverse table lookup and reverse cache with a
hashtable which improves cache-miss reverese-lookup times from
O(n) to O(1)* and maintains the same performance as a reverse
cache hit.

This reduces the time needed to add a new sidtab entry from ~500us
to 5us on a Pixel 3 when there are ~10,000 sidtab entries.

The implementation uses the kernel's generic hashtable API,
It uses the context's string represtation as the hash source,
and the kernels generic string hashing algorithm full_name_hash()
to reduce the string to a 32 bit value.

This change also maintains the improvement introduced in commit
ee1a84fd which removed the need to keep the current sidtab locked
during policy reload. It does however introduce periodic locking of
the target sidtab while converting the hashtable. Sidtab entries
are never modified or removed, so the context struct stored in the
sid_to_context tree can also be used for the context_to_sid
hashtable to reduce memory usage.

This bug was reported by:
- Stephen Smally on the selinux bug tracker.
  BUG: kernel softlockup due to too many SIDs/contexts #37
  https://github.com/SELinuxProject/selinux-kernel/issues/37
- Jovana Knezevic on Android's bugtracker.
  Bug: 140252993
  "During multi-user performance testing, we create and remove users
  many times. selinux_android_restorecon_pkgdir goes from 1ms to over
  20ms after about 200 user creations and removals. Accumulated over
  ~280 packages, that adds a significant time to user creation,
  making perf benchmarks unreliable."

* Hashtable lookup is only O(1) when n < the number of buckets.

Changes in V2:
-The hashtable uses sidtab_entry_leaf objects directly so these
objects are shared between the sid_to_context lookup tree and the
context_to_sid hashtable.
-Move the hash_add() statement to after the smp_store_release()
to ensure that the contents have been written before the object
becomes available in the hashtable.
-The new sidtab hash stats file in selinuxfs has been moved out of
the avc dir and into a new "ss" dir.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Reported-by: Jovana Knezevic <jovanak@google.com>
---
 security/selinux/Kconfig            |  12 ++
 security/selinux/include/security.h |   1 +
 security/selinux/selinuxfs.c        |  64 +++++++
 security/selinux/ss/context.h       |  11 +-
 security/selinux/ss/policydb.c      |   5 +
 security/selinux/ss/services.c      |  87 +++++++---
 security/selinux/ss/services.h      |   4 +-
 security/selinux/ss/sidtab.c        | 249 +++++++++++++---------------
 security/selinux/ss/sidtab.h        |  16 +-
 9 files changed, 287 insertions(+), 162 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 5711689deb6a..2d9788ad2d77 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -85,3 +85,15 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  via /selinux/checkreqprot if authorized by policy.
 
 	  If you are unsure how to answer this question, answer 0.
+
+config SECURITY_SELINUX_SIDTAB_HASH_BITS
+	int "NSA SELinux sidtab hashtable size"
+	depends on SECURITY_SELINUX
+	range 8 13
+	default 9
+	help
+	  This option sets the number of buckets used in the sitab hashtable
+	  to 2^SECURITY_SELINUX_SIDTAB_HASH_BITS buckets. The number of hash
+	  collisions may be viewed at /selinux/ss/sidtab_hash_stats. If chain
+	  lengths are high (e.g. > 20) than selecting a higher value here will
+	  ensure that lookups times are fast and stable.
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ae840634e3c7..8c0dbbd076c6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -395,5 +395,6 @@ extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern void avtab_cache_init(void);
 extern void ebitmap_cache_init(void);
 extern void hashtab_cache_init(void);
+extern int security_sidtab_hash_stats(struct selinux_state *state, char *page);
 
 #endif /* _SELINUX_SECURITY_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ee94fa469c29..996c6a0bc4e9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1482,6 +1482,32 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 	return length;
 }
 
+static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	char *page;
+	ssize_t length;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	length = security_sidtab_hash_stats(state, page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page,
+						length);
+	free_page((unsigned long)page);
+
+	return length;
+}
+
+static const struct file_operations sel_sidtab_hash_stats_ops = {
+	.read		= sel_read_sidtab_hash_stats,
+	.llseek		= generic_file_llseek,
+};
+
 static const struct file_operations sel_avc_cache_threshold_ops = {
 	.read		= sel_read_avc_cache_threshold,
 	.write		= sel_write_avc_cache_threshold,
@@ -1572,6 +1598,7 @@ static int sel_make_avc_files(struct dentry *dir)
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
 		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
+		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
 #endif
@@ -1599,6 +1626,35 @@ static int sel_make_avc_files(struct dentry *dir)
 	return 0;
 }
 
+static int sel_make_ss_files(struct dentry *dir)
+{
+	struct super_block *sb = dir->d_sb;
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+	int i;
+	static struct tree_descr files[] = {
+		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		struct inode *inode;
+		struct dentry *dentry;
+
+		dentry = d_alloc_name(dir, files[i].name);
+		if (!dentry)
+			return -ENOMEM;
+
+		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
+		if (!inode)
+			return -ENOMEM;
+
+		inode->i_fop = files[i].ops;
+		inode->i_ino = ++fsi->last_ino;
+		d_add(dentry, inode);
+	}
+
+	return 0;
+}
+
 static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -1963,6 +2019,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	ret = sel_make_avc_files(dentry);
+
+	dentry = sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto err;
+	}
+
+	ret = sel_make_ss_files(dentry);
 	if (ret)
 		goto err;
 
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 513e67f48878..3ba044fe02ed 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -31,6 +31,7 @@ struct context {
 	u32 len;        /* length of string in bytes */
 	struct mls_range range;
 	char *str;	/* string representation if context cannot be mapped. */
+	u32 hash;	/* a hash of the string representation */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -168,12 +169,13 @@ static inline int context_cpy(struct context *dst, struct context *src)
 		kfree(dst->str);
 		return rc;
 	}
+	dst->hash = src->hash;
 	return 0;
 }
 
 static inline void context_destroy(struct context *c)
 {
-	c->user = c->role = c->type = 0;
+	c->user = c->role = c->type = c->hash = 0;
 	kfree(c->str);
 	c->str = NULL;
 	c->len = 0;
@@ -182,6 +184,8 @@ static inline void context_destroy(struct context *c)
 
 static inline int context_cmp(struct context *c1, struct context *c2)
 {
+	if (c1->hash && c2->hash && (c1->hash != c2->hash))
+		return 0;
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
 	if (c1->len || c2->len)
@@ -192,5 +196,10 @@ static inline int context_cmp(struct context *c1, struct context *c2)
 		mls_context_cmp(c1, c2));
 }
 
+static inline unsigned int context_compute_hash(const char *s)
+{
+	return full_name_hash(NULL, s, strlen(s));
+}
+
 #endif	/* _SS_CONTEXT_H_ */
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e20624a68f5d..e369b0092cdf 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -878,6 +878,11 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			sidtab_destroy(s);
 			goto out;
 		}
+		rc = context_add_hash(p, &c->context[0]);
+		if (rc) {
+			sidtab_destroy(s);
+			goto out;
+		}
 
 		rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
 		if (rc) {
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a5813c7629c1..2f25ca2d9dde 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1257,6 +1257,17 @@ static int context_struct_to_string(struct policydb *p,
 
 #include "initial_sid_to_string.h"
 
+int security_sidtab_hash_stats(struct selinux_state *state, char *page)
+{
+	int rc;
+
+	read_lock(&state->ss->policy_rwlock);
+	rc = sidtab_hash_stats(state->ss->sidtab, page);
+	read_unlock(&state->ss->policy_rwlock);
+
+	return rc;
+}
+
 const char *security_get_initial_sid_context(u32 sid)
 {
 	if (unlikely(sid > SECINITSID_NUM))
@@ -1384,6 +1395,8 @@ static int string_to_context_struct(struct policydb *pol,
 	int rc = 0;
 
 	context_init(ctx);
+	/* hash the string before it gets mutated */
+	ctx->hash = context_compute_hash(scontext);
 
 	/* Parse the security context. */
 
@@ -1442,6 +1455,7 @@ static int string_to_context_struct(struct policydb *pol,
 	rc = -EINVAL;
 	if (!policydb_context_isvalid(pol, ctx))
 		goto out;
+
 	rc = 0;
 out:
 	if (rc)
@@ -1449,6 +1463,42 @@ static int string_to_context_struct(struct policydb *pol,
 	return rc;
 }
 
+int context_add_hash(struct policydb *policydb,
+		     struct context *context)
+{
+	int rc;
+	char *str;
+	int len;
+
+	if (context->str) {
+		context->hash = context_compute_hash(context->str);
+	} else {
+		rc = context_struct_to_string(policydb, context,
+					      &str, &len);
+		if (rc)
+			return rc;
+		context->hash = context_compute_hash(str);
+		kfree(str);
+	}
+	return 0;
+}
+
+static int context_to_sid(struct selinux_state *state,
+			  struct context *context, u32 *sid)
+{
+	int rc;
+	struct sidtab *sidtab = state->ss->sidtab;
+	struct policydb *policydb = &state->ss->policydb;
+
+	if (!context->hash) {
+		rc = context_add_hash(policydb, context);
+		if (rc)
+			return rc;
+	}
+
+	return sidtab_context_to_sid(sidtab, context, sid);
+}
+
 static int security_context_to_sid_core(struct selinux_state *state,
 					const char *scontext, u32 scontext_len,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
@@ -1501,7 +1551,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-	rc = sidtab_context_to_sid(sidtab, &context, sid);
+	rc = context_to_sid(state, &context, sid);
 	context_destroy(&context);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1805,7 +1855,7 @@ static int security_compute_sid(struct selinux_state *state,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+	rc = context_to_sid(state, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcontext);
@@ -2033,6 +2083,10 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			goto bad;
 	}
 
+	rc = context_add_hash(args->newp, newc);
+	if (rc)
+		goto bad;
+
 	return 0;
 bad:
 	/* Map old representation to string and save it. */
@@ -2280,9 +2334,7 @@ int security_port_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
-						   &c->sid[0]);
+			rc = context_to_sid(state, &c->context[0], &c->sid[0]);
 			if (rc)
 				goto out;
 		}
@@ -2374,9 +2426,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
-						   &c->sid[0]);
+			rc = context_to_sid(state, &c->context[0], &c->sid[0]);
 			if (rc)
 				goto out;
 		}
@@ -2416,14 +2466,10 @@ int security_netif_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(sidtab,
-						  &c->context[0],
-						  &c->sid[0]);
+			rc = context_to_sid(state, &c->context[0], &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[1],
-						   &c->sid[1]);
+			rc = context_to_sid(state, &c->context[1], &c->sid[1]);
 			if (rc)
 				goto out;
 		}
@@ -2601,7 +2647,7 @@ int security_get_user_sids(struct selinux_state *state,
 						 &usercon))
 				continue;
 
-			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			rc = context_to_sid(state, &usercon, &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2672,7 +2718,6 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2707,7 +2752,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 		goto out;
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(sidtab, &c->context[0], &c->sid[0]);
+		rc = context_to_sid(state, &c->context[0], &c->sid[0]);
 		if (rc)
 			goto out;
 	}
@@ -2770,8 +2815,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
-						   &c->sid[0]);
+			rc = context_to_sid(state, &c->context[0], &c->sid[0]);
 			if (rc)
 				goto out;
 		}
@@ -3026,8 +3070,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 			goto out_unlock;
 		}
 	}
-
-	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
+	rc = context_to_sid(state, &newcon, new_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcon);
@@ -3620,7 +3663,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		if (!mls_context_isvalid(policydb, &ctx_new))
 			goto out_free;
 
-		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
+		rc = context_to_sid(state, &ctx_new, sid);
 		if (rc)
 			goto out_free;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 9a36de860368..fc40640a9725 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -8,7 +8,7 @@
 #define _SS_SERVICES_H_
 
 #include "policydb.h"
-#include "sidtab.h"
+#include "context.h"
 
 /* Mapping for a single class */
 struct selinux_mapping {
@@ -39,4 +39,6 @@ void services_compute_xperms_drivers(struct extended_perms *xperms,
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					struct avtab_node *node);
 
+int context_add_hash(struct policydb *policydb, struct context *context);
+
 #endif	/* _SS_SERVICES_H_ */
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 7d49994e8d5f..31cdb4848d67 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -17,26 +17,37 @@
 #include "security.h"
 #include "sidtab.h"
 
+#define index_to_sid(index) (index + SECINITSID_NUM + 1)
+#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
+
 int sidtab_init(struct sidtab *s)
 {
 	u32 i;
 
 	memset(s->roots, 0, sizeof(s->roots));
 
-	/* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
-	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
-		s->rcache[i] = SIDTAB_MAX;
-
 	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;
 
 	s->count = 0;
 	s->convert = NULL;
+	hash_init(s->context_to_sid);
 
 	spin_lock_init(&s->lock);
 	return 0;
 }
 
+static u32 context_to_sid(struct sidtab *s, struct context *context)
+{
+	struct sidtab_entry_leaf *entry;
+
+	hash_for_each_possible(s->context_to_sid, entry, list, context->hash) {
+		if (context_cmp(&entry->context, context))
+			return entry->sid;
+	}
+	return 0;
+}
+
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 {
 	struct sidtab_isid_entry *entry;
@@ -47,14 +58,58 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 
 	entry = &s->isids[sid - 1];
 
-	rc = context_cpy(&entry->context, context);
+	rc = context_cpy(&entry->leaf.context, context);
 	if (rc)
 		return rc;
 
 	entry->set = 1;
+
+	/*
+	 * Multiple initial sids may map to the same context. Check that this
+	 * context is not already represented in the context_to_sid hashtable
+	 * to avoid duplicate entries and long linked lists upon hash
+	 * collision.
+	 */
+	if (!context_to_sid(s, context)) {
+		entry->leaf.sid = sid;
+		hash_add(s->context_to_sid, &entry->leaf.list, context->hash);
+	}
+
 	return 0;
 }
 
+int sidtab_hash_stats(struct sidtab *sidtab, char *page)
+{
+	int i;
+	int chain_len = 0;
+	int slots_used = 0;
+	int entries = 0;
+	int max_chain_len = 0;
+	int cur_bucket = 0;
+	struct sidtab_entry_leaf *entry;
+
+
+	hash_for_each(sidtab->context_to_sid, i, entry, list) {
+		entries++;
+		if (i == cur_bucket) {
+			chain_len++;
+			if (chain_len == 1)
+				slots_used++;
+		} else {
+			cur_bucket = i;
+			if (chain_len > max_chain_len)
+				max_chain_len = chain_len;
+			chain_len = 0;
+		}
+	}
+	if (chain_len > max_chain_len)
+		max_chain_len = chain_len;
+	return scnprintf(page, PAGE_SIZE, "context_to_sid:  %d entries and "
+			 "%d/%d buckets used, longest chain length %d\n",
+			 entries, slots_used, SIDTAB_HASH_BUCKETS,
+			 max_chain_len);
+}
+
 static u32 sidtab_level_from_count(u32 count)
 {
 	u32 capacity = SIDTAB_LEAF_ENTRIES;
@@ -88,7 +143,8 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 level)
 	return 0;
 }
 
-static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
+static struct sidtab_entry_leaf *sidtab_do_lookup(struct sidtab *s, u32 index,
+						  int alloc)
 {
 	union sidtab_entry_inner *entry;
 	u32 level, capacity_shift, leaf_index = index / SIDTAB_LEAF_ENTRIES;
@@ -125,7 +181,7 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
 		if (!entry->ptr_leaf)
 			return NULL;
 	}
-	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
+	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
 }
 
 static struct context *sidtab_lookup(struct sidtab *s, u32 index)
@@ -136,12 +192,12 @@ static struct context *sidtab_lookup(struct sidtab *s, u32 index)
 	if (index >= count)
 		return NULL;
 
-	return sidtab_do_lookup(s, index, 0);
+	return &sidtab_do_lookup(s, index, 0)->context;
 }
 
 static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
 {
-	return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
+	return s->isids[sid - 1].set ? &s->isids[sid - 1].leaf.context : NULL;
 }
 
 static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
@@ -150,7 +206,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 
 	if (sid != 0) {
 		if (sid > SECINITSID_NUM)
-			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
+			context = sidtab_lookup(s, sid_to_index(sid));
 		else
 			context = sidtab_lookup_initial(s, sid);
 		if (context && (!context->len || force))
@@ -170,117 +226,29 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
-static int sidtab_find_context(union sidtab_entry_inner entry,
-			       u32 *pos, u32 count, u32 level,
-			       struct context *context, u32 *index)
-{
-	int rc;
-	u32 i;
-
-	if (level != 0) {
-		struct sidtab_node_inner *node = entry.ptr_inner;
-
-		i = 0;
-		while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
-			rc = sidtab_find_context(node->entries[i],
-						 pos, count, level - 1,
-						 context, index);
-			if (rc == 0)
-				return 0;
-			i++;
-		}
-	} else {
-		struct sidtab_node_leaf *node = entry.ptr_leaf;
-
-		i = 0;
-		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
-			if (context_cmp(&node->entries[i].context, context)) {
-				*index = *pos;
-				return 0;
-			}
-			(*pos)++;
-			i++;
-		}
-	}
-	return -ENOENT;
-}
-
-static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
-{
-	while (pos > 0) {
-		WRITE_ONCE(s->rcache[pos], READ_ONCE(s->rcache[pos - 1]));
-		--pos;
-	}
-	WRITE_ONCE(s->rcache[0], index);
-}
-
-static void sidtab_rcache_push(struct sidtab *s, u32 index)
-{
-	sidtab_rcache_update(s, index, SIDTAB_RCACHE_SIZE - 1);
-}
-
-static int sidtab_rcache_search(struct sidtab *s, struct context *context,
-				u32 *index)
-{
-	u32 i;
-
-	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++) {
-		u32 v = READ_ONCE(s->rcache[i]);
-
-		if (v >= SIDTAB_MAX)
-			continue;
-
-		if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
-			sidtab_rcache_update(s, v, i);
-			*index = v;
-			return 0;
-		}
-	}
-	return -ENOENT;
-}
-
-static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
-				 u32 *index)
+int sidtab_context_to_sid(struct sidtab *s, struct context *context,
+			  u32 *sid)
 {
 	unsigned long flags;
-	u32 count, count_locked, level, pos;
+	u32 count;
 	struct sidtab_convert_params *convert;
-	struct context *dst, *dst_convert;
+	struct sidtab_entry_leaf *dst, *dst_convert;
 	int rc;
 
-	rc = sidtab_rcache_search(s, context, index);
-	if (rc == 0)
+	*sid = context_to_sid(s, context);
+	if (*sid)
 		return 0;
 
-	/* read entries only after reading count */
-	count = smp_load_acquire(&s->count);
-	level = sidtab_level_from_count(count);
-
-	pos = 0;
-	rc = sidtab_find_context(s->roots[level], &pos, count, level,
-				 context, index);
-	if (rc == 0) {
-		sidtab_rcache_push(s, *index);
-		return 0;
-	}
-
 	/* lock-free search failed: lock, re-search, and insert if not found */
 	spin_lock_irqsave(&s->lock, flags);
 
+	rc = 0;
+	*sid = context_to_sid(s, context);
+	if (*sid)
+		goto out_unlock;
+
 	convert = s->convert;
-	count_locked = s->count;
-	level = sidtab_level_from_count(count_locked);
-
-	/* if count has changed before we acquired the lock, then catch up */
-	while (count < count_locked) {
-		if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
-			sidtab_rcache_push(s, count);
-			*index = count;
-			rc = 0;
-			goto out_unlock;
-		}
-		++count;
-	}
+	count = s->count;
 
 	/* bail out if we already reached max entries */
 	rc = -EOVERFLOW;
@@ -293,7 +261,9 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	if (!dst)
 		goto out_unlock;
 
-	rc = context_cpy(dst, context);
+	dst->sid = index_to_sid(count);
+
+	rc = context_cpy(&dst->context, context);
 	if (rc)
 		goto out_unlock;
 
@@ -305,29 +275,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		rc = -ENOMEM;
 		dst_convert = sidtab_do_lookup(convert->target, count, 1);
 		if (!dst_convert) {
-			context_destroy(dst);
+			context_destroy(&dst->context);
 			goto out_unlock;
 		}
 
-		rc = convert->func(context, dst_convert, convert->args);
+		rc = convert->func(context, &dst_convert->context,
+				convert->args);
 		if (rc) {
-			context_destroy(dst);
+			context_destroy(&dst->context);
 			goto out_unlock;
 		}
+		dst_convert->sid = index_to_sid(count);
 
 		/* at this point we know the insert won't fail */
+		spin_lock_irqsave(&convert->target->lock, flags);
 		convert->target->count = count + 1;
+		hash_add(convert->target->context_to_sid,
+			 &dst_convert->list, dst_convert->context.hash);
+		spin_unlock_irqrestore(&convert->target->lock, flags);
 	}
 
 	if (context->len)
 		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
 			context->str);
 
-	sidtab_rcache_push(s, count);
-	*index = count;
+	*sid = index_to_sid(count);
 
-	/* write entries before writing new count */
+	/* Write entries before updating count and inserting into hashtable. */
 	smp_store_release(&s->count, count + 1);
+	hash_add(s->context_to_sid, &dst->list, dst->context.hash);
 
 	rc = 0;
 out_unlock:
@@ -335,25 +311,22 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	return rc;
 }
 
-int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 {
-	int rc;
+	unsigned long flags;
+	struct sidtab_entry_leaf *entry;
 	u32 i;
 
-	for (i = 0; i < SECINITSID_NUM; i++) {
-		struct sidtab_isid_entry *entry = &s->isids[i];
+	for (i = 0; i < count; i++) {
+		entry = sidtab_do_lookup(s, i, 0);
+		entry->sid = index_to_sid(i);
 
-		if (entry->set && context_cmp(context, &entry->context)) {
-			*sid = i + 1;
-			return 0;
-		}
-	}
+		spin_lock_irqsave(&s->lock, flags);
+		hash_add(s->context_to_sid, &entry->list, entry->context.hash);
+		spin_unlock_irqrestore(&s->lock, flags);
 
-	rc = sidtab_reverse_lookup(s, context, sid);
-	if (rc)
-		return rc;
-	*sid += SECINITSID_NUM + 1;
-	return 0;
+		cond_resched();
+	}
 }
 
 static int sidtab_convert_tree(union sidtab_entry_inner *edst,
@@ -400,6 +373,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 		}
 		cond_resched();
 	}
+
 	return 0;
 }
 
@@ -449,8 +423,12 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 		spin_lock_irqsave(&s->lock, flags);
 		s->convert = NULL;
 		spin_unlock_irqrestore(&s->lock, flags);
+		return rc;
 	}
-	return rc;
+
+	sidtab_convert_hashtable(params->target, count);
+
+	return 0;
 }
 
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
@@ -484,11 +462,16 @@ void sidtab_destroy(struct sidtab *s)
 
 	for (i = 0; i < SECINITSID_NUM; i++)
 		if (s->isids[i].set)
-			context_destroy(&s->isids[i].context);
+			context_destroy(&s->isids[i].leaf.context);
 
 	level = SIDTAB_MAX_LEVEL;
 	while (level && !s->roots[level].ptr_inner)
 		--level;
 
 	sidtab_destroy_tree(s->roots[level], level);
+	/*
+	 * The context_to_sid hashtable's objects are all shared
+	 * with the isids array and context tree, and so don't need
+	 * to be cleaned up here.
+	 */
 }
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 1f4763141aa1..e2809401c417 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -13,11 +13,14 @@
 
 #include <linux/spinlock_types.h>
 #include <linux/log2.h>
+#include <linux/hashtable.h>
 
 #include "context.h"
 
 struct sidtab_entry_leaf {
+	u32 sid;
 	struct context context;
+	struct hlist_node list;
 };
 
 struct sidtab_node_inner;
@@ -57,7 +60,7 @@ struct sidtab_node_inner {
 
 struct sidtab_isid_entry {
 	int set;
-	struct context context;
+	struct sidtab_entry_leaf leaf;
 };
 
 struct sidtab_convert_params {
@@ -66,7 +69,8 @@ struct sidtab_convert_params {
 	struct sidtab *target;
 };
 
-#define SIDTAB_RCACHE_SIZE 3
+#define SIDTAB_HASH_BITS CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS
+#define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)
 
 struct sidtab {
 	/*
@@ -83,11 +87,11 @@ struct sidtab {
 	struct sidtab_convert_params *convert;
 	spinlock_t lock;
 
-	/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
-	u32 rcache[SIDTAB_RCACHE_SIZE];
-
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
+
+	/* Hash table for fast reverse context-to-sid lookups. */
+	DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);
 };
 
 int sidtab_init(struct sidtab *s);
@@ -101,6 +105,8 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
 void sidtab_destroy(struct sidtab *s);
 
+int sidtab_hash_stats(struct sidtab *sidtab, char *page);
+
 #endif	/* _SS_SIDTAB_H_ */
 
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

