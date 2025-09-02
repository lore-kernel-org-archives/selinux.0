Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDC2DD608
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818794; cv=none; b=Lsij4dGlMJDdt86UNdnrWAWryeqBvliuC/UQY9aaNhihChiS4jUkoOK2mFDKEq2p6YfQ7QbLdkdEE7LCwoiQjj1Tm6bnpbS71vHrZeuODs6ND3cAud3IYOO0mtkmYpDZad5RI+l3aSNYEJGRS0C0FPH8dWqhDFaj6eR9HKuS5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818794; c=relaxed/simple;
	bh=/P0fn2jqvRWaOatTEpPvVFS3FIGlcANEmo+nxCJPzd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVgCrF+rUTYh9iM3WlwBc4q8ldQC1wVPID6bR1PB8X3ojakCZX2nVprrYfl5KceL3NpiF8uEpS6eEiWabwsMXwV5/B3kgDPJGuOcX5x0AC5g0TuC9coWvPXlyNqVMFgVwcyowNLx3HhsijkoLpq1O+LzuHGqIxpLR/1za5FkYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ5ZIEcw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ5ZIEcw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b33945989bso29733291cf.2
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818790; x=1757423590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgtN0YfVxpl/kl53lVF3hZ78e5x/MECopDk+aVJVJg0=;
        b=aQ5ZIEcwIXqDrgP/mMBDki+f+jXlpl0vRzUbHjOWv77yYziz1MXBKQwmEnUZ/McVpg
         CqdnpLD4lulCSDIOzjO1HXvEFqBamNra1DivfVfqJ22W57SJl/jL21TpJWKC8TMtpdQr
         jFCjP2GmKOhZxnNPkik/qyGRrmAizGPdyU3WQBi8N76WW4kzHw/G2qtoeHDfxGlvkBwg
         8t0JIg57WZtjH+R7Miw3xZ8Lgum+3J+/zKOowIW7gT2bbJdEANU4TqUxKU/RG5J9TXg5
         /La9x6YdkEt09Q6LkKjxLzbTiWSUWEoi1+fOHkDL8hRo4SA+tcUnzvBxsQ9uEsUEd7Os
         4syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818790; x=1757423590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgtN0YfVxpl/kl53lVF3hZ78e5x/MECopDk+aVJVJg0=;
        b=i4/zj6C1L+dhYbDSdaLT/K8wYGg+2jbyExUUR9qinVvrk+rlhup+1m7tL+LTa/4Qdj
         hpewdEXVludcdOk1cgt+3XynbruF9fKny+NKjs2PdqrXuy94wnoHkIxIl8S56uDYz3Ba
         0HmE/4mAW5PC5iENLYYHTDrVWEDgvg9DF2kyPk6L9SaRjzddqKI+YUveBE1aWijk2hBA
         eBJgzLHy2rkLd3SivYbS5BmC3LZDQEN9ldFK3/8jVwigLRldxUc/JiK4+cGJkeGturCB
         8gj2ZPHIqA8CDvuY0fbqpu65q+ujKu+u0GHUF1/JNiCI3zGsVnwyrW3GmF5IdnCc3yS3
         QsNw==
X-Gm-Message-State: AOJu0YwuIITDazBeSnzP4jnd3KWq14m7K0ODKghWgdg1v2A7RFpRj2Y3
	iL+9q6YjbdlUZjvhWz/Qnh4gMHGkWUjd16hO0WBfjJRcpF7z9nlF4+A7Hh2kEQ==
X-Gm-Gg: ASbGncuL8HSLg8Ssq0n820ueXPqwQPE0/ky3tLa2R9XbiArCzBD9wGpWN8ehKG8MlTY
	4jL5YoyEDHpUH2retcdDl1yKNDiJZONPcxgCmi+QgiTYERsLmSuDIeG63W3fYS2GaHWC8y2gDjq
	nbFb9T5HwU+YwuuoPJckQws6AJ6xGE2GDk8nBh0wn0xxGGKI1/eyYVkbVQfs4s8rO7Joipocwoq
	qAVczEx28vTvbnBGnVHiW6o/0yDiwRIL7NuMqPFfgAPEC2LWSX46yjd32leDsxqoIVCwyDhpZdZ
	Cg5nwUHdiccY0vV2py4mgOHhDVqM43Be7FEc9J+nayT0iTcTZuov9VqmUGDoSzdjVQYweFB7Be8
	etAk9togidy3Q7tQTCZ6GNzdfzWy3aec+4AVUSlNrwDmkZFXFRClYiSfsh2IgvdnEy96MADBszu
	QoW5v1YqG1ecVfzTkqGo0DZ+HkjknUCU3YZYkMPSBMJXxxmPcHUDFrCHnfoCTFoQ==
X-Google-Smtp-Source: AGHT+IGCR4YzNGmLHS17zje48igAHMJ4RFEdLZj6iXoqCpSEE+kr3F/aoMxnUJMVriQOIFhUwUYgjw==
X-Received: by 2002:a05:620a:470b:b0:7e2:c5ff:2078 with SMTP id af79cd13be357-7ff28979e65mr1409093985a.37.1756818789929;
        Tue, 02 Sep 2025 06:13:09 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069d6b1ff7sm133609585a.69.2025.09.02.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:13:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	willy@infradead.org,
	vishal.moola@gmail.com,
	david@redhat.com,
	mst@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: fix sel_read_bool() allocation and error handling
Date: Tue,  2 Sep 2025 09:11:08 -0400
Message-ID: <20250902131107.13509-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch sel_read_bool() from using get_zeroed_page() and free_page()
to a stack-allocated buffer. This also fixes a memory leak in the
error path when security_get_bool_value() returns an error.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9aa1d03ab612..232e087bce3e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1203,7 +1203,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
-	char *page = NULL;
+	char buffer[4];
 	ssize_t length;
 	ssize_t ret;
 	int cur_enforcing;
@@ -1217,27 +1217,19 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 					     fsi->bool_pending_names[index]))
 		goto out_unlock;
 
-	ret = -ENOMEM;
-	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		goto out_unlock;
-
 	cur_enforcing = security_get_bool_value(index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
 		goto out_unlock;
 	}
-	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
-			  fsi->bool_pending_values[index]);
+	length = scnprintf(buffer, sizeof(buffer), "%d %d", !!cur_enforcing,
+			  !!fsi->bool_pending_values[index]);
 	mutex_unlock(&selinux_state.policy_mutex);
-	ret = simple_read_from_buffer(buf, count, ppos, page, length);
-out_free:
-	free_page((unsigned long)page);
-	return ret;
+	return simple_read_from_buffer(buf, count, ppos, buffer, length);
 
 out_unlock:
 	mutex_unlock(&selinux_state.policy_mutex);
-	goto out_free;
+	return ret;
 }
 
 static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
-- 
2.51.0

