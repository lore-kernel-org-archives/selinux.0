Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FA4E3222
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617624; cv=none; b=sY2WZYv2i7WY+YA9YjxZAYiITjO0lq3AU9UaE8llpOn21hm61o+McFXQTwCweKHOT0UeGdEaJ+lMtcnwPgCXtZUkKO0DbOTrZxyoIq2LE2a38OHqLf+E6aW2bJ05t0N1y10kAYBfz+CQ6ePCN/B3ZKW/ngzJxnSP7Nozl/1PvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617624; c=relaxed/simple;
	bh=PhrdUaSKot7Yp2NrOv0ZemKjneKLZr72r2fzJRnKqXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjMVy8p+s6sQADHTr/Q2suPqZsZNiuzV3wPER+AQ7B7q0xdgTdHZuX2JsJi0aLxd1mP3liIq9Fs9VlfroT0RBb72cREe+XZhS98VWSQrLU0Imx3gs5cvvW7h61RXXvNYvzwZP8+EuUKx0aLiTvvyiVGTe8XYWvLT/iC3CSEEKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rMG6leTV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rMG6leTV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617618;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=marh4+ERpXBq9sSf2PIkuH8T5BlN1+4WLltm6GD8dkA=;
	b=rMG6leTVLWFfL3iALlloskghp9CUtKl66e937w0Z8iUVkAq1uQOv40AOKTCMuS2C8HhM3V
	sE91Yaxr78MwHCHbd7+bX9j//rcWLHXq+Zvew8LdHAXH2lUeRNzC+5cWSH9sRikIJVTF6V
	2XHLL5wHyY3AQgIA9KgFW8rCmvx50+t8a3s6eU7zPajuP+/4BdXdMtLAslFug6IUd/D0xJ
	S3yPYYfoZ4qMDxI/0BQMecvSl/sIoWOMFGzzM2/N3fvgTfe/2WahRQSDEMzy+mvgOmU/er
	LPtE1psNRgeIBdrR8k02OuUX0HF+cVo8X4ehMeJKBKECCZl2IdNBqlBjrXlGDg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 09/32] selinux: factor out sel_make_files()
Date: Mon, 28 Sep 2026 19:46:19 +0200
Message-ID: <20260928174643.2458710-8-cgoettsche@seltendoof.de>
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

sel_make_avc_files() and sel_make_ss_files() contain the same loop to
create the files of a tree_descr table.  Move it into a common helper.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 49 ++++++++++++++----------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 42cfef5fcca2..0fce6c0b0426 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1447,22 +1447,14 @@ static const struct file_operations sel_avc_cache_stats_ops = {
 };
 #endif
 
-static int sel_make_avc_files(struct dentry *dir)
+static int sel_make_files(struct dentry *dir, const struct tree_descr *files,
+			  unsigned int nfiles)
 {
-	struct super_block *sb = dir->d_sb;
-	struct selinux_fs_info *fsi = sb->s_fs_info;
+	struct selinux_fs_info *fsi = dir->d_sb->s_fs_info;
 	unsigned int i;
 	int err = 0;
-	static const struct tree_descr files[] = {
-		{ "cache_threshold",
-		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
-		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
-#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
-		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
-#endif
-	};
 
-	for (i = 0; !err && i < ARRAY_SIZE(files); i++) {
+	for (i = 0; !err && i < nfiles; i++) {
 		struct inode *inode;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
@@ -1478,30 +1470,27 @@ static int sel_make_avc_files(struct dentry *dir)
 	return err;
 }
 
-static int sel_make_ss_files(struct dentry *dir)
+static int sel_make_avc_files(struct dentry *dir)
 {
-	struct super_block *sb = dir->d_sb;
-	struct selinux_fs_info *fsi = sb->s_fs_info;
-	unsigned int i;
-	int err = 0;
 	static const struct tree_descr files[] = {
-		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
+		{ "cache_threshold",
+		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
+		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
+#ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
+		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
+#endif
 	};
 
-	for (i = 0; !err && i < ARRAY_SIZE(files); i++) {
-		struct inode *inode;
-
-		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode)
-			return -ENOMEM;
-
-		inode->i_fop = files[i].ops;
-		inode->i_ino = ++fsi->last_ino;
+	return sel_make_files(dir, files, ARRAY_SIZE(files));
+}
 
-		err = sel_attach_file(dir, files[i].name, inode);
-	}
+static int sel_make_ss_files(struct dentry *dir)
+{
+	static const struct tree_descr files[] = {
+		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
+	};
 
-	return err;
+	return sel_make_files(dir, files, ARRAY_SIZE(files));
 }
 
 static ssize_t sel_read_initcon(struct file *file, char __user *buf,
-- 
2.55.0

