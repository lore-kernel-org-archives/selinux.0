Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D028FFCC
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312845; cv=none; b=C+puzh6+7Tj8fX+3359rS27Fi28a8XG71HysDp8trrCtPKPGEuRpsUdE5u94/Qd/PqGfc0Tj5a1fx5Ar2v7BtxBWN3zoEv3lbYHpmhaS7XZGMzk0vbtOgdFVD7RuBBzvsAS1LVG+rHQBuUWW3EUQFBI/upoy3urALdLCiL5tJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312845; c=relaxed/simple;
	bh=B3s0JGOBPvj/4dWxFPhF6WfzXGZt43ifXqF/jYYkUQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cIMRtt9vJ1NAu3jxjS/S0ul0M84WYjkBuT5/QMl7Lx5iAlOsdaDWIWQ02CvUFGeThuuP4Gv1dROk+LN+tFtONv28xEblgz7TWWQNS3llD9Til4XPSvQfKFXFsCi6PmuDEBSq79BYqva7XdnRU58yZaFC6BLwWHmpakp0zH3EkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=busPQHsN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="busPQHsN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4775ce8a4b0so17906421cf.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744312842; x=1744917642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdXkWRkeAElLKjN5BJ4yibScrHTTVeE1NB2ECDI8+JI=;
        b=busPQHsNe9+rZbP7qX1vykDbxFWxD3KIjTLfULQKWWfkf2+Agu+rsW+qqu58rPY+mp
         dAy6vRks0y4GvZ01tFR89Qx4csih/mMmjrYbz6iAbqut/p0VLmTys6wkf/eZ8/A0UIdR
         IxAEAjftK+4Yg3qpGDx0NjPnA6fz2vR+MC/2Eyp8Y8Y8tNNQcNNmdleXXeBPYuSuCRPb
         Ic8lBrkoa4NqrFcXwyUnNcnCDa6i5u5YOwC+iHRJcqdu7H2YAT336Gs0QgMv9ylZqr0V
         bT0JVfvpH0rzmeDVfbh919+cXDeQGSKOGNi6cL+tIp57eGT8EtEwkW5yTlRQl1xN2fV2
         tsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312842; x=1744917642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdXkWRkeAElLKjN5BJ4yibScrHTTVeE1NB2ECDI8+JI=;
        b=h0bf5wCklKjQEIbvilWdzFhemhzzZes3JBzOTduRranDHOcAQnTY/DvSccnmImbefM
         jpT4yF8NcAyFR0Um6NNgwc+7krjn2h/pu8wJwwbkYs8Ai2cfkoW9tmkg0iaanvItGmbp
         u0rTzCCTYhM79AV+Qu7RO3HM/E7Magrpq5ZINc3nPnoxLCvvmJA8fVt9QksbG5o9cUtL
         SgLVN+h4bT0/kYfX1OEbynfdlbRfwvPsC3VtY4JpLvaneRpT6izcdOPVKOtr/RquwHGt
         PYFjkghbut645h6lX3yDU930dAN8qlkUfqCowMn3ol0o5zhGi1XBIW94S24SGAXLgaUu
         cegA==
X-Gm-Message-State: AOJu0YxldKcPjnBpJPy0uK6EcHr4tDLN9rnQ0x3FnWcK1QcmH+Z54DYm
	yLqvPW5auuV+fFhOhaQI5/Ed7IVnPuYqBol6okKriTspWxcoVeH6uvsI4p6OcuRlbejctpoT0ms
	=
X-Gm-Gg: ASbGnctX+ZqFzIm0E7hoER+2OBUCSQa6dTz6mo6v0nyoyThdBk+upiP+prjdimczAK/
	IPR3v1xUIUFxdmLtdNZl+pKvBUwb6eOQ+5WTs37Abjy1+f3ZAWe/fBRV2Bsr4c2hh5oQjsLKxM7
	63ZXDZgrmY9be/Ye+vvb2bcVuXe7r2Q7o4F24ZDUcuxL+yHbuxu2wPuhKWht9z7sPdWmWzwVb5u
	nGxZnVukBg29cOWwn7gk0JqjJxgnEM3vhPzZyhnUhUraJ4eHxCGfq8VDZHUClV6cm95xPuiWXgq
	6dtPcu6V4cAWUw6QOgTMPMOq6eBCGoEFP7VgBl9Ot2uAuburBhlJ/InYvscasgGKb62Gec2/vp+
	7AIUMBvboQ2oBfcfVY2AG
X-Google-Smtp-Source: AGHT+IGkJsX8okP2I8QssHz6JOIMMU8EcLnWfV4Ol/fX78Cdxt/Y+QMzRnMw7L7vbteHt35/qZFWcg==
X-Received: by 2002:a05:622a:1a0f:b0:478:f488:3cc9 with SMTP id d75a77b69052e-4796ccfa341mr65612921cf.38.1744312841410;
        Thu, 10 Apr 2025 12:20:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796edc1c29sm13511851cf.70.2025.04.10.12.20.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:20:40 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] selinux: reduce path walk overhead
Date: Thu, 10 Apr 2025 15:20:32 -0400
Message-ID: <20250410192031.259180-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15071; i=paul@paul-moore.com; h=from:subject; bh=B3s0JGOBPvj/4dWxFPhF6WfzXGZt43ifXqF/jYYkUQc=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn+Bn/j8hdycle79GBEUBsZcu89+j6YzUOOGd2H 4fdWYOtYLSJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/gZ/wAKCRDqIPLalzeJ c/eLD/4nQSQIL0qOEp4xJ5O31qGEai2r/geq74chKLUiOsBUCmGciORsPF45KZHLytlg4ly9l2K JNXYcWfxYu+XwCVpQdvIp4z3YorSEmZ6fGZCNLkUbFFlqAclXTGqpMqVKXKRUvcL6hK5vQNp2Qn 8EcrxiEWAEDVnZaXybfmcwg9jLvBRZBk/R9+1wovFpsiYJUWQ9USDpWXvIsJ0ByuUOLmVBRoiVe cTbQvxkBa26jY08YyguM9zEnBZaqYx1Fjrz2OczTtcbj3JtDBVg9xcgVVBdmSXzCmA+vmH26XYH 3f4wO+NKMh76ELDIufxN7TFOtlI1bnnicoS133xsmpjKegMxyJ7aTGfmrcdnJwChUbvtZzLgDwZ ms0QJC6d6CxvttGU8OYtqOF7hEXAp+IHwUxuPp4+Uf3wD+0Y4a/AxnORpLdVslbtmdUdob4qn8Z igBvxkQgGxw/m88CqJ7/HxMlTtA+992ThLemMb8VzJweKWAakXcAFuw8VjBDhW4KtABPUgpHiEb H+q50zm5yk6DeNCrMWbUqlQRs0N03Mhts1YoAbnnwk0yT90yXp7KdNnjZQoKi6/3dqFiGxS4GxJ eziMZWow45MX/X1LYesNwWblxByhife4agaHjImfYP1WlqqoE+n9FcEBpeO6Kj89nJd2NAsXvmy h4w4DsxbYHAn3EA==
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
 security/selinux/hooks.c          | 225 +++++++++++++++++++++++-------
 security/selinux/include/objsec.h |  14 ++
 2 files changed, 185 insertions(+), 54 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..edc9ae81e202 100644
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
@@ -278,27 +280,21 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = selinux_inode(inode);
+	if (!selinux_initialized())
+		return 0;
 
-	might_sleep_if(may_sleep);
+	if (may_sleep)
+		might_sleep();
+	else
+		return -ECHILD;
 
 	/*
-	 * The check of isec->initialized below is racy but
-	 * inode_doinit_with_dentry() will recheck with
-	 * isec->lock held.
+	 * Check to ensure that an inode's SELinux state is valid and try
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
 
@@ -307,41 +303,53 @@ static struct inode_security_struct *inode_security_novalidate(struct inode *ino
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
@@ -1683,12 +1691,15 @@ static inline int dentry_has_perm(const struct cred *cred,
 				  struct dentry *dentry,
 				  u32 av)
 {
-	struct inode *inode = d_backing_inode(dentry);
 	struct common_audit_data ad;
+	struct inode *inode = d_backing_inode(dentry);
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
-	__inode_security_revalidate(inode, dentry, true);
+	/* check below is racy, but revalidate will recheck with lock held */
+	if (data_race(unlikely(isec->initialized != LABEL_INITIALIZED)))
+		__inode_security_revalidate(inode, dentry, true);
 	return inode_has_perm(cred, inode, av, &ad);
 }
 
@@ -1699,12 +1710,15 @@ static inline int path_has_perm(const struct cred *cred,
 				const struct path *path,
 				u32 av)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
 	struct common_audit_data ad;
+	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = *path;
-	__inode_security_revalidate(inode, path->dentry, true);
+	/* check below is racy, but revalidate will recheck with lock held */
+	if (data_race(unlikely(isec->initialized != LABEL_INITIALIZED)))
+		__inode_security_revalidate(inode, path->dentry, true);
 	return inode_has_perm(cred, inode, av, &ad);
 }
 
@@ -3088,44 +3102,147 @@ static noinline int audit_inode_permission(struct inode *inode,
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

