Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93F148304
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836342; cv=none; b=mbkcmcqS3uQnlzE+toW8Q6s1iQWWdVa3D9ZXJ5UYSNtsmD9+N2HWqVYvHRevoYqVWHAv09DQ2vBDD6bKEHJmo01PLj+Mj+HG+L/S+mfpNky9Buyfr7G9B7fC0+LReq4yGPc07TXebUNOl6HRB07nI6ECZh9adQ1GVF9FIwy8aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836342; c=relaxed/simple;
	bh=i2P4oCa9hkqpT71p39TKSS/5YL3pQ6uw60fPVg3SdQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7stasVSi2VcPf6Z3G1Y+6+iYZeFG4Ww0c1sKUK5C6+OhROxwpOL0+mFQLVgmvVWR4xmKSJCCw4bsPVU7987UDd8OqvPJJgkzbtH/zI98D88xGfM4J4i57x65MIHNCQX9/mhMZCKHoN1M1O5lDEWGAOGlmwjsWG2vNBb2gDUUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYwxOwY1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYwxOwY1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a63f5d1cso101663521cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836339; x=1736441139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csT6Vl2cSdQwwE//FlLeaEOzUL91iYA1bbItlkvqKF8=;
        b=PYwxOwY1Q+M4O/FkSxeuxbh5BBQN4BMvVwPRQrKplwUvfiLKZqwso19qwZtt9k1l7G
         H1Iju57+M9sI+aCg1vlJ7mw2EjRuDLrYXYsgaUYL6OQb1tzzQASDlv6m6rfGm47xR/ws
         o22dSPN3/u7qBN9SdTTgbvUl1uA4wtARZBgfi98QLHwlqBWg8iGWJhzQB5v6wE8FEpOr
         P/8M1QKPDGTqnARZyAO8bYu3cUEoX9EoAYkFkwx1IEGzcw5MRZP+brnWhgtt4B/4zAlC
         5CiWd683G/PmSCjZ0ROLcOUP3AuBfaozrjXNQfdi8qfNUhYHhtk6BiUtaw0GGXI4Ocey
         OeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836339; x=1736441139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csT6Vl2cSdQwwE//FlLeaEOzUL91iYA1bbItlkvqKF8=;
        b=O2xIk99dJuR6KacmXAaKntKyLgikJyvB5xJPJJTbA+rb/R0UCiVFBYaXJFpfQwNwzQ
         xAf1XpTFItKXqZ9UiRdhViCMVnBiAeWddV4568eIT7oqAp+pDkt319IrC6KI8GaNjZtq
         UZZQF7dZYXhLXHHPxO80NNFrZUP7DrjrPB7u3Iksvg0IPpUjkIGPX8tS88E8F44fgQsT
         cgOzOoy33A/3SzhYS5S28Qd7Sc1n7FaJq16EbR0m3NaQAFFfyRBMmsyQLdmGATXnERBB
         tfm4ze5Ig2hvP7SMf+uG7M/6Umw6lmpqjLEZA4icHH20ASl+8cHIVZ0udLlCbT001oOU
         lE3w==
X-Gm-Message-State: AOJu0YzjJuBtpOuL8Btj9CfO9qJ1JdFymeIrj1QpBM7Hqz936K3x07Pk
	w9iShP9Si1+/wgQsxaOPbNdN7PyTbIMhcg36+RSvxzcVid0Fb76ySbELPg==
X-Gm-Gg: ASbGncs1JOxGLEqW7XIO18JzNYctS3JUZPG0mnIuGvEyq9f5vzwaTDwlpSOE9znP8h8
	EVS0qt9fM393yU0o0GhkWRyccajJIrzxQxUjGZN+VJPyoFBeUIghgnjbQEXRrRik5OHcjYtfmjg
	KAaUdUessgv0apXkebm12lPL0xxDKq1gdduRc44Ypnrjt38bjIzLHFNHv0hE6pxdIoAk1awx+Fu
	VadlS64HsEzvY7d4r4nq3L9pJ61WWJZMWAZVJW2GPkPwLtEmRErrK6YHeRtjxttjpzQlgxHkDLz
	eYV+05KYr3Xvnk2rH9Z+8pqCBRtisRzKGnXB/r0wqUUUT0m0gWOsXp9JHhxT+yhn7uDAjg==
X-Google-Smtp-Source: AGHT+IGVVBmHqwgQAlshdVSMnIK+XqcFDZLcHaXM8gy4loW28fKtqJgpqwzRzoTiAi/8lsSrN4xX2g==
X-Received: by 2002:a05:622a:654:b0:467:5a0b:de08 with SMTP id d75a77b69052e-46a4a8ae1eamr689891571cf.8.1735836338894;
        Thu, 02 Jan 2025 08:45:38 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:38 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 09/44] selinuxfs: restrict write operations to the same selinux namespace
Date: Thu,  2 Jan 2025 11:44:34 -0500
Message-Id: <20250102164509.25606-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
 security/selinux/selinuxfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 120cfff35029..0702aeb0c5b8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -148,6 +148,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	int scan_value;
 	bool old_value, new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -330,6 +333,9 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	bool set;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -662,6 +668,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	mutex_lock(&fsi->state->policy_mutex);
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -766,6 +775,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -822,6 +834,9 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -909,10 +924,14 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 
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
 
@@ -1352,6 +1371,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1408,6 +1430,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1539,6 +1564,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.47.1

