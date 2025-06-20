Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DC2EAB83;
	Fri, 20 Jun 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441550; cv=none; b=F3t23e5Hjwoifu/wolAuMU9uDLxNo3dKAlZSLYlz7bE5tuZpuibBllB8fat17azzmmi6Fg/J7Hhvth0OkZFHeVqTFErOzvYDF7CCQNWqQ+855Is0E/vQMVQJBolyE/u9w8YMM/nB4+qcA7J8dawwwOFCDTTG6zhJf4iZJIyFHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441550; c=relaxed/simple;
	bh=O9NR5xFDFJ8EhTXrbHp7LJCP0HFWFTKKVmYJbDfrhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duAUJN18Annn78Kcpvmjom3W04vseioVurivn0zsZgLDHXeddPcw2VSJk4h4xLPQq0ZI1an6DA26SmJmqsRiR9gfsXEZW7YknnOewNu46RIgU1ndZSKxnkMfiCHYgzuzCeQFNNGoZhvJq78Men7OpxxOKOO+hdqGUvkMXmWm5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8mnFWM5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8mnFWM5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a56cc0def0so34400231cf.3;
        Fri, 20 Jun 2025 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441547; x=1751046347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=M8mnFWM5wXDZQlYRY6daFeWEAXkIeSmNftOPp8sut65d4seQ0yXKzeiXE3ba9ZJnmt
         mTkOFFgDoL+D0AZvjrLjDiY3ykPAPnDCIXCuAC9ii9JUWomDVzF6xB6uIgKRGUS8IxLC
         P3Nip7GLxbamvKefL5JIj7sb0GBjzzRIaKW91JxVqXH1pmv+a/dmc316dmP7CVEIbGR+
         OQ/mCsVR12sxlSslKgLczz0gTRNEVFhiLhzt3noiCAe2JVjztxMLavCsJH9GKVE/cf2e
         UcUaWWyzcpubWpA5kufOxeUTKF3wdyZjAyZ3mye6qLK9ejJbvSpc2uczl1BLO7bF3RzW
         Oyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441547; x=1751046347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQDqI/GPdq+jEBhqLZbfBSlM3E5Zxx5nLl38nTqsDP8=;
        b=GKxh0tkDS+KOOvCwLJFbXahzbak9SVY9E8i1x0afP8vH/Cub6B7Yb3xqEAKYph8p4s
         ruoCV2SQerA4j+ERGZeOSxdGDVgX07A4OAuZ8qIMSD9SYjiI9PoVjYVQtWVedXowhWlR
         aBXFyo73vTo31SbgMzf2ivGaFrEnD+qwa7BJvr8qOS7Q+HQwrj5nhGi6OqwLulqGGW+3
         Fn8AI5Oy6bDZUFQQwMEJFbVrVnhsFlmIKBYNxd9hDHF8ZezvH2CdYLLkVSGdG4YZmWjv
         1BfFt0fVbMD3UvlaCDjeNdc7w5f4LWTSR0uH79E5+AYDAKY6df97GDqabLa5A9OfpnzG
         Bq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKyMUm4TprOKXU/TuRumV4ISYG6j91SPp8bRJzlx9JL7W0HHOF9rqANqTFwzS5syDH6ZDIKm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLrIW4TXUMt1P1LZhfw/tLOk0Er4sqQA8snSzA8hJ6g2tcRQL
	v4NM7P5pJGEymVBp11mv+7IUvp+dSy90u+esZmirwHAu2opweBPn/BU+tRq3rg==
X-Gm-Gg: ASbGncspnQzxkSK6ftO+XVvwiyF/WoUiqn5IYgKFtldyae5h6cN6epxo1/cZabTW4xi
	1PWlX2ZMNG4xA//vJ80g0QfMo3wZvUS85d4zrqSSxWiXgt/M8i426f7+tWHQIBVenENIQxEM+Pe
	vJK+oRYvFQl/1I8Jq/UQl30I+4gqahTDCLxWilkzVGk7SfjSfoL7GcjGRNkIkTnhvn3x58p3nFF
	3643rqFgVBGP/XKvLxesP/9VsL3JbNLmi8oM4MtlVci/ctoGlAkgTFErYUymoqzknWsxJ+gcXMf
	kB2Ijizq/6RZwD1uCj0gQa8ncTKlubkBJzfIpZL6lPCfsA+MIasC2YC8+UFUzmc82bL7IF6fv1A
	htUErfZ9QRIpKVo9YpT2KwYjJCmlNzmNSbjmd8mMzGv/uiMnOLLpibeSM64mnrs5mxA==
X-Google-Smtp-Source: AGHT+IEgJ0A2qJiv8VdVWnfDXQGBLcwyLZBbR+ULo8ERGI0IVe8Xb7ag8D5w2Nvoxol9ofI5/IRrLA==
X-Received: by 2002:a05:620a:2791:b0:7d3:f1ff:5bac with SMTP id af79cd13be357-7d3f9932a9amr578114785a.27.1750441546779;
        Fri, 20 Jun 2025 10:45:46 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 35/42] selinux: annotate selinuxfs permission checks
Date: Fri, 20 Jun 2025 13:44:47 -0400
Message-ID: <20250620174502.1838-36-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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

