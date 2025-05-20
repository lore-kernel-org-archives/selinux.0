Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01A28982D;
	Tue, 20 May 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742521; cv=none; b=gKSJ8XInJ4X5qrZQE3jTZMpCfbvJ8uBTtSKIlC9ctcgP0mB20UeJxlzOkZ82hpJ26vTHCWT/oYPXmtjBfPIRr+Hqs7GfYuDAs/K0p4/SgMRqWGFFaWbQx1VgntCgr/3SLrj86G5HOFXyMX0wl8fbkmu3qVnl9OxXloeqBWVNXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742521; c=relaxed/simple;
	bh=8AAWGI9mVTbIOvvWZ/vdGNfGVETY2OQMisdBIc7yisM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqyjvNIN1efhs90QvW6nwNKjD0XI5A8u9t5sCMIODvZ+PNkFvLv/d5Ngm5KCZN1YJPd0HwcBxnb9r+TeLMom8sncYsM2dt/heiVgEl99ttrAzZ8/66RJ7oK3+Y4+xSea8QQyLoFqPE/gSzKRNS3HF76alU3cRsMqtSUcpPz2STM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7HtNs7r; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7HtNs7r"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e39d1db2so346960685a.3;
        Tue, 20 May 2025 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742518; x=1748347318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHwSkLYEt6R23VP5umdMSGq8PnLF4TsFM1PnZxhRlLg=;
        b=G7HtNs7rJEYRd886BvZNUUU9LYN7n+40Bd1p3xKh8GcBABF3o7JmmZaBUd2Cv5zKi9
         ZL5UVJ3pr8ov/cYTsDlWtsJmKpdmogOq3NKKcX8m3NNjmt6aWtgLbSph0MUYn8aj2jLY
         7p/VMCwhizJuK0BzXD/eEgRBzVLWPDIeh3Rw9YZCc7H+Bx6JFuDS9b3ahaU931rzmLMe
         iOOfTaMt4HoomX6a6ioY7jJZstS+NpQydHU2GElU9+g++40SUAG46A8CeWFHTBJ4q/ja
         1dFSjWLfFRwBmdERdl+3ywMcOSwVe5TH3ls66k/JH2UYiVdupORbT5nVi6KS1ZclTw2g
         WcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742518; x=1748347318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHwSkLYEt6R23VP5umdMSGq8PnLF4TsFM1PnZxhRlLg=;
        b=iqs0xN+X7WD2Tv7LXdA8NgQSwy+vX6jTlVbUxItW/j+PbGaoppiXfam2bwwougsWl5
         uvlp+gFTPqI6vUVgDXOWi5met3Wb9Yu0pbbyH6sSlFz3ioVNMmv59EAJLekR2z7J522E
         kxfjnInDMgx+Lfb8FyoNxOcizWruqXQcRA29CZqzGQeYa4fa9Mibp3D7NoVmR7fLThYi
         Zuvj/A1Chsk4cfX2H0CcL2LcOB/iltcKSPkOmfhVdtLXD5ZsNL2iWc95zHRzj0Fz27P8
         eIecrbgnU7tMIkpLYokvmwh21ovkGEyT1+Kes0YwuAZ7w2X5M28bcbuHOFC9c08IlvDy
         XYdg==
X-Forwarded-Encrypted: i=1; AJvYcCVlQqe6aNZcNBU6IyV7IX47/484+FBEf2g1dqYA1168QdlXOAqCl5zBysvsgmi4fLqRAHdWFes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsGa0JmxNcMAHd+7zzRsGRTNSGZN7XU8CAbH4JizN2EtO9JN1
	tfy5K4fUvg892ELjw7+SPbVO3OrrpTX7PiMjNEBVG7lNcQTBU/ficYJfFWnjiQ==
X-Gm-Gg: ASbGncsqcIYiMxY0WY+RcW5hm0+lPMa4VvZ6WTWXIlKxz7ptQ4uWpPagTiH/l71sN9q
	zAZR8OVdhjtbXUvbRm6y/xZ7YssqPWPuXi0IN88sYKEmiWit08kveQgATKWl62EtTaGeAug9ZXZ
	2iqZOVaWiESvQHack19SDJygNDIdSylr54EA3xG1rk6i3NXvynZ5ecdvALDiyn5lkqviDl3DnRA
	UE9PMwWFofb2P2MlLyNAxJxczDYkSzQcJnJjQ6dm4K94sZW8OOEaoGvRv/MKEF0l2gmLcfgEhWt
	zRDPWlzCVfBK4XmVUcH5o6v4E5ctTQ05sfJeUzk0criLVam1bNx0v270DLIVvSNRPUd53S8nD9E
	yepLSRWMu9hjGtd9AyKcQG5ISUYvcQlK4apaJjR0S7mZH06wxyCdSfA==
X-Google-Smtp-Source: AGHT+IEKVRdFuL0p/BxqDLKGJ8UiRPKpwL461JfIXnXPa9CtAFuPYUjHO3094qdAsJw5Gx1fcBOqXQ==
X-Received: by 2002:a05:620a:1984:b0:7c5:65ab:5001 with SMTP id af79cd13be357-7cd4677db22mr2029769285a.39.1747742518012;
        Tue, 20 May 2025 05:01:58 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 42/42] selinux: init inode from nearest initialized namespace
Date: Tue, 20 May 2025 07:59:40 -0400
Message-ID: <20250520120000.25501-44-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index dcb97a636aa2..06a5ffaebafd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1332,10 +1332,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
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
@@ -1358,8 +1357,8 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
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
@@ -1370,7 +1369,9 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
-static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+static int inode_doinit_use_xattr(struct selinux_state *state,
+				  struct inode *inode,
+				  struct dentry *dentry,
 				  u32 def_sid, u32 *sid)
 {
 #define INITCONTEXTLEN 255
@@ -1413,8 +1414,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(current_selinux_state, context, rc,
-					     sid, def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(state, context, rc, sid,
+					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1434,6 +1435,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
+	struct selinux_state *state = current_selinux_state;
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
@@ -1451,8 +1453,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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
@@ -1509,8 +1517,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out_invalid;
 		}
 
-		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
-					    &sid);
+		rc = inode_doinit_use_xattr(state, inode, dentry,
+					    sbsec->def_sid, &sid);
 		dput(dentry);
 		if (rc)
 			goto out;
@@ -1523,8 +1531,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(current_selinux_state, task_sid, sid,
-					     sclass, NULL, &sid);
+		rc = security_transition_sid(state, task_sid, sid, sclass,
+					     NULL, &sid);
 		if (rc)
 			goto out;
 		break;
@@ -1537,7 +1545,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		if ((sbsec->flags & SE_SBGENFS) &&
 		     (!S_ISLNK(inode->i_mode) ||
-		      selinux_policycap_genfs_seclabel_symlinks())) {
+		      selinux_policycap_genfs_seclabel_symlinks(state))) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
@@ -1564,7 +1572,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 */
 			if (!dentry)
 				goto out_invalid;
-			rc = selinux_genfs_get_sid(dentry, sclass,
+			rc = selinux_genfs_get_sid(state, dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
 				dput(dentry);
@@ -1573,8 +1581,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
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
index a9ef6d97b88d..22de64287b4d 100644
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

