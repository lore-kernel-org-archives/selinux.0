Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67FBC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7569F20851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DvBHUxdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7569F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeLKWpw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:52 -0500
Received: from sonic303-49.consmr.mail.ne1.yahoo.com ([66.163.188.175]:35272
        "EHLO sonic303-49.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbeLKWpw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568350; bh=2uARvLb1q2zznR0LcReH3B1TK7Gvxnoz0sP/IEti4Co=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DvBHUxdliBud1jxIa/Gau/OMOqwgpw8V9+egdLDdkDMUV97rcp35JNaZHVatjYnc8iB/JTfKykxT5Xgygn+y0I4kr/zoy2lGo9C/oSyDTgX8iUMZKOvd2wElLJyrzqoKd5CcxlBFkXzRGJEDqwFo8MsoQMohxkGptVf++GZK9TJWmquVUconYg8CXLlBz/d+hxcK+HsPhAxfVH+Vnj8JFA9ceg1/c2BgnkGhVAe/xORZO+MKVCYsZfOVKgwHNUxDygIwspLMZn69Hg8/6b0K3zOgdLzVAm8x8elVY871p6sT9ULy1nbYcu5N4PY6+kNWM01vy0qowswQrQ3firtQGQ==
X-YMail-OSG: 1nLngaAVM1lv9XJh24xR8UVSp9RDXBFEO7WpWmTEEDFytfok7lqUCRnIBG6kYUI
 QhvHTqPqoJQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:45:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 22/38] SELinux: Abstract use of cred security blob
Date:   Tue, 11 Dec 2018 14:42:58 -0800
Message-Id: <20181211224314.22412-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the cred->security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 54 +++++++++++++++++++--------------------
 security/selinux/include/objsec.h |  5 ++++
 security/selinux/xfrm.c           |  4 +--
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index edd5b8dd3e56..24b6b459fa2a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -225,7 +225,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	return tsec->sid;
 }
 
@@ -461,7 +461,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(&selinux_state,
@@ -480,7 +480,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(&selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -1951,7 +1951,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1973,7 +1973,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(current_security(), dir,
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
 					   &dentry->d_name, tclass, &newsid);
 	if (rc)
 		return rc;
@@ -2480,8 +2480,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
+	old_tsec = selinux_cred(current_cred());
+	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
 	/* Default to the current task SID. */
@@ -2645,7 +2645,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = selinux_cred(bprm->cred);
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2688,7 +2688,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2991,7 +2991,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	u32 newsid;
 	int rc;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
@@ -3011,14 +3011,14 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 	int rc;
 	struct task_security_struct *tsec;
 
-	rc = selinux_determine_inode_label(old->security,
+	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
 	if (rc)
 		return rc;
 
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	tsec->create_sid = newsid;
 	return 0;
 }
@@ -3028,7 +3028,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	u32 newsid, clen;
 	int rc;
@@ -3038,7 +3038,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	newsid = tsec->create_sid;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 		dir, qstr,
 		inode_mode_to_security_class(inode->i_mode),
 		&newsid);
@@ -3500,7 +3500,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = new_creds->security;
+	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getsecid(d_inode(src), &sid);
 	tsec->create_sid = sid;
@@ -3920,7 +3920,7 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void selinux_cred_free(struct cred *cred)
 {
-	struct task_security_struct *tsec = cred->security;
+	struct task_security_struct *tsec = selinux_cred(cred);
 
 	/*
 	 * cred->security == NULL if security_cred_alloc_blank() or
@@ -3940,7 +3940,7 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *tsec;
 
-	old_tsec = old->security;
+	old_tsec = selinux_cred(old);
 
 	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
 	if (!tsec)
@@ -3955,8 +3955,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -3972,7 +3972,7 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3997,7 +3997,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4546,7 +4546,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4566,7 +4566,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -5444,7 +5444,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = selinux_cred(current_cred());
 	tsid = __tsec->sid;
 
 	return avc_has_perm(&selinux_state,
@@ -6381,7 +6381,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = selinux_cred(__task_cred(p));
 
 	if (current != p) {
 		error = avc_has_perm(&selinux_state,
@@ -6504,7 +6504,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -6633,7 +6633,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	if (!ksec)
 		return -ENOMEM;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index cc5e26b0161b..734b6833bdff 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -158,4 +158,9 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
+static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 91dc3783ed94..8ffe7e1053c4 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -79,7 +79,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 				   gfp_t gfp)
 {
 	int rc;
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct xfrm_sec_ctx *ctx = NULL;
 	u32 str_len;
 
@@ -138,7 +138,7 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
  */
 static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 
 	if (!ctx)
 		return 0;
-- 
2.14.5

