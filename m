Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703754E73D2
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=DXCSpxrYjE+Fs/+0YZQmQKT+W8+kAvJc9o/4LEtzstAKM2VzO9HA38DYehTMJQViVz0g2hMaU95SBFZFXvzceJJKBXgp4b5GqN+c060qdwTVwF5ZXTCHdpJd7mV+tgLWTSaBNZo22cMDtKFF2u/r0EJD8IF1xPDWidHMkpIPEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=T0eW7C/niXz/aTUtJIKGKPV/xqql8cin/tMAiaYoAic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sISAUs2b48zNe5Af2tLmQblCpennw8aLnL59KRmOfTYtOoDTjFhCp2byLPgM9uLKzYiqcZxmyVrabRd6J4EfSxo8QsDNrxELNSgtsyQ1jfGODe7tYuSaBN/idgHFnNqt0H8r12MlUUE7ZbdzSR1iwa5sWB7wScO6TjB+8uVZdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UcBwl9Kp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UcBwl9Kp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617624;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N54nmTtZCMXRgunQ24h+nqTBsH8FeaVyY6tXB8m7kYY=;
	b=UcBwl9KpKaRr9PkCui0FM4csI6unb0bN5RqgvpkI0IkD0mvctAS7l7E8CiOSHJ/G1flaBT
	MwPNwaKFldBQ9yZm4747/bj2OhzjwLX0ZNwoNiNNRPC3XT1oc9ihFegfyyxB5qQ+w4dF7s
	r8/85KdQm/qs2JRO6e1k+7bhu8Xj7b49IPWQBuG0LvrPRxYD4Y1f5hI3EK2h1Vy9Ak+4go
	FLNh6lVh8hPJtxmLVVaQmjpsCf+ztUPo72cgv3wMPFPK5PASvt1IHJtQzfpeRdCVse5/8E
	7Z6vsjUCxx2BTiJJEtBXL0+zqVdZHfYhK0gp1JeQNxKm9Jr9ztntwdgkE1uU9w==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 27/32] selinux: fail mount if status or policy cannot be marked immutable
Date: Mon, 28 Sep 2026 19:46:37 +0200
Message-ID: <20260928174643.2458710-26-cgoettsche@seltendoof.de>
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

sel_mark_immutable() silently ignores a failed lookup of the file to
mark. Since the status and policy files rely on S_IMMUTABLE to prevent
writable opens and thereby writable shared mappings, fail the mount
instead of continuing without the protection.

The lookup cannot fail in practice, as the dentries have just been
created by simple_fill_super() and are pinned in the dcache, so this
does not change behavior.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9c626ef26a78..8d72fba5bcdc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1722,15 +1722,19 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
 
 #define NULL_FILE_NAME "null"
 
-static void sel_mark_immutable(struct dentry *root, const char *name)
+static int sel_mark_immutable(struct dentry *root, const char *name)
 {
 	struct qstr q = QSTR(name);
 	struct dentry *dentry = try_lookup_noperm(&q, root);
 
-	if (!IS_ERR_OR_NULL(dentry)) {
-		d_inode(dentry)->i_flags |= S_IMMUTABLE;
-		dput(dentry);
-	}
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	if (!dentry)
+		return -ENOENT;
+
+	d_inode(dentry)->i_flags |= S_IMMUTABLE;
+	dput(dentry);
+	return 0;
 }
 
 static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -1772,8 +1776,13 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	sel_mark_immutable(sb->s_root, selinux_files[SEL_STATUS].name);
-	sel_mark_immutable(sb->s_root, selinux_files[SEL_POLICY].name);
+	ret = sel_mark_immutable(sb->s_root, selinux_files[SEL_STATUS].name);
+	if (ret)
+		goto err;
+
+	ret = sel_mark_immutable(sb->s_root, selinux_files[SEL_POLICY].name);
+	if (ret)
+		goto err;
 
 	fsi = sb->s_fs_info;
 	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
-- 
2.55.0

