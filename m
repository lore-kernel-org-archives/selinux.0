Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EF3DDAFB
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144725; cv=none; b=uZYBDvNNiUMRiZXbIE3RBBVVA8LEJQsNKl++ELfmAIVOAsLkeDQNVtrohuIz/BD5EwhyubWOB4dVVFjJS1h2V6NdjHwHMRuGeST4GCBq5CC47jd0AJPb0x5twGeFfD7Yf7GzpxEQuO7HLzyBydY+H3jWniGYT+gE26dmG66RXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144725; c=relaxed/simple;
	bh=hlpcUxfSNPtDQfSvTjmJmK2UAdIAn6d8cgFzA6t3c1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfRIZuLl28jfZQ5FEiUXW9Cl/zQCBrpa5p9SBiujNfDtw4hU9eYpYtIa8cDcAM9jt6326ACUjjAQb7vxTm/QYHvfQdpmDz2GITY+UuH2eycjgvNlztDRuaFh2qJTdyIiCWTxJMXjAiOHxG5Y6p/R+6B9dRmbJTmddvBFfshCMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYY0OXjD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYY0OXjD"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cc0ebbf4bso10678396d6.3
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144718; x=1789749518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yW/K5Z3iyKYMYDbjKrNWxxmSnn09tW9RBhDCj+/JJhU=;
        b=hYY0OXjD1c6wnpeSZTQvKsuc5ZekqKkUksLCFHriCGxSQDkAAWezl8GLbb7cNQBcxh
         7oDFe+RODoFwARqTQrknPUIGU7jgIHcDjGoNven1XsfWHIAJQ83fC5KP8M5Clf+vtNjM
         ULSFvrggA96XvyFSEm90f0iAeS2gBpovNLYT5l6P5dDKwJghCQKUsEap8IPWfYje1AR1
         SC9IJldpex57CXQ6OPrhQ1kJyMtWwFqKNmdBqP1l09IH5PWpP4D6DV6hXyN9dob2UQa3
         qFvLX8nyTeZ9pw3//buzLD+WDpy9W/bmNOlktAjtdF0K+3koABx0/em0B5FUnHnh7azm
         SDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144718; x=1789749518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yW/K5Z3iyKYMYDbjKrNWxxmSnn09tW9RBhDCj+/JJhU=;
        b=fZ64DUjBgoz8+x4uOC4nywj0ivhTaazcm7tLZ5FoIHI0Tagm9Bm8PPZOkOT4QSSu9S
         3kiNONvyGpJe44kaCLaPzM88Md8YDzOWgAIf7eQwp595Dqzk3ti6719licZ3n1XCHJQd
         d1AHGaY4xpi6oEVLIpd0dcWLDcvLUVXda9KAhRL6oq9PJp/D85F2QoIWaBLMgi129HB7
         7/6o0+pM2FLvBCn7+cE1+KrGQQtxYo19cukVpIx9lJXQLy+BeDbIE/lWnhLypwnven19
         q05kZ6nAq+AyXYYqrDPMqkdmQRoBSnlcpWyJOh9UFhUmY2MoB/ekYt/yJ5exEMl9ZiBi
         L06Q==
X-Gm-Message-State: AFuF++lHFsOWBLzipZdskxMeQKJCaNdDny4EJvcpeo5N7/mLYD+JWusN
	VIRYkeX9nm7BZQ9Ei5/wA0gfu93KRdfbQlkMbzm/Y0YWELnjX1NyEoa4alwB1Ygk
X-Gm-Gg: AYBFou019ZKCvSht3VraW8YKdSUmPSwzMWqxsjXV2EpiVnX1bceKKaQ2rw9BIY7QOUW
	FCDZNodX9zZij9JmeSAR2y7uvPwWBJQ2XqnGsaEWfCMOYC5YJApXOWFbQ11ME323yiQlvMOxOj1
	6wiOLyUGP5xX7VMdmg7bBTJEtQHjhE0Soufx0d+z3jg4u2JecEjSeyGex6YX9F/fYkVgd/8KOKK
	zznq5jF3izcdctS6reWezOm1BUwQdTqBgD8Hl32wGfuHoA7u+4EL622bwR0DqO58DC/RkuGy0wv
	yQRi0eL6UYOyfjZIctFEjRdmOxsk6dJBm4dst/fYdct2q/APHATp5CCfYWqrKYHVPkknShXZNe8
	6DOr9He+ATyvuHlGHy8KVKRR8WUf1upxxH4kPMHk/CX6XTax7SFiv6wazlQlcCJQZaJZwRnJBD2
	ob76ZIFJ/CO6soMTCa5yj/Sx/MAFYJ96TvKqX+RmMP9LBfP6+XpSbE+SnMiY8qoVpcuewAAqGm5
	Z0aDgIHwX2+1qRO+qSkYPbhMzarSL9y0lOhOi01RH997Y9yr0bOREoRXEY6BLzzPNMixDhh+3gk
	gxLfezoeww==
X-Received: by 2002:a05:6214:62d:b0:910:94c6:2ea1 with SMTP id 6a1803df08f44-9121208a51amr64327596d6.12.1789144718011;
        Fri, 11 Sep 2026 09:38:38 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49414csm24090916d6.34.2026.09.11.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:38:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	ljs@kernel.org,
	jannh@google.com,
	jack@suse.cz,
	cgzones@googlemail.com,
	brauner@kernel.org
Subject: [PATCH v3] selinux: mark status and policy inodes as immutable, drop status mmap write checks
Date: Fri, 11 Sep 2026 12:37:35 -0400
Message-ID: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selinuxfs "status" and "policy" files are read-only interfaces
that are also mmap'd by userspace. They are created 0444 by
simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.

Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
tests IS_IMMUTABLE before the DAC / capability checks, so all of the
above are rejected at the VFS layer without ever reaching the file
operations. Since a writable file can no longer exist, do_mmap() clear
VM_MAYWRITE for MAP_SHARED mappings on its own, and the
sel_mmap_handle_status() write/mprotect guards are dead; drop them.
MAP_PRIVATE writable mappings become permitted (they were previously
-EPERM) and CoW harmlessly to a private page, matching how
sel_mmap_policy() has always treated the private case.

The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
reason; leave dropping it to the pending "selinux: reject writable
opens of policy file, drop mmap shared/write check" patch so that the
patches do not conflict.

Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
cc: ljs@kernel.org
cc: jannh@google.com
cc: jack@suse.cz
cc: cgzones@googlemail.com
cc: brauner@kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 implements Jan's suggestion to mark the inodes immutable rather than
implementing open-time checks.

 security/selinux/selinuxfs.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..0941ce79ea0b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -247,11 +247,6 @@ static int sel_mmap_handle_status(struct file *filp,
 	/* only allows one page from the head */
 	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
 		return -EIO;
-	/* disallow writable mapping */
-	if (vma->vm_flags & VM_WRITE)
-		return -EPERM;
-	/* disallow mprotect() turns it into writable */
-	vm_flags_clear(vma, VM_MAYWRITE);
 
 	return remap_pfn_range(vma, vma->vm_start,
 			       page_to_pfn(status),
@@ -1818,6 +1813,17 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
 
 #define NULL_FILE_NAME "null"
 
+static void sel_mark_immutable(struct dentry *root, const char *name)
+{
+	struct qstr q = QSTR(name);
+	struct dentry *dentry = try_lookup_noperm(&q, root);
+
+	if (!IS_ERR_OR_NULL(dentry)) {
+		d_inode(dentry)->i_flags |= S_IMMUTABLE;
+		dput(dentry);
+	}
+}
+
 static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct selinux_fs_info *fsi;
@@ -1857,6 +1863,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
+	sel_mark_immutable(sb->s_root, "status");
+	sel_mark_immutable(sb->s_root, "policy");
+
 	fsi = sb->s_fs_info;
 	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
 	if (IS_ERR(fsi->bool_dir)) {
-- 
2.55.0

