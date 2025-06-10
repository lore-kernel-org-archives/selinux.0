Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B3255E53;
	Tue, 10 Jun 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576212; cv=none; b=IAmAZ62dGUD8pyvzDqIuGvywb6BuNpk7qJmubWZBaVStwk69daktLIfW3W3X2+QRizXKWNTVF819jcSQ23eMxtJoEvK/UShyR9aVVJwkk9NhpuZuIPqINUwibKs76DipXOOOlmlrG2Y25Vo3Ydh1amFejb+YQzEDU73+c8rk1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576212; c=relaxed/simple;
	bh=O9NR5xFDFJ8EhTXrbHp7LJCP0HFWFTKKVmYJbDfrhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIdzHl3ic7mpQVaeOPaED5wkUSQArVrp1uuahg5FdpGEFvn1AoWXMb44r6xCWU0smYSyM+uTob53SplMDfcQqJDewYk19PSbe1PPXDjZCzWiinG8N0L/5Vp9AeybgXnpNFGKu/XmmUTIgOMig2cWCO1cuV4pmhkwdKUq7bWRc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV6VYsIB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV6VYsIB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fb01566184so47311916d6.1;
        Tue, 10 Jun 2025 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576209; x=1750181009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=SV6VYsIBQP466zwFvZNYOPhefbMyMh/al1xsdqR0EU52KCWZVFM8VyDzmJIFoWIgaz
         gDoupKizi2HczTf194PbO3PDrFQWVAv/zGW8P3IGRHTEa8VmTFoQyb5gmhjQAV/x6oPh
         fQjVJ9uqpY5mvAPfN/OwBDQp/y3RfQ5xlZzXhf2y1z+szO67eIJN7fWnSnWOePY5WS2T
         R6vgUW+0ut/YbNK3Gc4v9dScmk7UxwzqU+F/F7KFR9RYT5oIDw8jdH/IIJ4UVrAY09vD
         D0PzxA2kvPJppvUJaC3TGE0c5OyIi+7YFNkqEV5f+SI1cElsdwdKt9MfPCxbve8SGKLH
         Jd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576209; x=1750181009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=n2sX+XlM8Rhqu1fsC6pSbd3JUzKFSuY+Pwym6ijck4pDqycOZ+RN0V+FpZbsaDAHh6
         P9kVqHwbv0ePCX3jKAQVLY6t35D3o8JNkfN0543dofA14RGzZ2iUeYBD97kxcMaNXjM6
         o7tutgL+X7orc3DTas/7v8VFds1IykMiJ1Z4dLWQKc0vUJNteZifLKgq2ATkzmR61OqX
         3pKYff6cBY5NbDfFKuupP9XsCKikKzZm+IYdghq6z3s/Bqef2U4sNY4h0morYMwi7yr5
         34nzAKkBzvnbz1apIDneJL9bKnOCYPrv6j7X+QabfnRHE4+SgWPc53e4m32q+ViHRaIN
         0pzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHxz+atTKAfJBUEoazlsLgffPPW9YmRWzE7wpZRIGyU1sNXp9pJqBp0HbUkjwFLqOfMfjmgWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJQaJNjre19qaigy0GlK0pCfvCkHMlrZXqN5WL3lae1Fw6eRN
	UOMdrMdvOfgWfYYLQ3M6r8bt+RbY7ApDLUfyIMTKMvX8hFliE+JZQ3QDsdhPkQ==
X-Gm-Gg: ASbGncuzlMk6pRqTioDZTQyeZ+uIL5CTe2J2CP2y0TGTfzLNgFcfwn9OfMfNfdmm4ea
	xmBYj8lnyEzs0HkB5XuP24L3VOcEiphk3KuGvNQ1m/rw3MzAASAtTsaN74fISTGOCmUjRWPRK13
	zllJOXoWOmPA7ZUZ8SE221SUrMO1L9a72a89gxqDlJVmzJ8Y+wF8VoFUN58LVnidSSOltNYhM6I
	SWSUfxCL73z+bT/ELiTgl9HgstGA3ceax4A8fmfK5ZnvuOIYv1fN7OT24Umoogr+muwjnKR/gGQ
	4WdZkg4bY9U3G/YgmkU6/wc7OYjhc7p6qhURadRLFNy2M/yaF/7pmBfMrqjF9tyidAnVaJNl6P5
	k5BPk8hULDcW3DnxxeZnCJ3N8F+qbPHHym/W0vFcYGNE9W7AB9sLEUO3PwmTcawxJ4g==
X-Google-Smtp-Source: AGHT+IHQd9t1dI1wrGIV5VsFlZKuL3bxsAtESsawxcs+Y7DZdv8YszPNUTbCtJilrm7SeGICxQESfw==
X-Received: by 2002:a05:620a:6292:b0:7cd:4b5b:a202 with SMTP id af79cd13be357-7d3a882994dmr33939585a.20.1749576208848;
        Tue, 10 Jun 2025 10:23:28 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 35/42] selinux: annotate selinuxfs permission checks
Date: Tue, 10 Jun 2025 13:22:06 -0400
Message-ID: <20250610172226.1470741-36-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate the selinuxfs permission checks with comments
explaining why we only check permissions against the
current SELinux namespace (because these operations only
read or modify the state of the current SELinux namespace).
If we were instead to check permissions against ancestor
namespaces, we would need to be allowed by the ancestor
policies to perform the same operation in those namespaces,
which would be undesirable.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 158994a1dcb3..c7825db4e06f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -175,6 +175,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
+		/*
+		 * Only check against the current namespace because
+		 * this operation only affects it and no others.
+		 */
 		length = avc_has_perm(current_selinux_state,
 				      current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
@@ -362,6 +366,10 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state, current_sid(),
 			  SECINITSID_SECURITY, SECCLASS_SECURITY,
 			  SECURITY__UNSHARE, NULL);
@@ -592,6 +600,10 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -654,6 +666,10 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -811,6 +827,11 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	mutex_lock(&fsi->state->policy_mutex);
+
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
@@ -866,6 +887,10 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
@@ -917,6 +942,10 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -976,6 +1005,10 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	if (state != current_selinux_state)
 		return -EPERM;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -1109,6 +1142,10 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
@@ -1163,6 +1200,10 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
@@ -1265,6 +1306,10 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
@@ -1331,6 +1376,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		" userspace.\n", current->comm, current->pid);
 	ssleep(5);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1396,6 +1445,10 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
@@ -1527,6 +1580,10 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1586,6 +1643,10 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1707,6 +1768,10 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	if (state != current_selinux_state)
 		return -EPERM;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.49.0

