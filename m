Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE74DA9C8
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605179; cv=none; b=QVo1uri1ra36Dy6ADFtkjKmkK2/I5fxIW751wa4AiQ7NiBoOa3282iDrEGzTn/HKnFUihJ72OjdLxBga9nmVfT3uM+lJQrJKV/U5o+DzBQwuAdEHdv0fPcz2dRwfUGbjNux6c6H+evYrcjkgovi2c3yEr5EGuwHCKrWOsDCVatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605179; c=relaxed/simple;
	bh=lu8TV9PTO+DN4eb4NGn3uKccW0VaDa4WOzbkO6OsRzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft01H1+XSxQn33Zs92MzYiGoB6adi+a2RXECdbc6pJUa34q56Pm+JoMQGWqfDG6m427/4ArC7t5PZroR7RUhr4mZNq3PcnYIEWsCGuVbrA1OaNSLF0+o2Y1rWG8SHI0rZBfxsiw4CC7CE2vA6TYSxC+1dBJ+dFORVb9IY78FwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+E2e7GA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+E2e7GA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53334ea7b5cso14957141cf.0
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605173; x=1791209973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FrJUTTv8FBY6cCYQn5Ro9HwTmJOKP989gkI1yTSk9lA=;
        b=a+E2e7GAOUc3lre5UlWkgPY9WmcjB+Hafj9pkcxuqW0QYnrapoGfG+L0u93wePtfDg
         jDKTBG+vd6QDsFKd+Gd6i0uBNgaomVfFl8zEzl9wnqfRWBwJGcLvBGpGB/gh95QKH1NU
         xdHHVGfZH+ew9y5cDQvMGBIKTkOnrmy78bBrqGO2zkmufbv7iWghV6Z/7JPtl8wdtBgI
         iKlogpBjwFZpl489e8dQeT8PUPzqDlqkz2YixW20SALfFEl1P95lxFi0GEuiNJhnQvdh
         /rrGH/m9/nhiiCaRVG7L4yB9TUtIpLSwAdfDds+WSW2omrugIPHDIG3IQpEYxLiHwnlL
         J8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605173; x=1791209973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrJUTTv8FBY6cCYQn5Ro9HwTmJOKP989gkI1yTSk9lA=;
        b=A/531pc/TLMKsYmzLdqPpn3iHGyaH9SYQpbVmzih32o6jgQ6edekry8eT6Ex490oor
         nvisos7kzwizISFtGko5qBwy93UEjCTpx5TRz6pDYXailvQS7ICKQnuPymrzWU7T195u
         BQjLctsjzAl7IJpPCjqZJlSaE13xWvrRyc+EqkraPiFvwYzKxYjqbxmhBk26jQZ0YTIS
         MnReazHKr89oQM8jh3KcdvvQRj3KXOWX0HJA+eMVTy3jkJGunU1jLIWQyw7obtzZmWdY
         OUBGakzm9lZGRLtYnGJA8/YG7DhvKUU5J5zaaQE192tW0mihLXTeboPBFj1KUtkON5oF
         jZhA==
X-Gm-Message-State: AFuF++k8vsIEQr7Kl65t+C17nMsCwoxIz14k9alkm+AmUytb9b6DPv/O
	Iz/RcP9cNDTOwYBSevitqI64K7dZE4Kh6f3GiEiq+IgZoVKKIFGS+krWVI7ijQ==
X-Gm-Gg: AYBFou3240mn0Hbxd9Sy9F75cXRvFVD5kvV6a9/TwrpB7ZEpLCp0mlAG2ItRm7AcdBE
	m6spuIe7sY7LIUO0XSWYLrMTNiC5UgbjkYJsKedZQPlUpEbhEQf1M1YvYMyk4eTbhIdIONoG5N7
	9hWGGtqc6pUntnEz2NalqN+kIvtQZIOkcklASytNwXffPae38tDu3605nyPsPMh+Ew/pl1Ib+T9
	dBZQIoAUQs9i93HSoyJ4QOpSIRSRzhIa3OYSXrUGWIGoJQBT1tXKgtuA6cuaqWTyTyfNY6QvAAH
	yTSvEqNjXvYPAek/VsZJ2mUiKSS+dItE6nlVcFo5EdmjcqZo+vVFpx0WzhVH+uumfoT68+f8o/2
	huzbEYUKb+cIR+an0Xifwa2ULe8B/m1Vdqi714TmrcN/9kVkbWEsJ5qW9tjmZ2ovnVcy0ZCO/pk
	wMu6R8+Kc/joTAWShk5hfIQjZyVHNYPVmchzRGHR/0ckCNoKgsr3OJ0js8UW2pOyWgohF2u8YS+
	aSIgAN5wfsjntPMwRkX/tgEyNcT6NWbJrl0ZbkFx5jkWk5QwZIhr162noYWDZ7Sm5WYGcLGzFM=
X-Received: by 2002:a05:622a:8b:b0:533:4346:5800 with SMTP id d75a77b69052e-53343465d46mr61711691cf.12.1790605172439;
        Mon, 28 Sep 2026 07:19:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533220200cdsm64877961cf.2.2026.09.28.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:19:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts
Date: Mon, 28 Sep 2026 10:19:17 -0400
Message-ID: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an NFSv4 filesystem exported with security_label is mounted a
second time, sget_fc() returns the existing superblock and
nfs_get_root() calls security_sb_set_mnt_opts() again on it. Since the
superblock is already SB_INITIALIZED, selinux_set_mnt_opts() takes an
early exit without setting SECURITY_LSM_NATIVE_LABELS in
*set_kern_flags. nfs_get_root() then sees kflags without
SECURITY_LSM_NATIVE_LABELS set and clears NFS_CAP_SECURITY_LABEL on
the shared nfs_server, silently disabling per-file labeling for both
the new and the original mount.

Commit 3815a245b501 ("security/selinux: fix SECURITY_LSM_NATIVE_LABELS
on reused superblock") fixed the same problem in
selinux_sb_clone_mnt_opts().  The reused-superblock path for a plain
second mount now goes through sb_set_mnt_opts rather than
sb_clone_mnt_opts, so it needs the same treatment: on both
SE_SBINITIALIZED early exits, set SECURITY_LSM_NATIVE_LABELS in
*set_kern_flags when the superblock was already using
SECURITY_FS_USE_NATVE.

Closes: https://github.com/SELinuxProject/selinux-kernel/issues/69
Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3f4a6ddee322..30776b0107f2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -690,8 +690,12 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * will be used for both mounts)
 	 */
 	if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
-	    && !opts)
+		&& !opts) {
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
+		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		goto out;
+	}
 
 	root_isec = backing_inode_security_novalidate(root);
 
@@ -735,6 +739,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
+		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		rc = 0;
 		goto out;
 	}
-- 
2.55.0

