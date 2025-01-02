Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8A15CD49
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836368; cv=none; b=LPLTYZ5TG2i0o2dAbGDzveSCnkI4/i8QiWks6n6bFkFnuQAxg9OMbIpAIuXm4A9lBCaGOziPU0VsYTUCeXzxITZUqvHOkVazC1OOm9b6RY+1MR/GyPldhYpjTG1BlsM/Bb4gVOcDHDjwD6bnp4P1+rPf+j4ga38muGU3QmKneoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836368; c=relaxed/simple;
	bh=kxf0ZUjIlKNZIGKFfrsPx3WNH881gPEEzAVzaVWCZBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/0NJRDlATAdufH/CFrp+UbtNLIVLeeDy/10mvF0DBxJKb7TtMvCokI08KnKxoKly9zEP720A5qLb1cwzSs58vef/Kn0Pabh1OzPO4MovcXRF8Z0ejcaAgRMGJUOKE5t2bNl9H3xAeLmINzzXZkupgll/GLnVbttjRrwfkVa174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvJPLUhU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvJPLUhU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a1d43821so110002461cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836362; x=1736441162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xRpCT6ZKl0oN4rqvkFExrCml7OdEuAPiV6bFp9DXyc=;
        b=gvJPLUhU0SPevumrqH/HXK+p1Y7Z0UdVp+84aNYMqRiO5/tkKz/7iHbeX90pMAPsxL
         NbjLvkU/obY5jXG7Q5vPEyUHyKNUBy+pa3DejqFDzDRbnBK8FVUGoV7CZvlqtczoCpjb
         Tz5DFMuOYNiLNNEB6mVYrEECyZrw7ahyRfPsj0bb2Yirh7oAsnB0AudCeltVUSnnlQPt
         69sspf61Hka9/XaWWdjohN362eU9CzuIxvEtElQkHsrbOGt3lBSk8rwOsRCXynT910g1
         x72HpoNLmqFHxbB6sXFXYbc9+PJv2e3uHQTXB37uSJGl/TyrU0TAAG+OXuOg+4ToNrZd
         8FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836362; x=1736441162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xRpCT6ZKl0oN4rqvkFExrCml7OdEuAPiV6bFp9DXyc=;
        b=ZwTQoLXRx95CfEK1ao+a1jvrT/lv8YbjwmZtTZeR6En5AgiCi9uU7rAUNXZpckbNpP
         ha1C8Hcrk24y6wvxoAX9dlmZJZnb00HLeuZWFMVZ1b3ukHapDROdN49KD69iPMCJ1bn6
         feTkISUhM4cUj4natlmQIXs8qyHjewb0L+R3aU8brppSLafxbphVkcNiSbQ7Ih8vJqqk
         nkwETYsOLyUgx6EksHAdBVfa0dqaNAAeXnFMSvbKs9XUYBZ+o9usksF9mqhDiM4VgV44
         gt0qlo6wqf2SdqJvEkizUmQXJf/VEBmk9/mGt0WpLh5RpXRR5HYN67aOplPT98xPPPel
         Osww==
X-Gm-Message-State: AOJu0YzlENzJu/MuB7LPXIctfHIHtFdwEULfOh14+jPajHI+A0MAhtg9
	jF/yPH+8dCZU+1GuPxHMdBrWxvmjQE5sS3AUdqUJB89sgIsEUSkHCFByZg==
X-Gm-Gg: ASbGnctDCD3id4epKePd5Q+UhX8SlGc8ZRGYyTX4G0sAckovWpT6ItYN9Yjz/hTmy5F
	1xP9DokbTne49BQhrjHmCktCr39UO6rpQ2qlErp1n3LHcSUGyfil5SD2XlkXB/lS3cVoXfOY8eW
	qmVzAHRxbtyFT89ACeIwE6JxWqV0YatkY2D0ufdDHbOJUGgNARc5LTUOXXe7LZ4j/tlFA+d04Cx
	9pMB7JktlE8pzD6Ya7+sCUMHXTdfYm1k/xcP6XNN0wyP4B2Q/Vz3c6xbopHpOvvJytHLV+ImjAU
	0D/ugzilRnSaNIf82OHgiLJkG0aB8iYbkwonynQ1B94pZhnXsfF6GOsGzINaxQoYwViXog==
X-Google-Smtp-Source: AGHT+IFrxWkcHUtssrANtNVYo2si1X1f9E1rklRIBWXl4+nbn5v4AgL4dbq8D+THvm/tHykYUkIcXA==
X-Received: by 2002:ac8:5910:0:b0:467:5cfb:bd40 with SMTP id d75a77b69052e-46a4b1890b0mr750650521cf.19.1735836362465;
        Thu, 02 Jan 2025 08:46:02 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:01 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 40/44] selinux: init inode from nearest initialized namespace
Date: Thu,  2 Jan 2025 11:45:05 -0500
Message-Id: <20250102164509.25606-41-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit deferred inode initialization until the current
SELinux state/namespace has been initialized, which fixes some
cases but can still leave some inodes unlabeled. Instead of
deferring initialization, proceed with initialization using the
nearest ancestor namespace that is initialized.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 47 +++++++++++++++++------------
 security/selinux/include/security.h |  6 ++--
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc422d9c042..5ce0e2afd84f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1320,10 +1320,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
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
@@ -1346,8 +1345,8 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
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
@@ -1358,7 +1357,9 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
-static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+static int inode_doinit_use_xattr(struct selinux_state *state,
+				  struct inode *inode,
+				  struct dentry *dentry,
 				  u32 def_sid, u32 *sid)
 {
 #define INITCONTEXTLEN 255
@@ -1401,8 +1402,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(current_selinux_state, context, rc,
-					     sid, def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(state, context, rc, sid,
+					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1422,6 +1423,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
+	struct selinux_state *state = current_selinux_state;
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
@@ -1440,8 +1442,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SE_SBINITIALIZED) ||
-		!selinux_initialized(current_selinux_state)) {
+	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -1452,6 +1453,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		goto out_unlock;
 	}
 
+	/*
+	 * Find an initialized state to use; there must be at least
+	 * one or else the sbsec won't have been initialized.
+	 */
+	while (!selinux_initialized(state))
+		state = state->parent;
+
 	sclass = isec->sclass;
 	task_sid = isec->task_sid;
 	sid = isec->sid;
@@ -1498,8 +1506,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out_invalid;
 		}
 
-		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
-					    &sid);
+		rc = inode_doinit_use_xattr(state, inode, dentry,
+					    sbsec->def_sid, &sid);
 		dput(dentry);
 		if (rc)
 			goto out;
@@ -1512,8 +1520,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(current_selinux_state, task_sid, sid,
-					     sclass, NULL, &sid);
+		rc = security_transition_sid(state, task_sid, sid, sclass,
+					     NULL, &sid);
 		if (rc)
 			goto out;
 		break;
@@ -1526,7 +1534,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		if ((sbsec->flags & SE_SBGENFS) &&
 		     (!S_ISLNK(inode->i_mode) ||
-		      selinux_policycap_genfs_seclabel_symlinks())) {
+		      selinux_policycap_genfs_seclabel_symlinks(state))) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
@@ -1553,7 +1561,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 */
 			if (!dentry)
 				goto out_invalid;
-			rc = selinux_genfs_get_sid(dentry, sclass,
+			rc = selinux_genfs_get_sid(state, dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
 				dput(dentry);
@@ -1562,8 +1570,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
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
index 4b2ebe31467b..1426302c353d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -245,11 +245,11 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
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
2.47.1

