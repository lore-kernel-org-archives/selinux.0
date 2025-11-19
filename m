Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D510364E97
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582211; cv=none; b=dG6koFu0YVGHWyqeReS75pnzdtpuo886BOGR6y25h5PO3YPfSozCyuAkTUDJLiBBbHLhlUwq8vcQiTJ71qh7Yp5DiFAKvQAhxzUXNNiFctm/ULd/2g/a+smX59Bsk6/jXyXkAM6YaeiXc++ReusYvdxbAe3FgR7m9w44ZTUoGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582211; c=relaxed/simple;
	bh=DPPKVHkDjWkX7IwsheLGUO+i/3i7gimsz7CmO+sA+Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ha+jtNRLncC2Rz93fCsL1f95zV9ITABEe6zFCd362HPtzVXy3NPfmwCKiPdeCMwqhv9arjHbl2Tr4KDT0II1pbA6nW9xs6E/nv5zRLnx4W1O4K7PjbeIpr6Z8wylOcCN7M0+n5VMFmAsLcl1RYNHIKz8gD1ZHUAM1rhacXP/MSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FgVOb33i; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FgVOb33i"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2ed01b95dso14277385a.0
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763582206; x=1764187006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WePxoo2tkO1gfuamc47xX4KZMwa3dNWH4auLMxbvCLk=;
        b=FgVOb33i0ReP0nXGolw9v5MEskdFTXdl+jrOGTJVL8fXU8KHv+0/ggms36u7VgZM0H
         glTjlJV5NKvpZN3/Dy1mpWOnb2Zre7mqjHcvk8kVYxkg4ZYYMPuKTMAEFJILaZutmz6V
         g+rLKW+kU+uZvXxGInulvfUQHcb4ZMrH48MWAuqeBfFKbr+f3UilZNsPMfRoxZ6Q7uqD
         kVcFe9UruwW4Vs0BwJk/8N+B4ivlJNC9ca9AWnALPaDJtkRIcI5F6ZBgsgNVA0wdPq9g
         DNLRIYtTCZ5WIY5uaztikAR7ERDgRK3zKEbrwq/s2WizPf3mZYy2aVFiyNr9XZwqOgLa
         9WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763582206; x=1764187006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WePxoo2tkO1gfuamc47xX4KZMwa3dNWH4auLMxbvCLk=;
        b=VUIAqk0w1Xme5ZplNIalJgqNfZ6jFR8IPU9AfHYwz3TODm0jRO0JThDCVNWo8TSmy/
         O0T63mMKBcp4v2n8IVCV1VdqdH+fqoMSd2MpK//jYj80OQiMlcHeoe65Coat8tAMiA0Q
         UBX83hLvfat0grbDdEIzWprUWa4e9mUcUM2yLme7myc9uF6Mo/aC0KvrJEU+caULSyvD
         2mcHfSZzvnGKDUiIsgp32Q9m2VsZqYj0u55XFKuXk4NOEsFhf139De2dW0RlaqOI6D9j
         pux3hA1qGxucD3353P0PHcuqsOE6orPrE3idToUnMfo2Cyqfzc8lYKm9ihy8myXKevRo
         KolQ==
X-Gm-Message-State: AOJu0YzVVclQxug0/Gi/msOl4s7akWRKpezfXLNKWDKHBvVsBWwFtzpm
	AoPFDLi6bSSsZ/zsN6ojY+NW1UmcMMcbce7s7d7EvY0FN+EMhxVTpj3aNemfJ4s0UzCmY25X/zh
	f8AM=
X-Gm-Gg: ASbGncutK1Y8svXgSezZnPMRbEbNdQBMynWRV8VVhTyCEiuAsA5WI76kTRrW1605Olw
	Kg6IHnzuWfIXFLmgVMsokcBnBdDyWJpAuI3j0XBVkmMlPSYkhXuqBWBeP+sD7MC5iXWcBiI6wL4
	oQ3/YG7ZbPsgQkSRmbZb+0//Calw8+AHQQd/UEivTOhLveq92TyVhbnAD67w55eoNu0/UZZ/w20
	wUx6UhyDCGLPwPpJ8RlyDUky59MaDhoQGkh6Ch+s7CXPBAFFzbYMSkQ5jhpFBJOfX0EwiBLM74o
	6JkHz1peOarAsevzIHEMECp1fPeHVPrYUnKQ8QrP/gu12YCqFcMYXHBDfOS3ckNx9biQvYOUb5Q
	LQFoNuW8BC7k8EaxXWu+qPw/bXND65yhFrsEaBm13ly1kaUCGrAusKkC6GLYd/X/mLt/sK9JnSn
	tQEu+Vi3nWysokLbNGI9Kixmpieugkc+8vMQA/UmUNLXxKwOCuIERC+7YT
X-Google-Smtp-Source: AGHT+IHpWVKhsRmJRKcOC4gesjTwPvpaw+191z+Ol/aGStr8/QlVCau8mXVjn4UARzNXl2dbZm33mQ==
X-Received: by 2002:ac8:5a09:0:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4ee49fd6b48mr4319801cf.37.1763582206153;
        Wed, 19 Nov 2025 11:56:46 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e8df63sm3181911cf.30.2025.11.19.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:56:44 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] selinux: rename task_security_struct to cred_security_struct
Date: Wed, 19 Nov 2025 14:56:29 -0500
Message-ID: <20251119195628.184825-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13948; i=paul@paul-moore.com; h=from:subject; bh=Lbgct7r1z6EW5KH2lN/ehSF6nuVD7szwVGPXk2/sJ+o=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHiDsC7/n62mavSqve1skguix64ZSlNMnrI83Y 7j288hbcRqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR4g7AAKCRDqIPLalzeJ cxzGD/4zI+p//A0D2XtcJWi2OEewm0umKAQV4OIQMydcaSvk7NNSBoa1VGpMUMAorZm4wcbQMOS 5BhTRoqP/j5M0eeD5j6e2MMCCypBbB+T1+nxF+e3g5EL7IDcArAhlhAYkoKeIdxsDSnhkV1lQ1Y /4W5smY0PAZF+zQXaLKd5Kv2Vjub4clHWKMv7IRoixor8BphZdOuK4KvVzXz0LfEjE0o+2L7K0x CfGPsc5un64nMIJGlh7JryWyUgJkB+ZLPW4JaoCIx7oQPk+WskEYUXE8zM2rre6N9Rd4kOiR8xm obfsmaVHNLpbte8nRZ/DXIBpM1PuozprBsxUrkZcqCllicnr+9SPOEmHwBuEEmwNhjh5Q5I1Cop pt0PSRtttO6O/yqysN190lp1tuIo1+WbU5CtpI5CpiGTPWLO/rsGBARN85xWQSEPN3zbhOWlmmK SILR8dp6KuCSWaFPchtGITkLGfAR+k+KyroUqgbWeuWy0LC9C3AFHNYzy92CyNb594/UiiJQAuA JeaQxtBACefpw36ck9zrwcFFFwD+a7EGqj37+5ggY+8qYEU1uoqGoNT2YhF/1hELiO7Bj+0kicS iOJEdevygdZM4sjPAkGIDTZzTkLC3zs3MKDlQz5iJ4QKAbbCgcb/niCHeaEjavaY9yE43j50amC 0Vv2W1z/gJFVvww==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Before Linux had cred structures, the SELinux task_security_struct was
per-task and although the structure was switched to being per-cred
long ago, the name was never updated. This change renames it to
cred_security_struct to avoid confusion and pave the way for the
introduction of an actual per-task security structure for SELinux. No
functional change.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 68 +++++++++++++++----------------
 security/selinux/include/objsec.h |  8 ++--
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc22da42f30..0890e7ee84c9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -210,7 +210,7 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
  */
 static void cred_init_security(void)
 {
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
 
@@ -223,7 +223,7 @@ static void cred_init_security(void)
  */
 static inline u32 cred_sid(const struct cred *cred)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 
 	tsec = selinux_cred(cred);
 	return tsec->sid;
@@ -437,7 +437,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -454,7 +454,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
@@ -1788,7 +1788,7 @@ static int file_has_perm(const struct cred *cred,
  * Determine the label for an inode that might be unioned.
  */
 static int
-selinux_determine_inode_label(const struct task_security_struct *tsec,
+selinux_determine_inode_label(const struct cred_security_struct *tsec,
 				 struct inode *dir,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
@@ -1817,7 +1817,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -2251,8 +2251,8 @@ static u32 ptrace_parent_sid(void)
 }
 
 static int check_nnp_nosuid(const struct linux_binprm *bprm,
-			    const struct task_security_struct *old_tsec,
-			    const struct task_security_struct *new_tsec)
+			    const struct cred_security_struct *old_tsec,
+			    const struct cred_security_struct *new_tsec)
 {
 	int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
 	int nosuid = !mnt_may_suid(bprm->file->f_path.mnt);
@@ -2305,8 +2305,8 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *old_tsec;
-	struct task_security_struct *new_tsec;
+	const struct cred_security_struct *old_tsec;
+	struct cred_security_struct *new_tsec;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
 	struct inode *inode = file_inode(bprm->file);
@@ -2483,7 +2483,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
  */
 static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 {
-	struct task_security_struct *new_tsec;
+	struct cred_security_struct *new_tsec;
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
@@ -2529,7 +2529,7 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 osid, sid;
 	int rc;
 
@@ -2911,7 +2911,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 {
 	u32 newsid;
 	int rc;
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 
 	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
@@ -2929,7 +2929,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
 				       struct xattr *xattrs, int *xattr_count)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
@@ -3110,7 +3110,7 @@ static noinline int audit_inode_permission(struct inode *inode,
  * Clear the task's AVD cache in @tsec and reset it to the current policy's
  * and task's info.
  */
-static inline void task_avdcache_reset(struct task_security_struct *tsec)
+static inline void task_avdcache_reset(struct cred_security_struct *tsec)
 {
 	memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
 	tsec->avdcache.sid = tsec->sid;
@@ -3127,7 +3127,7 @@ static inline void task_avdcache_reset(struct task_security_struct *tsec)
  * Search @tsec for a AVD cache entry that matches @isec and return it to the
  * caller via @avdc.  Returns 0 if a match is found, negative values otherwise.
  */
-static inline int task_avdcache_search(struct task_security_struct *tsec,
+static inline int task_avdcache_search(struct cred_security_struct *tsec,
 				       struct inode_security_struct *isec,
 				       struct avdc_entry **avdc)
 {
@@ -3167,7 +3167,7 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
  * Update the AVD cache in @tsec with the @avdc and @audited info associated
  * with @isec.
  */
-static inline void task_avdcache_update(struct task_security_struct *tsec,
+static inline void task_avdcache_update(struct cred_security_struct *tsec,
 					struct inode_security_struct *isec,
 					struct av_decision *avd,
 					u32 audited)
@@ -3201,7 +3201,7 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 {
 	int mask;
 	u32 perms;
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct inode_security_struct *isec;
 	struct avdc_entry *avdc;
 	int rc, rc2;
@@ -3283,7 +3283,7 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static int selinux_inode_getattr(const struct path *path)
 {
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 
 	tsec = selinux_cred(current_cred());
 
@@ -3659,7 +3659,7 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	struct lsm_prop prop;
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct cred *new_creds = *new;
 
 	if (new_creds == NULL) {
@@ -3697,7 +3697,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
@@ -4161,8 +4161,8 @@ static int selinux_task_alloc(struct task_struct *task,
 static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
-	const struct task_security_struct *old_tsec = selinux_cred(old);
-	struct task_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_tsec = selinux_cred(old);
+	struct cred_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 	return 0;
@@ -4173,8 +4173,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = selinux_cred(old);
-	struct task_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_tsec = selinux_cred(old);
+	struct cred_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -4195,7 +4195,7 @@ static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4219,7 +4219,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4744,7 +4744,7 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 
 /* socket security operations */
 
-static int socket_sockcreate_sid(const struct task_security_struct *tsec,
+static int socket_sockcreate_sid(const struct cred_security_struct *tsec,
 				 u16 secclass, u32 *socksid)
 {
 	if (tsec->sockcreate_sid > SECSID_NULL) {
@@ -4797,7 +4797,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4816,7 +4816,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -6526,7 +6526,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 	int error;
 	u32 sid;
 	u32 len;
@@ -6581,7 +6581,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct cred *new;
 	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
@@ -6876,7 +6876,7 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 	struct key_security_struct *ksec = selinux_key(k);
 
 	tsec = selinux_cred(cred);
@@ -7137,7 +7137,7 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
-	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_cred = sizeof(struct cred_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2d5139c6d45b..e71ce352bc97 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -37,7 +37,7 @@ struct avdc_entry {
 	bool permissive; /* AVC permissive flag */
 };
 
-struct task_security_struct {
+struct cred_security_struct {
 	u32 osid; /* SID prior to last execve */
 	u32 sid; /* current SID */
 	u32 exec_sid; /* exec SID */
@@ -54,7 +54,7 @@ struct task_security_struct {
 	} avdcache;
 } __randomize_layout;
 
-static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec)
+static inline bool task_avdcache_permnoaudit(struct cred_security_struct *tsec)
 {
 	return (tsec->avdcache.permissive_neveraudit &&
 		tsec->sid == tsec->avdcache.sid &&
@@ -172,7 +172,7 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 {
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
@@ -207,7 +207,7 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 
 	return tsec->sid;
 }
-- 
2.52.0

