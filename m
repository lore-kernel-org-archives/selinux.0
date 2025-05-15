Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35629A30C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314651; cv=none; b=jbfcfv9kbOs9CWkbyZ2nbcNJs1evM21d82wiXhO0b5S4TQZswOEloOxFSnysI5kp5EPJ3xd4F4UYAApIpjgc9c6wSDSjXqNygIhi/CvqJm/fTBOykVz8H4ah4kyQts3m9Ffdc8Y9yn8VIW3z0lszdjiR+TaFYch6EzAZww5lxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314651; c=relaxed/simple;
	bh=4MS2o0AX2z2Gm3iRLiv5eamReo1tOxKkcYRSg3cgixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Kbn/VwqUbPTi8erMA51TeQf240EeRDt8pH2ndsEYj2FpwVUb4j8XT9WWLy6q6qM+rcMCbZWCGGJPzJk5xsGFhiv2SZx1GY7BUbB31Etol+zzVCnO0bHhtN9B/bKlZUQZMKrGlWKCgf64aOvMk+InBrThjV7z8qcnZRZ1xcf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc2Citaf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc2Citaf"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-477296dce8dso10684371cf.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314648; x=1747919448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sou48SylvcFTKKqWxrXlxZiadu6pPcVGajlXO4SKIME=;
        b=Lc2Citaf+QxaskDAMnyZlHLN7HJgqForXPihE1eOeCq/NFMEeK1DtZ9orxqSlXpPwt
         ExBFXuFDvESdal94zwsX2gLY65xcvYCfTEmW9afIswZd0eDKyI7drTTX58FBw9OHjLkk
         eszuyxc5odLycO0yzfCx4PxXof51GyoUN2L2AUAW9xzCC/WLXvIzOH7LucwKKquj8V+9
         6K7zewolV7YCuSSKOKpLKWlcYwM5KMPQmE7W/9AGc+sbl4++2gQoiU7w25FQBZgbpBJe
         23SEPLQBtU3fGQCDd+6hCxtvThBC6ugP4hpNFpBf5LunKAwMXFFLn6519lSzPfLGANE7
         SQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314648; x=1747919448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sou48SylvcFTKKqWxrXlxZiadu6pPcVGajlXO4SKIME=;
        b=cXkMuPKnTG/2PjAT7flxnlPss+JFmHXgBPjPiKqLjFkBWSKN0taaH0+dpKLg96eVhr
         sT5R/azuUzUHxthEmHlu1NwqqNFQurLcXUpnJLqVlJwu7Gno5L4yLhBXf/i3080puE00
         7fs20htomIIg2xuj2lwxbNt5pw3lBoIjXEYY+VSTAC92P0mYPEOFpQf0cQ/hFma/cgC9
         swJIjFS9//GbCSYm78chxR2wqzk0CWGCLFzwf48QMTLKuk0v6/PSyQzlpDt6PkOELI+e
         +diDqvvMDsIfnF1fEQsYY5BwMRJlj4p8XmfqrjLJ8Sd5gwy+2Ez9yRnETHsG4SfD+izS
         6ADg==
X-Gm-Message-State: AOJu0YwK0VGN3iSlXehfYe0yTm+5qyuQ04f7aJ1PqF1QNmoWaiBa7AhM
	a6vZfhql9RsT+ywgsOgucLuRMkidz4PpMD/yXWOC9HefDAgA2cu/n+zuXQ==
X-Gm-Gg: ASbGncs53oeqfJ3dW2qCE2ZdLUaIiikphMVawWsbQ6jYqTg9O9iougcItEMhRKSu5Jj
	AZv6PqzF0NwGsrrQls7E+EcI9JwAyY8gXOea8CAohsFzPT5+GgBmX9e9I2RuKYfF/Fa4pQgSkMS
	gPKZM/blbCGPVIRAgkQWOh7DdQhZQaZdxjFaKI2LNWVFffnfJmtMK9czmVboC3CrIHfOklOzc8L
	5EMBXFsMizBrA8/aVbU/CCfo6WSVWVYMF7TlqRAY4cxNtQT5OkOu+a0JIk56Hz9UXXI9hf+jn6N
	EJGryIdHX13SQ+xahASpt4yePq3fA/Orar4TB+ve9T28BfWbHCG5fWLN+ahUvF1xOTzLM4meyZP
	B/dxkB6KVg2SQxJnODzOxRldjpiGrtseZU+sChj/IUsCIjQnnJ2BNysCrtkSGksJg
X-Google-Smtp-Source: AGHT+IGc1ZiCApKclixi9zDPlTqgLJ7wNjwHkgQm1hMjo8H+Uw5DBWz6YEuQObOKb3zfJe7uov026w==
X-Received: by 2002:a05:622a:4295:b0:472:133f:93ae with SMTP id d75a77b69052e-49495cf642fmr107886231cf.48.1747314647868;
        Thu, 15 May 2025 06:10:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 39/49] selinux: init inode from nearest initialized namespace
Date: Thu, 15 May 2025 09:09:37 -0400
Message-ID: <20250515130947.52806-40-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index a0e0d86e2992..5ac5c3e34729 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1329,10 +1329,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
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
@@ -1355,8 +1354,8 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
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
@@ -1367,7 +1366,9 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
-static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+static int inode_doinit_use_xattr(struct selinux_state *state,
+				  struct inode *inode,
+				  struct dentry *dentry,
 				  u32 def_sid, u32 *sid)
 {
 #define INITCONTEXTLEN 255
@@ -1410,8 +1411,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(current_selinux_state, context, rc,
-					     sid, def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(state, context, rc, sid,
+					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1431,6 +1432,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
+	struct selinux_state *state = current_selinux_state;
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
@@ -1448,8 +1450,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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
@@ -1506,8 +1514,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out_invalid;
 		}
 
-		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
-					    &sid);
+		rc = inode_doinit_use_xattr(state, inode, dentry,
+					    sbsec->def_sid, &sid);
 		dput(dentry);
 		if (rc)
 			goto out;
@@ -1520,8 +1528,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(current_selinux_state, task_sid, sid,
-					     sclass, NULL, &sid);
+		rc = security_transition_sid(state, task_sid, sid, sclass,
+					     NULL, &sid);
 		if (rc)
 			goto out;
 		break;
@@ -1534,7 +1542,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		if ((sbsec->flags & SE_SBGENFS) &&
 		     (!S_ISLNK(inode->i_mode) ||
-		      selinux_policycap_genfs_seclabel_symlinks())) {
+		      selinux_policycap_genfs_seclabel_symlinks(state))) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
@@ -1561,7 +1569,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 */
 			if (!dentry)
 				goto out_invalid;
-			rc = selinux_genfs_get_sid(dentry, sclass,
+			rc = selinux_genfs_get_sid(state, dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
 				dput(dentry);
@@ -1570,8 +1578,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
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
index d193866f729d..62d85e807c60 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -259,11 +259,11 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
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

