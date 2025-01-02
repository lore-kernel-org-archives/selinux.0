Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DB155A2F
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836356; cv=none; b=J4q7nitfTTsRW7/reJgoE1TN0kRulGG6MHRy4wBYoTJxeTHPTCwLsssUYDzwAHEe+a45JpwFh72kPPHHY8lYmzX2csCiQsvM50pBAHjdD+ETQIrXAuGJiEoygnjQgMdYE6mS5+RaXOulJX+1aQC58lEEf7GONLG2pbXNZuJJfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836356; c=relaxed/simple;
	bh=ZbS2+VccBHLtiDuM0S7nHtGMeAMZDaDEXxkyVy1DaYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K74TbntkH20+kLGN3GJZM5laqEtMRmN0Bl78cZ3FeiOfsgx43+RASiIqtM7T4RgvwwpWxi5iaIn0CVoZwx0Dt6w3NkCYeQZPtUxSRaPBbcMOa91psLWBGS73H0WtueoT3PkHuHNQsICgE+JvsOa5n/V9oqdjMQkh/YCw7E4No/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNApbCJn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNApbCJn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46769b34cbfso171277511cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836353; x=1736441153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw0Gl432QvBZ/79LUAgPlxfNl05mtmHs8WJ6hVvUgLE=;
        b=nNApbCJnPCw9OiO38O3gwfpCoMKJhCYTRncZl09Am6h4T3NwblDObvCAxnEcVnFlMM
         JT2NFr6F4oSPgP9ItpUbM+Fclt7VH66ItEZrDHG2ow61vT/hfKzeLMQjKh+6ATBHIz+3
         s52oRorvI6yA4WKHxz1p6BSSx3rvT8rKBVrkldNW7eLpKF8GAuJDroOLwfWm7fMe7rrY
         mIn7zyW+IwbwpG6RMghRQMj5Y5P1MH9H5GXj1UdxWqD3AxLcFlP54NoIoQ/NQ0T9gEyP
         l3PR7rk/UB9AhrBpPsv6TgqlqSC0xrRyOBMuBidSH73UDqNYH+XCjkZFykjq+Uqcldld
         B/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836353; x=1736441153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw0Gl432QvBZ/79LUAgPlxfNl05mtmHs8WJ6hVvUgLE=;
        b=tGFXWRVxUndOYA2f3UoJaZSzQPm1CvtiuHMNfnL9eitR4qiN+Vdl5yM5+4574G280G
         wOZUaqgO1mFH4eliIpJ4ZbSlyLNh+DquHlII0NT72XZUFW+tWH1KhD/Gt5p+lPXN/vZ7
         HHGbHgbHXHOds85e69GnfSYNZpETULiBnvtyzx8jiQq4nTZ41cHxknAM0ugN1RXRrt3L
         UnOrZn4wguVstZFDczk2T0qYklHgIG9qpk4n+H5f2dQGZv1S1v10OJt2RmIe8uPjh/lV
         xzzhuN2SYaT7Kv6/ruDBW/71od+GxZeeOxbunbhYs23aVSon+hwuym6z4a96XtaGGAK5
         U3bg==
X-Gm-Message-State: AOJu0YySaqRSKaZa0s/n+0GT6+7JBak2yvBhdfWnA93DUZazVQFHTpzi
	zALbwoMghNOVsVQDhppAZq8GiLTyB90U6hUdOz/DvTGz/XoiagEcUKmOmA==
X-Gm-Gg: ASbGnctKl3PErmso4icxzUYPOM3ZnEZcQ+4rxa+Xv7scD0tftw0goUSsHhoef2Qhhkc
	NZKFRe+cDj5quygouvwKVPd2DYFDheqfIZS+n0IE2qbwRNPpvFOhC+Vqc1TwlIBuxeWnJrJiB/U
	mKEq9UqZdgZfM64GhMwmG+ZTHt/O3VFShaDCC5AJ5uRfKgMo7bEYBDRyiZx0NK54uYI1Wie2mK8
	wI+vbyp+EeKJhZxABTa91SWHZOVb+wU/9LCg12j0bR1MRY5hjQMQiNpgxKuJ4dzHKETzrijxCM0
	Mp3tXxe8/RGSefrfYbyzbtpOi8x8B+jetIjuGWv5cQG4KpSErIdgrG/QDebrjOwgK2jQdA==
X-Google-Smtp-Source: AGHT+IHcfxxI/IAT0eB2MBjrltKe2yDP1mWx1v0j6zaZ6wzr0gIFbWCNQVITt2S3AG5j4p688TpE4g==
X-Received: by 2002:ac8:7d84:0:b0:467:8630:585b with SMTP id d75a77b69052e-46a4a8dae88mr697448331cf.14.1735836352895;
        Thu, 02 Jan 2025 08:45:52 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:52 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 26/44] selinux: annotate selinuxfs permission checks
Date: Thu,  2 Jan 2025 11:44:51 -0500
Message-Id: <20250102164509.25606-27-stephen.smalley.work@gmail.com>
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
index 8c159b88615f..590c883ae86d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -171,6 +171,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
+		/*
+		 * Only check against the current namespace because
+		 * this operation only affects it and no others.
+		 */
 		length = avc_has_perm(current_selinux_state,
 				      current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
@@ -344,6 +348,10 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state, current_sid(),
 			  SECINITSID_SECURITY, SECCLASS_SECURITY,
 			  SECURITY__UNSHARE, NULL);
@@ -455,6 +463,10 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -517,6 +529,10 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -674,6 +690,11 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
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
@@ -729,6 +750,10 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
@@ -780,6 +805,10 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -839,6 +868,10 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	if (state != current_selinux_state)
 		return -EPERM;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -972,6 +1005,10 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
@@ -1026,6 +1063,10 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
@@ -1128,6 +1169,10 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
@@ -1193,6 +1238,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		" This will not be supported in the future; please update your"
 		" userspace.\n", current->comm, current->pid);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1258,6 +1307,10 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
@@ -1389,6 +1442,10 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1448,6 +1505,10 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1569,6 +1630,10 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
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
2.47.1

