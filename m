Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE793ACA4B
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497182; cv=none; b=u1sMvdhh5MV7lfKmGO1dpR7xVK1++syE40Uqjxyt22ooU10DJVqOl573+HtXWIydJP5FSLl/TQDfzxCBzg/p5ns4Iqc3BKdiQGbOOH1B2A8vAjl/X2mu+N9CAILfFkveGRZaMer/3SKQgm5NhsIoF47FmIz0q9gFtY13qUcYei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497182; c=relaxed/simple;
	bh=IlNVBWZYmtwtvRvapB6vurdpvCpuOBcfKLIXvYDTpD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEiEo/R3BTeW6gfaWwGhes7tVOms9LdofcPRvCO/+URT9q7mXFwx99inTkqthBAIW3G9Hug3im47OwXiUwkU8DIUYnC+vs6K846aRVtdAU9L60k7y1lniDZYR50DIyazKUThAa7ER4mc1uynJKuKY8A00lpmCwOMn6qrVLOYBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE8DqZ4d; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE8DqZ4d"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8eab809593cso22655785a.3
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497179; x=1778101979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBet7G/t4Q846QOv3D7+HJ/IDS/SDqGIJzvvOB62rHU=;
        b=mE8DqZ4dJ54ZFy50lyjO/vMTSyPPpfDD39/H2oHmBgoMsaWrTT+ILY4Jczz6nSC9QG
         7Wo4sS/m71PtkAOBYmbOIXQcICuoBgA04RvTDM/GW6I3XsUww6ALow7UQzur3mhbLpxf
         D/Xoq4OVn4bZu/XJzJ5L2ysRynx5HxbGEG0qAmgHQ6dJ4wb69PxEmd9F40SMAwbUPPzb
         Gz3P5TC18mpvBdTyGkWLFhrYMIMLXRPV/Moa7mjEOa37qcF0pVD4MJvOUSDDj39Af/pC
         4Qj6qyTvY6Bpe8HBkOwnIroysXGpwU7//UO4PtWTvKzcyddHD0w2QITbaQpgCf3+AHSs
         5wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497179; x=1778101979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBet7G/t4Q846QOv3D7+HJ/IDS/SDqGIJzvvOB62rHU=;
        b=l/nWcVBc7XlommSoDYrIRShWzMwcXr4g/64NXA/CqAihftZyg2fFkQBX9gZvlQcTah
         wZ56sp/MK5na7nylAQVbdImDSfY0qdJbkLVHNBvhW7G1b8Vxp6GnB9as5beC121NVDFI
         5eOnhBy6bpZr3yKguIieYsnVqrjbY3IC+cMwtMcfLgYtPJNOi4jLelz1uwB9zBTnNHkC
         wfVrmTFbND68FuSF4C09Q+ejw+qStaXJBaoRXeSycwBgFgYKtgkC8Etq26ExRpp6sJeL
         +/JK9OtAO31gu29bBTf4m2B5hLp5nFI4aMPr2evYDTihaBLp3h4GlmV82rWWnEtu2dAZ
         n0pQ==
X-Gm-Message-State: AOJu0Yw8iFPggjk5IpQrYCh2ZQ6gY+UwFO+MUlJHZyqDp75k8RPrEcIs
	v958YO2P246pJd9fmqs+WaN2vZRINPMs/R+huNOnA8ExbtioyfBkm/wCyIoOsA==
X-Gm-Gg: AeBDietTUtqXSNTD3H0j+gDJMpkGaKPLmcGrXoQQ8D1Ku/qW7oMEcGhcSkqKmj+0MKB
	1CNHadMcZdfB/gItiwA2hNfMJXIwTn7xNn/ghqqTJJxsLLDw5gckB48U4A7POx3ckqqzRIp3nI4
	sdN3HtZRjJn0dOMeCKjEqdeDY27TzifNUcye/8Gp6kFXwZaSr1Hl6GmsJ/5dYbhpJhzReUrP+Fy
	b15kcVUAzzJBO2nD121CbGLdJY4CFUhRKes+XGcq6WEjDntnJ83eH0yXr7wfj9/h/J7epmiDA4z
	C8Sq+ZYl+6aBVjLp+TlKiJ7KxU/Sk8dNydCwAfsmeor3/wVI9Z2nZMvvEJCrgZiq+2SETl8g7lT
	vrdW/M2Qhvk3zSHNyGQBvR2UzqrFsAh8JduxHUs10OFssXLGCr9umFRlEW4FbSpxK0OaJ9vvV7r
	q5Bk3l7Gla11y6jdqdgXOJW3+3xmz0sv381Hm4hXoiGM0GgZMEPhg0AnM7bjQGRYdEDk96uzAfr
	GLBM+Ktl9QxQbC71Y/OLxDIs7nYQFLqITfRPM94dHHZ4rRT/kBBJBvkIkNspvzf7A==
X-Received: by 2002:a05:620a:2844:b0:8cf:d441:c7bd with SMTP id af79cd13be357-8fa88942a66mr71397385a.38.1777497178594;
        Wed, 29 Apr 2026 14:12:58 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93cff8e85sm280355885a.17.2026.04.29.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:12:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] selinux: prune /sys/fs/selinux/checkreqprot
Date: Wed, 29 Apr 2026 17:12:27 -0400
Message-ID: <20260429211229.3750-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
functionality") removed the ability to modify the checkreqprot setting
but left everything except the updating of the checkreqprot value
intact. Aside from unnecessary processing, this could produce a local
DoS from log spam and incorrectly calls selinux_ima_measure_state() on
each write even though no state has changed. Prune it to just return
count (i.e. all bytes written successfully) so that userspace never
breaks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 45 ++++--------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8c107af5140e..71ffa64b15a6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -689,46 +689,11 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	char *page;
-	ssize_t length;
-	unsigned int new_value;
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
-			      NULL);
-	if (length)
-		return length;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%u", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		char comm[sizeof(current->comm)];
-
-		strscpy(comm, current->comm);
-		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
-		       comm, current->pid);
-	}
-
-	selinux_ima_measure_state();
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting checkreqprot is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot
+	 */
+	return count;
 }
 static const struct file_operations sel_checkreqprot_ops = {
 	.read		= sel_read_checkreqprot,
-- 
2.54.0

