Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2082BC43215
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27BE20721
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDObZitr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKULJr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:09:47 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:45357 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKULJr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 06:09:47 -0500
Received: by mail-wr1-f73.google.com with SMTP id y3so1873841wrm.12
        for <selinux@vger.kernel.org>; Thu, 21 Nov 2019 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gBrTTxmV0Za3OdwQ2/YdJ0I7/ArS6YDk3Mq66OH3MKE=;
        b=TDObZitrX+qVY9v+bNkgNZlqP1keUvqKrbX8adOYrdEt9pM66UMLdqRLCaU4OB74Ks
         Rlwin3Tb8x6+OdsJKeyzo33InPVFEgh4pFnsPoOeBTkI3cUeMepn+u/BjMatrlU4b+Mb
         qNiKWKvV4wjy5EiMIV3FuJRHTs4A86Q4ht2zkqbTvOCkTzhMpmBC32XJg9VStxIE+Kdq
         msYyIUlw1TG6af+zbrW2q8lz+A2RRvLg4emWjCMPt9co/X0aR6Bap8I5RzjUHdlEJ5TB
         1Kcl7ONGT0tal8+aQZzDz12WvzWcHVftwiB9IK7HNONaGxaZp5J6JouHdm1a2im2ANBY
         2HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gBrTTxmV0Za3OdwQ2/YdJ0I7/ArS6YDk3Mq66OH3MKE=;
        b=fRlAdeOdWG5lcgL4jZDFOdRl5l8F/HzJhENp0sMqbvByaWYqKj6+lKnO0VAvgvBb7J
         yYs5VVbnnGhdo9IsifxPX+YSyhOX4cVN4gW+UKbHlu8WllpBEeZBWO0YJwHGw1BrYVB2
         iHM9z/Qv5ZSEU1Gtfuu+ZSBbL7/zt48Lk/PwSjbLh5knNrlKVsK5GbglokiAvPV2DMWs
         g03CRe4lNRbR87Yo1Nf2KrtxRXozkedahMEmE/hNCRhCwowHi6Qh4JVZPq3IO/hgTI+1
         mbTFrQRwx5lPurHweCHQmQWoeo233O2MewOAa2yGa4WxRNIsoUid+60SeMRo2p5azOYR
         5KNA==
X-Gm-Message-State: APjAAAVbzHESioWlqMrW0U4vBjzM1aB04ldGFemyGMC/DxnyurM1RHoH
        T5AYn8y+QSy3J0G8tGtcLpNPyAUtqmGjOrS6XeF9XyUFeXtpdvEdV1NXTxXem/adsfInBx/Dw/R
        ax85JdK+KgOEdKo1cVXjUkPGy+cz3ZxVAcmFtcehVMkmY4sJUGFci+Uc5qfmU
X-Google-Smtp-Source: APXvYqwMdTFTMxPSv9Vnzgae7guPBtaiKI5AjfvnTniumt5uMNgToLcqmDM9Kc/wpcX/dGXx9QxVxBpnSw==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr8021577wrq.99.1574334579486;
 Thu, 21 Nov 2019 03:09:39 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:09:32 +0100
Message-Id: <20191121110933.209018-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v8] selinux: sidtab: reverse lookup hash table
From:   Jeff Vander Stoep <jeffv@google.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, sds@tycho.nsa.gov,
        will@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This replaces the reverse table lookup and reverse cache with a
hashtable which improves cache-miss reverse-lookup times from
O(n) to O(1)* and maintains the same performance as a reverse
cache hit.

This reduces the time needed to add a new sidtab entry from ~500us
to 5us on a Pixel 3 when there are ~10,000 sidtab entries.

The implementation uses the kernel's generic hashtable API,
It uses the context's string represtation as the hash source,
and the kernels generic string hashing algorithm full_name_hash()
to reduce the string to a 32 bit value.

Sidtab entries are never modified or removed, so the context struct
stored in the sid_to_context tree can also be used for the
context_to_sid hashtable to reduce memory usage.

This bug was reported by:
- On the selinux bug tracker.
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
context_to_sid hashtable. This simplifies memory allocation and
was suggested by Ondrej Mosnacek.
-The new sidtab hash stats file in selinuxfs has been moved out of
the avc dir and into a new "ss" dir.

V3:
-Add lock nesting notation.

V4/V5:
-Moved to *_rcu variants of the various hashtable functions
as suggested by Will Deacon.
-Naming/spelling fixups.

V6
-Remove nested locking. Use lock of active sidtab to gate
access to the new sidtab.
-Remove use of rcu_head/kfree_rcu(), they're unnecessary because
hashtable objects are never removed when read/add operations are
occurring. Why is this safe? Quoting Ondrej Mosnacek from the
selinux mailing list:
"It is not visible in this patch, but the sidtab (along with other
policy-lifetime structures) is protected by a big fat read-write lock.
The only places where sidtab_destroy() is called are (a) error paths
when initializing a new sidtab (here the sidtab isn't shared yet, so
no race) and (b) when freeing the old sidtab during policy reload - in
this case it is happening after a policy write-locked critical
section, which had removed the old sidtab pointer from the shared
structures, so at that point all sidtab readers will already be
accessing the new sidtab and the old one is visible only by the thread
doing the destruction."

V7
-Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
/sys/fs/selinux/avc/hash_stats.
-Add __rcu annotation to rcu pointers.
-Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
-Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
RCU logic.

V8
-Removed the __rcu annotation added in V7. The annotation is
intended to be applied to pointers to an object, however the
objects referenced in the rcu hashtable are allocated and
stored in an array.
-Fixed bug where multiple SIDs were receiving the same hash
due to security_get_user_sids() reusing the same context
struct without calling context_init() on it. This bug was
discovered and root-caused by Stephen Smalley.
-Fixed two more places where the context hash needs to be
added in convert_context().
-Moved two more function calls from sidtab_context_to_sid()
to context_struct_to_sid().
-Verified on Android and Fedora 31.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
Reported-by: Jovana Knezevic <jovanak@google.com>
---
 security/selinux/Kconfig            |  12 ++
 security/selinux/include/security.h |   1 +
 security/selinux/selinuxfs.c        |  65 +++++++
 security/selinux/ss/context.h       |  11 +-
 security/selinux/ss/policydb.c      |   5 +
 security/selinux/ss/services.c      |  98 ++++++++---
 security/selinux/ss/services.h      |   4 +-
 security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
 security/selinux/ss/sidtab.h        |  16 +-
 9 files changed, 308 insertions(+), 167 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 5711689deb6a..c9e576c430c2 100644
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
+	  This option sets the number of buckets used in the sidtab hashtable
+	  to 2^SECURITY_SELINUX_SIDTAB_HASH_BITS buckets. The number of hash
+	  collisions may be viewed at /sys/fs/selinux/ss/sidtab_hash_stats. If
+	  chain lengths are high (e.g. > 20) then selecting a higher value here
+	  will ensure that lookups times are short and stable.
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
index ee94fa469c29..dd7bb1f1dc99 100644
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
@@ -1599,6 +1625,37 @@ static int sel_make_avc_files(struct dentry *dir)
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
+		if (!inode) {
+			dput(dentry);
+			return -ENOMEM;
+		}
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
@@ -1963,6 +2020,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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
index 3a29e7c24ba9..5ccae6ac8cab 100644
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
 
@@ -1449,6 +1462,42 @@ static int string_to_context_struct(struct policydb *pol,
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
+static int context_struct_to_sid(struct selinux_state *state,
+				 struct context *context, u32 *sid)
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
@@ -1501,7 +1550,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-	rc = sidtab_context_to_sid(sidtab, &context, sid);
+	rc = context_struct_to_sid(state, &context, sid);
 	context_destroy(&context);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1805,7 +1854,7 @@ static int security_compute_sid(struct selinux_state *state,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+	rc = context_struct_to_sid(state, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcontext);
@@ -1950,6 +1999,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			context_init(newc);
 			newc->str = s;
 			newc->len = oldc->len;
+			newc->hash = oldc->hash;
 			return 0;
 		}
 		kfree(s);
@@ -2026,6 +2076,10 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			goto bad;
 	}
 
+	rc = context_add_hash(args->newp, newc);
+	if (rc)
+		goto bad;
+
 	return 0;
 bad:
 	/* Map old representation to string and save it. */
@@ -2035,6 +2089,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	context_destroy(newc);
 	newc->str = s;
 	newc->len = len;
+	newc->hash = context_compute_hash(s);
 	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
 		newc->str);
 	return 0;
@@ -2273,8 +2328,7 @@ int security_port_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
+			rc = context_struct_to_sid(state, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2299,14 +2353,12 @@ int security_ib_pkey_sid(struct selinux_state *state,
 			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2320,7 +2372,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
+			rc = context_struct_to_sid(state,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2367,8 +2419,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
+			rc = context_struct_to_sid(state, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2409,13 +2460,11 @@ int security_netif_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(sidtab,
-						  &c->context[0],
-						  &c->sid[0]);
+			rc = context_struct_to_sid(state, &c->context[0],
+						   &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[1],
+			rc = context_struct_to_sid(state, &c->context[1],
 						   &c->sid[1]);
 			if (rc)
 				goto out;
@@ -2456,14 +2505,12 @@ int security_node_sid(struct selinux_state *state,
 		      u32 *out_sid)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	int rc;
 	struct ocontext *c;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2505,7 +2552,7 @@ int security_node_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
+			rc = context_struct_to_sid(state,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2589,12 +2636,17 @@ int security_get_user_sids(struct selinux_state *state,
 		usercon.role = i + 1;
 		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
 			usercon.type = j + 1;
+			/*
+			 * The same context struct is reused here so the hash
+			 * must be reset.
+			 */
+			usercon.hash = 0;
 
 			if (mls_setup_user_range(policydb, fromcon, user,
 						 &usercon))
 				continue;
 
-			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			rc = context_struct_to_sid(state, &usercon, &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2665,7 +2717,6 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = state->ss->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2700,7 +2751,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 		goto out;
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(sidtab, &c->context[0], &c->sid[0]);
+		rc = context_struct_to_sid(state, &c->context[0], &c->sid[0]);
 		if (rc)
 			goto out;
 	}
@@ -2763,7 +2814,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
+			rc = context_struct_to_sid(state, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -3019,8 +3070,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 			goto out_unlock;
 		}
 	}
-
-	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
+	rc = context_struct_to_sid(state, &newcon, new_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcon);
@@ -3613,7 +3663,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		if (!mls_context_isvalid(policydb, &ctx_new))
 			goto out_free;
 
-		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
+		rc = context_struct_to_sid(state, &ctx_new, sid);
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
index 7d49994e8d5f..97d6fedeff68 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -17,26 +17,43 @@
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
+	u32 sid = 0;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(s->context_to_sid, entry, list,
+				   context->hash) {
+		if (context_cmp(&entry->context, context)) {
+			sid = entry->sid;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return sid;
+}
+
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 {
 	struct sidtab_isid_entry *entry;
@@ -47,14 +64,60 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 
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
+	rcu_read_lock();
+	hash_for_each_rcu(sidtab->context_to_sid, i, entry, list) {
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
+	rcu_read_unlock();
+
+	if (chain_len > max_chain_len)
+		max_chain_len = chain_len;
+
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\n", entries,
+			 slots_used, SIDTAB_HASH_BUCKETS, max_chain_len);
+}
+
 static u32 sidtab_level_from_count(u32 count)
 {
 	u32 capacity = SIDTAB_LEAF_ENTRIES;
@@ -88,7 +151,8 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 level)
 	return 0;
 }
 
-static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
+static struct sidtab_entry_leaf *sidtab_do_lookup(struct sidtab *s, u32 index,
+						  int alloc)
 {
 	union sidtab_entry_inner *entry;
 	u32 level, capacity_shift, leaf_index = index / SIDTAB_LEAF_ENTRIES;
@@ -125,7 +189,7 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
 		if (!entry->ptr_leaf)
 			return NULL;
 	}
-	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
+	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
 }
 
 static struct context *sidtab_lookup(struct sidtab *s, u32 index)
@@ -136,12 +200,12 @@ static struct context *sidtab_lookup(struct sidtab *s, u32 index)
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
@@ -150,7 +214,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 
 	if (sid != 0) {
 		if (sid > SECINITSID_NUM)
-			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
+			context = sidtab_lookup(s, sid_to_index(sid));
 		else
 			context = sidtab_lookup_initial(s, sid);
 		if (context && (!context->len || force))
@@ -170,117 +234,30 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
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
-		return 0;
-
-	/* read entries only after reading count */
-	count = smp_load_acquire(&s->count);
-	level = sidtab_level_from_count(count);
-
-	pos = 0;
-	rc = sidtab_find_context(s->roots[level], &pos, count, level,
-				 context, index);
-	if (rc == 0) {
-		sidtab_rcache_push(s, *index);
+	*sid = context_to_sid(s, context);
+	if (*sid)
 		return 0;
-	}
 
 	/* lock-free search failed: lock, re-search, and insert if not found */
 	spin_lock_irqsave(&s->lock, flags);
 
+	rc = 0;
+	*sid = context_to_sid(s, context);
+	if (*sid)
+		goto out_unlock;
+
+	/* read entries only after reading count */
+	count = smp_load_acquire(&s->count);
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
 
 	/* bail out if we already reached max entries */
 	rc = -EOVERFLOW;
@@ -293,7 +270,9 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	if (!dst)
 		goto out_unlock;
 
-	rc = context_cpy(dst, context);
+	dst->sid = index_to_sid(count);
+
+	rc = context_cpy(&dst->context, context);
 	if (rc)
 		goto out_unlock;
 
@@ -305,29 +284,32 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
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
-
-		/* at this point we know the insert won't fail */
+		dst_convert->sid = index_to_sid(count);
 		convert->target->count = count + 1;
+
+		hash_add_rcu(convert->target->context_to_sid,
+				&dst_convert->list, dst_convert->context.hash);
 	}
 
 	if (context->len)
 		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
 			context->str);
 
-	sidtab_rcache_push(s, count);
-	*index = count;
+	*sid = index_to_sid(count);
 
-	/* write entries before writing new count */
+	/* Write entries before updating count. */
 	smp_store_release(&s->count, count + 1);
+	hash_add_rcu(s->context_to_sid, &dst->list, dst->context.hash);
 
 	rc = 0;
 out_unlock:
@@ -335,25 +317,19 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	return rc;
 }
 
-int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 {
-	int rc;
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
+		hash_add_rcu(s->context_to_sid, &entry->list,
+				entry->context.hash);
 
-	rc = sidtab_reverse_lookup(s, context, sid);
-	if (rc)
-		return rc;
-	*sid += SECINITSID_NUM + 1;
-	return 0;
+	}
 }
 
 static int sidtab_convert_tree(union sidtab_entry_inner *edst,
@@ -400,6 +376,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 		}
 		cond_resched();
 	}
+
 	return 0;
 }
 
@@ -435,7 +412,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 	/* enable live convert of new entries */
 	s->convert = params;
 
-	/* we can safely do the rest of the conversion outside the lock */
+	/* we can safely convert the tree outside the lock */
 	spin_unlock_irqrestore(&s->lock, flags);
 
 	pr_info("SELinux:  Converting %u SID table entries...\n", count);
@@ -449,8 +426,17 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 		spin_lock_irqsave(&s->lock, flags);
 		s->convert = NULL;
 		spin_unlock_irqrestore(&s->lock, flags);
+		return rc;
 	}
-	return rc;
+	/*
+	 * The hashtable can also be modified in sidtab_context_to_sid()
+	 * so we must re-acquire the lock here.
+	 */
+	spin_lock_irqsave(&s->lock, flags);
+	sidtab_convert_hashtable(params->target, count);
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return 0;
 }
 
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
@@ -484,11 +470,16 @@ void sidtab_destroy(struct sidtab *s)
 
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
2.23.0

