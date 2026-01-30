Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF952D46B2;
	Fri, 30 Jan 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793437; cv=none; b=ifbW1uOfMvEqO07i7L5y23RARnW/vcKWEa+wNMxD9uS+wR2K2o6lJK8pU4fn+biJ3EeoDzz7vLTh+i65xTnryPFvNYrmm5ve5ra7CZwpgjvGRCYXv0kxsYID3hQP6AJn/NwjlR9H+FXT1M0KSDnlUKlNhl532Q+l9CMsNo3+vBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793437; c=relaxed/simple;
	bh=0qhuHLX9dLv0hvZScpCTSqz1jXp+XCcexS2/4/L6+Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDULISO/X4VQEGVXSlRLTv0M+a021FbzFCu+s3UsrGvDTVXHXoeuiD5FYiGY99HWMqDx3slPCwjNA6o35UjVYETuoZb3xnKurBYDdkgzUr7fqKYAgBVlhgaVWmohSgKeruO+fuaSqHH3meeEIExDGK6Rp34NOAhpOoxN71fd6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=A7/9kYGm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="A7/9kYGm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1769793110;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J7SOsyqJhXmjCoAG0kfTjzIphX44lnuMzlQK9hOwLvQ=;
	b=A7/9kYGmJuQ7DBbpV4vcoBqzNkRJe0ZgS1m5UFN0qudHUnXBlWmcLIm0opnbvXucV9Cxz6
	n8Hofx/mfgBhFmIzzZQg1xrWbsSdd2/TBe4gC1xwmVkZAxFLSmsxdSv3UUV7sHt/x+4Z9m
	oquoup9BDECC2lrhzJ5u0zCRxACmkIml9iLmYimWgq9Zn2mXSXn6uWXbMsNEMsTb+QZNSs
	c+pyTepWyJAfpL4dsBwXRKNeC9Llp0c7AbyeG+uCBtTbT0KDII0PfTJhUCzzv54psRZBWj
	kAUqm9IkVQ7ZZG/NyXYR7fmASpZDB7NQ6ZXjCwRRLhmRpSUma5pnp4Wn8Tndag==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: prevent truncation of status map
Date: Fri, 30 Jan 2026 18:11:32 +0100
Message-ID: <20260130171140.90966-1-cgoettsche@seltendoof.de>
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

Currently the SELinux status map can be truncated, given the necessary
permissions, leading to foreign user space processes getting a bus error
(SIGBUS) while concurrently making use of the status map.
For example systemd can be killed that way, see [1].

Override the setattr inode handler and check for O_TRUNC in the open
handler to prevent truncations.

Link [1]: https://github.com/systemd/systemd/issues/37349
Closes: https://github.com/SELinuxProject/selinux/issues/475
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 43 ++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 896acad1f5f7..df079a35a02d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -214,10 +214,30 @@ static const struct file_operations sel_handle_unknown_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static int sel_setattr_handle_status(struct mnt_idmap *idmap,
+				     struct dentry *dentry,
+				     struct iattr *iattr)
+{
+	/* Prevent truncation to avoid raising SIGBUS */
+	if (iattr->ia_valid & ATTR_SIZE)
+		return -EINVAL;
+
+	return simple_setattr(idmap, dentry, iattr);
+}
+
+static const struct inode_operations sel_handle_status_iops = {
+	.setattr	= sel_setattr_handle_status,
+};
+
 static int sel_open_handle_status(struct inode *inode, struct file *filp)
 {
-	struct page    *status = selinux_kernel_status_page();
+	struct page *status;
 
+	/* Prevent truncation to avoid raising SIGBUS */
+	if (filp->f_flags & O_TRUNC)
+		return -EINVAL;
+
+	status = selinux_kernel_status_page();
 	if (!status)
 		return -ENOMEM;
 
@@ -1980,7 +2000,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
-		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
@@ -1995,6 +2014,26 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
+	/* Create "status" separately to assign a custom inode_operations */
+	{
+		ret = -ENOMEM;
+
+		dentry = d_alloc_name(sb->s_root, "status");
+		if (!dentry)
+			goto err;
+		inode = new_inode(sb);
+		if (!inode) {
+			dput(dentry);
+			goto err;
+		}
+		inode->i_mode = S_IFREG | 0444;
+		simple_inode_init_ts(inode);
+		inode->i_fop = &sel_handle_status_ops;
+		inode->i_op = &sel_handle_status_iops;
+		inode->i_ino = SEL_STATUS;
+		d_add(dentry, inode);
+	}
+
 	fsi = sb->s_fs_info;
 	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
 	if (IS_ERR(fsi->bool_dir)) {
-- 
2.51.0

