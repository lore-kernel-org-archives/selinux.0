Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7B3446B6
	for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142346; cv=none; b=oJ+hPMbB7FdEvjRj2iRwHYwyykYAmXPJeCvgTYL6Y7ua1U0wKbHv3ioJKNs4NjuLp3nYe8kPAw0JxwIZF8nGtCrCf8qmzKlMV1NN3hSqrBoJsAVrJKkD5u+m0OR45Ch90Gz+akHqH40MpWADmeBvfvYW/83JChxaNV/iJ/y84RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142346; c=relaxed/simple;
	bh=mth9clJXioKwAh32IvxwvV35pAioOu5ZUHKQfG9K3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZNThvVdbeMFQQ50zeVtaDGXgUKc2SOTpDAp3quVig9yA4Mpt9JTUHbDadnWrRSQbvWJ4SanF9sq4Om9+J+kh8v+BXme4CAVwCJQ8WO1U02IgA4MIz5hGuxVvgMxYr1vHqmPUm8ohnV/OOfqMse7dIVd/ekbs7jX2zOy4qZohak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0fAyLV8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0fAyLV8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b23b6d9f11so218329285a.3
        for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763142343; x=1763747143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoY09meUbJ0zFiRNOWsoHDWQzdsKb55K8gjDo52Zs60=;
        b=b0fAyLV8cZszDCwkAWhgw/GTU/qqezWYg4+X3Gxw1XVwOZ09wnyD/Zoxk41Rfa+rXu
         AFBVA8YNlD54YYhky62r4dBqbBbSAaJduhzjiHYFY8ydYr6ZgbpLxeMu2NQbISr2tJfO
         JR9qaEarfNUhNiPQqmY5dgE+95QjBKhLN7nWmduG3EDAs/FO0gs2DN1C9o4rgg5Zp2jD
         +EK5stnrlqd6N5lWzDGZXDAjo1yL10gSSTIg9W43H9lDttjSpSjkU8jy5uYl3Oc5Wo1r
         4xGXZEm5crh5f6XsiumO+FEgHd/RMzN4autfKyf1i+ahhl9nWNu0+S5r0S/mr9rpOsoJ
         zS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142343; x=1763747143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoY09meUbJ0zFiRNOWsoHDWQzdsKb55K8gjDo52Zs60=;
        b=w5Kjyt6x2ytlFi4Up6MyY6Nshck0+r+E2WH6ET1LK1i6Z8hhUZXrQ+mN3IMdK05N/T
         jgiq309X6gaxgPdpb/BcJCpDOCI1La4hn35/Xf/7vz6GKwA4SqKdwJLhA6SRHbAXhlmd
         GVDfnHcyxZJGOsXX9lM7Hu/xd/qIW3fP5qae45IumkfgcHdJIH4DY94k5EOpAcFbsMXv
         EgPvAKfgDXrlWAn+VN7Spf2AH4n0+paDWQJfDnJRgZ/CJMYPg1WGqhvCHCWYn2kb5aVn
         J8yLO9/nzvRi3BVo9s5TFwfZnD7M6PAs1YPmVPRoMZrnUCSvIEZkjkLSHAE0UiC6742A
         zIJg==
X-Gm-Message-State: AOJu0YxMQiqyzlIentyXPs7DKrgjT4CHWyQlHtaCyOjIN5jPjpAI6y++
	ZmcBd4hsEdZXG5cvOfrCspZXh1IjNOcLWbDtgleUyqu0eHdpgdLnN92zXXFp9A==
X-Gm-Gg: ASbGncsi0xIPO7mILKWL2zF45G2gLAn2r+KUR/0g2y4lf04SpPq0CSwM5tEQa1mC7RH
	ik8Ykc9NeRztxSHEc2yZT8g7AlM0g53hiTs3bj5UMmmxp4x23vG1980rUIzUkfmQy0MSFiwZR4D
	AaNWk1AQzxYK8oFuET0clvsKiiez0cklwacqbyzos6FJLFSitia0Kt3q4wMffFSS1tTcV04qgtI
	nBbSb23JdvL358DXtxT0h6OOUoVjWgrSUliNh0sz+z08MRlVGeciBx9K7bVCcyHAfFXDgT/OVkd
	lJTDYqLZLXJyB/qRfDVAAj+RQm2BT9f2WuiCvUj/5u3qeYnoK8m2uMN+fcz7VCK95v7RsuO1P9i
	Q3sEkG/eXWMrafPd5P+y/CNMETvWYxS+0UJq34KqZigmqhHxcob25Zk5zp4vNyOAJOmzzgQ/a73
	vVb9t1BH7FRRfa5oxrqs2svTMR0aUQzK8MD/pGk5DhXwGcgQRVxmn0oayMEFBdHqKPeg1pLOWii
	4HRhvY5LuKytGTghNJIlisARQ9JRe3O21Fg1Sg64M0cXrUQ3m0Vog==
X-Google-Smtp-Source: AGHT+IHOOMIWp+h9KKYvPSqRKhjx2n4odnx93kirkVa/AMCQhvn2HmN01dGzVfZ5QD0enH9Bani+ig==
X-Received: by 2002:a05:620a:1a18:b0:85a:789e:640b with SMTP id af79cd13be357-8b2c314c1d3mr501989185a.21.1763142343299;
        Fri, 14 Nov 2025 09:45:43 -0800 (PST)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af04254csm370956185a.47.2025.11.14.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:45:42 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: rename task_security_struct to cred_security_struct
Date: Fri, 14 Nov 2025 12:45:13 -0500
Message-ID: <20251114174514.14695-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before Linux had cred structures, the SELinux task_security_struct was
per-task and although the structure was switched to being per-cred
long ago, the name was never updated. This change renames it to
cred_security_struct to avoid confusion with the separate per-task
task_selinux_struct. No functional change. A further renaming
change could be to rename all cred_security_struct variables from
tsec to csec but that can be done separately if desired.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c          | 58 +++++++++++++++----------------
 security/selinux/include/objsec.h |  6 ++--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0eea43e4a90c..74f38449cfc7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -211,7 +211,7 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
  */
 static void cred_init_security(void)
 {
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct task_selinux_struct *tsel;
 
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
@@ -228,7 +228,7 @@ static void cred_init_security(void)
  */
 static inline u32 cred_sid(const struct cred *cred)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 
 	tsec = selinux_cred(cred);
 	return tsec->sid;
@@ -442,7 +442,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -459,7 +459,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
@@ -1793,7 +1793,7 @@ static int file_has_perm(const struct cred *cred,
  * Determine the label for an inode that might be unioned.
  */
 static int
-selinux_determine_inode_label(const struct task_security_struct *tsec,
+selinux_determine_inode_label(const struct cred_security_struct *tsec,
 				 struct inode *dir,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
@@ -1822,7 +1822,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -2256,8 +2256,8 @@ static u32 ptrace_parent_sid(void)
 }
 
 static int check_nnp_nosuid(const struct linux_binprm *bprm,
-			    const struct task_security_struct *old_tsec,
-			    const struct task_security_struct *new_tsec)
+			    const struct cred_security_struct *old_tsec,
+			    const struct cred_security_struct *new_tsec)
 {
 	int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
 	int nosuid = !mnt_may_suid(bprm->file->f_path.mnt);
@@ -2310,8 +2310,8 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *old_tsec;
-	struct task_security_struct *new_tsec;
+	const struct cred_security_struct *old_tsec;
+	struct cred_security_struct *new_tsec;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
 	struct inode *inode = file_inode(bprm->file);
@@ -2492,7 +2492,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
  */
 static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 {
-	struct task_security_struct *new_tsec;
+	struct cred_security_struct *new_tsec;
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
@@ -2538,7 +2538,7 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 osid, sid;
 	int rc;
 
@@ -2920,7 +2920,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 {
 	u32 newsid;
 	int rc;
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 
 	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
@@ -2938,7 +2938,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
 				       struct xattr *xattrs, int *xattr_count)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
@@ -3680,7 +3680,7 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	struct lsm_prop prop;
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct cred *new_creds = *new;
 
 	if (new_creds == NULL) {
@@ -3718,7 +3718,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
@@ -4185,8 +4185,8 @@ static int selinux_task_alloc(struct task_struct *task,
 static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
-	const struct task_security_struct *old_tsec = selinux_cred(old);
-	struct task_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_tsec = selinux_cred(old);
+	struct cred_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 	return 0;
@@ -4197,8 +4197,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = selinux_cred(old);
-	struct task_security_struct *tsec = selinux_cred(new);
+	const struct cred_security_struct *old_tsec = selinux_cred(old);
+	struct cred_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -4219,7 +4219,7 @@ static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4243,7 +4243,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4768,7 +4768,7 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 
 /* socket security operations */
 
-static int socket_sockcreate_sid(const struct task_security_struct *tsec,
+static int socket_sockcreate_sid(const struct cred_security_struct *tsec,
 				 u16 secclass, u32 *socksid)
 {
 	if (tsec->sockcreate_sid > SECSID_NULL) {
@@ -4821,7 +4821,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4840,7 +4840,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -6550,7 +6550,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 	int error;
 	u32 sid;
 	u32 len;
@@ -6605,7 +6605,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
-	struct task_security_struct *tsec;
+	struct cred_security_struct *tsec;
 	struct cred *new;
 	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
@@ -6900,7 +6900,7 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
-	const struct task_security_struct *tsec;
+	const struct cred_security_struct *tsec;
 	struct key_security_struct *ksec = selinux_key(k);
 
 	tsec = selinux_cred(cred);
@@ -7161,7 +7161,7 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
-	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_cred = sizeof(struct cred_security_struct),
 	.lbs_task = sizeof(struct task_selinux_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 1ac35ae5332f..b90f842cc310 100644
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
@@ -176,7 +176,7 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 {
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
@@ -216,7 +216,7 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *tsec = selinux_cred(current_cred());
 
 	return tsec->sid;
 }
-- 
2.51.1

