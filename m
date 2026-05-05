Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27B38F636
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985421; cv=none; b=qjB13tUH3tPyBkloLEcdiTxqRMFyM4C5aAuslSNIxhZmPICTALqJcFqPLImDoPsBP0SNRzsp8JFNUXdGpZXtY284kCRmu44IMSUg4Ci7eMRI2NQnITFhsyzEXfYLUwQQ064Ws+C4V9sr9U/sop8fh/8HWC+VQ4SQCXp3gpJPLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985421; c=relaxed/simple;
	bh=OubP7fcXTUx4EEKrdPYLZRFPez2hpvlPK0XvI83cFeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+FxZrBQiIaH4mskKBvxyRjoCBAK7FQEdfg9tXl7PIhhDF/ReCMl4UWbWPV/flXLs6qUANEEMMeGmmK2Na9Y35XExnSNvCA639nTJIilf+dKwEotmMIGXcoiDZs64RGDrfEOwtMjDZW5yFkaXYxmHnUyqAswNARgixxNDRM6OL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orTloTfI; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orTloTfI"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b98482b253so21013876d6.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985415; x=1778590215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8x2THlMNq2PfFKqFQqCrGVHklZUEeSxd7Y/nkQLps4=;
        b=orTloTfIFf3eMGYvPzz+1tXg2vaXxhtRwi/BtXvuqT+XnxL70rULZxK0qOTDnZA99H
         ykcuVShjM17PvEqPHyGxowsrvG0CR3WgqchwnQh5SqXwCeBVrWpkOyH41mNsAuk51Sdy
         pSBsiJTD2yNq0w+tHjeOrN2EztDhzsLRcaazH0UpjqsB1c8iv9cE6Um//mFR3K5ihc0U
         /SWRczK58uV1HxYBf6h8v/aTuAKO5YcUcRRgx2RE0haRdoz2LV3vtcvXkOoDuK3GM06K
         h2xj1UCLZOdjk1dqI4piI1MnH5pi50HQce0/Wekp2I3gSV7zv3oM6X+V3Q5cZyOtrEVe
         HINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985415; x=1778590215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8x2THlMNq2PfFKqFQqCrGVHklZUEeSxd7Y/nkQLps4=;
        b=j21DsOM1Mq5+0TNZgGlQDupcoXqx4fSV0SCtchTYkCbbQu1MXz2m0KThKS6A2ylmhc
         PWmT0QoJXev+9eK4/qlgAp4A73CNazhHhOJ8NEApyQNZu76Xd1VIg5OKG4v04nrw+Mil
         FmcqbP1MXVmzh7l2/C6UJYMvpqVbYcRCHyNCh43Y64Ux4cCvi/BJw7M/EHtW9AbRYxwz
         OBuI0ChK9u1kupbX7TtqddaZ8OYhNEuzENFa6rRG+c2MrQlVZJYlKhzFTY59vDRhQmBB
         sZz6u8G1mmB9CuCiBsyZbTL/jRfqw7jQcswYqp+7qsMmc6clYo+kphxZG/DNiXk59PJc
         S6hQ==
X-Gm-Message-State: AOJu0YxwwAweapzagxhLb1BlY7cDHUaoKBkLA+S6c7+ir0BmVaZZmodT
	e+PfIZvtaQCAxRgRvkfd+vS05Y5jwySDvBmmYRBJO1RzaXBLgc6CNDHA+u2fYg==
X-Gm-Gg: AeBDiesq035xRq5SzRNGSsgfZDmrADuI12YXvfU7Lwd38+Pmuf51mev28ZW1o5U6yBO
	5aecnhH/SfLrrRd+/7n4jZkNKr7Hzr0VZ7wTsBnzxOglTIaIZWTToRUyL+HjV5sfhAoRzxOZC6S
	kqBOyfro3wrJYtakzjliGXghsKqYGFCkYg8ufrbmGhrW+m7mpdSY3l+U9A98W0UEZ8OABJTf996
	SpI4DvGS8wFBXK3SglkkX3lrr/IQACRMhsV183ekrDcy6TwX2dfkfYB6ITzYzKvxV/hrzzrxJo4
	ovtk5Gug7LmytFiW7XFNleujEpiliUd0/9kEvS4dDVj3BIvpEVzNchEBeJFGwlmnBHUxozrVLps
	D424O+q1Vi80CukcJlz0DLdl2kPtWvMuRDdCWaLhrxIYSo8DC6YrYLUbdwcECOwbHs1mj2wtck1
	D9xHau/GtI3P0Y1XA2Y8FncYMs85FgowfbpEjDDMOjMhjnzYegVBF7aicK0yyeNZ8F1A7h/mR6m
	QxOz4GMPqNp45PsMqj3OiPti4ZK8XjxwUYzptSRRiXTjFsCJrAx3Pzv1ahlGIGX6w==
X-Received: by 2002:a05:6214:3d86:b0:8ac:b258:71d1 with SMTP id 6a1803df08f44-8bad8e9fa33mr47006326d6.3.1777985415081;
        Tue, 05 May 2026 05:50:15 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm145437216d6.47.2026.05.05.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:50:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/3] selinux: prune /sys/fs/selinux/disable
Date: Tue,  5 May 2026 08:49:49 -0400
Message-ID: <20260505124949.2541-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505124949.2541-2-stephen.smalley.work@gmail.com>
References: <20260505124949.2541-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality") removed the underlying SELinux runtime disable
functionality but left everything else intact and started logging an
error message to warn any residual users.

Prune it to just log an error message once and to return count
(i.e. all bytes written successfully) to avoid breaking
userspace. This also fixes a local DoS from logspam.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 adds a pr_err_once() call as requested. Note that we do not need
to copy current->comm when using it in pr_*() calls; this is only
necessary when acting on another task (get_task_comm) or saving
for later use.

 security/selinux/selinuxfs.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e5cf6367313d..a31bb7b126d5 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -270,35 +270,13 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
-	ssize_t length;
-	int new_value;
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
-	if (sscanf(page, "%d", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
-	}
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting disable is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable
+	 */
+	pr_err_once("SELinux: %s (%d) wrote to disable. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 
 static const struct file_operations sel_disable_ops = {
-- 
2.54.0

