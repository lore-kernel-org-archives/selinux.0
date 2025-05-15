Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012A299AAB
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314655; cv=none; b=f9HopNW7jmYgiuQ4KMjg2Y/5D5Zd3AAN057vRC0crPidqgv0d+i5nHuO+ki+yaUx8utMe/gazDCkzR25SjG1S86kIMf4z5QOu4nGQWe0mYxy8RdQMrVclqMBYVNp7SQc66Z1DMH4Y78oBqsBnJCPcYp3UQdWG6X6D0Oum8hq0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314655; c=relaxed/simple;
	bh=G1itJxs0C7Xsmy7qSH7fq6q4gCfWMA2H+0s+SbIddIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRRt+t2smogYv0UmuRnAUjZRwA1Sh3fzJ3mSfxcdwVQtG66VnrCjXBSRqsknnGwCdUL0aamsGASZB4cWhdd68qCRI6GBb+GGItxvedFCp4A4vBwQPfCKu9LrUiZwCB28HHL/db/qHaO3jKLQbf/+4l3+OMcCsdgZGxTI9t1kERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdmyioTp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdmyioTp"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f54079e54bso8223896d6.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314652; x=1747919452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R9UOAjmiJ4D2mz7IJ6UaAdqWhjplQ8GTQXHOfrwUno=;
        b=SdmyioTpAWOq+r9UouZer2jKSNrl1qHGGJJhSeOpq/Lvz8T99439h1ILf5OneRmQ+Q
         1Zop3gRHF7Rigj2G69qMjogOUVQGA6vxxrnse7f3LJNa6xEJnga4N0QjcTOFRau9fkGn
         lSCINDlac9qMk3kMqFF4O4C78yBhsa9GC7PMq1ERH/UiGfy+yuozEwKf+UGFQxlW+Jmk
         UXB02wv/23SiUXGfFzzfaJy/wgjClrUUwHzFIl8FDcqyNBDKdcA5OPezqCWkWayw+HMm
         BQn2DuUvUv/XEc9OO0mLGvfkvCF6vaipUUwjC+CORx+gLgZhFNDZ6dfgaw/2wEqrP1il
         MLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314652; x=1747919452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R9UOAjmiJ4D2mz7IJ6UaAdqWhjplQ8GTQXHOfrwUno=;
        b=CrGzxyveVcllf2HQxnO1YscupvkNZF6TYrvqrgIx2+095Y4eykvcPhossKl34XYxk/
         qlF6kEnmzRgTXZM7B+X1rpZnaM1lFSDJnCE4iVtVQyYS6HyVT4byykljAr4QIC44PmyL
         hHK8fQW0oRJxqQ4VeMj/DOJSREAgoXkrxyAhhW0NgCB7HJI4DxIXssXPVm6+5ARjYzji
         6hvMaJwpcvz1pBU0fYMFxQ8ZSHuEIgj3b15Icgeo4yVaItq0t5NNJ+mb9u08TSrfFZGW
         MI25zOBTEkGDj1JOo1npQaXdYl7mucboFU9rafeXIcozJrDpUSQfPKs5dQexdh7eYKwB
         MCwQ==
X-Gm-Message-State: AOJu0YxhoNp0s8LHUZNTr4D2GW5LzVrq14Zm75XTzJrIrATJGAMxcWuy
	A0jS0dLoU4jj3GDSHQP4yzqeOyKiA4YFzsh9yqdNT21P06bEeR8wIBe/Ig==
X-Gm-Gg: ASbGnct0qziSnOJn1SW0CxXjYYveJd5yVgS3UHWku7mLeXnwJqpbA2E23+JGoKX3ilH
	P20R9y6kl8sGYa+iyVOEyOptg20jt6/x4jN8hoXm+EBhd6sA02b8B+Zkw0Ozj3w72CUW7q+n+Qk
	0B8bZ5C1Ytjs627vXVpJKYBLrVNQ7V2USLDOtXz1KCkEp0pSqGxOkgf0v2PyR1SLIHHINt+Hwxy
	jXTJ12RUjOfEEIE3MflKLQf5W21fW6HgHjgNgSFJr9AJOp9ZcfAGo/juU6/rAmijItT8Ks2TJmO
	ikGjM1kFA/gQG/BxrhlqsT9pKYgCqlSVCp4D3HNFufbykERieENLbLzfX6s7fivfGoC64h6OWFQ
	4qbY5VgGPieUXeKNq0qbmBUDifJ6sJk0BVDixQtiwNAgN//xaLMB9UukhSithlL20
X-Google-Smtp-Source: AGHT+IFfrj10QmQ/qfDa/v3tf//q00kya5vLazEC7FIJ0J970SKavs3QDj159HoM85NaZZcAcZxzHw==
X-Received: by 2002:a05:622a:229d:b0:476:b02d:2b4a with SMTP id d75a77b69052e-49495ce6194mr134335051cf.27.1747314652093;
        Thu, 15 May 2025 06:10:52 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 45/49] selinux: change /sys/fs/selinux/unshare to check current process state
Date: Thu, 15 May 2025 09:09:43 -0400
Message-ID: <20250515130947.52806-46-stephen.smalley.work@gmail.com>
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

Previously reads of /sys/fs/selinux/unshare would return "1" if the
selinuxfs instance was associated with a non-init SELinux namespace,
which could be confusing for userspace prior to unmounting the old
selinuxfs and mounting the new one. Instead return "1" if the current
process has a non-init SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 2ddcaea0394c..d165379271f9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -335,10 +335,10 @@ static const struct file_operations sel_disable_ops = {
 static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	char tmpbuf[1];
 
-	if (fsi->state == init_selinux_state)
+	if (tsec->state == init_selinux_state)
 		tmpbuf[0] = '0';
 	else
 		tmpbuf[0] = '1';
-- 
2.49.0

