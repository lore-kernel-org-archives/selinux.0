Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F104E73C7
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=M0/45VO6PBzUFuLbU0q0iqiQBPcg8qUiYrGw5rQUNhiE/BWCAXq7czBVsNhXOXyJWWZ2C+9MNqYuxSHX7rsrXJrwgGvtmNtFbvI+zmmkdBmKw+c5GmDSB0/7Aj9gZlbmwdTlERwyCyrs1QsjZotXeSYWgJXzIVX0ahx5z2RPsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=6zH+Ea59MtHSI57byrxKdp48UmxSZYe7mzGqABbcfhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My50a4eOv0vhINs5DAYYBWcOeluHkpmSM7CNr+BHNYwZ/1Ni26zXTWpCOTxYoaRAapOj45azdcMNd9hm4mckTKLn7Q50fAKXXwlXg8lXd+W3ZiaQJ6k7Ve3U6nZeFX/VjenYc9yVWOiVqlVRW/l6foD3u3Lj/nNt4JgECrP+omI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KWdm5Vdp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KWdm5Vdp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617625;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG2zmcc6OwwxcUtiL9lveLkK1vP8aUMYlgN5jL8pF2w=;
	b=KWdm5VdpjrbG5ev3A74Dutz7gm4e1bISIaWxTyIIZEZ0UBZaWvQxt2ItqvLmRykFqE7q8o
	QfypLR11djO5dPKMaN/3VaTmGFcL3DneApodT/rYvnsc7S7zp/VAY0D8drOv9v4S8kAmLG
	LVXimxkDE+wMdskxgKqJlhAkz5ZSrx3vqgHMrtBont0J9YCmYUkhys+7OAgaOMwSxPFp4x
	GOIg/Vtlz3tzuqq86P+pVHA7VLNSiqTkMC7JH51Fnbs0c+mCB9R8N818EP9xseGQg3AYmd
	B7tC6fzq5PyxdJeYJMWkH3aaezmDp86aXpjf6qfvQLfUTPbK/4JiDpuKs0NCNQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 29/32] selinux: drop sb member of struct selinux_fs_info
Date: Mon, 28 Sep 2026 19:46:39 +0200
Message-ID: <20260928174643.2458710-28-cgoettsche@seltendoof.de>
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

The back pointer to the super block is only used by
sel_make_policy_nodes(), whose sole caller has the super block at hand
via the written file's inode. Pass the super block instead and look up
the selinuxfs info from it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a131b27c70a7..648bee713ea8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -78,7 +78,6 @@ struct selinux_fs_info {
 	struct dentry *class_dir;
 	u64 last_class_ino;
 	u64 last_ino;
-	struct super_block *sb;
 };
 
 static int selinux_fs_info_create(struct super_block *sb)
@@ -90,7 +89,6 @@ static int selinux_fs_info_create(struct super_block *sb)
 		return -ENOMEM;
 
 	fsi->last_ino = SEL_INO_NEXT - 1;
-	fsi->sb = sb;
 	sb->s_fs_info = fsi;
 	return 0;
 }
@@ -442,9 +440,10 @@ static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
 	kfree(bool_values);
 }
 
-static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
-				struct selinux_policy *newpolicy)
+static int sel_make_policy_nodes(struct super_block *sb,
+				 struct selinux_policy *newpolicy)
 {
+	struct selinux_fs_info *fsi = sb->s_fs_info;
 	int ret = 0;
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir;
 	struct renamedata rd = {};
@@ -453,7 +452,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	int *bool_values = NULL;
 
 	/* Don't increment last_ino in this function */
-	tmp_parent = sel_make_swapover_dir(fsi->sb, fsi->last_ino + 1);
+	tmp_parent = sel_make_swapover_dir(sb, fsi->last_ino + 1);
 	if (IS_ERR(tmp_parent))
 		return PTR_ERR(tmp_parent);
 
@@ -481,7 +480,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 		goto out;
 
 	rd.old_parent = tmp_parent;
-	rd.new_parent = fsi->sb->s_root;
+	rd.new_parent = sb->s_root;
 
 	/* booleans */
 	ret = start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
@@ -522,7 +521,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
 {
-	struct selinux_fs_info *fsi;
 	struct selinux_load_state load_state;
 	ssize_t length;
 	void *data = NULL;
@@ -549,8 +547,8 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out_unlock;
 	}
-	fsi = file_inode(file)->i_sb->s_fs_info;
-	length = sel_make_policy_nodes(fsi, load_state.policy);
+	length = sel_make_policy_nodes(file_inode(file)->i_sb,
+				       load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(&load_state);
-- 
2.55.0

