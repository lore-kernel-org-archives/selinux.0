Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69637287505;
	Tue, 20 May 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742505; cv=none; b=JTy80hkxas44Vpn6Zokew0Vt8j6vPUHKtk81C/MSFn5sHng/FG6jqkxJX3KdpMbCvZCpYXli0R5MOZxNwgtKzTMFtxmgcRhywP6az+W8A/LuZXgft7Nr6qFP0mQixxW4sdrDveNvA3gYLILSDLxkBzxIDlqTSlIXtHjdrktNJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742505; c=relaxed/simple;
	bh=l1Gsx8s/mFR+N16ugIxt220yd0xgYZ4lg59Qqnfj2ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDG7UwmPLN4va+PyWR96B70TW/IXaIyIW7e1cSvGmG64HKhWMny9xCxF0PewZVkG4/6nn9KFpGmzJw9dp8i6x4fCWCPZSM3LSRogLXh0gCiyQvjonGtqJn2MqhGJq50rPm11+tAaErvTez/azbD0nKjVAUHvsmFQxpZ+ObrykT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwLsoCrh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwLsoCrh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7caea4bc9e9so901672885a.1;
        Tue, 20 May 2025 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742502; x=1748347302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPhLOQJtk3OHKIPwPtPojvJhdEU7fxREThByJqpUXPs=;
        b=hwLsoCrhrlzVaBHw+UpOfElal48STt4tz9tGngZ33HuodxpjFsw4P9cO6dAhdpNzhi
         4rqBDq97e9UfRrAGRldj0LUPMpR8XX+W/Vn3KBwCLt98VsXSBrLWXGHm6jOk3RGrdjka
         fY8zNYiFwnN0Xpg3bhG4fHA3GopRtqXOR2W+JlU+vDG94e4Jg90DkJXm7dZ7AZptEMfE
         Qqv9TgOk/0Gb1QsiC4HddibTTCB7qAGE3JoMug0MNBUBofnhBw+YaibmFgrwxSm6FApU
         luM/Llm/6q+HJA6Ey1Np1Q2zz99LQtCRNIZ8bBwaBTC0xsHC+022ZjFCrTz3LtKnWMp1
         bvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742502; x=1748347302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPhLOQJtk3OHKIPwPtPojvJhdEU7fxREThByJqpUXPs=;
        b=k5zdVOU2SQd2rh6CdMdNqV9Y13LuK4vIiRt1y7in+1DjKIvx8WJY8lNCDruczSPXzu
         IyBaRis8gMTanzWX2D+FudTTIa7yutO22NCHpXxvnFCCo8YeHKYzJwgeVAgObc8dk5US
         SU8JriI0B2YunZiBcdnPiccjddy+TiwMUCrKK1W6RA0I0lRSS1UvBJolmawCJ84eBQat
         FeeXE7BulEzLQ8kxZyHOEu5TeIELk9CN97GNg8D1t3qvpx6AoFdPyZotiQXyN5FuVRMK
         EUo2Oh6sKyWsfoghhKCZ/8PY3cTQN5KgUSEJWH7NNuMOUiM3pqTbDETuSfdTxReGud0H
         qMow==
X-Forwarded-Encrypted: i=1; AJvYcCVHNmnzw1od5UYSAaiuJzCmHEe91X1AlXGQNcB1/XNgcnyIQKx6LaiET4FO1PcngoTsRDeUxVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYV0Z8SPdTbWssRjXa3oazMlYBeUSi2+voaHviuTLnuEnqgeS
	MnPZAUeQYPOQTZ+Odh1xr8BYIwIV/aoB/UnpuDUXLLm+72KH2GbeJiRoXO9VBw==
X-Gm-Gg: ASbGncvrJy2M0l8ae24ekzvat9o+JgETE+b84JHpDqcufowjRA0Fl4UOLQ/7DJFnhvX
	CwQzvwv7Io50BhoN0mAKs+eGnCCYicwZW73LebX3QDrblSbcdZ6KeCjTPaGyv84gKmo23PuzmAA
	ExNJiLEaz5C1d9MF7MGf2nJULgWkfSvJczCN5dkb7/FKx5bl4uZt2nNQ9sEMvAYToYFfjL9zzh2
	fRflgxSW565V8F7E2pbi2Rw5pKQP9swNuryE+UM16Oq5270Vs9IMtINbnWLahDHQ3cHhVc28IcR
	qZ3LnzOEnZ6RxIao2H4+vxV+QVSP0VsElbw3OPu4/RyUKH/C7vTH4TiYq1mOV91eKLhkdSXpMES
	H47AfRBJPDiWQWFeGCGhdNSsthh6rm1gxoRH/TSqiCIJuqRwhU3TdeJ5CSInnCO4k
X-Google-Smtp-Source: AGHT+IGsWxCHBOd6HQ7Sj2H4NmDczIfO/AW/9h52yafCtyASsaoyGU3szK3+UyCeMcD2OmKLJaPtfw==
X-Received: by 2002:a05:620a:394b:b0:7c5:6a66:5c1e with SMTP id af79cd13be357-7cd47fda7f9mr2137708185a.58.1747742501712;
        Tue, 20 May 2025 05:01:41 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 34/42] selinux: annotate selinuxfs permission checks
Date: Tue, 20 May 2025 07:59:32 -0400
Message-ID: <20250520120000.25501-36-stephen.smalley.work@gmail.com>
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
index 1651354dfa23..8dde8f865dda 100644
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
@@ -1330,6 +1375,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		" This will not be supported in the future; please update your"
 		" userspace.\n", current->comm, current->pid);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1395,6 +1444,10 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
@@ -1526,6 +1579,10 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1585,6 +1642,10 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->state->policy_mutex);
 
+	/*
+	 * Only check against the current namespace because
+	 * this operation only affects it and no others.
+	 */
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1706,6 +1767,10 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
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

