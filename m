Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837527FD50;
	Tue, 20 May 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742489; cv=none; b=DObUW/5bBrlpMBOBLcdU4utDVXEA0I1YsQqoE6B8pYhz6Y4W/wXBXTQEuWOHJVkxR91XqSVuWEkRaujDpmPbrsR6kI1maJlW/vvBWFN6aRa+ea6DeuI5MOI7TvxMajPsWJwW2Mj+bc8gRtA3C9+NA+w5wfevHGcfdddkoT9HDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742489; c=relaxed/simple;
	bh=zbzWWlmHAu+WpIR3gMquaD/H3WoHsUsW1tntQoWqVPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPOC18ucEoVGXsR0ZQPoVCpc2egfJck3aKHQF6xfLpU4XpZL4Aj0HXLE0Wv+2N/wgbNHkOcElMzUGi9/pMMhjfHCUbtcfOIAjvfgh274gvz1jp7O3NUM3E8x/y+SBkwBtkf5EMSO3Qq9CDqWs3bj+5p+3TDgUlNnGkyqwe8VYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqR9ooMb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqR9ooMb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742af848148so2873663b3a.1;
        Tue, 20 May 2025 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742487; x=1748347287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn52Rhou6I14SJm/yFwT6Yj7U5o3/kLEmyz4Zw1Sd+w=;
        b=lqR9ooMb7ESo1tOi+y3lIdNBmKJ45Kr9P1mcuVnoOCLYrKZKpfP7urOglBKyJCS0mP
         a7ghoHlmnersw8tGUI0dCrAzVZzwrNolETAKwydAtLyHmzp8JK+yZbTkTNFdyRrQS0P2
         FnW5l+Xr3hdKdXQjT11HZbMha1dzrAq71M2kqLn1edGelWYgWJPPkeS1AfhxqTTzvCXV
         7CIozbSQjuhaWn/R/26r96qATIgnE1yuvm9+Wi/EPmIP7b0+meyoJ3QE8Ge3pUipCFwT
         6tvLGRyhjVVcCzb+Ucc0Su2P2NE7p1nE5iiIE48MXOY6tRHBGBQBpfg0xEeX+5B6LRl6
         XhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742487; x=1748347287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn52Rhou6I14SJm/yFwT6Yj7U5o3/kLEmyz4Zw1Sd+w=;
        b=FszaE0/09B2Kdmv2SCmkUrl88cEbmNn1t6YJrtYmyUUR4Oa+2AQUCf7p+85/StXNxg
         w2fxQhW2yLEj2dbgXmvWv0N3SvMSnv1eK9/UPoaXSIk49cjuD7hiPGaZSIm2rPiFwjqv
         UtMur2CCW0aGm3JGjZONqoeYIaYC/85RJ1v9umSEIhEwJEnkxqaeHQCRXhsxcx22Wet2
         hna3R4dyGXKNiP66w37R/hErp385rezSbw+nVFufiwpffh5WIE00bd2ECze/rsZg7toS
         8Iiw5LVFlYJndit6FaUV6qYiv97rAL/sRqLbypotZGY/ZfN3WuW8hXxiiXi1yLUIcEeC
         kMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn+VQB+06qFJNOcMaHjhGxWEmMPWGoTuAsls5mQ/sRCIm5qAbl0NQX+KyfzIvDzJHua7TSrIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HcnGOjLH8GNn6+WwkQlu7DMSwBzBHsEuURi609stoTSzO/PP
	1cD+7a+u2XmGwAGmqE/ab1eu1eaIk4EAH2/RllFpiiNM5PZjGD+0WUe6pngkwg==
X-Gm-Gg: ASbGnctiyTzXmE61p/MSPhdljIMZxgmBpilYIV/cVIh0armJxaNPTy0Nuh6JotpX26E
	wdNVt1Il+KzqUdufkBhXyFPuFoft5/imhc8BB2uSlN8IAEI3xBA3/GeGVREDPyRub0VPhpoAUmw
	X6GLRCCA7o+sk/9LK0q+IE+mDL1GUStPNF0V6OGNI76irBUKplolWqr2q6ybjmjUw5PNZwpy1oG
	MVAJ1w2VAuhTcI87jVGcqwafY+68O2CW/hDS18Xpr6AZ4WtvQlOTZCYb5vsiu0KFcTNp0cUXBEO
	87Gl/g1TyCZJ5fimrw3SoxMHggJTXCNoQML01Z5dLM8TSNfCFowCEPDXPTohAz/OhsV8tSSkxlF
	0WvUJs+sH6LPi9LVfHs7vAf6CaNgM3FC3Pg/Yma07XJiz9RrwO5tPcfWI31EN4h6o
X-Google-Smtp-Source: AGHT+IEh2Hekn1Qe18806pl08nZu4nAAUNhw9Zyxmgx9/NYiBgdXhtuiW/Lz/WG1T805FxBHbqIA4g==
X-Received: by 2002:a05:620a:29d6:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7cd4672de2emr2507863185a.23.1747742475820;
        Tue, 20 May 2025 05:01:15 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 14/42] selinuxfs: restrict write operations to the same selinux namespace
Date: Tue, 20 May 2025 07:59:12 -0400
Message-ID: <20250520120000.25501-16-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 40d2d2cae2a6..a0c398c2d3f8 100644
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
 
@@ -1485,6 +1506,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1541,6 +1565,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1672,6 +1699,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
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

