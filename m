Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBC272803
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990060; cv=none; b=SLp3ta+HqadjzOeIAKeWlOz2fGsWXL6ZReRfmEyw4WQr9w1b7nxg2YKMklv8IWRC5+4Mx+nB/2GGiRkUC55cOQu0Bm6eYYuoCiBeBSO16vzivA3o9fpNyLA04HP6QjxTo8I7p3NfVwfeHRcMmVuVtaQfORVoAQ0K/0ctxscZ320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990060; c=relaxed/simple;
	bh=QS9Lk0GCl1GMgDrzpU9+FPJb/HrG/fUjFB0jvEymjp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEWtG+voECI+7aVnFI7qav/EreOYAuzxq23m6sX9U3wRzqiZ7ycC9mNO7t5sBuU4eN3xu7HiwsG5oJYS3LPZqXrcXY4jZfRhA29T00As/LjcVBsCm3wtAOVTAxXPh8zDtjOkNBTNyl65pY6GpjlAoONBQEHPxQ5lciUnwPeVl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INdokUvK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INdokUvK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ee63e91acfso412260185a.2
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990058; x=1778594858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f01fKGYnxqOpgOEYpAT17E10j56IAu8gBtbdm4zSPuk=;
        b=INdokUvKzm/ja6JEeYLiwqtsJi5zqAXK5Y8hY0EK3n0emUWk0ooPDAmpxa+2Drfv4/
         DtwGst0OOCHvU2RYVW+LaZp44BMIHM8S/B5ATzloR6S+nd4cLVlFOZOpu4tPL0CPaGj2
         NJuIOAjBkMHfMBVBzf/Qx3+l87GO9Viri2k72Z8GcCsu9ps5xiTKfKBCtwi1vfVtdXTH
         YCJHIlp+RzUzQS5fqKllX3CLZsSFoQZPFViQcc7+SLtXgauWP8F7WAscp+kqee+g6kOz
         4ug0so95iTvOC4GoZk6Bz1Ebe5YaRtD96HLrgc+PDoky0RB7t8xqWeRvOaj9phvRuK/S
         B0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990058; x=1778594858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f01fKGYnxqOpgOEYpAT17E10j56IAu8gBtbdm4zSPuk=;
        b=i+69188mk/2Vf9FigrUYNShBQFvHJZ7GCDPKBCDQiEmMtwMgiUn2MZ8cx8FE/0+5vt
         ciW0sHfq9QobJJEKJPdDHuLQc6toIUys+zCTX8Sq2XDx8/Y7En6adhVx5Uj9BmAc+3HV
         k/Z0shB3az9+twxMbiJ6YB4brOzCMk3EWkLMJDldP8tOu/lpirFeOPbzyaQbq1+T/i3j
         dVFcklIuiOmo5gSz/FInKvl/FwdnE1+dHAR0ZT/uW1ZXqHGc+suepU1xbAJpe4bV7j0R
         cHCF8Q3YxE6/1XC1DrWUdpS30deg3CN5GaoewTHPEnthZG6nBU7aEzZ5mVHz9ciom5sx
         UP/w==
X-Gm-Message-State: AOJu0YzSPfxlbkciF/16t6fMzEsFycGMJ48PnFexO745X7urShZc8a2M
	HFYiARJ4zmXxmwYrVi+JSKpukXq/RVwCPrHX92wgs76vMiSkvvBUJgepNpoKlQ==
X-Gm-Gg: AeBDiesOordtDH3kYhy5wJ2FbsEjTVJEEqgE96aGlLaXEo8v7+D1ebf2I66B3JDf/rb
	osZCLMVkLiwhO/X1rrOZvqMH4GTPhZtev7OM2sFsajfMYY70qHjz7lcgrZyTQ2JmYwxjXUTFuGR
	lTMzi6IZPCJha7vP7m3FzTS/M6cNi2Lmf3PJToTar2kxPlSov5/JsiEjActrPJCWlhtgJngU2LC
	Lf2MA7A1tic4UWpjNfNNrLZEjGASiAnsnBXoVxwEideM78N1nxaBbMHRFA1jF41YnmNGxIw2kkD
	rmxcVFHrntrP+cCKpp2Gv/KiPpwZH6B8cQ5pu2MyhJmRSp93e2n5WIZgPC7BHbVJ4ZPnHbtzquZ
	0nfYvChIFdHU5gvSGYlSx7ihrMKVpe8oeP/SA+PtvSjoj06pmc6zFfgqluH30ObFYa35yycO4rX
	N3b+QQP/q8w7EB+KnAw2JFBO7ZWxUYyXEnwbH+NWfs+NsZo+h4OFxVd8QmUkvmJV/DDJwfnzDbP
	rrJhezrKiekBrveRRgTCCotYM3/k5o85vgOunEfvjKNTgq6FEdifwedZT5ySfF0zg==
X-Received: by 2002:a05:620a:2996:b0:8ee:dc47:3b70 with SMTP id af79cd13be357-8fd18137bb2mr2155773985a.39.1777990057765;
        Tue, 05 May 2026 07:07:37 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm1385589885a.34.2026.05.05.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:07:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: allow multiple opens of /sys/fs/selinux/policy
Date: Tue,  5 May 2026 10:06:38 -0400
Message-ID: <20260505140637.2468-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there can only be a single open of /sys/fs/selinux/policy at
any time. This allows any process to block any other process from
reading the kernel policy. The original motivation seems to have been
a mix of preventing an inconsistent view of the policy size and
preventing userspace from allocating kernel memory without bound, but
this is arguably equally bad. Eliminate the policy_opened flag and
shrink the critical section that the policy mutex is held. While we
are making changes here, drop a couple of extraneous BUG_ONs.

Link: https://lore.kernel.org/selinux/20100726193414.19538.64028.stgit@paris.rdu.redhat.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 shrinks the critical section that the policy mutex is held and
removes a couple of extraneous BUG_ONs.

 security/selinux/selinuxfs.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..407052d0ddcf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -76,7 +76,6 @@ struct selinux_fs_info {
 	int *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
-	bool policy_opened;
 	unsigned long last_ino;
 	struct super_block *sb;
 };
@@ -360,44 +359,31 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
-	BUG_ON(filp->private_data);
-
-	mutex_lock(&selinux_state.policy_mutex);
-
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
-		goto err;
-
-	rc = -EBUSY;
-	if (fsi->policy_opened)
-		goto err;
+		return rc;
 
-	rc = -ENOMEM;
 	plm = kzalloc_obj(*plm);
 	if (!plm)
-		goto err;
+		return -ENOMEM;
 
+	mutex_lock(&selinux_state.policy_mutex);
 	rc = security_read_policy(&plm->data, &plm->len);
 	if (rc)
 		goto err;
-
 	if ((size_t)i_size_read(inode) != plm->len) {
 		inode_lock(inode);
 		i_size_write(inode, plm->len);
 		inode_unlock(inode);
 	}
-
-	fsi->policy_opened = 1;
+	mutex_unlock(&selinux_state.policy_mutex);
 
 	filp->private_data = plm;
 
-	mutex_unlock(&selinux_state.policy_mutex);
-
 	return 0;
 err:
 	mutex_unlock(&selinux_state.policy_mutex);
@@ -410,13 +396,8 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 static int sel_release_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
-	BUG_ON(!plm);
-
-	fsi->policy_opened = 0;
-
 	vfree(plm->data);
 	kfree(plm);
 
-- 
2.54.0

