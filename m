Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065F2ECEB6;
	Tue, 17 Jun 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169210; cv=none; b=s5g83w/BoTAFoEE5EH3CjHjHsBvg2aDXsaONAv9DiF9LUxxCz/zzP/t1rLNckEkBd2f+uikb5zfb+6GRvDHRrwJ4b9/KrayQ/YsGGnE5oDIZCG3vokhK3d811ZY6BGe9RQrhxgaynHCVeQlLdNu3A6BQopyEIV/AFjawmuihI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169210; c=relaxed/simple;
	bh=O9NR5xFDFJ8EhTXrbHp7LJCP0HFWFTKKVmYJbDfrhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI+VRvmu622VKkikl2/Qnl0XoHyWDC4bg3EdMc5uKIH3mXk3aBTmDT9WgIlASR8qdYhCsMhZccOlwOHFgaHz0mhcthwPqYA3hp36L63M8iUz1WkFW9/ApH0tDF8WyFb+pxM9e0Rq+15tSLRcwtf2x6wxLgEtDkxdbPQ0+spWF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk++F8Kg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk++F8Kg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3939ecb7dso598408785a.3;
        Tue, 17 Jun 2025 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169208; x=1750774008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=Yk++F8KgR6bWioAOSK6IqcuHGKRNYLRr1DTp0yujTZpGEhdnSaw4skQzzj3KSwL0mh
         kwO16C2uc307vU490SieCvw8pH3HVhFs4nVp59ZoZ9gsdCErq59GZlJBG5tUA+0QUolC
         IDVreYJE4RVKqiqOVSA7IR0obw94SoYj5j8/PL4Lf4bin5mElLUtAIz5AeacZgWYf6m9
         iT88rDrIw7wz8nnYdlN2IE1dOSA70fNwlHRdgkVfJpLF43nvjZo+VJ/RLbqjZZw/Glk+
         zMw/PBafqFZPFQsmeHPBebXSkR6NGUpCWhpbgPKVLXyNjv4oAXh7C0VuVgsXjOUk9waR
         W5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169208; x=1750774008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=VC05IHbr5+wMR+PEfp6Rkk9pWnPZGs0sXZjVSGn7Au3bpaVL+KVyvptTqyzCvBWNJS
         UY/uqt2lswVm70HbuGxAKQRpcuHzID1arBmEDrdYE+v2hOLIQvIGYr6Be0YTjY9bFiLn
         Mpq0HNBMx669Cc00pAQu89G57AREWJRmoUFAx9k11psfibnvfi/h5DNWRD58TRmt1Qnl
         lb1TUxiog0Ztysh3dgHwFm/GhyTaInRV99wY+hRlwpQtzsxTFXchUhH7x2a1njk9S+/T
         ulw7ClaYmd95CLbuz0yV0+fcwl3ZrqWxsgjPVJvb7YAKNl4Ldgq/bL0jwaZGvMzUQsMk
         ZsZw==
X-Forwarded-Encrypted: i=1; AJvYcCWqdOxiLqDIV4stnF2gVLMQ7uF/RM+v/lKq8UPLWoPY5TUs2bLAjitpK9iDMyeQ0/oYqKK0Il0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXgakWvNqgswrr3cOi3l4lvIAa8bHrvA8dEFEYFkO2jJt6KwX
	aASl4f9hiF1iF3smkS5kdOPwytnRKz5zuZGRiFUBYsRCQaZ9Su69ngqk0qz7xA==
X-Gm-Gg: ASbGncvMCryD+50UdezKaXUaWJnb47MXUTOYhawDULp+7oJkG1sUSMt3RdIeqN3XiWE
	Rj6hQD1sWqH6MJzMGqhjrEOXV31vXXoldDoN522GOVRWvz5e6O5/1B5bow9UZnn9k8tWGL8ctJA
	O2uy5x1jmtHoFqMSaGuIXjDR0NfppOYQr7C3Nd1K/RGYacs5ALHvktSWMTUZ8TPfCL10z2NLyLl
	NVx8LvmBqQ1Yhr6S+SX1opSYvfEpPO/JJCgQateiBVZE5NKhqHmagjaegHE/Cy1RT1m7B9kgHgb
	AZMd4MkINS4MySk4vTg1FfbXpNd2lXNniGq+KMXjX2rotUgEnuWm4tiuvgYM+NZ3mN9yknG4P2g
	BimYzB7u3KvKf1I2BSJdd7FjOd4E4gKssrJ+QAmu/d1WMd4Evxkra5MryAfwIEtz2kTu2z8EzZx
	hC
X-Google-Smtp-Source: AGHT+IEDW2igc7/zmbsq+cc8AkCDgQkNR2XjNTSpqMqytcNV2rfLVhRe2L718eHZgMPcI0rXusDfcw==
X-Received: by 2002:a05:620a:2456:b0:7d0:96e8:4791 with SMTP id af79cd13be357-7d3c6ce1498mr1606024585a.28.1750169207752;
        Tue, 17 Jun 2025 07:06:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 35/42] selinux: annotate selinuxfs permission checks
Date: Tue, 17 Jun 2025 10:05:22 -0400
Message-ID: <20250617140531.2036-36-stephen.smalley.work@gmail.com>
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

