Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C65674E
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836343; cv=none; b=jP7GuSCLHbmcfpmgA2akqklXqiEJEO4sbUjlBTtzAiMPf5Abj47sRvj9lhoE5M3YWBnvI76jkhroVlmuWvbbvIWPHSTHaNF4kKUv9D4cbEeQecrS9cTJj3GIyAmN/UJtm76GmRAwseXMNxRO9UHdiW2EUVpLdK4j5Weera87GVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836343; c=relaxed/simple;
	bh=ddt75JMWirLWecqKjnS76ZO08C4RC9X45567CB+EL0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtleRL+LJhSJep8YTAZWV+R6WhyAGVl0EUFiBHtUoZFgP8PZYIIFptxCTqc+rY3gZJbEa9pk8xFzR7Eb7J9eruLYTtHpqeaySOAJokjaNhsoFMyg9YX0LxY8krfwhV57GIS+VTYigLkeD31V2uwu0tgst9hIANgErlQ81pEuJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ioy+6crp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ioy+6crp"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46741855f9bso103437251cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836335; x=1736441135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNGFBcaEy7n9Hg2LBf77IaXrRV+YkP8AoVkuchbwl2M=;
        b=Ioy+6crpcn6f44XfzL5Io0a2q6PADd/9IjVvmLX6xwP6lBQr56mnoQwOOc8fo/kJFg
         qt3uCCD1iHAP3PWylSA5oaxtzouYWR2/T6Dk/lrzcqem4b7pKbCy29xdFkzIX87j4e0j
         jmYjd0EeHnIXY+G/bglEvIrG/WdYbVk0wb2E8AZsIWFKjGzQynlwKYSYBArPnPjK5xi+
         gpQIKGg3zHf3n60SenpYrlbww5uhdBV6LX3hFNch1QM5cQFMLfejh5wmtD+7USRU6AjT
         0b7pZJiel0Am9rL0y2RxlfUtuFuxkd7sKVXXZQgA8VpmSIjnEnTxWpW2nTxoC1F8s6d3
         TF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836335; x=1736441135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNGFBcaEy7n9Hg2LBf77IaXrRV+YkP8AoVkuchbwl2M=;
        b=pH+aCuKgpAqXl6WcZxYmsJR7uE4CapKBcr2ZBWFlNhp2VFruUx7Efxjjf/AaKvu76O
         q5ww5ETGoRqS24hsyc4INfdArCWAnKfgV7mxi/OAuUEQbENAp+DQIAIkmQ7ReeCVjIId
         XdPH3CSsbt+JvuBHwioHW0aIhkY0vxJNh3yCIWjDs7pCgFxifz5bHQ5NGWvmHnjg6tgO
         j12oFZf+ALFPUMKlEbpC2Mmq5EtevWXkSZODKCJpOXUcBhf2K/0zor+HFL0ct4Y9KYQ4
         qd8BJT1XzP9aBxZ6hosEO5zkT3ASW0ZDeM7ZCMch70j6M3eFt6fTx3Kj8jJAFJWtbjTD
         sY5A==
X-Gm-Message-State: AOJu0YzeNNb2b55B4W5181VCrO2pYtNcG4eJLJDc5gPtCD6ErgXDN/Pu
	w4rD/xZmvToyfUtTbB/v0806o89i/AN3UM8IA8mtnSE3DsVS5E8u3M4v/w==
X-Gm-Gg: ASbGncsHxZmXzrcjonlXsWpgZdozaziAfGk95oSA6XjIARggTn4iyKOwQuvdaOQsGZB
	PQDvJem+zs/p2ogR5NWRJZKLNhTvy1UFHAUwhyblcgCcoWURQhFN/lO6xqNB7ITxQh681cGFSTN
	06KagDl2izRJNHEB4Cbn4ekL6utKGvDA8CmgzxURPhdsF7ffkeZBOxgmIE8FwhOZBimgRvNTatV
	ovCo/FN3vRFF/3qkEApRrgHL//v9kJoGRpcR/G1klmKX+xvTVgRKVwpoY1B4nil6+80iqwNSApG
	9u3ZFgqmcKpuJZ2xjQkh6NofaF/mS0GDNVnutj2biMv8IIvWwqJLlx8lT5PbhpgU7TelvQ==
X-Google-Smtp-Source: AGHT+IET3KZbI7lJqnLcgcFnJFlHiwfCxkAw7hzOqy9Qm9YxyZ7LCnntkP+ZSqDSTpIjOU+atCNVig==
X-Received: by 2002:ac8:5ac6:0:b0:467:6692:c18b with SMTP id d75a77b69052e-46a4a8b303bmr760353301cf.5.1735836334050;
        Thu, 02 Jan 2025 08:45:34 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:33 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 02/44] selinux: introduce current_selinux_state
Date: Thu,  2 Jan 2025 11:44:27 -0500
Message-Id: <20250102164509.25606-3-stephen.smalley.work@gmail.com>
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

Rename selinux_state to init_selinux_state, make it static, and
introduce a current_selinux_state pointer initialized to it that
can be used everywhere we were previously directly referencing
selinux_state.  This is in preparation for future changes where
multiple selinux states (aka namespaces) will be supported and
current_selinux_state will refer to the correct one for the current
process.

Note that passing the current selinux state is not correct for
all hooks; some hooks will need to be adjusted to pass the selinux
state associated with an open file, a network namespace or socket,
etc, since not all hooks are invoked in process context and some
hooks operate in the context of a cred that may differ from current's
cred.  Fixing all of these cases is left to future changes, once
we introduce the support for multiple selinux namespaces.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 413 ++++++++++++++--------------
 security/selinux/ibpkey.c           |   2 +-
 security/selinux/include/security.h |  32 ++-
 security/selinux/netif.c            |   2 +-
 security/selinux/netlabel.c         |  12 +-
 security/selinux/netnode.c          |   4 +-
 security/selinux/netport.c          |   2 +-
 security/selinux/selinuxfs.c        |  36 +--
 security/selinux/ss/services.c      |   4 +-
 security/selinux/xfrm.c             |  16 +-
 10 files changed, 267 insertions(+), 256 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ec8e746ec67e..400e4dec90a5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,7 +108,8 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-struct selinux_state selinux_state;
+static struct selinux_state init_selinux_state;
+struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
@@ -287,7 +288,7 @@ static int __inode_security_revalidate(struct inode *inode,
 	 * inode_doinit_with_dentry() will recheck with
 	 * isec->lock held.
 	 */
-	if (selinux_initialized(&selinux_state) &&
+	if (selinux_initialized(current_selinux_state) &&
 	    data_race(isec->initialized != LABEL_INITIALIZED)) {
 		if (!may_sleep)
 			return -ECHILD;
@@ -433,13 +434,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
@@ -451,13 +452,13 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
@@ -541,7 +542,7 @@ static int sb_check_xattr_support(struct super_block *sb)
 
 fallback:
 	/* No xattr support - try to fallback to genfs if possible. */
-	rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
+	rc = security_genfs_sid(current_selinux_state, sb->s_type->name, "/",
 				SECCLASS_DIR, &sid);
 	if (rc)
 		return -EOPNOTSUPP;
@@ -652,7 +653,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	mutex_lock(&sbsec->lock);
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		if (!opts) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
@@ -751,7 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 * Determine the labeling behavior to use for this
 		 * filesystem type.
 		 */
-		rc = security_fs_use(&selinux_state, sb);
+		rc = security_fs_use(current_selinux_state, sb);
 		if (rc) {
 			pr_warn("%s: security_fs_use(%s) returned %d\n",
 					__func__, sb->s_type->name, rc);
@@ -776,7 +777,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		}
 		if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
 			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
-			rc = security_transition_sid(&selinux_state,
+			rc = security_transition_sid(current_selinux_state,
 						     current_sid(),
 						     current_sid(),
 						     SECCLASS_FILE, NULL,
@@ -935,7 +936,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	 * if the parent was able to be mounted it clearly had no special lsm
 	 * mount options.  thus we can safely deal with this superblock later
 	 */
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
 			newsbsec->flags |= SE_SBNATIVE;
 			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
@@ -962,7 +963,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
-		rc = security_fs_use(&selinux_state, newsb);
+		rc = security_fs_use(current_selinux_state, newsb);
 		if (rc)
 			goto out;
 	}
@@ -1011,7 +1012,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	if (!s)
 		return -EINVAL;
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
 		return -EINVAL;
 	}
@@ -1048,7 +1049,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		WARN_ON(1);
 		return -EINVAL;
 	}
-	rc = security_context_str_to_sid(&selinux_state, s, dst_sid, GFP_KERNEL);
+	rc = security_context_str_to_sid(current_selinux_state, s, dst_sid,
+					 GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
 			s, rc);
@@ -1065,7 +1067,7 @@ static int show_sid(struct seq_file *m, u32 sid)
 	u32 len;
 	int rc;
 
-	rc = security_sid_to_context(&selinux_state, sid,
+	rc = security_sid_to_context(current_selinux_state, sid,
 					     &context, &len);
 	if (!rc) {
 		bool has_comma = strchr(context, ',');
@@ -1089,7 +1091,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	if (sbsec->flags & FSCONTEXT_MNT) {
@@ -1343,7 +1345,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 				path++;
 			}
 		}
-		rc = security_genfs_sid(&selinux_state, sb->s_type->name,
+		rc = security_genfs_sid(current_selinux_state, sb->s_type->name,
 					path, tclass, sid);
 		if (rc == -ENOENT) {
 			/* No match in policy, mark as unlabeled. */
@@ -1398,8 +1400,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
-					     def_sid, GFP_NOFS);
+	rc = security_context_to_sid_default(current_selinux_state, context, rc,
+					     sid, def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
 		unsigned long ino = inode->i_ino;
@@ -1508,7 +1510,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		rc = security_transition_sid(&selinux_state, task_sid, sid,
+		rc = security_transition_sid(current_selinux_state, task_sid, sid,
 					     sclass, NULL, &sid);
 		if (rc)
 			goto out;
@@ -1653,10 +1655,10 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(&selinux_state,
+	rc = avc_has_perm_noaudit(current_selinux_state,
 				  sid, sid, sclass, av, 0, &avd);
 	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(&selinux_state,
+		int rc2 = avc_audit(current_selinux_state,
 				    sid, sid, sclass, av, &avd, rc, &ad);
 		if (rc2)
 			return rc2;
@@ -1681,7 +1683,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1755,7 +1757,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -1799,7 +1801,7 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 		*_new_isid = tsec->create_sid;
 	} else {
 		const struct inode_security_struct *dsec = inode_security(dir);
-		return security_transition_sid(&selinux_state, tsec->sid,
+		return security_transition_sid(current_selinux_state, tsec->sid,
 					       dsec->sid, tclass,
 					       name, _new_isid);
 	}
@@ -1827,7 +1829,7 @@ static int may_create(struct inode *dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
@@ -1839,12 +1841,12 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    newsid, sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE, &ad);
@@ -1874,7 +1876,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
@@ -1895,7 +1897,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
@@ -1920,18 +1922,18 @@ static inline int may_rename(struct inode *old_dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
 	ad.u.dentry = old_dentry;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, old_isec->sid,
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, old_isec->sid,
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
@@ -1942,14 +1944,14 @@ static inline int may_rename(struct inode *old_dir,
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, new_isec->sid,
 				  new_isec->sclass,
 				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
@@ -1970,7 +1972,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = selinux_superblock(sb);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2045,7 +2047,7 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
@@ -2059,21 +2061,21 @@ static int selinux_binder_transaction(const struct cred *from,
 	int rc;
 
 	if (mysid != fromsid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  mysid, fromsid, SECCLASS_BINDER,
 				  BINDER__IMPERSONATE, NULL);
 		if (rc)
 			return rc;
 	}
 
-	return avc_has_perm(&selinux_state, fromsid, tosid,
+	return avc_has_perm(current_selinux_state, fromsid, tosid,
 			    SECCLASS_BINDER, BINDER__CALL, NULL);
 }
 
 static int selinux_binder_transfer_binder(const struct cred *from,
 					  const struct cred *to)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(from), cred_sid(to),
 			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
@@ -2094,7 +2096,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2113,7 +2115,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, file_to_av(file),
 			    &ad);
 }
@@ -2125,16 +2127,16 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 	u32 csid = task_sid_obj(child);
 
 	if (mode & PTRACE_MODE_READ)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    task_sid_obj(parent), task_sid_obj(current),
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
@@ -2142,7 +2144,7 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
 			    PROCESS__GETCAP, NULL);
 }
@@ -2152,7 +2154,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -2220,20 +2222,20 @@ static int selinux_syslog(int type)
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE,
 				    NULL);
 	}
 	/* All other syslog types */
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, NULL);
 }
@@ -2294,7 +2296,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
 		if (!rc)
@@ -2306,7 +2308,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 	 * i.e. SIDs that are guaranteed to only be allowed a subset
 	 * of the permissions of the current SID.
 	 */
-	rc = security_bounded_transition(&selinux_state, old_tsec->sid,
+	rc = security_bounded_transition(current_selinux_state, old_tsec->sid,
 					 new_tsec->sid);
 	if (!rc)
 		return 0;
@@ -2352,7 +2354,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 * early boot end up with a label different from SECINITSID_KERNEL
 	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
 	 */
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		new_tsec->sid = SECINITSID_INIT;
 		/* also clear the exec_sid just in case */
 		new_tsec->exec_sid = 0;
@@ -2370,7 +2372,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 			return rc;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(&selinux_state, old_tsec->sid,
+		rc = security_transition_sid(current_selinux_state, old_tsec->sid,
 					     isec->sid, SECCLASS_PROCESS, NULL,
 					     &new_tsec->sid);
 		if (rc)
@@ -2389,20 +2391,20 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  new_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
@@ -2410,7 +2412,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 		/* Check for shared state */
 		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  old_tsec->sid, new_tsec->sid,
 					  SECCLASS_PROCESS, PROCESS__SHARE,
 					  NULL);
@@ -2423,7 +2425,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
-				rc = avc_has_perm(&selinux_state,
+				rc = avc_has_perm(current_selinux_state,
 						  ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
 						  PROCESS__PTRACE, NULL);
@@ -2438,7 +2440,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
 				  NULL);
@@ -2531,7 +2533,7 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
 	if (rc) {
@@ -2571,7 +2573,7 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
 		clear_itimer();
@@ -2926,7 +2928,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (xattr_name)
 		*xattr_name = XATTR_NAME_SELINUX;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
+	return security_sid_to_context(current_selinux_state, newsid, (char **)ctx,
 				       ctxlen);
 }
 
@@ -2979,12 +2981,12 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized(&selinux_state) ||
+	if (!selinux_initialized(current_selinux_state) ||
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
 	if (xattr) {
-		rc = security_sid_to_context_force(&selinux_state, newsid,
+		rc = security_sid_to_context_force(current_selinux_state, newsid,
 						   &context, &clen);
 		if (rc)
 			return rc;
@@ -3005,7 +3007,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	struct inode_security_struct *isec;
 	int rc;
 
-	if (unlikely(!selinux_initialized(&selinux_state)))
+	if (unlikely(!selinux_initialized(current_selinux_state)))
 		return 0;
 
 	isec = selinux_inode(inode);
@@ -3029,7 +3031,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	} else {
 		isec->sclass = SECCLASS_ANON_INODE;
 		rc = security_transition_sid(
-			&selinux_state, sid, sid,
+			current_selinux_state, sid, sid,
 			isec->sclass, name, &isec->sid);
 		if (rc)
 			return rc;
@@ -3044,7 +3046,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid,
 			    isec->sid,
 			    isec->sclass,
@@ -3113,7 +3115,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 				  sid, isec->sid, isec->sclass, FILE__READ, &ad);
 }
 
@@ -3127,7 +3129,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_INODE;
 	ad.u.inode = inode;
 
-	return slow_avc_audit(&selinux_state,
+	return slow_avc_audit(current_selinux_state,
 			    current_sid(), isec->sid, isec->sclass, perms,
 			    audited, denied, result, &ad);
 }
@@ -3159,7 +3161,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(&selinux_state,
+	rc = avc_has_perm_noaudit(current_selinux_state,
 				  sid, isec->sid, isec->sclass, perms, 0,
 				  &avd);
 	audited = avc_audit_required(perms, &avd, rc,
@@ -3252,7 +3254,7 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
 
 	sbsec = selinux_superblock(inode->i_sb);
@@ -3266,13 +3268,13 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_context_to_sid(&selinux_state, value, size, &newsid,
+	rc = security_context_to_sid(current_selinux_state, value, size, &newsid,
 				     GFP_KERNEL);
 	if (rc == -EINVAL) {
 		if (!has_cap_mac_admin(true)) {
@@ -3301,24 +3303,24 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 
 			return rc;
 		}
-		rc = security_context_to_sid_force(&selinux_state, value,
+		rc = security_context_to_sid_force(current_selinux_state, value,
 						   size, &newsid);
 	}
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, newsid, isec->sclass,
 			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(&selinux_state, isec->sid, newsid,
+	rc = security_validate_transition(current_selinux_state, isec->sid, newsid,
 					  sid, isec->sclass);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    newsid,
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
@@ -3359,7 +3361,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	if (!selinux_initialized(&selinux_state)) {
+	if (!selinux_initialized(current_selinux_state)) {
 		/* If we haven't even been initialized, then we can't validate
 		 * against a policy, so leave the label as invalid. It may
 		 * resolve to a valid label on the next revalidation try if
@@ -3368,7 +3370,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	rc = security_context_to_sid_force(&selinux_state, value, size,
+	rc = security_context_to_sid_force(current_selinux_state, value, size,
 					   &newsid);
 	if (rc) {
 		pr_err("SELinux:  unable to map context to SID"
@@ -3406,7 +3408,7 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	/* No one is allowed to remove a SELinux security label.
@@ -3476,7 +3478,7 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 * If we're not initialized yet, then we can't validate contexts, so
 	 * just let vfs_getxattr fall back to using the on-disk xattr.
 	 */
-	if (!selinux_initialized(&selinux_state) ||
+	if (!selinux_initialized(current_selinux_state) ||
 	    strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
@@ -3491,11 +3493,11 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 */
 	isec = inode_security(inode);
 	if (has_cap_mac_admin(false))
-		error = security_sid_to_context_force(&selinux_state,
+		error = security_sid_to_context_force(current_selinux_state,
 						      isec->sid, &context,
 						      &size);
 	else
-		error = security_sid_to_context(&selinux_state, isec->sid,
+		error = security_sid_to_context(current_selinux_state, isec->sid,
 						&context, &size);
 	if (error)
 		return error;
@@ -3527,7 +3529,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (!value || !size)
 		return -EACCES;
 
-	rc = security_context_to_sid(&selinux_state, value, size, &newsid,
+	rc = security_context_to_sid(current_selinux_state, value, size, &newsid,
 				     GFP_KERNEL);
 	if (rc)
 		return rc;
@@ -3544,7 +3546,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 {
 	const int len = sizeof(XATTR_NAME_SELINUX);
 
-	if (!selinux_initialized(&selinux_state))
+	if (!selinux_initialized(current_selinux_state))
 		return 0;
 
 	if (buffer && len <= buffer_size)
@@ -3586,7 +3588,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 	 * xattrs up.  Instead, filter out SELinux-related xattrs following
 	 * policy load.
 	 */
-	if (selinux_initialized(&selinux_state) &&
+	if (selinux_initialized(current_selinux_state) &&
 	    !strcmp(name, XATTR_NAME_SELINUX))
 		return -ECANCELED; /* Discard */
 
@@ -3624,8 +3626,8 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		return rc;
 	}
 
-	rc = security_context_to_sid(&selinux_state, context, clen, &parent_sid,
-				     GFP_KERNEL);
+	rc = security_context_to_sid(current_selinux_state, context, clen,
+				     &parent_sid, GFP_KERNEL);
 	kfree(context);
 	if (rc)
 		return rc;
@@ -3639,14 +3641,14 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		q.name = kn->name;
 		q.hash_len = hashlen_string(kn_dir, kn->name);
 
-		rc = security_transition_sid(&selinux_state, tsec->sid,
+		rc = security_transition_sid(current_selinux_state, tsec->sid,
 					     parent_sid, secclass, &q,
 					     &newsid);
 		if (rc)
 			return rc;
 	}
 
-	rc = security_sid_to_context_force(&selinux_state, newsid,
+	rc = security_sid_to_context_force(current_selinux_state, newsid,
 					   &context, &clen);
 	if (rc)
 		return rc;
@@ -3686,7 +3688,7 @@ static int selinux_file_permission(struct file *file, int mask)
 
 	isec = inode_security(inode);
 	if (sid == fsec->sid && fsec->isid == isec->sid &&
-	    fsec->pseqno == avc_policy_seqno(&selinux_state))
+	    fsec->pseqno == avc_policy_seqno(current_selinux_state))
 		/* No change since file_open check. */
 		return 0;
 
@@ -3727,7 +3729,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3740,7 +3742,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(&selinux_state,
+	rc = avc_has_extended_perms(current_selinux_state,
 				    ssid, isec->sid, isec->sclass,
 				    requested, driver, xperm, &ad);
 out:
@@ -3837,7 +3839,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -3868,7 +3870,7 @@ static int selinux_mmap_addr(unsigned long addr)
 
 	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
 		u32 sid = current_sid();
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, sid, SECCLASS_MEMPROTECT,
 				  MEMPROTECT__MMAP_ZERO, NULL);
 	}
@@ -3917,12 +3919,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		 */
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(&selinux_state,
+			rc = avc_has_perm(current_selinux_state,
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
@@ -4015,7 +4017,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	else
 		perm = signal_to_av(signum);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    fsec->fown_sid, sid,
 			    SECCLASS_PROCESS, perm, NULL);
 }
@@ -4042,7 +4044,7 @@ static int selinux_file_open(struct file *file)
 	 * struct as its SID.
 	 */
 	fsec->isid = isec->sid;
-	fsec->pseqno = avc_policy_seqno(&selinux_state);
+	fsec->pseqno = avc_policy_seqno(current_selinux_state);
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
@@ -4061,7 +4063,7 @@ static int selinux_task_alloc(struct task_struct *task,
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
@@ -4109,7 +4111,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -4134,7 +4136,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4152,7 +4154,7 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
@@ -4167,7 +4169,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	/* init_module */
 	if (file == NULL)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    sid, sid, SECCLASS_SYSTEM,
 					SYSTEM__MODULE_LOAD, NULL);
 
@@ -4178,14 +4180,14 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
 		if (rc)
 			return rc;
 	}
 
 	isec = inode_security(file_inode(file));
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SYSTEM,
 				SYSTEM__MODULE_LOAD, &ad);
 }
@@ -4224,21 +4226,21 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSESSION, NULL);
 }
@@ -4256,21 +4258,21 @@ static void selinux_task_getlsmprop_obj(struct task_struct *p,
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
@@ -4286,7 +4288,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -4301,7 +4303,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), task_sid_obj(p),
 				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
@@ -4310,21 +4312,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
@@ -4343,7 +4345,7 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 		secid = current_sid();
 	else
 		secid = cred_sid(cred);
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
 }
 
@@ -4364,7 +4366,7 @@ static int selinux_userns_create(const struct cred *cred)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
+	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
 						USER_NAMESPACE__CREATE, NULL);
 }
 
@@ -4623,7 +4625,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	if (unlikely(err))
 		return -EACCES;
 
-	err = security_net_peersid_resolve(&selinux_state, nlbl_sid,
+	err = security_net_peersid_resolve(current_selinux_state, nlbl_sid,
 					   nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
 		pr_warn(
@@ -4652,7 +4654,7 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 	int err = 0;
 
 	if (skb_sid != SECSID_NULL)
-		err = security_sid_mls_copy(&selinux_state, sk_sid, skb_sid,
+		err = security_sid_mls_copy(current_selinux_state, sk_sid, skb_sid,
 					    conn_sid);
 	else
 		*conn_sid = sk_sid;
@@ -4670,7 +4672,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 		return 0;
 	}
 
-	return security_transition_sid(&selinux_state, tsec->sid, tsec->sid,
+	return security_transition_sid(current_selinux_state, tsec->sid, tsec->sid,
 				       secclass, NULL, socksid);
 }
 
@@ -4708,7 +4710,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), sksec->sid, sksec->sclass, perms,
 			    &ad);
 }
@@ -4729,7 +4731,7 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
@@ -4866,7 +4868,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 						      snum, &sid);
 				if (err)
 					goto out;
-				err = avc_has_perm(&selinux_state,
+				err = avc_has_perm(current_selinux_state,
 						   sksec->sid, sid,
 						   sksec->sclass,
 						   SOCKET__NAME_BIND, &ad);
@@ -4906,7 +4908,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		else
 			ad.u.net->v6info.saddr = addr6->sin6_addr;
 
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->sid, sid,
 				   sksec->sclass, node_perm, &ad);
 		if (err)
@@ -5005,7 +5007,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
 		ad.u.net->family = address->sa_family;
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->sid, sid, sksec->sclass, perm, &ad);
 		if (err)
 			return err;
@@ -5116,7 +5118,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
 	ad_net_init_from_sk(&ad, &net, other);
 
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sksec_sock->sid, sksec_other->sid,
 			   sksec_other->sclass,
 			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
@@ -5125,7 +5127,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 
 	/* server child socket */
 	sksec_new->peer_sid = sksec_sock->sid;
-	err = security_sid_mls_copy(&selinux_state, sksec_other->sid,
+	err = security_sid_mls_copy(current_selinux_state, sksec_other->sid,
 				    sksec_sock->sid, &sksec_new->sid);
 	if (err)
 		return err;
@@ -5146,7 +5148,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
 			    &ad);
 }
@@ -5162,7 +5164,7 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netif_sid(ns, ifindex, &if_sid);
 	if (err)
 		return err;
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   peer_sid, if_sid,
 			   SECCLASS_NETIF, NETIF__INGRESS, ad);
 	if (err)
@@ -5171,7 +5173,7 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    peer_sid, node_sid,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
@@ -5192,7 +5194,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -5253,7 +5255,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
 		}
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
 		if (err) {
@@ -5263,7 +5265,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -5290,7 +5292,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	if (peer_sid == SECSID_NULL)
 		return -ENOPROTOOPT;
 
-	err = security_sid_to_context(&selinux_state, peer_sid, &scontext,
+	err = security_sid_to_context(current_selinux_state, peer_sid, &scontext,
 				      &scontext_len);
 	if (err)
 		return err;
@@ -5440,7 +5442,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		 * consistency among the peer SIDs.
 		 */
 		ad_net_init_from_sk(&ad, &net, asoc->base.sk);
-		err = avc_has_perm(&selinux_state,
+		err = avc_has_perm(current_selinux_state,
 				   sksec->peer_sid, asoc->peer_secid,
 				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
 				   &ad);
@@ -5671,7 +5673,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 
 static int selinux_secmark_relabel_packet(u32 sid)
 {
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), sid, SECCLASS_PACKET,
 			    PACKET__RELABELTO, NULL);
 }
@@ -5711,7 +5713,7 @@ static int selinux_tun_dev_create(void)
 	 * connections unlike traditional sockets - check the TUN driver to
 	 * get a better understanding of why this socket is special */
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
 			    NULL);
 }
@@ -5720,7 +5722,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 {
 	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
 			    TUN_SOCKET__ATTACH_QUEUE, NULL);
 }
@@ -5749,12 +5751,12 @@ static int selinux_tun_dev_open(void *security)
 	u32 sid = current_sid();
 	int err;
 
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
-	err = avc_has_perm(&selinux_state,
+	err = avc_has_perm(current_selinux_state,
 			   sid, sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELTO, NULL);
 	if (err)
@@ -5806,7 +5808,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
@@ -5884,7 +5886,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6007,7 +6009,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6018,14 +6020,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
 		if (sel_netif_sid(state->net, ifindex, &if_sid))
 			return NF_DROP;
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, if_sid,
 				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 		if (sel_netnode_sid(addrp, family, &node_sid))
 			return NF_DROP;
-		if (avc_has_perm(&selinux_state,
+		if (avc_has_perm(current_selinux_state,
 				 peer_sid, node_sid,
 				 SECCLASS_NODE, NODE__SENDTO, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
@@ -6051,7 +6053,7 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(&selinux_state, current_sid(),
+	return avc_has_extended_perms(current_selinux_state, current_sid(),
 				      sksec->sid, sksec->sclass, perms,
 				      driver, xperm, &ad);
 }
@@ -6097,8 +6099,8 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 				sk->sk_protocol, nlh->nlmsg_type,
 				secclass_map[sclass - 1].name,
 				task_pid_nr(current), current->comm);
-			if (enforcing_enabled(&selinux_state) &&
-			    !security_get_allow_unknown(&selinux_state))
+			if (enforcing_enabled(current_selinux_state) &&
+			    !security_get_allow_unknown(current_selinux_state))
 				return rc;
 			rc = 0;
 		} else if (rc == -ENOENT) {
@@ -6137,7 +6139,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, isec->sclass, perms, &ad);
 }
 
@@ -6164,7 +6166,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__CREATE, &ad);
 }
@@ -6180,7 +6182,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
@@ -6193,7 +6195,7 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
@@ -6233,7 +6235,7 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 		 * Compute new sid based on current process and
 		 * message queue this message will be stored in
 		 */
-		rc = security_transition_sid(&selinux_state, sid, isec->sid,
+		rc = security_transition_sid(current_selinux_state, sid, isec->sid,
 					     SECCLASS_MSG, NULL, &msec->sid);
 		if (rc)
 			return rc;
@@ -6243,17 +6245,17 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.u.ipc_id = msq->key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, msec->sid, SECCLASS_MSG,
 				  MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  msec->sid, isec->sid, SECCLASS_MSGQ,
 				  MSGQ__ENQUEUE, &ad);
 
@@ -6276,11 +6278,11 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(&selinux_state,
+		rc = avc_has_perm(current_selinux_state,
 				  sid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
@@ -6299,7 +6301,7 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SHM,
 			    SHM__CREATE, &ad);
 }
@@ -6315,7 +6317,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
@@ -6329,7 +6331,7 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
@@ -6380,7 +6382,7 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SEM,
 			    SEM__CREATE, &ad);
 }
@@ -6396,7 +6398,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, isec->sid, SECCLASS_SEM,
 			    SEM__ASSOCIATE, &ad);
 }
@@ -6411,7 +6413,7 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(&selinux_state,
+		return avc_has_perm(current_selinux_state,
 				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case GETPID:
@@ -6499,7 +6501,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	rcu_read_lock();
 	tsec = selinux_cred(__task_cred(p));
 	if (p != current) {
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
@@ -6535,7 +6537,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 		return 0;
 	}
 
-	error = security_sid_to_context(&selinux_state, sid, value, &len);
+	error = security_sid_to_context(current_selinux_state, sid, value, &len);
 	if (error)
 		return error;
 	return len;
@@ -6558,27 +6560,27 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	 */
 	switch (attr) {
 	case LSM_ATTR_EXEC:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
 		break;
 	case LSM_ATTR_FSCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
 		break;
 	case LSM_ATTR_KEYCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
 		break;
 	case LSM_ATTR_CURRENT:
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 		break;
@@ -6595,7 +6597,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(&selinux_state, value, size,
+		error = security_context_to_sid(current_selinux_state, value, size,
 						&sid, GFP_KERNEL);
 		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
@@ -6622,7 +6624,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 				return error;
 			}
 			error = security_context_to_sid_force(
-						      &selinux_state,
+						      current_selinux_state,
 						      value, size, &sid);
 		}
 		if (error)
@@ -6646,7 +6648,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		tsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
-			error = avc_has_perm(&selinux_state, mysid, sid,
+			error = avc_has_perm(current_selinux_state, mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
 			if (error)
 				goto abort_change;
@@ -6660,14 +6662,14 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(&selinux_state,
+			error = security_bounded_transition(current_selinux_state,
 							    tsec->sid, sid);
 			if (error)
 				goto abort_change;
 		}
 
 		/* Check permissions for the transition. */
-		error = avc_has_perm(&selinux_state,
+		error = avc_has_perm(current_selinux_state,
 				     tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
@@ -6677,7 +6679,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		   Otherwise, leave SID unchanged and fail. */
 		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
-			error = avc_has_perm(&selinux_state,
+			error = avc_has_perm(current_selinux_state,
 					     ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
 			if (error)
@@ -6768,7 +6770,7 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(&selinux_state, secid,
+	return security_sid_to_context(current_selinux_state, secid,
 				       secdata, seclen);
 }
 
@@ -6780,7 +6782,7 @@ static int selinux_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_context_to_sid(&selinux_state, secdata, seclen,
+	return security_context_to_sid(current_selinux_state, secdata, seclen,
 				       secid, GFP_KERNEL);
 }
 
@@ -6887,7 +6889,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = selinux_key(key);
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
@@ -6898,7 +6900,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	unsigned len;
 	int rc;
 
-	rc = security_sid_to_context(&selinux_state, ksec->sid,
+	rc = security_sid_to_context(current_selinux_state, ksec->sid,
 				     &context, &len);
 	if (!rc)
 		rc = len;
@@ -6912,7 +6914,7 @@ static int selinux_watch_key(struct key *key)
 	struct key_security_struct *ksec = selinux_key(key);
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, KEY__VIEW, NULL);
 }
 #endif
@@ -6935,7 +6937,7 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
 	ibpkey.subnet_prefix = subnet_prefix;
 	ibpkey.pkey = pkey_val;
 	ad.u.ibpkey = &ibpkey;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_PKEY,
 			    INFINIBAND_PKEY__ACCESS, &ad);
@@ -6950,7 +6952,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	struct ib_security_struct *sec = ib_sec;
 	struct lsm_ibendport_audit ibendport;
 
-	err = security_ib_endport_sid(&selinux_state, dev_name, port_num,
+	err = security_ib_endport_sid(current_selinux_state, dev_name, port_num,
 				      &sid);
 
 	if (err)
@@ -6960,7 +6962,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	ibendport.dev_name = dev_name;
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_ENDPORT,
 			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
@@ -6984,12 +6986,12 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
 				   NULL);
 		break;
 	case BPF_PROG_LOAD:
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
 				   NULL);
 		break;
@@ -7030,7 +7032,7 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
 		bpfsec = map->security;
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, bpfsec->sid, SECCLASS_BPF,
 				   bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
@@ -7038,7 +7040,7 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
 		bpfsec = prog->aux->security;
-		ret = avc_has_perm(&selinux_state,
+		ret = avc_has_perm(current_selinux_state,
 				   sid, bpfsec->sid, SECCLASS_BPF,
 				   BPF__PROG_RUN, NULL);
 		if (ret)
@@ -7053,7 +7055,7 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, bpfsec->sid, SECCLASS_BPF,
 			    bpf_map_fmode_to_av(fmode), NULL);
 }
@@ -7064,7 +7066,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sid, bpfsec->sid, SECCLASS_BPF,
 			    BPF__PROG_RUN, NULL);
 }
@@ -7172,7 +7174,7 @@ static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
 	else
 		return -EINVAL;
 
-	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
+	return avc_has_perm(current_selinux_state, sid, sid, SECCLASS_PERF_EVENT,
 			    requested, NULL);
 }
 
@@ -7191,7 +7193,7 @@ static int selinux_perf_event_read(struct perf_event *event)
 	struct perf_event_security_struct *perfsec = event->security;
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
 			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
 }
 
@@ -7200,7 +7202,7 @@ static int selinux_perf_event_write(struct perf_event *event)
 	struct perf_event_security_struct *perfsec = event->security;
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+	return avc_has_perm(current_selinux_state, sid, perfsec->sid,
 			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
 }
 #endif
@@ -7215,7 +7217,7 @@ static int selinux_perf_event_write(struct perf_event *event)
  */
 static int selinux_uring_override_creds(const struct cred *new)
 {
-	return avc_has_perm(&selinux_state, current_sid(), cred_sid(new),
+	return avc_has_perm(current_selinux_state, current_sid(), cred_sid(new),
 			    SECCLASS_IO_URING, IO_URING__OVERRIDE_CREDS, NULL);
 }
 
@@ -7229,7 +7231,7 @@ static int selinux_uring_sqpoll(void)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(&selinux_state, sid, sid,
+	return avc_has_perm(current_selinux_state, sid, sid,
 			    SECCLASS_IO_URING, IO_URING__SQPOLL, NULL);
 }
 
@@ -7251,7 +7253,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	return avc_has_perm(&selinux_state, current_sid(), isec->sid,
+	return avc_has_perm(current_selinux_state, current_sid(), isec->sid,
 			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
 }
 #endif /* CONFIG_IO_URING */
@@ -7564,11 +7566,12 @@ static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	memset(&selinux_state, 0, sizeof(selinux_state));
-	enforcing_set(&selinux_state, selinux_enforcing_boot);
-	selinux_avc_init(&selinux_state.avc);
-	mutex_init(&selinux_state.status_lock);
-	mutex_init(&selinux_state.policy_mutex);
+	memset(&init_selinux_state, 0, sizeof(init_selinux_state));
+	enforcing_set(&init_selinux_state, selinux_enforcing_boot);
+	selinux_avc_init(&init_selinux_state.avc);
+	mutex_init(&init_selinux_state.status_lock);
+	mutex_init(&init_selinux_state.policy_mutex);
+	current_selinux_state = &init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 5839ca7bb9c7..6492e57f1c53 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -141,7 +141,7 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 		return 0;
 	}
 
-	ret = security_ib_pkey_sid(&selinux_state, subnet_prefix, pkey_num,
+	ret = security_ib_pkey_sid(current_selinux_state, subnet_prefix, pkey_num,
 				   sid);
 	if (ret)
 		goto out;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index bf223dcc7e0f..14aa2cbb391a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -108,7 +108,7 @@ struct selinux_state {
 
 void selinux_avc_init(struct selinux_avc **avc);
 
-extern struct selinux_state selinux_state;
+extern struct selinux_state *current_selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
@@ -151,57 +151,65 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
 
 static inline bool selinux_policycap_netpeer(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_NETPEER]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_NETPEER]);
 }
 
 static inline bool selinux_policycap_openperm(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_OPENPERM]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_OPENPERM]);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_EXTSOCKCLASS]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_EXTSOCKCLASS]);
 }
 
 static inline bool selinux_policycap_alwaysnetwork(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_ALWAYSNETWORK]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_ALWAYSNETWORK]);
 }
 
 static inline bool selinux_policycap_cgroupseclabel(void)
 {
-	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_CGROUPSECLABEL]);
+	return READ_ONCE(
+		current_selinux_state->policycap[POLICYDB_CAP_CGROUPSECLABEL]);
 }
 
 static inline bool selinux_policycap_nnp_nosuid_transition(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
 }
 
 static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
 }
 
 static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 {
-	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
+	return READ_ONCE(current_selinux_state
+				 ->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
 static inline bool selinux_policycap_userspace_initial_context(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
+		current_selinux_state
+			->policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
 }
 
 static inline bool selinux_policycap_netlink_xperm(void)
 {
 	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
+		current_selinux_state->policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
 struct selinux_policy_convert_data;
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 6d0c7bc9be15..5f0d20031784 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -153,7 +153,7 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 		goto out;
 	}
 
-	ret = security_netif_sid(&selinux_state, dev->name, sid);
+	ret = security_netif_sid(current_selinux_state, dev->name, sid);
 	if (ret != 0)
 		goto out;
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index b858b46fd4b4..e35c224145a4 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -47,7 +47,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 {
 	int rc;
 
-	rc = security_netlbl_secattr_to_sid(&selinux_state, secattr, sid);
+	rc = security_netlbl_secattr_to_sid(current_selinux_state, secattr, sid);
 	if (rc == 0 &&
 	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
 	    (secattr->flags & NETLBL_SECATTR_CACHE))
@@ -79,7 +79,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 	if (secattr == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	rc = security_netlbl_sid_to_secattr(&selinux_state, sksec->sid,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state, sksec->sid,
 					    secattr);
 	if (rc != 0) {
 		netlbl_secattr_free(secattr);
@@ -252,7 +252,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	if (secattr == NULL) {
 		secattr = &secattr_storage;
 		netlbl_secattr_init(secattr);
-		rc = security_netlbl_sid_to_secattr(&selinux_state, sid,
+		rc = security_netlbl_sid_to_secattr(current_selinux_state, sid,
 						    secattr);
 		if (rc != 0)
 			goto skbuff_setsid_return;
@@ -290,7 +290,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(&selinux_state,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state,
 					    asoc->secid, &secattr);
 	if (rc != 0)
 		goto assoc_request_return;
@@ -339,7 +339,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(&selinux_state, req->secid,
+	rc = security_netlbl_sid_to_secattr(current_selinux_state, req->secid,
 					    &secattr);
 	if (rc != 0)
 		goto inet_conn_request_return;
@@ -473,7 +473,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
 	if (rc == 0)
 		return 0;
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 0ac7df9a9367..7683c7f28421 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -204,13 +204,13 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
 	switch (family) {
 	case PF_INET:
-		ret = security_node_sid(&selinux_state, PF_INET,
+		ret = security_node_sid(current_selinux_state, PF_INET,
 					addr, sizeof(struct in_addr), sid);
 		if (new)
 			new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
-		ret = security_node_sid(&selinux_state, PF_INET6,
+		ret = security_node_sid(current_selinux_state, PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
 		if (new)
 			new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 8eec6347cf01..bd35a7c96264 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -148,7 +148,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 		return 0;
 	}
 
-	ret = security_port_sid(&selinux_state, protocol, pnum, sid);
+	ret = security_port_sid(current_selinux_state, protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 792a042add28..5de86b2b3378 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -90,7 +90,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 		return -ENOMEM;
 
 	fsi->last_ino = SEL_INO_NEXT - 1;
-	fsi->state = &selinux_state;
+	fsi->state = current_selinux_state;
 	fsi->sb = sb;
 	sb->s_fs_info = fsi;
 	return 0;
@@ -165,7 +165,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
-		length = avc_has_perm(&selinux_state,
+		length = avc_has_perm(current_selinux_state,
 				      current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
 				      NULL);
@@ -381,7 +381,7 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
@@ -443,9 +443,9 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
-			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
+			   SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
 		return ret;
 
@@ -597,7 +597,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		return -EINVAL;
 
 	mutex_lock(&fsi->state->policy_mutex);
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
@@ -652,7 +652,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
 	if (length)
@@ -700,7 +700,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
 			      NULL);
@@ -756,7 +756,7 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
 	if (rc)
@@ -885,7 +885,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
 	if (length)
@@ -939,7 +939,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
 			      NULL);
@@ -1041,7 +1041,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
 			      NULL);
@@ -1106,7 +1106,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		" This will not be supported in the future; please update your"
 		" userspace.\n", current->comm, current->pid);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
 			      NULL);
@@ -1171,7 +1171,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
 			      NULL);
@@ -1299,7 +1299,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
@@ -1355,7 +1355,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
-	length = avc_has_perm(&selinux_state,
+	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
@@ -1473,7 +1473,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
-	ret = avc_has_perm(&selinux_state,
+	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
 			   NULL);
@@ -2221,7 +2221,7 @@ static int __init init_sel_fs(void)
 	 * Try to pre-allocate the status page, so the sequence number of the
 	 * initial policy load can be stored.
 	 */
-	(void) selinux_kernel_status_page(&selinux_state);
+	(void) selinux_kernel_status_page(current_selinux_state);
 
 	return err;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7d6fd08dcb7d..db6c17bb274d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3579,7 +3579,7 @@ void selinux_audit_rule_free(void *vrule)
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 			    gfp_t gfp)
 {
-	struct selinux_state *state = &selinux_state;
+	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct selinux_audit_rule *tmprule;
@@ -3704,7 +3704,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 
 int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
-	struct selinux_state *state = &selinux_state;
+	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
 	struct context *ctxt;
 	struct mls_level *level;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 83a94ca4d738..4d1647ba8e5f 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -97,12 +97,12 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	ctx->ctx_len = str_len;
 	memcpy(ctx->ctx_str, &uctx[1], str_len);
 	ctx->ctx_str[str_len] = '\0';
-	rc = security_context_to_sid(&selinux_state, ctx->ctx_str, str_len,
+	rc = security_context_to_sid(current_selinux_state, ctx->ctx_str, str_len,
 				     &ctx->ctx_sid, gfp);
 	if (rc)
 		goto err;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
 	if (rc)
@@ -137,7 +137,7 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 	if (!ctx)
 		return 0;
 
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    current_sid(), ctx->ctx_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
 			    NULL);
@@ -160,7 +160,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(&selinux_state,
+	rc = avc_has_perm(current_selinux_state,
 			  fl_secid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
@@ -202,7 +202,7 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(&selinux_state, flic_sid, state_sid,
+	return (avc_has_perm(current_selinux_state, flic_sid, state_sid,
 			     SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
 			     NULL) ? 0 : 1);
 }
@@ -352,7 +352,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (secid == 0)
 		return -EINVAL;
 
-	rc = security_sid_to_context(&selinux_state, secid, &ctx_str,
+	rc = security_sid_to_context(current_selinux_state, secid, &ctx_str,
 				     &str_len);
 	if (rc)
 		return rc;
@@ -421,7 +421,7 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(&selinux_state,
+	return avc_has_perm(current_selinux_state,
 			    sk_sid, peer_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
 }
@@ -465,6 +465,6 @@ int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(&selinux_state, sk_sid, SECINITSID_UNLABELED,
+	return avc_has_perm(current_selinux_state, sk_sid, SECINITSID_UNLABELED,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
 }
-- 
2.47.1

