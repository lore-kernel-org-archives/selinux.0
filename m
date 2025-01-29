Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA571DF99B
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169892; cv=none; b=hyNodhZewiKxhIjJtUfZUfH8/2nfg4WFTDufp/gIf4Uyn8ncl8GuILmWZBWyIQr18+eJQbJxFS+cNcJaeVVpV46m+MFcAk1UhZUDa0TcoPU7qMwbzka7FQ5sMa0KwGDmsDJcPUteC6GkfPn35aSaTgL6SUw0iafG05AbgfIWq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169892; c=relaxed/simple;
	bh=DKCFnynVrWXhmVEQr+aS3zp2f0/Az12wXu4UNExj0B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYw+2KJOVa/GP4ojlu4LvVw7gqfqgW/ObOY4tbVetBbH7tcZNMi87vvwE0GKCJi1elQkNdz8g0+PcnDmpuc5t2SSQJr8XDhtdfvsOsK6yVCRgXa5jz8DAuqzCxqEJ4eI56NApfRXyMCMDbDhTVY/i6E8HVc65O8DqyQsFHQ5MNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMAizBSc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMAizBSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cL0iDutphCFwfyqtxi61Du6PZWPMl2UagnhyvLtfKA=;
	b=AMAizBScSXO0SVBcH12dgF0lIfFOhQglmF00b4yPc1/NgmGE4onzYuBoH9FG7VWftPf+yA
	BV46CyP0OgGCHbU8uKdHgpEFxk2ZttUuE5KEboJlEMjY3f1OZy2w6yNCz4U5NsMNUrzHNu
	7s6SzY4NhJaFI1H6Vu5b5j2qURIyMYc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-fQan4vpEPBauNVCJVUQTlQ-1; Wed, 29 Jan 2025 11:58:08 -0500
X-MC-Unique: fQan4vpEPBauNVCJVUQTlQ-1
X-Mimecast-MFC-AGG-ID: fQan4vpEPBauNVCJVUQTlQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab6d5363a4bso88949366b.3
        for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 08:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169887; x=1738774687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cL0iDutphCFwfyqtxi61Du6PZWPMl2UagnhyvLtfKA=;
        b=Sf8erloPymOBUghqvOQ/ZpgTkTcGqtOLnxA3lReuOddCNqM38RklqSjFylVv9giFwh
         3PYKbdZ8K4kEqHINnuxwPpwlKZe2G+E1C8rrLr9d1Z3QWcda4rgU4b/gZK8947MmhbZY
         KHnGC8idULNzzW4sN1q5ZFDQxsDpXb+vbvjcmGLE5OOuL+buKFMako0GmudGHPX8m6gW
         P258Y/xesJ3rd6CeiFYSq1Ul+jvdgAFM0pBVpuyHE8x5nxWfHBUpL7FT4HTNBNjeXYxX
         dr4PDW5RtRgDboUVfN4etr5Cfql/HlPnTpi8nxSoRPRGDGO8f1oh7D6/ux5TPHXKpMJP
         A9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUCGipmISlnMXciUy2JDeLnsbueyt1w1A/VbImpo6vfWbgcjviwIONMofNAbkb3XysoExNYhvcO@vger.kernel.org
X-Gm-Message-State: AOJu0YzurQes6ersmcWY57M4t9K4rOBiMZZadHNnUOHPzDutAwt9COGq
	oQWsGn8FlMgtJWFhPEEHBqb0xslRmqyaIUxkxL3fh5FkGmE9L+4AwyP68IICNShP8Wqydr5l/RX
	x45veeGYZrGKy03vBGh7LHpV0XJPlxKK3o9fpPH5fyxMDxDYImfIRNZ0=
X-Gm-Gg: ASbGncuvjXRTC7WC6GcIV5A34FcJky1dVm/ITbuyKUIW/vwXaCxyvxgAJiJfYxB+vk/
	mTGCNBeNGA7o8wJJydOZqvG5YPUVcfLcGjcTeT4xsBzSmSbrG/4aJum4HNxtPRCSO7EaCXGcpXe
	yrkx7nSGyEdgSLNlWEZP+WRpdXC5e2AYlNkoQu8L8I4qg7I8m1u0uiDtkP8ZM9HcGq1tXWKxOhW
	rh8ZojgDKCpQbdsW7DR2DNPMxMe69ESSjflANNJjFyFq/LBhi6+5dT24goybhwg/gPRlo8XYrrd
	6Ouz2WbXujjIfq996pNOSclONxwzX9fmt4YUVZNpC+35VKPPx7yOz6OZ
X-Received: by 2002:a17:906:3bd8:b0:ab6:d014:7ba with SMTP id a640c23a62f3a-ab6d014174cmr360174866b.15.1738169887324;
        Wed, 29 Jan 2025 08:58:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmpRnVWGiRmD8FQ5NeHX2vMDciuOSd1rF54vIxD3sOqSanFVoKAPksdwIThyL4XTcesuZGUw==
X-Received: by 2002:a17:906:3bd8:b0:ab6:d014:7ba with SMTP id a640c23a62f3a-ab6d014174cmr360171766b.15.1738169886850;
        Wed, 29 Jan 2025 08:58:06 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:06 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 1/3] fsnotify: add mount notification infrastructure
Date: Wed, 29 Jan 2025 17:57:59 +0100
Message-ID: <20250129165803.72138-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129165803.72138-1-mszeredi@redhat.com>
References: <20250129165803.72138-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just the plumbing between the event source (fs/namespace.c) and the
event consumer (fanotify).  In itself it does nothing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                       |  4 +++
 fs/notify/fsnotify.c             | 47 +++++++++++++++++++++++++++-----
 fs/notify/fsnotify.h             | 11 ++++++++
 fs/notify/mark.c                 | 14 ++++++++--
 include/linux/fsnotify.h         | 20 ++++++++++++++
 include/linux/fsnotify_backend.h | 42 ++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index ffb613cdfeee..82aa3bad7cf5 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -21,6 +21,10 @@ struct mnt_namespace {
 		struct rcu_head		mnt_ns_rcu;
 	};
 	u64 event;
+#ifdef CONFIG_FSNOTIFY
+	__u32			n_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
+#endif
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8ee495a58d0a..c64b95cf50c7 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	fsnotify_clear_marks_by_mount(mnt);
 }
 
+void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	fsnotify_clear_marks_by_mntns(mntns);
+}
+
 /**
  * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
  * @sb: superblock being unmounted.
@@ -420,7 +425,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 				     file_name, cookie, iter_info);
 }
 
-static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
+static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
 {
 	struct fsnotify_mark_connector *conn;
 	struct hlist_node *node = NULL;
@@ -538,14 +543,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
 	struct dentry *moved;
 	int inode2_type;
 	int ret = 0;
-	__u32 test_mask, marks_mask;
+	__u32 test_mask, marks_mask = 0;
 
 	if (path)
 		mnt = real_mount(path->mnt);
@@ -578,17 +584,20 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks) &&
+	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
 		return 0;
 
-	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
+	if (sb)
+		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
 		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
 	if (inode)
 		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
-
+	if (mnt_data)
+		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -618,6 +627,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[inode2_type] =
 			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
+	if (mnt_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
+			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
+	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
@@ -702,11 +715,31 @@ void file_set_fsnotify_mode(struct file *file)
 }
 #endif
 
+void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	struct fsnotify_mnt data = {
+		.ns = ns,
+		.mnt_id = real_mount(mnt)->mnt_id_unique,
+	};
+
+	if (WARN_ON_ONCE(!ns))
+		return;
+
+	/*
+	 * This is an optimization as well as making sure fsnotify_init() has
+	 * been called.
+	 */
+	if (!ns->n_fsnotify_marks)
+		return;
+
+	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 663759ed6fbc..5950c7a67f41 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
 	return conn->obj;
 }
 
+static inline struct mnt_namespace *fsnotify_conn_mntns(
+				struct fsnotify_mark_connector *conn)
+{
+	return conn->obj;
+}
+
 static inline struct super_block *fsnotify_object_sb(void *obj,
 			enum fsnotify_obj_type obj_type)
 {
@@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
 }
 
+static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
+{
+	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4981439e6209..798340db69d7 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
 		return &real_mount(obj)->mnt_fsnotify_marks;
 	case FSNOTIFY_OBJ_TYPE_SB:
 		return fsnotify_sb_marks(obj);
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
 	default:
 		return NULL;
 	}
@@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 		return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
 	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
 		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
+		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
 	return NULL;
 }
 
@@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
+	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
 	}
 
 	rcu_assign_pointer(*connp, NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 
 	return inode;
 }
@@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	 * Attach the sb info before attaching a connector to any object on sb.
 	 * The sb info will remain attached as long as sb lives.
 	 */
-	if (!fsnotify_sb_info(sb)) {
+	if (sb && !fsnotify_sb_info(sb)) {
 		err = fsnotify_attach_info_to_sb(sb);
 		if (err)
 			return err;
@@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 1a9ef8f6784d..589e274adc7d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -299,6 +299,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	__fsnotify_vfsmount_delete(mnt);
 }
 
+static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	__fsnotify_mntns_delete(mntns);
+}
+
 /*
  * fsnotify_inoderemove - an inode is going away
  */
@@ -507,4 +512,19 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
 			NULL, NULL, NULL, 0);
 }
 
+static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0d24a21a8e60..6cd8d1d28b8b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -59,6 +59,10 @@
 
 #define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
 
+#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -80,6 +84,9 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
+/* Mount namespace events */
+#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
+
 /* Content events can be used to inspect file content */
 #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
 				      FS_ACCESS_PERM)
@@ -108,6 +115,7 @@
 
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
+			     FSNOTIFY_MNT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
@@ -298,6 +306,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
+	FSNOTIFY_EVENT_MNT,
 	FSNOTIFY_EVENT_ERROR,
 };
 
@@ -318,6 +327,11 @@ static inline const struct path *file_range_path(const struct file_range *range)
 	return range->path;
 }
 
+struct fsnotify_mnt {
+	const struct mnt_namespace *ns;
+	u64 mnt_id;
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -383,6 +397,24 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 	}
 }
 
+static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
+							   int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_MNT:
+		return data;
+	default:
+		return NULL;
+	}
+}
+
+static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
+{
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+
+	return mnt_data ? mnt_data->mnt_id : 0;
+}
+
 static inline struct fs_error_report *fsnotify_data_error_report(
 							const void *data,
 							int data_type)
@@ -420,6 +452,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_SB,
 	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_INODE2,
+	FSNOTIFY_ITER_TYPE_MNTNS,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
@@ -429,6 +462,7 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
+	FSNOTIFY_OBJ_TYPE_MNTNS,
 	FSNOTIFY_OBJ_TYPE_COUNT,
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
@@ -613,8 +647,10 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
+extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
 extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
+extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 {
@@ -928,6 +964,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
+static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{}
+
 static inline void fsnotify_sb_free(struct super_block *sb)
 {}
 
@@ -942,6 +981,9 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.48.1

