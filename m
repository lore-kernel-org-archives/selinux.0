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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A79C433DB
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41452339D
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbhAMMjg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbhAMMjg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 07:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610541489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E3ZiL2zfsbGZSFuFiXq2TGGLGuf0WImlfkuBxf50sB4=;
        b=K9UPfjfstuhaldHua+7oDtgoEuO2jnwJOOXDrmnBkuHY+5Nzy2ZGppvcgZ1ZOLJq40NcMK
        HwUr6ky0/pZTQTwYXO4WyKXylXpqskfxWtSRMdOlVq4ldxjrtqAvmALVNURC1VvlBQZRQJ
        9sWPvUwsYZcS4+F2PtPUS/32y67AuaI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-x4WA65dfNM-afOk2TV1irA-1; Wed, 13 Jan 2021 07:38:06 -0500
X-MC-Unique: x4WA65dfNM-afOk2TV1irA-1
Received: by mail-ed1-f71.google.com with SMTP id dc6so784928edb.14
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 04:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3ZiL2zfsbGZSFuFiXq2TGGLGuf0WImlfkuBxf50sB4=;
        b=AO4kBp2Xy5e9W8v2a3wZ7xXrYbAt2MmFFGSjtNm/l1jpqLXnYrmiWgoYcuWRX1SVuc
         /+tFdnxw/cKnM7evMryHFcr4DrAurzKO+7QTIJoEQvww5L3YDfRHqt5w+JW9axcDOTVt
         SoHisYWBWYrzZphG835HnRvUvyGQ/J1thMIPS7WdI0aRZHO7ENiAbgyVXiY89f7Fz13R
         BiDQVSx5SxsRf+eSSQn6+N3sqnZ0oe9qZ9vuEI/95QCtUHoPJaXuJbMJM0gX8CM9qN1R
         kjGRNtnyKMSCSsT9UWYyqwZSsZB+fdouKEb/Vv8UOe9POz5qa4uuL2Vb/qPN45ERsz8F
         vJSQ==
X-Gm-Message-State: AOAM531hUbwFDVEIeGPc+NhTsASKpiNn9rq5u++dqmoGoeljJVtM3IMV
        WLPqxnx0NND+pjF129Kj0+mQ6Si6rfr4Qrrh9TdMcXeMj8zQkSTABNgX70xYwwzFJqDEW75bmYp
        8VDhrjEToxpuGfT5/zgQLqq87W/L6T23bTphwLCiOa15+06iUyo6O0ifxJesP+kOWPU7rMw==
X-Received: by 2002:a17:907:3e1b:: with SMTP id hp27mr1334908ejc.506.1610541484435;
        Wed, 13 Jan 2021 04:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/uGSOycgNjlnw5dlKbZCNyB7jXyy9kTp+JjUcU2fC2ksiCu70PH0dG+1vYb29gxr5DQxxcg==
X-Received: by 2002:a17:907:3e1b:: with SMTP id hp27mr1334882ejc.506.1610541484049;
        Wed, 13 Jan 2021 04:38:04 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id qu21sm663072ejb.95.2021.01.13.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:38:03 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v2] selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support
Date:   Wed, 13 Jan 2021 13:38:02 +0100
Message-Id: <20210113123802.63563-1-omosnace@redhat.com>
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
    # ls -Zd /mnt
    system_u:object_r:ramfs_t:s0 /mnt

See also:
https://lore.kernel.org/selinux/20210105142148.GA3200@redhat.com/T/
https://github.com/fedora-selinux/selinux-policy/pull/478

Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2:
 - incorporated Paul's suggestions
 - corrected the `ls` command in reproducer

 security/selinux/hooks.c | 77 +++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658e..f9e52b622f467 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -484,6 +484,55 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 	}
 }
 
+static int sb_check_xattr_support(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = sb->s_security;
+	struct dentry *root = sb->s_root;
+	struct inode *root_inode = d_backing_inode(root);
+	u32 sid;
+	int rc;
+
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
+		goto fallback;
+	}
+
+	rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
+	if (rc < 0 && rc != -ENODATA) {
+		if (rc == -EOPNOTSUPP) {
+			pr_warn("SELinux: (dev %s, type %s) has no security xattr handler\n",
+				sb->s_id, sb->s_type->name);
+			goto fallback;
+		} else {
+			pr_warn("SELinux: (dev %s, type %s) getxattr errno %d\n",
+				sb->s_id, sb->s_type->name, -rc);
+			return rc;
+		}
+	}
+	return 0;
+
+fallback:
+	/* No xattr support - try to fallback to genfs if possible. */
+	rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
+				SECCLASS_DIR, &sid);
+	if (rc)
+		return -EOPNOTSUPP;
+
+	pr_warn("SELinux: (dev %s, type %s) falling back to genfs\n",
+		sb->s_id, sb->s_type->name);
+	sbsec->behavior = SECURITY_FS_USE_GENFS;
+	sbsec->sid = sid;
+	return 0;
+}
+
 static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -492,30 +541,9 @@ static int sb_finish_set_opts(struct super_block *sb)
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
-		/* Make sure that the xattr handler exists and that no
-		   error other than -ENODATA is returned by getxattr on
-		   the root directory.  -ENODATA is ok, as this may be
-		   the first boot of the SELinux kernel before we have
-		   assigned xattr values to the filesystem. */
-		if (!(root_inode->i_opflags & IOP_XATTR)) {
-			pr_warn("SELinux: (dev %s, type %s) has no "
-			       "xattr support\n", sb->s_id, sb->s_type->name);
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-
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
+		rc = sb_check_xattr_support(sb);
+		if (rc)
+			return rc;
 	}
 
 	sbsec->flags |= SE_SBINITIALIZED;
@@ -554,7 +582,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 		spin_lock(&sbsec->isec_lock);
 	}
 	spin_unlock(&sbsec->isec_lock);
-out:
 	return rc;
 }
 
-- 
2.29.2

