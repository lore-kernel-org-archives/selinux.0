Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93024677E;
	Tue, 10 Jun 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576192; cv=none; b=gnpf2jfgff86mzvW4aaAhx3b0QMSxlgcWZBISEestpKDLvCICVp9c+LkhLUolhEVczEl4w1ol4+zDuNifO+Vemo+TnmoK8NYpvp8ANXuImJPumsIM74d/aTMrFbvmUsZ0Uu5Po0pqfmjv0rBdDUBC61JYSsErvklOY1VWBw/SAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576192; c=relaxed/simple;
	bh=wTos/DqInk4yJzQrKhVz7Ck3h9maiBlZtOHjHxOX7gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ypy7n1ycq/j0w1HRyUYOrxwT0vnYVw2tmFsS2lblIKeKVDrLY1ovw++YmamB0V0ormB+Nz5AMK0Rn5KjhgfBSHnWpo8gU/Vf8piSt7qHRNr68bGomvjX5xFeTejBH9rzYVeAVpV1Pirki/9LvAYHHSteft5kp+vD/Y0Myu7IXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSae2nrJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSae2nrJ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d09a032914so466109685a.3;
        Tue, 10 Jun 2025 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576189; x=1750180989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Al2U9IHRHL5AbWg4zaDrxc/egYD5sB8U24EcNPZ0gU=;
        b=BSae2nrJR2TvHB7HZsYhelDER20XWXyJq/NCZsvkoANLkYjlzOqqsHEWvLPQABEEHu
         FvBUzBAwbLPkEXEZhRleB/lcp3+THWHYFOkoV+xe01wa7O5e9q8o3bEH4njwlS997SJ7
         6U0MyHfPiQYdwFtplGCvk3v+7Z5D4xVpYJ8GChsszjfZMNLKwDKEeSYEF+v/43cRe/pG
         hWsrc8n8qJRjiUVzRnhdEDJfBIMo+v4MfARvVRnnLpMjBswoxjNOz6gpylCRTyTTsW5g
         IPQpGgiorgmgRzZpOV03KcDMRYzuY7W28x2DFF2J5srv7FJAwFaDaqP1iCslsZHHTQCX
         DShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576189; x=1750180989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Al2U9IHRHL5AbWg4zaDrxc/egYD5sB8U24EcNPZ0gU=;
        b=ZXBgSGjZhSoDYcf7i/kDg0+4VcBtCrCxU3yW0tzd9dsQHJBnqeKiS3d1WY8JlMROHl
         2bzydI+qL4ryFpoWO+HZBrfpzWq40pd4dD3KWEMCwpV7C2Cv8aS6tYqAIM/vlsUHKYgV
         cOoabGkY3G8wHDjVGzGlhIWB5COtUBrpuWWP1x5bUKllqyNupzNqgWYnmfRcrC8ohLEG
         2JHOBng5ZR5y729XDeWIrUrjiLO27NNhSoy2dTRZkWUPzkZud5PATgr5T3PIISgtzBYo
         Tf3kIH6GwmiLqgoYrM6PANHNg8Zs1Zmkg1ak4iYF3SaxLNIzjs+WYfWyjqpvxYXZsC8M
         BzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjBRIsYKc+FzVCpULQXOTi8odpzE63qqHUS/oeIUBcSm+wrqrxI8eGDjzUEbloM9uaFuvQ+oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3jGdeL8O9f40BU+FhXUOx0h107WSSLJ5nRmgTXg9dBIkFftH
	9IwGgZqRfbiXWOyeUFYH8wQlHdxApCaG1sremfXDOwqiIo1P8PNNHJyACSvkDg==
X-Gm-Gg: ASbGncud/l27bgbh8Y/OUJt6jNhCSS51gKSwDV1SlCLlI8DvzAUnlh1e1aYxJWyTpdQ
	GinCYV/3fjLk7wgnAhEADC8utRazS82h2zk2fRVI6ZHLm2F+5RpPwTs01VcNWbxGJVRxdpYKvy+
	U3TH7QZ5eFjg2Q0wFDT6YlJV9Lg870qH49EnxiUGKpCU4WZZ+HgEGwQD6wVljZcZ0q9It3CHCBb
	yT9VKyDZOE20dayATQbZPeZTDGgHFy6XlumVN+u3QI8zCB691cwwmV4JRoalXx80crcX/uYNgLq
	e8tKb/WJLZoXqwCkwQeewVzvyVeRGoNl/Zr4TcKaCAdLVDK5iAfpmYl5UalpRZ4MeO2+G8xfU3f
	h/kxRhylFytEafw2dBLBWos9OKZX+hSfvy8wdbe+RbBtngb1BgddyYMdlWW1QaALKiA==
X-Google-Smtp-Source: AGHT+IH6f0yy7KXoE32a76QhWWlHeAzHvuv7Fvwg3C/TT6yGEp474XJEvwvhKMf6GDqQiFBv7bg+Xw==
X-Received: by 2002:a05:620a:4109:b0:7d3:8fa3:f62d with SMTP id af79cd13be357-7d3a89271c8mr24012785a.38.1749576188896;
        Tue, 10 Jun 2025 10:23:08 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 09/42] selinux: init inode from nearest initialized namespace
Date: Tue, 10 Jun 2025 13:21:40 -0400
Message-ID: <20250610172226.1470741-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index f4209dbb4efc..f5979a6f1cce 100644
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
index a2c833df53f5..33e8673266eb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -258,11 +258,11 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
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
2.49.0

