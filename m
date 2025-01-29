Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923431DF747
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169897; cv=none; b=q73hHrOm5pjteFingxDHdJXIZXGKkTYsvRZFr3hxu7Lz3BZIQQY6rH3m7+JIqrTmadE4pPZmBUAedalo7KEJBXh2mqGXv2TTc8w/mfJ6iWxcJEXf/dD0W0p1/PlOz/2uJeCLThZOMvmDjka7nO5+Z4HvpHcsDSYsU522NbFxyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169897; c=relaxed/simple;
	bh=8e2TjtANaHTeoe8sl6kPmDjkwKIWob2Bs6CtDcqCCoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjMIoL5JQCvMsVp8lfpN8bu/h7G2+zUcy9HY4lwuF9CwCm9TfRodk4VDnDPzAwYJykRbNq8NqiSOQqW9Z0/ue+MrF+Hsb5zgxX+liB3koLAecWZsO0yw+r35QwewSpBqB2XFAOn3aueNdJV5thBoQBkbMC8F4dvqEm1FL31m0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfnzMtB2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfnzMtB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
	b=GfnzMtB2MRlLYntJlS8LVlTNBL5O3V20gDv7HoMj6XJnOrh7troo2sP6YPZbdBED+MzYiE
	h9r2ELuUnc1ZltteMCpccY+g+/5vH1sXEW0Mj+BD/L2iZzCcklr7Q8HAE2HnHvFq+9t/WA
	pDanBZHYI9zheyaY0byEpBmo9GjUDi4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-D_7uaTHtNk-n53_bm4nN4Q-1; Wed, 29 Jan 2025 11:58:11 -0500
X-MC-Unique: D_7uaTHtNk-n53_bm4nN4Q-1
X-Mimecast-MFC-AGG-ID: D_7uaTHtNk-n53_bm4nN4Q
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso8901649a12.2
        for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 08:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169890; x=1738774690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
        b=lShpEYfHN+VKMv9t2TJBbfRTH5GXKm4KDS2vw7m3cLzqMiqI73itPqM9vdynBo5ikE
         e1puXQEPa72qohnJVg/qDzXwNE3dHLsZ3WIoWwruTIBOwhk/k28+wFaAfnLvxPfez578
         zNbbRWPv/N8+GybSpeoenfZhWNA8IbyB9oO3Mbn7doACPNbgElHgZJt/eM9FiHlMk7xU
         NAo+eR4gk7fr0CzPwJrh92BwEtrNaowWtYeC+KpPwr52nMNgKzBwT0/pdCKamZ8XGgtZ
         UEPMlwY+gnOVJI6v+aa4OkJz+lYkgtuX3PCNPY4ssFqHh4WY5MRdPSJg1G1h42WvsCd+
         h4rw==
X-Forwarded-Encrypted: i=1; AJvYcCX5F6mIrnqShYVG4XXdqu497dXi5Rp7X//AYN3NP2um7cehXgkeV1pAt1GBL+fU0zbReiTGxC7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDPotcELO0MtETQUqPbC+z74InIKnFB2vnK9xCpCgZU/eZdGG
	+IdFvNiF7jz6EtHbjYmfXbh9ayalxSqB24G4cI4KYL//L9j+VF3z66Te5RlVb7CVfu5ocmufulm
	T1S+wwPhr2lC5ikjRsrUfkQrqqSIcNWHAzPVfZ0UIAicKNMOmVx56BI4=
X-Gm-Gg: ASbGncuj4GyfflLAbncAHxfyJ3w2nbXQKZuY/WHSGQzYEfPfWvnNGKVYlgXNeLV8qjK
	PPrp0hKPGhr3DV4PfXio1V3orqsjjgfCcsrxgfsP704PRT+oUikeGyaczSYQhbHHBgd8pyFAFnQ
	IdpJEFrlsRj45Tlz+nJGDAD/N4wd7xA3tIvlw7vRwpQ/92pKyy+pW2lSO7pmUF9/UzlSmuFynDj
	oIkGcP+CpL8dqrvJA6U3H688OF2ZB2QCJESKjEvCosn+/GWVnwJLIeG1U8rCAIhY3k1OoY+y9iE
	e7zlzLgYMYWe/XbZwFZX4/FMHbKWJH/UeG3lirW6CcLsMShr4Vb9uwGh
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153464366b.35.1738169889735;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyc1gmLR/6x+vkL+zqwJDDj0W/YmQwy5Gp0kD+BKGvnFwC6jvJ1Vephop+nOzwGW0bGm75ZQ==
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153460966b.35.1738169889230;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:08 -0800 (PST)
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
Subject: [PATCH v5 3/3] vfs: add notifications for mount attach and detach
Date: Wed, 29 Jan 2025 17:58:01 +0100
Message-ID: <20250129165803.72138-4-mszeredi@redhat.com>
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

Add notifications for attaching and detaching mounts to fs/namespace.c

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h     | 20 +++++++++++++
 fs/namespace.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/pnode.c     |  4 ++-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 5324a931b403..946dc8b792d7 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,8 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct list_head notify_list;
+
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -80,6 +82,8 @@ struct mount {
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
+	struct list_head to_notify;	/* need to queue notification */
+	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
@@ -182,4 +186,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 	return container_of(ns, struct mnt_namespace, ns);
 }
 
+#ifdef CONFIG_FSNOTIFY
+static inline void mnt_notify_add(struct mount *m)
+{
+	/* Optimize the case where there are no watches */
+	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
+	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
+		list_add_tail(&m->to_notify, &notify_list);
+	else
+		m->prev_ns = m->mnt_ns;
+}
+#else
+static inline void mnt_notify_add(struct mount *m)
+{
+}
+#endif
+
 struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index d8d70da56e7b..1e964b646509 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -81,6 +81,9 @@ static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
+#ifdef CONFIG_FSNOTIFY
+LIST_HEAD(notify_list); /* protected by namespace_sem */
+#endif
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
@@ -163,6 +166,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1176,6 +1180,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 		ns->mnt_first_node = &mnt->mnt_node;
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+
+	mnt_notify_add(mnt);
 }
 
 /*
@@ -1723,6 +1729,50 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
+#ifdef CONFIG_FSNOTIFY
+static void mnt_notify(struct mount *p)
+{
+	if (!p->prev_ns && p->mnt_ns) {
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	} else if (p->prev_ns && !p->mnt_ns) {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+	} else if (p->prev_ns == p->mnt_ns) {
+		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
+	} else {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	}
+	p->prev_ns = p->mnt_ns;
+}
+
+static void notify_mnt_list(void)
+{
+	struct mount *m, *tmp;
+	/*
+	 * Notify about mounts that were added/reparented/detached/remain
+	 * connected after unmount.
+	 */
+	list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
+		mnt_notify(m);
+		list_del_init(&m->to_notify);
+	}
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return !list_empty(&notify_list);
+}
+#else
+static void notify_mnt_list(void)
+{
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return false;
+}
+#endif
+
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
@@ -1733,7 +1783,18 @@ static void namespace_unlock(void)
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
-	up_write(&namespace_sem);
+	if (need_notify_mnt_list()) {
+		/*
+		 * No point blocking out concurrent readers while notifications
+		 * are sent. This will also allow statmount()/listmount() to run
+		 * concurrently.
+		 */
+		downgrade_write(&namespace_sem);
+		notify_mnt_list();
+		up_read(&namespace_sem);
+	} else {
+		up_write(&namespace_sem);
+	}
 
 	shrink_dentry_list(&list);
 
@@ -1846,6 +1907,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
+
+		/*
+		 * At this point p->mnt_ns is NULL, notification will be queued
+		 * only if
+		 *
+		 *  - p->prev_ns is non-NULL *and*
+		 *  - p->prev_ns->n_fsnotify_marks is non-NULL
+		 *
+		 * This will preclude queuing the mount if this is a cleanup
+		 * after a failed copy_tree() or destruction of an anonymous
+		 * namespace, etc.
+		 */
+		mnt_notify_add(p);
 	}
 }
 
@@ -2555,6 +2629,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -4476,6 +4551,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	mnt_notify_add(root_mnt);
+	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
diff --git a/fs/pnode.c b/fs/pnode.c
index ef048f008bdd..82d809c785ec 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
 			mp = parent->mnt_mp;
 			parent = parent->mnt_parent;
 		}
-		if (parent != mnt->mnt_parent)
+		if (parent != mnt->mnt_parent) {
 			mnt_change_mountpoint(parent, mp, mnt);
+			mnt_notify_add(mnt);
+		}
 	}
 }
 
-- 
2.48.1

