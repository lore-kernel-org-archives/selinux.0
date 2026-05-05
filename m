Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B934250D
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985418; cv=none; b=ZvhG4qbLrRJi5WCkACzLvbcvyzcY36VkVKBVc/xC0fEjxFV4lATAJyOG8rvHML0R0nI7wwC6pSwB25vLJeG9MeIR8fZ5dDsDgqN6IddhcWWwmj2H+4gsm24XHFxnEZhtGzkCun6InpbfxoZowyRKzo1KgJWryNtPa4357WXw7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985418; c=relaxed/simple;
	bh=/4sHn6+plR9EH2NhtheaQwmmlZ/79NZzUqwSZLvhC7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BycEEXGD4XrGi5tcyNHdruCaaftxmQgcTyq9wESPMfFjQpKSIWFEjBcAKJk6IiXoktbeZ0WDOuUF/m8NrllMzL9OQOLmtt/iXL5p+nNzj85jziei4auq+60UazevGasM2q6Ufcf8tMHOjq/S+9kJTN65zRcPuHLcG/Ydl7BqqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIecluf2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIecluf2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca4e14411so52227676d6.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985413; x=1778590213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEr3XrLymNb9u2nsyR6Lcf8q3GX8jmL63QRPoPCdpuw=;
        b=gIecluf2uY9JwD5sEXZvplfByeKFanyjRSu66EuQ7/JXpHD7tTFr1uiaDWD8okpPsz
         RLwSKVUT9gK1csWqk2+Qq2K0lXjPznCacVAg689JOE3HRrFW1qOBEzkcm2Vx86WoloG8
         MxpOek7eAGKnKeQrCxsFOJSLTDaErBbxx7dAW/NLC/8zi9Ka+V7uSLfF7pb/adzcpTbe
         0Bba4RcxmWKTdAnWy5qNGo+J91rO9CSxjTdJCr4JiuXxERw9HZ/w21DHyIsOSGu9+g4v
         Jn/xEMKYqWQFAGUfBzXBen1uKlkp5p2fzXQ5N4tx7pw8yy0/T1TzD696J8eUIVjYe4CR
         585w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985413; x=1778590213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEr3XrLymNb9u2nsyR6Lcf8q3GX8jmL63QRPoPCdpuw=;
        b=Cg+bE7ySvvC+7GzRQGcQ9Uk+tvyjQxkREe3VZAkhfGTG/9AwEI9bNkhLZYsskip8VB
         pMccl8RcCJqj997eiJuIAvsgvLyy1YmaPkxy+Rnr6mcfYmNbiHH2TLevDK/aOyiM+CHu
         jP49d3fJCocIvktZXaWxs3YkcEJ0QaskRud/e1NO2eMxBLYgdQ3OsXRF0Xu7qwlBFfpI
         MkF/wX+MYp0J1MWreW2bYhvvChW8E33dM918CPZCntaIuZL51lSmDUvtQnvqG4iwagBD
         i8DVq418SKYlvWPDH3uR0YAMgAZuXZZZ9YRRxlHgv5y8RVsOHMTLx9sjD7STZG8nLS5i
         SrCQ==
X-Gm-Message-State: AOJu0YwF30QISbj28OFkolssxyCC3xbS5RE/e+QxauAYML9RdjzOXa64
	BCedBlR/qVY6fSfiCsZX+4YB020aLZ5ZbAGUEwjXhrMlugl90x1BWgXUEzB1XA==
X-Gm-Gg: AeBDieto0KP6FUq7XVyf83JGofpmYeYli6pWVUQSiHEc8/z058R+Ri7NoFjhtUiV3vy
	pQihuNqEf9ZYHp4R/cG2nKp969qqDNVL3xaOBO1U4BEHBHx/OIWDgecAeFsrh5Q49lfeaxQCkVu
	tRdrDPzNOKqUy8HO8pJ64vtbmwrhiMR9ri9as4sOQ8UJWkhjbx8bgloEt4oVf1jfMR6Q+rnYa5B
	1pp9IpREoYsMtApJ449PHL6vbG8fK47QtA5jWIBerYdZc/tiUzRaYsa+pEvYhD3kYcp071pbNlL
	F+5DihjEMT6E2QDlfA3K7d2kwDcVv3mJe1QDlKv+G6nnzxC3nbNBXV1QBM2xpXUpmLfbURoZaPz
	iQ84m3RnOfbiLxTPwWf7j5fxdzonCxveRCJ63ZOy1hvnZ6t1T2rKwLrnQ1VcM40LbuTZmS4yMYj
	QLBLqKQZQR7GISKNLiM/htmAwlBtkaqvTb/J6wpo2A/c08xFdr3BxQR4S1pMETtpaydqXlPE8xm
	GiY5mOcWLO7MmBF3zO5bJCqASy+RTHEkeayPaZzA2upToaP/LwDH8Yao77mxvkntA==
X-Received: by 2002:a0c:e001:0:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8b6665f1489mr200196826d6.15.1777985413091;
        Tue, 05 May 2026 05:50:13 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm145437216d6.47.2026.05.05.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:50:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/3] selinux: prune /sys/fs/selinux/checkreqprot
Date: Tue,  5 May 2026 08:49:48 -0400
Message-ID: <20260505124949.2541-3-stephen.smalley.work@gmail.com>
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

commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
functionality") removed the ability to modify the checkreqprot setting
but left everything except the updating of the checkreqprot value
intact. Aside from unnecessary processing, this could produce a local
DoS from log spam and incorrectly calls selinux_ima_measure_state() on
each write even though no state has changed. Prune it to just log an
error message once and return count (i.e. all bytes written
successfully) so that userspace never breaks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 adds a pr_err_once() call as requested. Note that we do not need
to copy current->comm when using it in pr_*() calls; this is only
necessary when acting on another task (get_task_comm) or saving
for later use.

 security/selinux/selinuxfs.c | 47 ++++++------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..e5cf6367313d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -687,46 +687,13 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
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
+	pr_err_once("SELinux: %s (%d) wrote to checkreqprot. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 static const struct file_operations sel_checkreqprot_ops = {
 	.read		= sel_read_checkreqprot,
-- 
2.54.0

