Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36072299AA1
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314645; cv=none; b=TRyQpA7BcvokjacodR2bkJsYqxLe9htyi1GjnDIQjATOwxOg63c26Jwk0MDJoSO+fO6zm9mFkbAw3xEwdF2fmjW6uuz4TCVDx7Zv1DeYkxZGavac4tTLxBdMMYCtLW8mrsFhkxW51QJN6gd1/oou2sqfwNhYoFI+Kfdb2BFx5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314645; c=relaxed/simple;
	bh=9emiheiXajKHvIROj5B/Zv//boOcq/XUqOzFvlSxdAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0fwCC+8miF1IlKGCEuunFpuC+5Mt7MwAeJOT9FSb95AHJ4Bsx1KotUnsBla+ezpC9YflCAeRusC2BhR2I66f2l98+d+rH8sDv8hHaw1nIdq3rioPXNkWpPIIzg0PT7JbvJZnH/389qG2GTkH1//nX3PByZhu7FkjTUj6NMh9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAO0cWPK; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAO0cWPK"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f2b04a6169so10212736d6.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314641; x=1747919441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRUWIGf8UIS+PqAAXB9UhWI2oAQG5vCXOeWvGPU1UpM=;
        b=kAO0cWPKAI03f0tcHmj9Tx1dUi+AbvQmdCfZ1a71/TcPRo1qPwrISTqMAbgD+Yqebg
         AUiRyz1dvcuoisIIIMr+WUybqQH+8O0TZ7LXdtTztLogeMG9cS4bAifQUQ8ntKGTE/cl
         5YJxuUKSYJHYhZJ5u+sqLwWnD9PlVCF31g8VZdGUlEIOUS9hx5m4up6MjDybxYITvGLf
         Vujuv39BfxJRMuae0Pt6bFj5BOI1Cr4ScswJ6eF2G/Y5uKClk2awXUkroLCuhbeJslNQ
         53SkpttiaJ4dmH2916lexihiaf9z0IsR6+bMeQ4bNfZkMKhzOydM0A04n2Qc+GhQErTM
         HceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314641; x=1747919441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRUWIGf8UIS+PqAAXB9UhWI2oAQG5vCXOeWvGPU1UpM=;
        b=HTWTgbRcP+HeI3qR3QNlMcsC6oehAWg34n2kxMm3T4fI8E1qmWKk/jsD4ddwe/wNyP
         XUo47IP7pq2mMIRjenPbJKqzD2GhzOLrTINAynI7WKVvJ4CXKLe3q51nPWlrj0ITDQNx
         Hl7m1KXlUrzPgBF7WFG3fIoGIzOrofI/EOls4zh8pfh2Okns/gvuThdFkypauojAIiju
         c3xotBWfrtFZIvAsoFnAmjEb9mWDoZHDVaXVoiOpBVasaSp0wd4zCTKivTbF+V2A419X
         zJHnxUCnZtaVZQ5OfqW2/d2AubwtG//sq8h4boltqXLU/OHvk2p/wzaqjsaFdZFVlhOu
         CsYg==
X-Gm-Message-State: AOJu0YwxWHh62Qj555cI1AiHRqq2OcX7zt6jXdy1/7k3dfa4GuquJrbJ
	oZHLrlr5ov7t3vvq73urAOuMEB6gFen2Ds3h+L2gkj011ktdt9xzOHe/kQ==
X-Gm-Gg: ASbGncum3iLtlTYxRewxVfTdkY/3UP1w1sIU2NaNUqhD6lK43EroXDwQVORU/6jb2lT
	IdboBJIP0OQHAIM8x8C1Z/SOl5mWykRa33RftcMheDaqMgmUANVtdYVm6CjLaGv3hAWx/OM2Wnf
	mjpShF2jpIpGri/nlLswFKsKUyhUh7KgRTF/9nZUEtwAFWQMRSW0uf67f6qncVagUlPXSr86+fK
	G1tnJcDicheh+E9GXukGaiovn0zaU1lg2kzbTy0jGkyEtLJQFirI1b8YxwMLsng0c28x/hLZJhb
	2y0kxZBT6fLSAga0AMx2pjs7eOuxeqYliwBV19NNIMu5URjZND/nWvFpR9ySZgNYP519//OhyEp
	hqlGMAzNSmMMdGDeRgUshAATiMO27gR560QEkgMWWG6H9tqqjUQ0VxQ==
X-Google-Smtp-Source: AGHT+IHe+ImpMdm8KJIQ2B7G2MrfkpdMa0OddvZNAQb25ADlBBVkX0FGtvy21FocrUyA0zv/EtYoAA==
X-Received: by 2002:ad4:5def:0:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6f8a4c4dfc7mr44720466d6.39.1747314638137;
        Thu, 15 May 2025 06:10:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 26/49] selinux: annotate selinuxfs permission checks
Date: Thu, 15 May 2025 09:09:24 -0400
Message-ID: <20250515130947.52806-27-stephen.smalley.work@gmail.com>
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
index e92c8eb5723f..6a2580a684ff 100644
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
2.49.0

