Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89B3090EB;
	Thu, 14 Aug 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178061; cv=none; b=OmMOlpOHVowSPWpZC4AX1GMnD87PTdelflhtiYxZMRTllFWfRr10Bv/bL3aZp5Gy5XA74GlKcp5RhEEChX/HhGBGaoVBC9BUCewzoJdN4KhQRdzhfQR0GdqW6d1/lzffBTBbV0IJhQl1PCmezWUbezLIj6rrYxNec573Mbwmf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178061; c=relaxed/simple;
	bh=b6lC4ZSVXYJBSXWp8PVJkxW58MFM6DlbxSmvqDbSojc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnCqWd7Kc8iQlif6VTT67wo+JoK2x/y9jALzzPvdm1hP8fC2xUoSoUw+xKPUnC0FMyH5OkkfH6k6uot3rujLQoBATl6r3T93y8sWD1yx8gWPvyO/MHsKIfZatkuYNJZsIXwzz4jU5xxsTHPpbhKIZ2+cZA/63Vzbn5qYsixykIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEdqg1Yd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEdqg1Yd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e87055e1b6so123653685a.1;
        Thu, 14 Aug 2025 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178058; x=1755782858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29A7/5VAiM4GENNkvHC0nxXXa/DMb3GN/z+XG3NOojE=;
        b=KEdqg1YdXScoGZCH3vK5ONjIOoZCxvAzgIDArAuB76FYhkr3z8sydcXxo7TvyPmMjm
         jEuvH340HURkI2C1vrIxSC1GinCM23YXluyrQWOYsi7/j64Qk+oLRGsbWlJQkZuAvx1g
         4Mjbhjhd5vpz6dualzXGOu7CehBdB2R3fT7PIv5cK1HD44aTbSioBMXinK+B3yASVdfi
         nJ+DpLCq5ctF4DO+52Rg0tN8eI2PUAikbDmVGXK7DGDOoV2H4cmuPRnrzQl5+J623W1L
         Vp7DIGtSf/jQTjM8ihvgp6QBwpkvr3TS3lVYW7/HrtroUJXCVmvxestkqOGYHy4QOIKU
         PIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178058; x=1755782858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29A7/5VAiM4GENNkvHC0nxXXa/DMb3GN/z+XG3NOojE=;
        b=d3mFKtzRLZcvz4y7uYfxRvN9UspcFYHwO1SF9+ghN4hlxaasZVhAz2qImO5Slceqok
         7p9cG1YzigqBIR1+Ivk7vtlWgt5c6oDtK8vl0R6GinXF4OgOZRSpV141dd4LY49gZWPA
         4dbN7eUhCn/wYXaZpBhlkqer91EP3LQtsYswlIDGpYHE8grRFCsOteedMsqu/c0qsiHW
         9DcPe2pgkCKgnWPSHAdFdRwEzAG7X2QnQekORPU9suv4YpU1yB5laIFDwW9+6lUFA6cG
         8g0483PgSrtTZAz7sDJOrEtMBLMMl+0m4Hatd+2a2yATUHr16sEwK3WqKwwbTlcognjx
         XXAw==
X-Forwarded-Encrypted: i=1; AJvYcCXUPnxNHKk1AN8tfOWqHC3DX2BnVtdPMFhbSQ+ugQdQ+/L/e3LlxM2PYi1Hz4VbE2mEjlROijU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMLcGxUyyYmzOaEAORqBrk4jD9Lk0K9loBC5EgFD3BtfwKdkc
	BpqbbXCQhxc8xkbyd7x9Mfl8lpt4173zS/9Drej8UO0g2Gmq/RwdQfIotrZBCQ==
X-Gm-Gg: ASbGnct0uHeVK134hc7Gv7a24+GYsx4pehbYcXglWqUtUeNjZa5anycmvynlxJRQqRj
	9WcMmt9ERzl5jbg2BEvNqVv3cXuMp4QFqZGbAgcNxPWvqDWxm0acv2qPDgSqgoQwBW+bNdeEJHY
	qnKN7iZi58kJ8tNGqf9NdGj2YTdKl57KyAwA8TcpxFinyIRyBgMOdSePw/agolOQ/0atdm74Env
	NWJMTbwY8aVZfs3Xg3YDlMEA7Eu7jxrAV7mlu8O81DSOeLIoTTaxwuXALdY6sfZOkvUFLLurwnx
	W7J6eROARKVLFYtimcSoKmJO4saH/bnSKfp7a1rim/EPh/4EwzROFpDV/mbVmAkjSsmFYhV1Mjd
	mFb+TD44QRE3Cb5qQ86UgXb4nu3MBU2/Ti6VHai/WdnhwCSOKTaMxyDR6vw2Ev796G0sKH9FI1D
	AodL2Jjbz/VezZLeYUpV+ZEZkAtQ==
X-Google-Smtp-Source: AGHT+IHq9MNLDGGUsMzyQheCVcx8ogSK9KhDhseDZrMGhouTj/aVyB+i8uoNhUwj7l36T5T1vanTuw==
X-Received: by 2002:a05:620a:2954:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e870290994mr443410185a.9.1755178057575;
        Thu, 14 Aug 2025 06:27:37 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 35/42] selinux: annotate selinuxfs permission checks
Date: Thu, 14 Aug 2025 09:26:26 -0400
Message-ID: <20250814132637.1659-36-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index be78b71b7fcd..b1ce3a98a241 100644
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
2.50.1

