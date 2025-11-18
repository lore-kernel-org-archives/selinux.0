Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD32F2609
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480831; cv=none; b=s7ps8N8clPij85pytHYpHMbKZYss+4RBVC8HWkXzDjHdI4Hxgg3+0/+ym6QN/vst2HYxYe/fadp42w/qnXhGQcr76tDxNUW5RutBTvRxwvsWshFOxXCk8tE2sIU0iO2QYzlvy99uJNmhQ0x7Njyw6ccjVPwobeY6swQ43ozAhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480831; c=relaxed/simple;
	bh=0DSh5U6k/7MqxoHu1XYz4w8LNDAQWRUhBf3mNdUyqzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqJm33NYZMYlE/XLIzbL4g5MMmvEPGkSQWUUwwiaUSScC5wmFrRnERE53juGO9j2jX/lp8t2WFigpExoOpwvg35VyPRmntdSdWyWo0FljgvHp7trO9janIBhNDjoszd7C8Uqm9y8l1KqBfpU3KVaoas2Wy4D6w4IVPFi2urGu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQNIWmZO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQNIWmZO"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8823dfa84c5so62204016d6.3
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480824; x=1764085624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOOFjWD3UgDN5O/sQw+SKQvJ9LcxlCkXlswm/lL/LXE=;
        b=XQNIWmZOt1tFMqS1O0XA+NFOCtzsWDe3S8qDv2ZhOotfBg1JluhhBAE3SnGCgvmRF4
         Lcn8k6qInIzgnrsphLRv69Evyi6Cn72UGPfGqnLLEInJVLjpAvgyaSGWUoJcL8Te83sZ
         5JDVgrjtvzjQ0BztTUVm8wb8bdmCcvOm2c+rLSLU5H8nUDEgwcNf/08JZUZIcXFAFXhO
         KgVMbdaTM0FGQhe5e3PquMVCFfrDgZyui9EqQn7KlHNFCPPy5eilNPQydugzT4VFeDrO
         hQgGGfpIXxigehhB4XOquWWn8XcAhn6J2mMCKyPCtPZcA07waioRJIB4o68lgjLkGcsV
         LeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480824; x=1764085624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOOFjWD3UgDN5O/sQw+SKQvJ9LcxlCkXlswm/lL/LXE=;
        b=VjZMGxGIdv2aC3lOLHN9T93VZHaKnBm+j8I48qqZbPIyC88GUPVVLlhFpUvWa8WkFy
         ReRXp375i0L00COxe3iG4yn0VsEt8H/V7NyxqA61OYTHLP9QEuWsx743B346l2L/pXvC
         bJ4KwrmT112HJUzTKB2izlWLeZTXR3Q0ekB/5FPbkFCP8qXRoyoYiLG6/sRu/D/FxXXt
         X6639G4EJNs49cFFwE5ZV3TFrrYN0ZksQeXE+kyM/cvAGIvQ0Hs3qmrrUIL4M/fyXuCz
         AdPzrHNtyJGBPWtjKihEO7WKhejAV3hZML5P8pvnHAE74Z7/MBiLyxtVv4XNWvOvU2ep
         p4yw==
X-Gm-Message-State: AOJu0YzBh3Nc1u0vOFSOUbvOd60T/fbxIf4MtsD43q4V+zlbiEcVUkz1
	ztbeXe4XsxVJF9GeZ1xzCNz0SRjoLmiHjnz/rjZ45r4q7vHS5NJvuIkL
X-Gm-Gg: ASbGnct0gR6bWpg3FujXk2k14Y/okrxDolKx/1FYaehCkPrEP7K2u5T8CeIGICjnwe/
	0oeM3hljSQHG6n2ex5ZOD8SaJYWzLFpvdKS9iRhrdCrZe5XXanMk/7+zMCtHTdBVC1VBzNwt5xO
	0HpEA9cSs9fDRWvCFU3dKsVWZwuyH4WDQy1rh+aGmyKc23FO+48afkGgZP1dT2FaVLUhT+LZdUC
	SgwGRXUxTBm813HqTFRVW0J38yUUM6FW+YUT2kYWCOd9YNi5CZv1XPNz45VYbN874+2qewkrSAi
	kv9b3QY6+T18Xzg+pMkk6jETjtDYxSWYc/S+rnRe4/T/fxHYlQp9DpUqURzGQT/YdCPAbBaQKfJ
	5B4cuC5w+Fbs9sKeGcJB1jQ0X+YEV8FeQCWAT2+Z9P7I2rYIj2fRGAjRVaxpAweLim/KWbY7S/t
	+vC+pUkV5y+an+5LxppbEu58ZJ3WX5qqxr3o76ohpd4e+Wf6OaQlObi5uFbUT6TBcxrhIeR82F5
	B775wBPAN4f96T7iv8mZVwZtw==
X-Google-Smtp-Source: AGHT+IEyjOtV/gQBNwixrpysBWLRW3hLqnBpEqMirSBmHIJv7zfocPQgipMyay4ffPJQt5kmE5wwFw==
X-Received: by 2002:a05:6214:234d:b0:880:8843:1f91 with SMTP id 6a1803df08f44-88292616614mr235366036d6.22.1763480824425;
        Tue, 18 Nov 2025 07:47:04 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286312406sm115911066d6.19.2025.11.18.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:47:04 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: mertsas@cisco.com
Cc: selinux@vger.kernel.org,
	paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH selinuxns 1/3] selinux: do not cache sblabel mount flag in superblock
Date: Tue, 18 Nov 2025 10:46:45 -0500
Message-ID: <20251118154647.14566-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently SELinux determines whether the superblock supports
security labeling at superblock creation time and caches it
as a SBLABEL_MNT flag in the superblock security blob. However,
with the introduciton of SELinux namespaces, this can change
within a child SELinux namespace due to a different value for
the cgroupseclabel policy capability in its policy. Stop
precomputing and caching this flag and instead check it on use.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 22 ++++++----------------
 security/selinux/include/security.h |  1 -
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7003a3f96ead..61171c45329f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -581,16 +581,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 
 	sbsec->flags |= SE_SBINITIALIZED;
 
-	/*
-	 * Explicitly set or clear SBLABEL_MNT.  It's not sufficient to simply
-	 * leave the flag untouched because sb_clone_mnt_opts might be handing
-	 * us a superblock that needs the flag to be cleared.
-	 */
-	if (selinux_is_sblabel_mnt(sb))
-		sbsec->flags |= SBLABEL_MNT;
-	else
-		sbsec->flags &= ~SBLABEL_MNT;
-
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(root_inode, root);
 
@@ -1141,7 +1131,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 		if (rc)
 			return rc;
 	}
-	if (sbsec->flags & SBLABEL_MNT) {
+	if (selinux_is_sblabel_mnt(sb)) {
 		seq_putc(m, ',');
 		seq_puts(m, SECLABEL_STR);
 	}
@@ -1815,7 +1805,7 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
 		*_new_isid = sbsec->mntpoint_sid;
-	} else if ((sbsec->flags & SBLABEL_MNT) &&
+	} else if (selinux_is_sblabel_mnt(dir->i_sb) &&
 		   tsec->create_sid) {
 		*_new_isid = tsec->create_sid;
 	} else {
@@ -3023,7 +3013,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (!selinux_initialized(current_selinux_state) ||
-	    !(sbsec->flags & SBLABEL_MNT))
+	    !selinux_is_sblabel_mnt(dir->i_sb))
 		return -EOPNOTSUPP;
 
 	if (xattr) {
@@ -3454,7 +3444,7 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
 
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SBLABEL_MNT))
+	if (!selinux_is_sblabel_mnt(inode->i_sb))
 		return -EOPNOTSUPP;
 
 	if (!inode_owner_or_capable(idmap, inode))
@@ -3730,7 +3720,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SBLABEL_MNT))
+	if (!selinux_is_sblabel_mnt(inode->i_sb))
 		return -EOPNOTSUPP;
 
 	if (!value || !size)
@@ -7105,7 +7095,7 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
 {
 	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
 					   ctx, ctxlen, 0);
-	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
+	/* Do not return error when suppressing label. */
 	return rc == -EOPNOTSUPP ? 0 : rc;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e3e0b1eb7575..c5df7a0b0069 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -63,7 +63,6 @@
 #define FSCONTEXT_MNT	0x02
 #define ROOTCONTEXT_MNT 0x04
 #define DEFCONTEXT_MNT	0x08
-#define SBLABEL_MNT	0x10
 /* Non-mount related flags */
 #define SE_SBINITIALIZED 0x0100
 #define SE_SBPROC	 0x0200
-- 
2.51.1

