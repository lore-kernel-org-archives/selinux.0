Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470A4E50AF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=WUYV5tFdeK2lV0Cixr1QvGin7K1M1lQHmEjnZP74LMeOyVKXwpTgtcnqVnwXau4K8NalAPW9fhW8qsqywLnfRVq3okhCGeoIe7L5o1CLXSt55uE5yN4rtGfdK/t34Z9CtBi+AXvhXzowbdXQKYNi0JXfNenAuK0GK/mweIfPlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=R99Zw/bRxZQ1aLcbM1B99Qf/wSvm26Iu1nYFC9JfHtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFcEt7i0N70IeSKl07SKbcMC46qzliumyndx07SMR3NrOIgwLqJMqVB8ZKYSDGC/UqWeEtbSkuQPY77m8mR7Kwh2Fz9f1+1iStVUAKn13K3Hnag/lU4oIke4b/aGhpGgp7jw2HZcktsPrd4zXke7E9V3AG0Zfb2qwpgmYrVEw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UrfOVc8p; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UrfOVc8p"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617621;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR/erXh0fK8D7/+Mk5kRy54lSUe2GHKfyy54yS/ERcY=;
	b=UrfOVc8p2kQxFFFWrZvAop9el17h9mdlKJ4tW6ZOhelAbtr0gH7uWjqLtXEryxFpuzgNXQ
	9LR3414Hp6CIGUoHdBYr804AxiCecDkOU5ScTSz72wMv4UQRtncizLDf5SwwA9P5vct+8D
	uWXVsmP22bfDIG0nAhqHphsWnWwXemn3AtjS2d8VVVKRvqAKt7dCkLPPTKJyShWPa/TdZG
	58UZyor0RfeYi1vy9K06OnqY1wWx1aQA9NNHrtx1RxaKVOQpmyogZ6m60M0ChcstM6zg5p
	JU8tI8D8hBor/TBtNcEwx5q6Vu/toyKkacWp7zpFy0YsOFXnN0JBV/75UGIJ9Q==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 17/32] selinux: drop redundant last_class_ino parameter
Date: Mon, 28 Sep 2026 19:46:27 +0200
Message-ID: <20260928174643.2458710-16-cgoettsche@seltendoof.de>
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

sel_make_classes() is always passed a pointer to the last_class_ino
member of the superblock's selinux_fs_info, which its callee
sel_make_class_dir_entries() already accesses directly.  Do the same.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 7236348a33dc..4982f9362e25 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -295,8 +295,7 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 			  unsigned int *bool_num, char ***bool_pending_names,
 			  int **bool_pending_values);
 static int sel_make_classes(struct selinux_policy *newpolicy,
-			    struct dentry *class_dir,
-			    u64 *last_class_ino);
+			    struct dentry *class_dir);
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
@@ -479,8 +478,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	if (ret)
 		goto out;
 
-	ret = sel_make_classes(newpolicy, tmp_class_dir,
-			       &fsi->last_class_ino);
+	ret = sel_make_classes(newpolicy, tmp_class_dir);
 	if (ret)
 		goto out;
 
@@ -1668,9 +1666,9 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 }
 
 static int sel_make_classes(struct selinux_policy *newpolicy,
-			    struct dentry *class_dir,
-			    u64 *last_class_ino)
+			    struct dentry *class_dir)
 {
+	struct selinux_fs_info *fsi = class_dir->d_sb->s_fs_info;
 	u32 i, nclasses;
 	int rc;
 	char **classes;
@@ -1680,13 +1678,13 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 		return rc;
 
 	/* +2 since classes are 1-indexed */
-	*last_class_ino = sel_class_to_ino(nclasses + 2);
+	fsi->last_class_ino = sel_class_to_ino(nclasses + 2);
 
 	for (i = 0; i < nclasses; i++) {
 		struct dentry *class_name_dir;
 
 		class_name_dir = sel_make_dir(class_dir, classes[i],
-					      last_class_ino);
+					      &fsi->last_class_ino);
 		if (IS_ERR(class_name_dir)) {
 			rc = PTR_ERR(class_name_dir);
 			goto out;
-- 
2.55.0

