Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA5AC43381
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0AD22CB1
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbhAEQaM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbhAEQaL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 11:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609864124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qGR79Wqya0DwlLErOWBGmZcitI1Qdwa0Yol4lTPmFDg=;
        b=JzkFTQ2UUrxoOLZjvbeE74ZxsohrZ/r9zZ3ecI8U4PKHatH0vqI4zZZYYyAJK+a/ifZIi4
        QEHibz0oY7F3Ez2Y3VAqMJA7DLEgwGRbwr+DH3/RWFE/8IAaWWgxGGzIsaH7MuapgNnqFQ
        0Tcv7mGMEbJ/oMv6i4/Vns+bPrc97w0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-KzbVsi3NP7SSpZzm2up32A-1; Tue, 05 Jan 2021 11:28:41 -0500
X-MC-Unique: KzbVsi3NP7SSpZzm2up32A-1
Received: by mail-ej1-f69.google.com with SMTP id w6so88204ejo.2
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 08:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGR79Wqya0DwlLErOWBGmZcitI1Qdwa0Yol4lTPmFDg=;
        b=tyQ0raoGkKQtWtmsMyvB1aHfSfbIwyomOLE3CeMlD6sH8ixALCqiUl09a80FAeqQLG
         eRwjdD1auyyP55p9dMHQar27RPXW9wIdY6ANTZFE2PtSBAbqe+Ad0eUf1JDjF9t4+BX8
         8JvD5RFKZhXmpWD9Li0mDiJoRu6qQK042aEUFDAdwutX6cITyKW1K7MYw4W0ZuaxkZCA
         WZiCSsIFI4t/7yCTQe2iY6ptTxOnawVyFM3iSmlZw3Ry2VfVAreU8MK4PFV6uzEMzM4s
         p7DNjaFP3hkA+q2qvoaV/n94CjscxtFvRx8wDVOH9niBMyF34HxrlcvTzolkIIaWhFqM
         3C/w==
X-Gm-Message-State: AOAM530rZQlq5GfThGVqVQEvlM4RHcanSTs/ZbRLB/7wViUkxskIpiY6
        UxCgRJh8rE8Q3F1GnOSEI6b+SDpU9e2IbzCXZi6SOHfOhfR1zuvjjHjnk+1OW9g44SU4h2dJLnL
        xnKTMLxDkzM11ZzYCg336sOncL6rj6WcuQz0NIg0DfucU3pipBYer2vc/fuwZHpbIWwn8ow==
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr70411220ejd.478.1609864119355;
        Tue, 05 Jan 2021 08:28:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlCxQvesOLZdDPpz5BRiCrqjaZJW7nO548UsqKceWgzPzfEnUXz3TQFQZ6UmS7kamfw79HCQ==
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr70411204ejd.478.1609864119110;
        Tue, 05 Jan 2021 08:28:39 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id d6sm49590ejy.114.2021.01.05.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 08:28:38 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support
Date:   Tue,  5 Jan 2021 17:28:30 +0100
Message-Id: <20210105162830.1037459-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a superblock is assigned the SECURITY_FS_USE_XATTR behavior by the
policy yet it lacks xattr support, try to fall back to genfs rather than
rejecting the mount. If a genfscon rule is found for the filesystem,
then change the behavior to SECURITY_FS_USE_GENFS, otherwise reject the
mount as before. A similar fallback is already done in security_fs_use()
if no behavior specification is found for the given filesystem.

This is needed e.g. for virtiofs, which may or may not support xattrs
depending on the backing host filesystem.

Example:
    # seinfo --genfs | grep ' ramfs'
       genfscon ramfs /  system_u:object_r:ramfs_t:s0
    # echo '(fsuse xattr ramfs (system_u object_r fs_t ((s0) (s0))))' >ramfs_xattr.cil
    # semodule -i ramfs_xattr.cil
    # mount -t ramfs none /mnt

Before:
    mount: /mnt: mount(2) system call failed: Operation not supported.

After:
    (mount succeeds)
    # ls -Z /mnt
    system_u:object_r:ramfs_t:s0 /mnt

See also:
https://lore.kernel.org/selinux/20210105142148.GA3200@redhat.com/T/
https://github.com/fedora-selinux/selinux-policy/pull/478

Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 78 +++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658e..0b9b4050b9315 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -484,38 +484,67 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 	}
 }
 
-static int sb_finish_set_opts(struct super_block *sb)
+static int sb_check_xattr_support(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = d_backing_inode(root);
-	int rc = 0;
+	u32 sid;
+	int rc;
 
-	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
-		/* Make sure that the xattr handler exists and that no
-		   error other than -ENODATA is returned by getxattr on
-		   the root directory.  -ENODATA is ok, as this may be
-		   the first boot of the SELinux kernel before we have
-		   assigned xattr values to the filesystem. */
-		if (!(root_inode->i_opflags & IOP_XATTR)) {
-			pr_warn("SELinux: (dev %s, type %s) has no "
-			       "xattr support\n", sb->s_id, sb->s_type->name);
+	/*
+	 * Make sure that the xattr handler exists and that no
+	 * error other than -ENODATA is returned by getxattr on
+	 * the root directory.  -ENODATA is ok, as this may be
+	 * the first boot of the SELinux kernel before we have
+	 * assigned xattr values to the filesystem.
+	 */
+	if (!(root_inode->i_opflags & IOP_XATTR)) {
+		pr_warn("SELinux: (dev %s, type %s) has no xattr support\n",
+			sb->s_id, sb->s_type->name);
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
+	if (rc < 0 && rc != -ENODATA) {
+		if (rc == -EOPNOTSUPP)
+			pr_warn("SELinux: (dev %s, type %s) has no security xattr handler\n",
+				sb->s_id, sb->s_type->name);
+		else
+			pr_warn("SELinux: (dev %s, type %s) getxattr errno %d\n",
+				sb->s_id, sb->s_type->name, -rc);
+		goto out;
+	}
+	return 0;
+out:
+	/* No xattr support - try to fallback to genfs if possible. */
+	if (rc == -EOPNOTSUPP) {
+		rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
+					SECCLASS_DIR, &sid);
+		if (rc) {
 			rc = -EOPNOTSUPP;
-			goto out;
+		} else {
+			pr_warn("SELinux: (dev %s, type %s) falling back to genfs\n",
+				sb->s_id, sb->s_type->name);
+			sbsec->behavior = SECURITY_FS_USE_GENFS;
+			sbsec->sid = sid;
 		}
+	}
+	return rc;
+}
 
-		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
-		if (rc < 0 && rc != -ENODATA) {
-			if (rc == -EOPNOTSUPP)
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) has no security xattr handler\n",
-				       sb->s_id, sb->s_type->name);
-			else
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) getxattr errno %d\n", sb->s_id,
-				       sb->s_type->name, -rc);
-			goto out;
-		}
+static int sb_finish_set_opts(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = sb->s_security;
+	struct dentry *root = sb->s_root;
+	struct inode *root_inode = d_backing_inode(root);
+	int rc = 0;
+
+	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
+		rc = sb_check_xattr_support(sb);
+		if (rc)
+			return rc;
 	}
 
 	sbsec->flags |= SE_SBINITIALIZED;
@@ -554,7 +583,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 		spin_lock(&sbsec->isec_lock);
 	}
 	spin_unlock(&sbsec->isec_lock);
-out:
 	return rc;
 }
 
-- 
2.29.2

