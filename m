Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3D29712C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314628; cv=none; b=jEEr2q9W6elBlkEQjUqLtPlPV/QaBcYyGQOU+JIpQJNbsXAUnQG74z93qByaPHILRGSo3K1S7QPfB2w0QYBygblCBReC6LaVKohvsU3YcV07sc1VF3Z7/iEkjT66WV+ye+CMHQQuNkmB5WOctsqsPBvq5dGIEjgptBJavohun1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314628; c=relaxed/simple;
	bh=DOJdYa0YGcttmuCEq/5atL7uoS4J9n5Ddes0hvH+uK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QooppUvHvDW5CE2PL8LVlllPkdkPQ3SpmcXuCreUIo6bUbjIVJr5YKatnmBgv8YIXSaowC1FptBp0keB/+dRpK1Zqdyfo1YD7q600Q1R4RHUkFGrSYYyCgR3eIfIN6TzwSqcVaKfgwVXQtyDuOhWbpYYp7TZ3fDPKwyoooDJbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyf593sF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyf593sF"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476977848c4so10451831cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314626; x=1747919426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG6ld1LqhB+QxWjn0NZ8KyGMOpg/YU+mhvpq20dzPS8=;
        b=dyf593sFhOkNlbPXUQRwPTxfIFaX03r+0qLvR8DnRRVoFBzEA8qdsmOE80pSpbPUsj
         GxP9S2SDKa8y3hy1K5qDehLQrivOd3nBghJKrAW7TKUYBZXlF2PWPLn3Dez+8ycVr/1o
         tVmWr5Fvi7SH0qKZZH+JiPT1Z4K+zNdqIxj+Oq13KibauaqbWcf/BzWGV+qNsfWTFey/
         Duaxewh3Ie6OQFQB0e2tQt+RBAtYQ0N4y+n8XTvTKtRdo+sLIr/jUJiti2y905aXVemF
         THDX6Cgk5C/+hK8/S2NDDcT3pDOcOXryrMsYrA3Y0ADD6xXGHSP+F6YW+nYtYFCzq2q0
         mFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314626; x=1747919426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG6ld1LqhB+QxWjn0NZ8KyGMOpg/YU+mhvpq20dzPS8=;
        b=DZHuyy6smibFRGvZRXRRBBFCoWWIDSUVV2MreqziqJ8QgsruHYh1f75B1DhuSdjBlW
         oGDUlQtfVfKbdNGlvSmUZmWlvTIFDf12nhZ9awkJimg2TI47Hro81n9Bh4Jq2wV5eu2S
         DxuGpTXVMtwViaI1pl67kTGN+WBw3Nk9u8gk8kCHkjahYyUmPhPt2jHaqriQ9zvoG6Zz
         fcoVW9Bd4dysdrdpnIJcLwEyxAV8G/AbX3fTfJAMfzWTNX4MPB4MGldCJM2eF7JROQ+J
         GCvalnJ0nk0gDr8VXYiv3BTUNBUa3c58fSbAYD3lBUOkN37SvwE8kKSunwTd9O0o9a3A
         uj1g==
X-Gm-Message-State: AOJu0YxqTw50v2ucLblvZ0YMapJQGEOWIou1E7u/cerh5ZxvkMleBgUr
	H21DzFzp/XZpx4JHstt0rjW9UrmsxYJZcARYFGDEYEtvGhXjwv4DHU8K7A==
X-Gm-Gg: ASbGncs3l+Z0EQxBAjgjFmeFO9D3/57XNl5DU7wgm6HhoVzpW/uxRlaG7pZ9z2kdH3Q
	u0b+PmegL41cKGm74uHD6QylnPOjTAZSfl5fB0XzoFK5cJcT95w9Yrz2fIsy7nPDC83KTRyUr0A
	q5G2pYB6+kL3QuKadH9EED5FXMsDYhVKAFgmRjnkGX7ydfofL+PJqeIXzt4VAY9UJWjOetrdgQB
	lwIww11YH+rlKC52krSr9YN1DEEypGGr069/Q37Qf9lxggwgX5I4wqan0uVQxOuFp91Lt6nAMdc
	i3jiOCKU2gZcwL+D8V7NycChe/dQK8p+HGa6MFp9UheBJ5CuPYKaFFkcM69MK2fSl5+HdQQHXy8
	cXRfZYfalJbdrQtfw/AwChPAW47K1kbkvcUz+RSFoKIdatR+3RGNelQ==
X-Google-Smtp-Source: AGHT+IGFPmnk0op8q5oxqhymfXFC3L8s1kNDoi+Aw2tfUBFXCBX3mCNn6bkfapSYGMX2UiQrDhglZg==
X-Received: by 2002:a05:622a:989:b0:48a:c411:e864 with SMTP id d75a77b69052e-49495c659damr99288311cf.7.1747314625588;
        Thu, 15 May 2025 06:10:25 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 09/49] selinuxfs: restrict write operations to the same selinux namespace
Date: Thu, 15 May 2025 09:09:07 -0400
Message-ID: <20250515130947.52806-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index 26b9fe149b2a..920908491c55 100644
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
2.49.0

