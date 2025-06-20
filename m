Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316042ED15E;
	Fri, 20 Jun 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441534; cv=none; b=OHfTlmTjS1MSQu8dTiJQg72c10TJ1XUzbWuZfKKGzIr8fGv9V3bf/oJydec9OAVIKx5kb28aaJ35lNfQd6aKRs2/yQiMC81pKapGKrNfuI2SXUb0w7IMTIpDmrBGuxk92J1PkYjY4DZrjoyEwmWYAy75GriFy9Hae8N1FQ1HqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441534; c=relaxed/simple;
	bh=/KgZ1EGgODjNUyvkggk2lqwkbe6ebA2nUqdDZRYqPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccwK/tXwTt/TQ2oYYVwwAJ323vNPzxDTn9F5Iey7s1cP7+5EitZw671sGNDxhgwQahUGC7Shak1W89UIyNmJHn4C/MGBk8wM0gxASwcbijgpfJAMM9KucMcs2cRcUz/e5JPo+z7IImeleOXKqEaa7+IUmQqjDh42uHKdBNs3F3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l60SrG8D; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l60SrG8D"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso19662136d6.0;
        Fri, 20 Jun 2025 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441532; x=1751046332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D/7tdRBCBhx4iOag+EI9Xg2d/VS/yPCChyzETtmSc4=;
        b=l60SrG8D7Z2oEkAHZo4OciJewUygmMIr0sstwbpDDJWFAlyFRAOpA9NNYsQC58U5S+
         5H1lemxeGibyRbWiyW9lg3g+RyLmWBSv8n8ylCe2dVMHuspp+UXn75ZRF8UBtHNCinfy
         T79YwSDnDrz1IvyB12gaXQEBdc6GwXt+ViIioUq1PognTHHf0FCwoqlCXC8nVM3otZg1
         66X+NF4GFZc2WyvmUxRqq42YIrm4L7FBmdr8GcLIv/JYhdqc6Ucw/fjY0Gl7bxuEi3W0
         a0t4TYcw+7ZMD6lKMZim1gTIc2PRTkYaPEGdmCTtYrx5+Lot5LMn17f0QyYzAJ2c6tP0
         ZG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441532; x=1751046332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D/7tdRBCBhx4iOag+EI9Xg2d/VS/yPCChyzETtmSc4=;
        b=PpcHcGLlSM1xKIauJxts6tgDwNk7VvIFDZcPWf2wubxS7w5EAjtLsHCUwlBsxT60KQ
         ipe9lagccPtNtXhAHxo5ZLPE6nNdu5sMquEZWliwnWLmc57E0Y9KJwatdkWtyAhagMCs
         AqItqmWmS3eyXS/nBn+9yRKioW9S4zBhgYnzyDiRuJYelGjETwF3YdGnGW6kg5unRhGL
         DXvv3Gxp5frzgyckALasCQxMTlR6Vdjf8SIw6TIYKiiAKpDv/RZAdG13r9GRB91jAYaa
         YLQxpKCu4gi8wbohJuFN2I2+v8D5GS4FvqI3uDPh8LOFgtenQlfJspj+q/dvqCTTjPC8
         t3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXhLX4xFKqoQ5Kl3wz8LX++QUIdOz87mTkSZR+laX6+xoEw+Lnuu7n1QXS42AI0weBQvq75qhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl73Gb4tnitEbOKKr6R76Yem3oA6orFgeHN9EWQ+daUbiwF2Ns
	LaN9HBGpTSQQ8PvMnsDuJmPATuyzwTXkj9S2+XoUYhmzbCQFSdsAXZ0cLAXSNw==
X-Gm-Gg: ASbGncvIoQMxvxRyg24XS6byPMOCixCg5hD0wvCCoJWEjVID3AgAZPNYUGeByyA7iRX
	RkhRzvg9mFykyhkCtbZcKIW7/tn8AnHnM3iQJZqqFEPoP++WF0p9o3ME/DStcxZpRN+5xzkbnLP
	2Kf4j7u2LE+Pz45zKPskovE/GkpyCukJrSZupawHt2XbRVxqiZX0zX0af6NLpIj5j52KvLpRz20
	W41Eux8/0sQFuSCUE+BnpGAVouEJmXafypfyoKKm5v7rK1Od/xfiz49vmlY0BTMiWmHUw7nynW6
	rE1T3kCChRCDeV9O8FCs5yvjfvrJXXp5dhC1p1FrV3yGQaMmABkFVxP+lwqu/4B90tQXPdlAIyM
	PfpQagumW46bpY/rkGZMZEWCE+mReRJSCXwbIrPE4jG0OcpFevfrJ78ZnOaST/defqQ==
X-Google-Smtp-Source: AGHT+IFCvWS9mp+fYAjHCVvLHac7V7NiBNkucWZJ9aeXmYMFxDLM9mwjsWJFtEClCIY71R+Nh8/HdQ==
X-Received: by 2002:a05:6214:23c9:b0:6fd:79d:c77b with SMTP id 6a1803df08f44-6fd0a491ef0mr63416256d6.10.1750441531854;
        Fri, 20 Jun 2025 10:45:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 15/42] selinuxfs: restrict write operations to the same selinux namespace
Date: Fri, 20 Jun 2025 13:44:27 -0400
Message-ID: <20250620174502.1838-16-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that once a process unshares its selinux namespace,
it can no longer act on the parent namespace's selinuxfs instance,
irrespective of policy.  This is a safety measure so that even if
an otherwise unconfined process unshares its selinux namespace, it
won't be able to subsequently affect the enforcing mode or policy of the
parent.  This also helps avoid common mistakes like failing to create
a mount namespace and mount a new selinuxfs instance in order to act
on one's own selinux namespace after unsharing.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 39a60d221143..09d22af6e3ea 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -150,6 +150,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	int scan_value;
 	bool old_value, new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -338,11 +341,16 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 	bool set;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -795,6 +803,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	mutex_lock(&fsi->state->policy_mutex);
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -899,6 +910,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -955,6 +969,9 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -1042,10 +1059,14 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	ino_t ino = file_inode(file)->i_ino;
 	char *data;
 	ssize_t rv;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (ino >= ARRAY_SIZE(write_op) || !write_op[ino])
 		return -EINVAL;
 
@@ -1486,6 +1507,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1542,6 +1566,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1673,6 +1700,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.49.0

