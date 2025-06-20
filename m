Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B862EBB98;
	Fri, 20 Jun 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441530; cv=none; b=L4LA0ICdg1OGVNhPxnuk67qo5ODiP0bQGc8q9alFSgj418ow2QltNDn3VY3zJh9N4FmIlYslymtWIqB9CUzFSHZA+Q6ZIdYB6/LGVjz5RBZ01vayfsJIhRXCGfLYS0OxdAV0Ga+hmYCEe4pPFOqUugLEP/t6hLnh5/MC0c3Fyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441530; c=relaxed/simple;
	bh=ONys4fF+Fd6E1Wjw/Ojndzy52tGLRFZA79gUYXhLa7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLKg50hHc99JtLJHv/j/PfYGA96SwOHhhj8RRxOvsreiWOnTvIuremTi//VHVubooybUiR5voDij3Zz77WZj1gu2d6Yz+bbeXs6iUkdkWtZu9afUXWi1TCoD5Z+szWl1j+rBYt+QibehVap9HvPPx1X2f4zbs5jWrI0SEvlsrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE6clTRt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE6clTRt"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so19932436d6.0;
        Fri, 20 Jun 2025 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441527; x=1751046327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOVFOskN2Yu2h6nnxZqtgkz38MBYbHuHJJ6hi9NIqH8=;
        b=nE6clTRt+5cU8BL49DEXgP9P3rIk4pO5G7HjumLbG0tNQj7nSVpEaO01pVcSLR8vrA
         YmGBrBAf1tehU7wX1qt6fTWEKgwjPz1u2J0y4A3O2lPlBAnmWIDPv5KwuMknU/dxRusb
         zw44oem31gwm2JhONENmnDrdawumCzSKQpMzqqpg6YQvdxINBzaWw2s/HD277fJ+H8Pa
         AjX/d6VO/iP+kzj6AdvWWcgC3ZhhmgVF/wezwx92cpSHft51Et9fJPjqIr8p+0DITNZ3
         Et6+7a310wF3yCiuxL2gxnoEee5w8SWkzSJ2i+RigmUkQorYkltbgIbmnb9XTjCdGEiP
         JGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441527; x=1751046327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOVFOskN2Yu2h6nnxZqtgkz38MBYbHuHJJ6hi9NIqH8=;
        b=thA+nw/9+T2Nd+vrkkes8qJ4QJVdl+PdCtnoYxSZW176e8QhB1xJGo29+8/FPL7biv
         KqT8ojhpKo/e94CmGd3C37kygdGbm2LufGXF3vJmhGE0mnDCatZlbPuw1b8nCus7mhjM
         1l/8LcznUMCVorgiyfMpBNUrSw5jNq4YX5nW8b0jMJdb9Gv2ghm+odapqL078zKfSyNI
         IJ8Y3nNwW+PGQDFQSZXDSYN8ZZ1H2yYRX4omYJrJM5O0xs6cpZ3pR4eKcjjENsoaIE/U
         NaXacjn7xb/rd2PmVhExkB7KKcc4hJ6eBxCyipfx31ctRy1L+RwqYn0CrZ/Irx/KzGuA
         65TA==
X-Forwarded-Encrypted: i=1; AJvYcCWmsUd6dqsi+j4ZM6r9MFEIx+c0z8a4+68n4VCNVKllDJ7ns80zVXDOTz4rbxWiaj0iZBi6Jmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWisgiRD3FtX+xEsSYShfioCxGDSTEPcM48FBebFD7nn3qQHf
	jtFUUsi+ltzi86vgX5YheGa/+qoEM6J+K8C/v7F+B7KHLBUO77QceVj6JCb83w==
X-Gm-Gg: ASbGncus1JEJKh1rmc8V9zv5h88Zg4PGwzIO5zMjsGmcIuNSV6UdLkTtzK6BRGUs/dI
	KZSKrMHrx4QLM8OqIL90iuK2lXlDvqCkKYo7k6S/Z6EOTiWJClalb18jPtiyJPQ6A7HQZdU1scE
	c1jERGWqqCuDcPvzPFy6zI1dop6jjxdVqigCh12bQXEbEi1gxYjcbxHNmCzOr+Gj5+hUblwjeuM
	7FoSDsx9m9pyX38TgMWMXvLtK3S1tAgiURu2DOs6wYxnPh4Pr49SPmfyy9J29b/Qa9TMWylhwV2
	bbBfhSJo/DZqKMXUBKnSzzPccVu8SkCj62YVyqEIU6u56hrIV1qITFAGCzer6xY9ClH9o1nI/56
	0UNe9f5jTG+YRGe7Y9o2l5VvgoaO6OWmXHpHLF1iIDhPLFffxMM89hxBRYHDF1xqyKw==
X-Google-Smtp-Source: AGHT+IFLTBOzTu43DAPthVOLHpCYoH9tW/YKKm4BttFFCOrzcIqvUJFjwYHfeBTalM/LAURv6+ivRw==
X-Received: by 2002:a05:6214:590a:b0:6fb:3c9:2d65 with SMTP id 6a1803df08f44-6fd0a4585edmr61079946d6.2.1750441527151;
        Fri, 20 Jun 2025 10:45:27 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 09/42] selinux: init inode from nearest initialized namespace
Date: Fri, 20 Jun 2025 13:44:21 -0400
Message-ID: <20250620174502.1838-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 7254418e7e5e..986fec6c8e4b 100644
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
index 5db362488a3f..c8934489098f 100644
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
2.49.0

