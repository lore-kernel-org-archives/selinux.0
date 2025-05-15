Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A12989BA
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314657; cv=none; b=pdwGx0owkJ9KaIPNMnjsg/hQaI4SRNnN365ToGF3ooDHuS3a1UyHFR92QSqyr+8cbKQKyknzLr739+1cj2P6lqAUuGgePzdyJPiS28ALfIHvFlgMQwklvUtRtuJszbTLNoK1haKJ+7eeN3WJIvBpPid3cZYwVQ3IEt2Rm9TkTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314657; c=relaxed/simple;
	bh=FTP27+EYkvislpz6ixAOhSKFnnSKI6EkojyYg7N7V3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPMNthZ2dePo1nYrnScygsiGu/1OkKnB2z1LQzvO0BiT+dGiyRei03+WjcGdNmtBmVql6L2aDdx/UUKtk78yvMumhUIaMeZEJu8xPaWERbkJIvcy28cwpQ2rEAIxuRP1c/4+eY2UCY9zfL1iDmsqyZMMwsYeBK2f9W39/n/K27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY9rtOs+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY9rtOs+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f6e6ec07f0so8576946d6.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314654; x=1747919454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvOgpvytNBDVq7v+9peOmFVWs7IO5oyDduKafmUlRsw=;
        b=dY9rtOs+8ga0gHLgZgK+03gep8dEY7db8ZCEJKL+PlgLGI9kC8UbMEaxcFze36dQzx
         OyXOR/T6L+pEw9hEEwJsXYwsuKF5HF3sWJPUojvTHt14rho8++n2hYhwKo+6/uCusowV
         vitgNqidOij28VbWUWiop5R/wlq8ncV529LEiItOQmrXPsbbbZfyh/eCIIbUUBW73lwj
         /vf042Rn7O7b67WNHO8w8F2JzDI8P8jYtFcyKvLP2Mo9YmbitJ3pVbV5lchi76+8OeKl
         WCkmypv5DnDsz4O0nVZs4EJLIN0mJiagTLXDai3JtYpgrShb/EEoHfs2UA+5z4k6imf8
         35+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314654; x=1747919454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvOgpvytNBDVq7v+9peOmFVWs7IO5oyDduKafmUlRsw=;
        b=fgtQvCOaXbb3CD8gplp5sP7nyfZA5A8e/+/F4NkKvigC6hHYh9z+HdzYts1t1G0s85
         Y9KORigS0/zFYKpgFx2v3jQNhz0h8EuIQ/C/XX+G1J/VGHhCgj6HRehcZCb5y2Rk8oaI
         pqiDdS0MCMjTgl6vo7j93rPLYeDF7VUAY8OLSx5rAH2r97Boau3AxxKzqqsYtd67Y9nX
         SEU9o+F8yQQeeWCCqVzAulclyNidciCwODDsjEFxpB0FRG22eZeSJaKo8K7PkjpcqgCk
         r2wgKqX0U95me/ZbTPCzVX9pcng8j6f3y/f6n+hKS24ReZ0Nx9rqfLiUEd8sjgxqWCnG
         uj5A==
X-Gm-Message-State: AOJu0Yyf5fqskqBZtaHF0MmAk5kbrHfGM1EWHtm6HjZeA9fNBaRiIzA3
	fhbQfHYVfAWK7/ZMHQ44klumR+CmEJBVol44UwGxxr5wuOm8evammsqAVA==
X-Gm-Gg: ASbGncsXF6xDnL9Fv6ghb06JvKRuQyxJzMBqvv3kOgF8QVrZMmXBv0zWRBUtiDJx9tK
	JVbO9RtFonHGUe/q8ihqm/GtQhJQzJ6ZdQCROnrI/88AxFsUtU7K5lgZAdNzkQw7tb14SPsvwBr
	cIlbH2yQd0jcl1U4FVKxI39gxWWNxZzJ3FDhE+NBMbsNSZlF2oG496A5/zZJ3UhV0zS3lnUpWmA
	udyNiyGJUgnEEId7tVqEysmd8G9pJrqsSDFvNLOCtkQfJ4wnFSV1pimMLvqRgawgZwp3I3OA9uA
	tWRa/ERN+4mKtMLesYg5vtUhooM16YS+hgY5hue9MeLlCPE6nnOPlpDDjRV+YOs6yMBFgqwiObv
	uJ3imLhxTGIbHNXfnxsr3ZcW+YHBtdy+e87UURcc0MHLLi5Zi7FGH2A==
X-Google-Smtp-Source: AGHT+IEgdctwxtvecXVrE621cmpav5/Ic4IkUAv2A7B5mpPgQgoYrXzmu6v/P5QCsXC4uesvdGo3EA==
X-Received: by 2002:a05:6214:21ad:b0:6e8:fa72:be51 with SMTP id 6a1803df08f44-6f896e34e03mr124918816d6.19.1747314654147;
        Thu, 15 May 2025 06:10:54 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 48/49] selinux: repair security_fs_use() interface and its users
Date: Thu, 15 May 2025 09:09:46 -0400
Message-ID: <20250515130947.52806-49-stephen.smalley.work@gmail.com>
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

The security server interfaces were meant to be independent of
the core kernel data structures and security blobs. Originally
security_fs_use() passed the fstype, behavior, and sid parameters
explicitly, but this was later simplified to just pass the
superblock structure and set fields in the superblock security
blob directly, breaking this layering. With the introduction of
the global SID table, we need to map the SID returned by the
security server to a global SID, which is less straightforward
in the absence of proper layering. Revert the security_fs_use()
interface and implementation to its original form and update the
callers. This is not a performance-critical path regardless and
any small benefit from passing the single superblock pointer
instead of the three separate parameters is not worth the
maintainability cost.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/global_sidtab.c      | 22 +++++++---------------
 security/selinux/hooks.c              |  7 +++++--
 security/selinux/include/security.h   |  8 +++++---
 security/selinux/include/selinux_ss.h |  3 ++-
 security/selinux/ss/services.c        | 24 ++++++++++++------------
 5 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index 396efd98e064..e1acf6607788 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -691,33 +691,25 @@ int security_net_peersid_resolve(struct selinux_state *state, u32 nlbl_sid,
 	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
 }
 
-// only required for (mis)use of superblock_security_struct + selinux_superblock() below.
-// TODO Remove when security_fs_use() interface is repaired
-#include "objsec.h"
-
-int security_fs_use(struct selinux_state *state, struct super_block *sb)
+int security_fs_use(struct selinux_state *state, const char *fstype,
+		    unsigned short *behavior, u32 *sid)
 {
 	int rc;
-	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	if (!selinux_initialized(state)) {
-		sbsec->behavior = SECURITY_FS_USE_NONE;
-		sbsec->sid = SECINITSID_UNLABELED;
+		*behavior = SECURITY_FS_USE_NONE;
+		*sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
-	// TODO - it was a mistake to have pushed direct access to
-	// sbsec into a security server function. Fix both that
-	// interface and here to explicitly return the behavior and
-	// SID via parameters to be set in the sbsec by the caller.
-	rc = selinux_ss_fs_use(state, sb);
+	rc = selinux_ss_fs_use(state, fstype, behavior, sid);
 	if (rc)
 		return rc;
 
-	if (sbsec->sid <= SECINITSID_NUM)
+	if (*sid <= SECINITSID_NUM)
 		return 0;
 
-	return map_ss_sid_to_global(state, sbsec->sid, &sbsec->sid, GFP_ATOMIC);
+	return map_ss_sid_to_global(state, *sid, sid, GFP_ATOMIC);
 }
 
 int security_genfs_sid(struct selinux_state *state, const char *fstype,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a9b5879cdd62..06a5ffaebafd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -762,7 +762,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 * Determine the labeling behavior to use for this
 		 * filesystem type.
 		 */
-		rc = security_fs_use(current_selinux_state, sb);
+		rc = security_fs_use(current_selinux_state, sb->s_type->name,
+				     &sbsec->behavior, &sbsec->sid);
 		if (rc) {
 			pr_warn("%s: security_fs_use(%s) returned %d\n",
 					__func__, sb->s_type->name, rc);
@@ -973,7 +974,9 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
-		rc = security_fs_use(current_selinux_state, newsb);
+		rc = security_fs_use(current_selinux_state,
+				     newsb->s_type->name,
+				     &newsbsec->behavior, &newsbsec->sid);
 		if (rc)
 			goto out;
 	}
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7aac5c4e4991..d1f65e0741a8 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -587,7 +587,8 @@ int security_get_allow_unknown(struct selinux_state *state);
 #define SECURITY_FS_USE_MAX	 7 /* Highest SECURITY_FS_USE_XXX */
 
 #ifdef CONFIG_SECURITY_SELINUX_NS
-int security_fs_use(struct selinux_state *state, struct super_block *sb);
+int security_fs_use(struct selinux_state *state, const char *fstype,
+		    unsigned short *behavior, u32 *sid);
 
 int security_genfs_sid(struct selinux_state *state, const char *fstype,
 		       const char *path, u16 sclass, u32 *sid);
@@ -596,9 +597,10 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy, const char *fstype,
 			     const char *path, u16 sclass, u32 *sid);
 #else
 static inline int security_fs_use(struct selinux_state *state,
-				  struct super_block *sb)
+				  const char *fstype, unsigned short *behavior,
+				  u32 *sid)
 {
-	return selinux_ss_fs_use(state, sb);
+	return selinux_ss_fs_use(state, fstype, behavior, sid);
 }
 
 static inline int security_genfs_sid(struct selinux_state *state,
diff --git a/security/selinux/include/selinux_ss.h b/security/selinux/include/selinux_ss.h
index d1f526475b53..e7b5346d2b49 100644
--- a/security/selinux/include/selinux_ss.h
+++ b/security/selinux/include/selinux_ss.h
@@ -94,7 +94,8 @@ int selinux_ss_sid_mls_copy(struct selinux_state *state, u32 sid, u32 mls_sid,
 int selinux_ss_net_peersid_resolve(struct selinux_state *state, u32 nlbl_sid,
 				   u32 nlbl_type, u32 xfrm_sid, u32 *peer_sid);
 
-int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb);
+int selinux_ss_fs_use(struct selinux_state *state, const char *fstype,
+		      unsigned short *behavior, u32 *sid);
 
 int selinux_ss_genfs_sid(struct selinux_state *state, const char *fstype,
 			 const char *path, u16 sclass, u32 *sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a98c9ff8b790..32eb57af8a7a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -62,7 +62,6 @@
 #include "services.h"
 #include "conditional.h"
 #include "mls.h"
-#include "objsec.h"
 #include "netlabel.h"
 #include "xfrm.h"
 #include "ebitmap.h"
@@ -3008,21 +3007,22 @@ int selinux_ss_policy_genfs_sid(struct selinux_policy *policy,
 /**
  * selinux_ss_fs_use - Determine how to handle labeling for a filesystem.
  * @state: SELinux state
- * @sb: superblock in question
+ * @fstype: filesystem type
+ * @behavior: labeling behavior to apply
+ * @sid: SID for superblock
  */
-int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb)
+int selinux_ss_fs_use(struct selinux_state *state, const char *fstype,
+		      unsigned short *behavior, u32 *sid)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
 	struct ocontext *c;
-	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-	const char *fstype = sb->s_type->name;
 
 	if (!selinux_initialized(state)) {
-		sbsec->behavior = SECURITY_FS_USE_NONE;
-		sbsec->sid = SECINITSID_UNLABELED;
+		*behavior = SECURITY_FS_USE_NONE;
+		*sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
@@ -3040,8 +3040,8 @@ int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 	if (c) {
-		sbsec->behavior = c->v.behavior;
-		rc = ocontext_to_sid(sidtab, c, 0, &sbsec->sid);
+		*behavior = c->v.behavior;
+		rc = ocontext_to_sid(sidtab, c, 0, sid);
 		if (rc == -ESTALE) {
 			rcu_read_unlock();
 			goto retry;
@@ -3050,16 +3050,16 @@ int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb)
 			goto out;
 	} else {
 		rc = __security_genfs_sid(policy, fstype, "/",
-					SECCLASS_DIR, &sbsec->sid);
+					SECCLASS_DIR, sid);
 		if (rc == -ESTALE) {
 			rcu_read_unlock();
 			goto retry;
 		}
 		if (rc) {
-			sbsec->behavior = SECURITY_FS_USE_NONE;
+			*behavior = SECURITY_FS_USE_NONE;
 			rc = 0;
 		} else {
-			sbsec->behavior = SECURITY_FS_USE_GENFS;
+			*behavior = SECURITY_FS_USE_GENFS;
 		}
 	}
 
-- 
2.49.0

