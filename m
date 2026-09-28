Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5F4EC648
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=uUqkdisbi/Mdjnki+GTSHB0W7Pz9Jp4Hpt6spfPflbI4tpbshwCdREfvcAgkCVt99hT6+nYLZ9EtrElyF73NznIDCbM2/VwW0vkhyUpYfp4VJ2rIAlra3cR42n8o02AfP81DJP7aYj5ugvM0zEXgk1kl+LDJAuC5mCQrUAP+ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=AOYeU/l6SkCxlXaaHvKw1dfpjM7ijqo6uIikRlOOINE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXvm2ErOnOAWqPHCxAWKcdx9a25t2UJhn84BPbu9kOYCjUZa6SOXPARrs5HgYFWGFcu8nKERKp0+p9eTZmbhl01VnLDDpyvj1Ds4xmawgrRYHhJ6HwFCtUwprimcypZwbaqnYyH/ZOfopAZRiqAsfnqfyNMF/DqhT3tKWA6wPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uoEi03V6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uoEi03V6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617625;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqAJMqUmJm24dTm9B64n5+KEhb5sevYm9NV3ELHZHjM=;
	b=uoEi03V6nixiHqurxjhlSYt+4NGJRaJcubMCEkhw33C9KtN3gMP5zJdH/eG6ctMFShplLL
	q4ru2v+LiDuDM5qoPlP24kSAYNPVVRkxu+3NuNn1Us6KJbiab3SnYIPtHvHlR506+LKH6i
	HzzI9sn7edCAnPCd32v7MZmq2i5FjeJQn9WmfaWIGOtDpl5JMs15U+YeY24KET0f98BHAu
	1oGMROS3oCop+AFIlmMGjtPBShgRdH7SYRe8oReiQrUFPDDSeNFudElpGAbYct679UjaGQ
	MyVgYzBZsvGEKwHngCjE+iaCvC7xwmqi46nV1WjVVtdzfggG1XqFFGOTyFJUcA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 28/32] selinux: pass inode number by value to sel_make_dir()
Date: Mon, 28 Sep 2026 19:46:38 +0200
Message-ID: <20260928174643.2458710-27-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

sel_make_dir() and sel_make_swapover_dir() take a pointer to an inode
number counter which they increment and assign. This forces
sel_make_policy_nodes(), which wants to reuse the inode numbers of the
existing booleans and class directories, to set a temporary counter to
the desired value minus one.

Pass the inode number to assign instead and let callers increment
their counters themselves. All directories keep their inode numbers.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 40 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8d72fba5bcdc..a131b27c70a7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -299,10 +299,10 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
-				   u64 *ino);
+				   u64 ino);
 
 /* declaration for sel_make_policy_nodes */
-static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino);
+static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 ino);
 
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
@@ -451,21 +451,21 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	unsigned int bool_num = 0;
 	char **bool_names = NULL;
 	int *bool_values = NULL;
-	u64 tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
-	tmp_parent = sel_make_swapover_dir(fsi->sb, &tmp_ino);
+	/* Don't increment last_ino in this function */
+	tmp_parent = sel_make_swapover_dir(fsi->sb, fsi->last_ino + 1);
 	if (IS_ERR(tmp_parent))
 		return PTR_ERR(tmp_parent);
 
-	tmp_ino = fsi->bool_dir->d_inode->i_ino - 1; /* sel_make_dir will increment and set */
-	tmp_bool_dir = sel_make_dir(tmp_parent, BOOL_DIR_NAME, &tmp_ino);
+	tmp_bool_dir = sel_make_dir(tmp_parent, BOOL_DIR_NAME,
+				    d_inode(fsi->bool_dir)->i_ino);
 	if (IS_ERR(tmp_bool_dir)) {
 		ret = PTR_ERR(tmp_bool_dir);
 		goto out;
 	}
 
-	tmp_ino = fsi->class_dir->d_inode->i_ino - 1; /* sel_make_dir will increment and set */
-	tmp_class_dir = sel_make_dir(tmp_parent, CLASS_DIR_NAME, &tmp_ino);
+	tmp_class_dir = sel_make_dir(tmp_parent, CLASS_DIR_NAME,
+				     d_inode(fsi->class_dir)->i_ino);
 	if (IS_ERR(tmp_class_dir)) {
 		ret = PTR_ERR(tmp_class_dir);
 		goto out;
@@ -1594,7 +1594,7 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	if (err)
 		return err;
 
-	dentry = sel_make_dir(dir, "perms", &fsi->last_class_ino);
+	dentry = sel_make_dir(dir, "perms", ++fsi->last_class_ino);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -1620,7 +1620,7 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 		struct dentry *class_name_dir;
 
 		class_name_dir = sel_make_dir(class_dir, classes[i],
-					      &fsi->last_class_ino);
+					      ++fsi->last_class_ino);
 		if (IS_ERR(class_name_dir)) {
 			rc = PTR_ERR(class_name_dir);
 			goto out;
@@ -1666,7 +1666,7 @@ static int sel_make_policycap(struct dentry *dir)
 }
 
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
-				   u64 *ino)
+				   u64 ino)
 {
 	struct inode *inode;
 
@@ -1676,7 +1676,7 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
-	inode->i_ino = ++(*ino);
+	inode->i_ino = ino;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	/* bump link count on parent directory, too */
@@ -1695,7 +1695,7 @@ static const struct inode_operations swapover_dir_inode_operations = {
 	.permission	= reject_all,
 };
 
-static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
+static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 ino)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -1711,7 +1711,7 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
 	}
 
 	inode->i_op = &swapover_dir_inode_operations;
-	inode->i_ino = ++(*ino);
+	inode->i_ino = ino;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
@@ -1785,7 +1785,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto err;
 
 	fsi = sb->s_fs_info;
-	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
+	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, ++fsi->last_ino);
 	if (IS_ERR(fsi->bool_dir)) {
 		ret = PTR_ERR(fsi->bool_dir);
 		fsi->bool_dir = NULL;
@@ -1808,7 +1808,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
+	dentry = sel_make_dir(sb->s_root, "avc", ++fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
@@ -1818,7 +1818,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	dentry = sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
+	dentry = sel_make_dir(sb->s_root, "ss", ++fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
@@ -1828,7 +1828,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	dentry = sel_make_dir(sb->s_root, "initial_contexts", &fsi->last_ino);
+	dentry = sel_make_dir(sb->s_root, "initial_contexts", ++fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
@@ -1838,14 +1838,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	fsi->class_dir = sel_make_dir(sb->s_root, CLASS_DIR_NAME, &fsi->last_ino);
+	fsi->class_dir = sel_make_dir(sb->s_root, CLASS_DIR_NAME, ++fsi->last_ino);
 	if (IS_ERR(fsi->class_dir)) {
 		ret = PTR_ERR(fsi->class_dir);
 		fsi->class_dir = NULL;
 		goto err;
 	}
 
-	dentry = sel_make_dir(sb->s_root, "policy_capabilities", &fsi->last_ino);
+	dentry = sel_make_dir(sb->s_root, "policy_capabilities", ++fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
-- 
2.55.0

