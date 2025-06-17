Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F82E06FC;
	Tue, 17 Jun 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169187; cv=none; b=Japi0akRfF+T2+GN36226sCt8oQIKQj9IOAxlyZxEtg5S1UUjHI7uxaSzbm8141JNHrUA4sv8vDnrhllhWFa+8FFygZ0w2UCXW4D9Wn66HCZ0adivNf5kt+HT5nVq0PGb0Hgqbt+nei4jPv7tXryfLm+GoHPvIMivIDrSMpdDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169187; c=relaxed/simple;
	bh=/KgZ1EGgODjNUyvkggk2lqwkbe6ebA2nUqdDZRYqPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH0J5VzQky6NJCSF4hL8Cjtw7pZmsZW1LnDPb6mVLwn/U1X/dArqmF74yvC+0KB16cLCvIJOwfXydWHVJH+N2jyiClt5IehA7iUZA8iE2eWQuJeSola/p27+FDX22GxAax0Q9p6zo6RTk4cE1XTEGhvArd1In+D4wonviZUZR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhuMNldD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhuMNldD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d094ef02e5so723920085a.1;
        Tue, 17 Jun 2025 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169184; x=1750773984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D/7tdRBCBhx4iOag+EI9Xg2d/VS/yPCChyzETtmSc4=;
        b=GhuMNldDfGof0neh4rWL6blt7EvPEM/BbajGZfSvJb1sC44hlMELP58ucBzMRX/9WN
         iTqqfQBgzOXv5M3iVHceG7SNvxuO0HRcRkr1Or8IBNyHSLWvOV2RBjo02J13Lo0wWQ1O
         v+YGEU/fTyUosATgJw2ySZxJo1sHS3pLhCPSOViEZwX1ixvXSTM7i4NFmuclFxe6DYBz
         YhKx0S+F08g1k8vKQ6roQphWdl1yA1S1Gx0J9mliKKfUMXrUe0zW+P3KINEUORxsZWkR
         JYJfDfb/Og/gKJ1Hq78fzsP7PKnU64tGQuxv4ppPjQZZvkJ5RfVfh2qGuo+rgMIwmojA
         Pmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169184; x=1750773984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D/7tdRBCBhx4iOag+EI9Xg2d/VS/yPCChyzETtmSc4=;
        b=dhB7DDysW8JtDT4fyJTW5b1OnNbaByqvK2QaTq+t8BkuZquYp+euN9FLNOwjl4UIpu
         moSMoBwuo549ITrordZ5y5pourqwZ5qOUAq72EtOu80e+/WF1m184e9UVBcWTWI+N5qh
         OCy1SBFB94WYiZNCAr7HMplnidgw9pNIMuC8vAnDz0Gwh1DoYxYSObfx9UDssQEgGh+T
         dPLQiFXiupZ+HSypGFVrnlxGjOm9gawcBGlsEVVFl3Eh47uIgR8t9NRlRhMCZKbcUN9Y
         l5PLRL84HMf5Hsal11mS4CnbFpoXYslE/jpqXnF99g8xCaL7rYpLjeXY0cFXNiMe8FJO
         8U0A==
X-Forwarded-Encrypted: i=1; AJvYcCX8aWkCb+bYu/WfBnt2VYGPpAqBOY9W/FwGrpH39h034iuN/ozqBblF2fiXQfcN7rnLHYXN3ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnJYJyblOwEUIRZQ0UOld4E+jhmZ+/2LiB8a9fN5gSQ1hynQg
	h8xl9P26/qNPF/HT8h8PU+rA7tkpWBytGkOZ869Kp45/SDyPa3J8Ckv3xRCnWg==
X-Gm-Gg: ASbGncv8/mQ62oNlKEIjtlgbx1jY/WMHD1dDNMU19pHdeZy/af7YI1zhY1KvI1SdWS6
	zRuMHIDdi30Z1UUAmECu1OGy1YWtdB/YwF0R6Gz6zxv6RTWj/MCQE64PV67+lZFihZJysyRlEzX
	PWeijZWNOxhVl3MTmOil0MEK3Fp/vPGAP2Tz0LvthuKxGgyCMsbWqmQbAsKKARNwmo6HT0M5Oh8
	/lNOlnZxcsNaUKd+LYebP2D5N7rFZNi9TSLq4OxpQ2I0hNEGhy1WNX2VTSWLcTbCGQrr1tkN4ay
	qsinciOg6TPs/xXrwsSLCS6sOOXJMnLrV/+FjLACD63tO9xBVba1ZcNyatnlAfgm9S1liWPI5QC
	AwomEmzTQXwYzadRZgkxb/J1JagDhUCyJDsk2+LVsz7fztcLNPsV6OC3e1C4oy1+q7w==
X-Google-Smtp-Source: AGHT+IHwJAYBVT+ajJ4nI/PcWTdrUOU/dEp2CAspQmuuUVM5zmGsTR3Lfr3xyGkNM2j7A5GT8Lpt/Q==
X-Received: by 2002:a05:620a:1911:b0:7cf:5cdb:7b68 with SMTP id af79cd13be357-7d3e017885fmr442365585a.0.1750169183904;
        Tue, 17 Jun 2025 07:06:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 15/42] selinuxfs: restrict write operations to the same selinux namespace
Date: Tue, 17 Jun 2025 10:05:02 -0400
Message-ID: <20250617140531.2036-16-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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

