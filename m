Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F71917E7
	for <selinux@vger.kernel.org>; Wed,  2 Apr 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625870; cv=none; b=NXOsuRysMdStVJwsHcFJ/oSs1NP4mlzttoVh4f13pbijZwtIyeeO0U6UoJ4tqpNVNYNJVvGc8penNwygk1TD55MIMhhRaSc5/hpdQew+pBs4pEBf2vFgFoOXFKr+3xNV70P91XMgWwi986CIhKzTHLjjTdt9ozJw5Wz5K6VLQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625870; c=relaxed/simple;
	bh=8f3uvE3nK9BeYVZJJtCXojgtYsazXVqrsMvZrUk5nh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P53hNMGh0RxUBXKCp/kUamAMW/ZqrbK8W9F5TYZmmvjGVKw8aZx04+Urm30BUMlvUoNt/ntoaiNossb0YPLq9FL6ZLGHIfNKJ1iQ8iZkFYQlSu4s5jCDioxjlY0uNnzuylQ6EBZjcypmcNhzf6GuLoHEnU0jkkKVdWHlA+t+H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JnigJa+L; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JnigJa+L"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c081915cf3so16993985a.1
        for <selinux@vger.kernel.org>; Wed, 02 Apr 2025 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743625863; x=1744230663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJIjtEWXE7DkmFx61TvEJnwr7sbYPDTCc8/Pm2EvpAc=;
        b=JnigJa+LtGXmEWFRGeQLVXDPXjgbWi3/fTnkjPOd6bcg/VmsC4AePyUA2zQfTyc9dw
         Vn/F+wV0JfzALvxvZQsHlpGvePFBkZ8HlksGWiwpHbH/IXqrsG1+ha7foJpKml40Gjwk
         tcG6LCq7NzosOkqJKoKd/vH/bbof6nLrhyWxe0Ry8qeFNMj6qk2sxrQnYRvd9YX1uWvf
         PxVpQGIfGhZQp9s1Yf6H90czYWUocHVUU18FQdorauMThmNkXxm76ntwiiRFvTmyvOUB
         A9C1NJU0uJv/DlNJs25/3yCYTcPBoJKlk48Voi4ihelAMXbmj6KePNpD0vKWUOc6WO1l
         kkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625863; x=1744230663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJIjtEWXE7DkmFx61TvEJnwr7sbYPDTCc8/Pm2EvpAc=;
        b=FzUpvQEyNeDy4th1pwX0j/G3Eu8cMmpbMs/SkJP3JeFT53zxvSyngQpTIgHG7DjGhU
         wNs2aikY7/BNf81SGS8LebcECw5UM8INPQZiLtQ8AAP1xreHv0tgMImNrWm+MJHnnVyL
         ydkx3iz+FAk2O/X3jJ8RI7iRo/r3Ya0NQxITR2TtwVHt+FsZdMz6vh67ZpuR3Al2hM++
         sd1wYcabTNagNdRyHXlibmkzmcVsmZILXac9ikaaUdE2LuecBOefRLx2D7dITph9B/X3
         unlIrQcsuCDC3xviviaska5HOG0BCfOKKJVu5VXAm3+DChcDi6j8nsZm7BYZvQ9Ael49
         5uqw==
X-Gm-Message-State: AOJu0YzM7lsCiYN68iBuqaHa+r9jL34MDkRxH8xovKxAP452im4dqNe8
	bHmi+FuAXdn6FzmQxotv1ym5ks0Jw1DQgmycXDByalALX8NNmTgJxbLoCcO/Ymza97LF10gfnxo
	=
X-Gm-Gg: ASbGncs83K7Bm1R99h9KqLLJZ4KciuBsZ4WLO2lx+goH7mGO8vLTZhP8AQ045j47/IA
	fWfqISV9vezRwOPn/i+Jblw5tc1tvtZ8MSOU8eLZ6O389p2QXS1qoqvviadGiYoVacWO2c2/Qal
	UEIswDDb8XiUu1mXMxhB6uGySwk1hKnRrursTWF7kbvisZDESGcEWXWOvuJt0J2jMQh0zPDMICU
	c2HoNpUSSM6jQdjo5VN5xDqT8wJlosOa2/M2boB4/lIR3R0nReWlguqi2MGbQ7SS0uzs3thjS7H
	IcRPn4xo4aDzDcRNAMOQ3SadHZ2R2ogpqC1P8/0DEXXXluYn+FDK8a161nOqmMu/eRqqz2nAvoG
	DxoBiAoFrOjtxIw==
X-Google-Smtp-Source: AGHT+IHaZuO6GLUVI1wyKaDnJCvpBqnOp6wm+wDKZYQgNilaNXzHU2bBnTPvAUs/2Drv0X4EqEmahQ==
X-Received: by 2002:a05:620a:1a83:b0:7c5:674c:eecc with SMTP id af79cd13be357-7c69072c7famr2934622585a.32.1743625863305;
        Wed, 02 Apr 2025 13:31:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5f7765259sm834532485a.70.2025.04.02.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:31:02 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] selinux: reduce path walk overhead
Date: Wed,  2 Apr 2025 16:30:53 -0400
Message-ID: <20250402203052.237444-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14380; i=paul@paul-moore.com; h=from:subject; bh=8f3uvE3nK9BeYVZJJtCXojgtYsazXVqrsMvZrUk5nh0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn7Z58ignYXVsaHhJNtDcQ7N8a2MB7vFZzjXHQE FYOMljKNAOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ+2efAAKCRDqIPLalzeJ c+p9EACF614fqe8t+hfQ9BzMf9CcVUh/3lLONt2o57LaBh/5WuMuq3zH38z97wm4xraIh/5RnsS 0IJ2PjCf6/seoUaS4qv+ygj66FypQlbq3uWJCalcJkRQNUf/oGGICJfBAlfRzYAwEOvIHwcqrNe d/IXkwUL6OQ1CxiNQGystP2PYVYVdyEcOvqKLcB6+HA438EJFS0g+i/nfn59hgrysWr5Ene5Ecm uQZnGae6OJW+GNONMllAi6lTIxiLD/39wakTsS0qC6/CRX2UGLu1Uvfp0h4IrGMpw0puoku+7Oo QVua5MJBle809RK4/SraHxkz81Jq39/mvZsnIIO50Mbav9gCG1nBQRkxge0IxvjmmY6Azgd76MD zDovomVtpjsLcbRb3mBZHUotyq7zHuI4EXbC6AYjxpbITAG1jR2QGHM8AHpjBeWVQrOIRflZ16A SH0nW4ymY5EgfhU9PwEr9OcyLKcLOraUGOiqtrzAn0r6eg+siAqqCf4v7rkHoxkpB3qFCcC/OLN Ct1NOffZWOxILd/+yqX7KNiA32uUMum7ysJPvT2Q/4NGCG8VsISyx+Vas/KUGI3iaPS4vnOY9zA lFcOQCy51MdEGUxgZyVyJ2JIM6wGygYvCC1JE7XJBxZ26K+oMihLFPlTZqC+1ectn9Xe5xnuwdO NgiJDwgICtAp6Bg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reduce the SELinux performance overhead during path walks through the
use of a per-task directory access cache and some minor code
optimizations.  The directory access cache is per-task because it allows
for a lockless cache while also fitting well with a common application
pattern of heavily accessing a relatively small number of SELinux
directory labels.  The cache is inherited by child processes when the
child runs with the same SELinux domain as the parent, and invalidated
on changes to the task's SELinux domain or the loaded SELinux policy.
A cache of four entries was chosen based on testing with the Fedora
"targeted" policy, a SELinux Reference Policy variant, and
'make allmodconfig' on Linux v6.14.

Code optimizations include better use of inline functions to reduce
function calls in the common case, especially in the inode revalidation
code paths, and elimination of redundant checks between the LSM and
SELinux layers.

As mentioned briefly above, aside from general use and regression
testing with the selinux-testsuite, performance was measured using
'make allmodconfig' with Linux v6.14 as a base reference.  As expected,
there were variations from one test run to another, but the measurements
below are a good representation of the test results seen on my test
system.

 * Linux v6.14
   REF
     1.26%  [k] __d_lookup_rcu
   SELINUX (1.31%)
     0.58%  [k] selinux_inode_permission
     0.29%  [k] avc_lookup
     0.25%  [k] avc_has_perm_noaudit
     0.19%  [k] __inode_security_revalidate

 * Linux v6.14 + patch
   REF
     1.41%  [k] __d_lookup_rcu
   SELINUX (0.89%)
     0.65%  [k] selinux_inode_permission
     0.15%  [k] avc_lookup
     0.05%  [k] avc_has_perm_noaudit
     0.04%  [k] avc_policy_seqno
     X.XX%  [k] __inode_security_revalidate (now inline)

In both cases the __d_lookup_rcu() function was used as a reference
point to establish a context for the SELinux related functions.  On a
unpatched Linux v6.14 system we see the time spent in the combined
SELinux functions exceeded that of __d_lookup_rcu(), 1.31% compared to
1.26%.  However, with this patch applied the time spent in the combined
SELinux functions dropped to roughly 65% of the time spent in
__d_lookup_rcu(), 0.89% compared to 1.41%.  Aside from the significant
decrease in time spent in the SELinux AVC, it appears that any additional
time spent searching and updating the cache is offset by other code
improvements, e.g. time spent in selinux_inode_permission() +
__inode_security_revalidate() + avc_policy_seqno() is less on the
patched kernel than the unpatched kernel.

It is worth noting that in this patch the use of the per-task cache is
limited to the security_inode_permission() LSM callback,
selinux_inode_permission(), but future work could expand the cache into
inode_has_perm(), likely through consolidation of the two functions.
While this would likely have little to no impact on path walks, it
may benefit other operations.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 216 +++++++++++++++++++++++-------
 security/selinux/include/objsec.h |  14 ++
 2 files changed, 181 insertions(+), 49 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..df2bc01175b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,8 +213,10 @@ static void cred_init_security(void)
 {
 	struct task_security_struct *tsec;
 
+	/* NOTE: the lsm framework zeros out the buffer on allocation */
+
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
 }
 
 /*
@@ -278,27 +280,20 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = selinux_inode(inode);
+	if (!selinux_initialized())
+		return 0;
 
 	might_sleep_if(may_sleep);
+	if (!may_sleep)
+		return -ECHILD;
 
 	/*
-	 * The check of isec->initialized below is racy but
-	 * inode_doinit_with_dentry() will recheck with
-	 * isec->lock held.
+	 * Check to ensure that an inode's SELinux state is invalid and try
+	 * reloading the inode security label if necessary.  This will fail if
+	 * @dentry is NULL and no dentry for this inode can be found; in that
+	 * case, continue using the old label.
 	 */
-	if (selinux_initialized() &&
-	    data_race(isec->initialized != LABEL_INITIALIZED)) {
-		if (!may_sleep)
-			return -ECHILD;
-
-		/*
-		 * Try reloading the inode security label.  This will fail if
-		 * @opt_dentry is NULL and no dentry for this inode can be
-		 * found; in that case, continue using the old label.
-		 */
-		inode_doinit_with_dentry(inode, dentry);
-	}
+	inode_doinit_with_dentry(inode, dentry);
 	return 0;
 }
 
@@ -307,41 +302,53 @@ static struct inode_security_struct *inode_security_novalidate(struct inode *ino
 	return selinux_inode(inode);
 }
 
-static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
+static inline struct inode_security_struct *inode_security_rcu(struct inode *inode,
+							       bool rcu)
 {
-	int error;
+	int rc;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
-	error = __inode_security_revalidate(inode, NULL, !rcu);
-	if (error)
-		return ERR_PTR(error);
-	return selinux_inode(inode);
+	/* check below is racy, but revalidate will recheck with lock held */
+	if (data_race(likely(isec->initialized == LABEL_INITIALIZED)))
+		return isec;
+	rc = __inode_security_revalidate(inode, NULL, !rcu);
+	if (rc)
+		return ERR_PTR(rc);
+	return isec;
 }
 
 /*
  * Get the security label of an inode.
  */
-static struct inode_security_struct *inode_security(struct inode *inode)
+static inline struct inode_security_struct *inode_security(struct inode *inode)
 {
+	struct inode_security_struct *isec = selinux_inode(inode);
+
+	/* check below is racy, but revalidate will recheck with lock held */
+	if (data_race(likely(isec->initialized == LABEL_INITIALIZED)))
+		return isec;
 	__inode_security_revalidate(inode, NULL, true);
-	return selinux_inode(inode);
+	return isec;
 }
 
-static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
+static inline struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
-
-	return selinux_inode(inode);
+	return selinux_inode(d_backing_inode(dentry));
 }
 
 /*
  * Get the security label of a dentry's backing inode.
  */
-static struct inode_security_struct *backing_inode_security(struct dentry *dentry)
+static inline struct inode_security_struct *backing_inode_security(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct inode_security_struct *isec = selinux_inode(inode);
 
+	/* check below is racy, but revalidate will recheck with lock held */
+	if (data_race(likely(isec->initialized == LABEL_INITIALIZED)))
+		return isec;
 	__inode_security_revalidate(inode, dentry, true);
-	return selinux_inode(inode);
+	return isec;
 }
 
 static void inode_free_security(struct inode *inode)
@@ -2313,6 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	new_tsec->keycreate_sid = 0;
 	new_tsec->sockcreate_sid = 0;
 
+	/* Reset AVD cache, transfer the old_tsec cache later if possible. */
+	new_tsec->avdcache.sid = 0;
+
 	/*
 	 * Before policy is loaded, label any task outside kernel space
 	 * as SECINITSID_INIT, so that any userspace tasks surviving from
@@ -2406,6 +2416,11 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		bprm->secureexec |= !!rc;
 	}
 
+	/* Transfer the AVD cache if the SIDs match. */
+	if (new_tsec->sid == old_tsec->sid)
+		memcpy(&new_tsec->avdcache, &old_tsec->avdcache,
+		       sizeof(old_tsec->avdcache));
+
 	return 0;
 }
 
@@ -3088,44 +3103,147 @@ static noinline int audit_inode_permission(struct inode *inode,
 			    audited, denied, result, &ad);
 }
 
-static int selinux_inode_permission(struct inode *inode, int mask)
+/**
+ * task_avdcache_reset - Reset the task's AVD cache
+ * @tsec: the task's security state
+ *
+ * Clear the task's AVD cache in @tsec and reset it to the current policy's
+ * and task's info.
+ */
+static inline void task_avdcache_reset(struct task_security_struct *tsec)
 {
+	memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
+	tsec->avdcache.sid = tsec->sid;
+	tsec->avdcache.seqno = avc_policy_seqno();
+	tsec->avdcache.dir_spot = TSEC_AVDC_DIR_SIZE - 1;
+}
+
+/**
+ * task_avdcache_search - Search the task's AVD cache
+ * @tsec: the task's security state
+ * @isec: the inode to search for in the cache
+ * @avdc: matching avd cache entry returned to the caller
+ *
+ * Search @tsec for a AVD cache entry that matches @isec and return it to the
+ * caller via @avdc.  Returns 0 if a match is found, negative values otherwise.
+ */
+static inline int task_avdcache_search(struct task_security_struct *tsec,
+				       struct inode_security_struct *isec,
+				       struct avdc_entry **avdc)
+{
+	int orig, iter;
+
+	/* focused on path walk optimization, only cache directories */
+	if (isec->sclass != SECCLASS_DIR)
+		return -ENOENT;
+
+	if (unlikely(tsec->sid != tsec->avdcache.sid ||
+		     tsec->avdcache.seqno != avc_policy_seqno())) {
+		task_avdcache_reset(tsec);
+		return -ENOENT;
+	}
+
+	orig = iter = tsec->avdcache.dir_spot;
+	do {
+		if (tsec->avdcache.dir[iter].isid == isec->sid) {
+			/* cache hit */
+			tsec->avdcache.dir_spot = iter;
+			*avdc = &tsec->avdcache.dir[iter];
+			return 0;
+		}
+		iter = (iter - 1) & (TSEC_AVDC_DIR_SIZE - 1);
+	} while (iter != orig);
+
+	return -ENOENT;
+}
+
+/**
+ * task_avdcache_update - Update the task's AVD cache
+ * @tsec: the task's security state
+ * @isec: the inode associated with the cache entry
+ * @avdc: the AVD info to cache
+ * @audited: the permission audit bitmask to cache
+ *
+ * Update the AVD cache in @tsec with the @avdc and @audited info associated
+ * with @isec.
+ */
+static inline void task_avdcache_update(struct task_security_struct *tsec,
+					struct inode_security_struct *isec,
+					struct av_decision *avd,
+					u32 audited)
+{
+	int spot;
+
+	/* focused on path walk optimization, only cache directories */
+	if (isec->sclass != SECCLASS_DIR)
+		return;
+
+	/* update cache */
+	spot = (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1);
+	tsec->avdcache.dir_spot = spot;
+	tsec->avdcache.dir[spot].isid = isec->sid;
+	tsec->avdcache.dir[spot].audited = audited;
+	tsec->avdcache.dir[spot].allowed = avd->allowed;
+	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
+}
+
+/**
+ * selinux_inode_permission - Check if the current task can access an inode
+ * @inode: the inode that is being accessed
+ * @requested: the accesses being requested
+ *
+ * Check if the current task is allowed to access @inode according to
+ * @requested.  Returns 0 if allowed, negative values otherwise.
+ */
+static int selinux_inode_permission(struct inode *inode, int requested)
+{
+	int mask;
 	u32 perms;
-	bool from_access;
-	bool no_block = mask & MAY_NOT_BLOCK;
+	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
-	u32 sid = current_sid();
-	struct av_decision avd;
+	struct avdc_entry *avdc;
 	int rc, rc2;
 	u32 audited, denied;
 
-	from_access = mask & MAY_ACCESS;
-	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
+	mask = requested & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
 
 	/* No permission to check.  Existence test. */
 	if (!mask)
 		return 0;
 
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
-
-	perms = file_mask_to_av(inode->i_mode, mask);
-
-	isec = inode_security_rcu(inode, no_block);
+	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
+	tsec = selinux_cred(current_cred());
+	perms = file_mask_to_av(inode->i_mode, mask);
+
+	rc = task_avdcache_search(tsec, isec, &avdc);
+	if (likely(!rc)) {
+		/* Cache hit. */
+		audited = perms & avdc->audited;
+		denied = perms & ~avdc->allowed;
+		if (unlikely(denied && enforcing_enabled() &&
+			     !avdc->permissive))
+			rc = -EACCES;
+	} else {
+		struct av_decision avd;
+
+		/* Cache miss. */
+		rc = avc_has_perm_noaudit(tsec->sid, isec->sid, isec->sclass,
+					  perms, 0, &avd);
+		audited = avc_audit_required(perms, &avd, rc,
+			(requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0,
+			&denied);
+		task_avdcache_update(tsec, isec, &avd, audited);
+	}
 
-	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0,
-				  &avd);
-	audited = avc_audit_required(perms, &avd, rc,
-				     from_access ? FILE__AUDIT_ACCESS : 0,
-				     &denied);
 	if (likely(!audited))
 		return rc;
 
 	rc2 = audit_inode_permission(inode, perms, audited, denied, rc);
 	if (rc2)
 		return rc2;
+
 	return rc;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c88cae81ee4c..b00f8ac98b84 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,6 +29,13 @@
 #include "flask.h"
 #include "avc.h"
 
+struct avdc_entry {
+	u32 isid; /* inode SID */
+	u32 allowed; /* allowed permission bitmask */
+	u32 audited; /* audited permission bitmask */
+	bool permissive; /* AVC permissive flag */
+};
+
 struct task_security_struct {
 	u32 osid; /* SID prior to last execve */
 	u32 sid; /* current SID */
@@ -36,6 +43,13 @@ struct task_security_struct {
 	u32 create_sid; /* fscreate SID */
 	u32 keycreate_sid; /* keycreate SID */
 	u32 sockcreate_sid; /* fscreate SID */
+#define TSEC_AVDC_DIR_SIZE (1 << 2)
+	struct {
+		u32 sid; /* current SID for cached entries */
+		u32 seqno; /* AVC sequence number */
+		unsigned int dir_spot; /* dir cache index to check first */
+		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
+	} avdcache;
 } __randomize_layout;
 
 enum label_initialized {
-- 
2.49.0

