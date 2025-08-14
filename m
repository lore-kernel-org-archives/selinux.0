Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D163009C3;
	Thu, 14 Aug 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178036; cv=none; b=BsQbUL5pTUmGNt6T+F6jLPBIOWyMRn2n2DfxJmyE23HCAgNe+jnUGLVDhIM72sPOMqROP3APIOOst1QOlk66XVxjNJ6JvtkcaswAT4FdCIGITR1+mo64mKHyEOZiJe6F1oDGTuduEda1P8b7jEbAcQQMHK/gyBukwIWrcY9NgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178036; c=relaxed/simple;
	bh=mlXuHa/CVBKzIXTmtFKaqrwtQFfe4EaGD72hmWcucys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtavP+jCsL6E+k9bh8jOZ7HzwOTCiDr7fYmuLisgGuRQzyzML+EocS2AkLgpBHQnb1o7kN1EVBMS+xngjtOEFk6CbkWt1mnvxNwK8TKCua6590HdGDF7OaENC3ax9BNVOl2Yb0+xOx8YY9APcFQ9pqAmVe/Fh5oY5kTXBmR5Ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWp/2f4H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWp/2f4H"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109bbea05so13480661cf.2;
        Thu, 14 Aug 2025 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178032; x=1755782832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NMcS4/5UKKltNLyIxgfjuBxe76tvfE3QJ1HePWkT1g=;
        b=bWp/2f4H30pXaf5TSMzc3pNePqoRahqO7GCtCtYh171NUu8Y2NuqqrJU6oezJS3t7k
         /5CF7OpkJTUAMUnBCVfgSlMmvZYZp6Y3yC0g5rs+//ULuJDefKsqiskWqdvkMs59aKvq
         JwyQF3LNDjXkIqeBEVPlvMynH1Y8wtXjE0+PQQBWnYVdvVHi36jzXqPGHvpOCX3aKl3o
         M2B8n7pPyR9vZFp1mnQgBhgh0JXmVmEdCP7KzPT6tKDKKPOcltN8yfHb1TnXbl3Npddx
         cGnRM4MJYTK/R+dFYx5HQ+qsuMMwPMzHU8lnfHxCw3G4q5T8WMSwhCmABHEZlOhSb0Qb
         +WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178032; x=1755782832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NMcS4/5UKKltNLyIxgfjuBxe76tvfE3QJ1HePWkT1g=;
        b=pucXoqV2uqfrmUP3kYkXplZ0TrJRtWTfNvKoPyJQFFtHLYOIv8ELwdAEUh/xtnS5DU
         rc0haHBKyZYlx37DkGEkwFmnGITRkVnUBoFn3NPfV9K8WOZUv0mV9BplnOzLi/xhMeBC
         PDofEoNI5mJQmcO//sXsb8Zjw2JSaYeBElH05qONyCxGn8GTzVexhD/WxbmYUxQhtHQx
         qSZgPt51HRQZKak6jnMNL3nhzuqnSklxfgEu/gR3nzxtcjvn+lQ9I9flti1SnpOEIdfl
         rmbJZ7x0ESpF4FJ3xIoPaQCbkzMjZU3QxdbRg5v2+3XLrO/fHeqgNmneiP+ZH525vKBy
         IdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8HMmYxe9gTzRERMMV6jMytREmyviqA2en9h3TKtKW5+FjUKNG3hlT9ojssoLvMOe+LCDHE+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgR/7/ZPLHewZf07I83o4t/wjp19xl3yHqnivs5F0WAwsDJHiQ
	RjUt0UpFytv/qTjymlL+qcLeNrPKA6ir9AMi0bH0vOhcKh2cZMwRPOqxN7Km9A==
X-Gm-Gg: ASbGnctiPj0h+3vv3/cur9WdKvBWGV0sz97Z4YF/DL6pyB63WE8DpEoTvyKNY//FA9t
	ZhgFtSuVJZjboaZEkdD8jrXKNwMJPdM1TBJlBvEDlojfazs2jqxytYl5B985LeGBWPq2ibg76+q
	/1EgF6n+vm/vPpNuCpCLQyG4jGTZPJyyDHsfprmqdjmrj2XLPh6dhEpBLL/LlA9Eiacu+br1K/N
	BYQMoMu+GtoVjRL4/s42sHWWIDU73Tyca19X+JDNZKzH+74EYECNAhcG8azz0IgyaauUsyVzPS8
	y6mE0ki15C544DQjCnacZm82QiTwO5BOD6YIH8CHfOWbIhI7ie0LneGXP8Tq9mNhndTpNbW9pG5
	ZdzT9aYPcLzCGXP8s92pLsCEJnvZJa+Hp6ptkH2K9TRurOFmoA+19DSRPg3HiVR/EI307uyBXVj
	JpLN0x4N4h2bN0nX7Lib5buviJcvliR9t1GO0/
X-Google-Smtp-Source: AGHT+IFJ70QhAUTOTCzgUR+9/RiEnOxLy7IgMFqXl0hACt5ryBMXCODnDBz5XCO4dpN/ol+xq3uD0w==
X-Received: by 2002:a05:622a:4d04:b0:4b0:8190:5c09 with SMTP id d75a77b69052e-4b10ab8a8cemr48678201cf.52.1755178032381;
        Thu, 14 Aug 2025 06:27:12 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 09/42] selinux: init inode from nearest initialized namespace
Date: Thu, 14 Aug 2025 09:26:00 -0400
Message-ID: <20250814132637.1659-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously inode_doinit_with_dentry() was only checking sbsec->flags
to see if it should defer the inode security blob initialization,
which was fine when there was only a single SELinux state/namespace
since that could only be set if the state was initialized. However,
with the introduction of SELinux namespaces, the superblock could be
initialized in the parent (or other ancestor) namespace but the
current namespace may not yet be initialized (i.e. the namespace was
unshared but no policy has yet been loaded into it). Check for this
case, and if uninitialized, find the nearest ancestor SELinux
namespace that is initialized and use it instead. In the case where
the init SELinux namespace was never initialized (i.e. no policy
loaded on the host), then defer initialization of the inode.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 45 +++++++++++++++++------------
 security/selinux/include/security.h |  6 ++--
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3135378e9229..65d9762b992a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1347,10 +1347,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 	return SECCLASS_SOCKET;
 }
 
-static int selinux_genfs_get_sid(struct dentry *dentry,
-				 u16 tclass,
-				 u16 flags,
-				 u32 *sid)
+static int selinux_genfs_get_sid(struct selinux_state *state,
+				 struct dentry *dentry, u16 tclass,
+				 u16 flags, u32 *sid)
 {
 	int rc;
 	struct super_block *sb = dentry->d_sb;
@@ -1373,8 +1372,8 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 				path++;
 			}
 		}
-		rc = security_genfs_sid(current_selinux_state, sb->s_type->name,
-					path, tclass, sid);
+		rc = security_genfs_sid(state, sb->s_type->name, path,
+					tclass, sid);
 		if (rc == -ENOENT) {
 			/* No match in policy, mark as unlabeled. */
 			*sid = SECINITSID_UNLABELED;
@@ -1385,7 +1384,9 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
-static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+static int inode_doinit_use_xattr(struct selinux_state *state,
+				  struct inode *inode,
+				  struct dentry *dentry,
 				  u32 def_sid, u32 *sid)
 {
 #define INITCONTEXTLEN 255
@@ -1428,8 +1429,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(current_selinux_state, context, rc,
-					     sid, def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(state, context, rc, sid,
+					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1449,6 +1450,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
+	struct selinux_state *state = current_selinux_state;
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
@@ -1466,8 +1468,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
+	/*
+	 * Find an initialized state to use.
+	 */
+	while (state && !selinux_initialized(state))
+		state = state->parent;
+
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SE_SBINITIALIZED)) {
+	if (!state || !(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -1524,8 +1532,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out_invalid;
 		}
 
-		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
-					    &sid);
+		rc = inode_doinit_use_xattr(state, inode, dentry,
+					    sbsec->def_sid, &sid);
 		dput(dentry);
 		if (rc)
 			goto out;
@@ -1538,8 +1546,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(current_selinux_state, task_sid, sid,
-					     sclass, NULL, &sid);
+		rc = security_transition_sid(state, task_sid, sid, sclass,
+					     NULL, &sid);
 		if (rc)
 			goto out;
 		break;
@@ -1552,7 +1560,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		if ((sbsec->flags & SE_SBGENFS) &&
 		     (!S_ISLNK(inode->i_mode) ||
-		      selinux_policycap_genfs_seclabel_symlinks())) {
+		      selinux_policycap_genfs_seclabel_symlinks(state))) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
@@ -1579,7 +1587,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 */
 			if (!dentry)
 				goto out_invalid;
-			rc = selinux_genfs_get_sid(dentry, sclass,
+			rc = selinux_genfs_get_sid(state, dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
 				dput(dentry);
@@ -1588,8 +1596,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 			if ((sbsec->flags & SE_SBGENFS_XATTR) &&
 			    (inode->i_opflags & IOP_XATTR)) {
-				rc = inode_doinit_use_xattr(inode, dentry,
-							    sid, &sid);
+				rc = inode_doinit_use_xattr(state, inode,
+							    dentry, sid,
+							    &sid);
 				if (rc) {
 					dput(dentry);
 					goto out;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 329b1fe48057..c4a0766aa24e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -261,11 +261,11 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 			->policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
 }
 
-static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
+static inline bool
+selinux_policycap_genfs_seclabel_symlinks(struct selinux_state *state)
 {
 	return READ_ONCE(
-		current_selinux_state
-			->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
+		state->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
 }
 
 static inline bool selinux_policycap_ioctl_skip_cloexec(void)
-- 
2.50.1

