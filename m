Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4729A339
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314651; cv=none; b=pGBjRU7XYZRyHDriBSYLnldB78hQyUqUlj0gpF/QlRZeQWXHq7ke6KlJIKsxyRqopOzyPTeD2QtOsYDBtqjvK8UhpHbI2WKK2YWtYrY5hu5IQQgIrPN9uFKL6F8PNiY4W+UyrUnBrGViuO4M8kP7bQ3DZtDE3hxwehuR0d0ocwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314651; c=relaxed/simple;
	bh=o9YCtY/4nf+PD40mBHKrS+FMUKC0xVu6A5R1CGt3z7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpR/q9mym1SgiHC+6zBu6o+Qr/h2MnkoUlKhKIA9SUuyfdveKWT00je6LY/ZFinuW1UjCL3tEJbnet0Rm/CrJtJ85XPo3WWSxRVrS3e4ipgBzGMQ8x6qtaQsTH35f4lwmQP8Ybn7cpOZpMtfUqPQS1vlr+4dSt7SzZs+45cB3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5d6qOHU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5d6qOHU"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-48d71b77cc0so12615271cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314649; x=1747919449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjUlHFtMI8f20Jtv6Fvqvu3CcYDhIdV3+4h3uvtjAZ0=;
        b=Z5d6qOHUXW8y+iWIbHbl5YCeYqz1lhZ6XTzKXKRevtYuFJUYyUfxOe1w6O7yjQSbxW
         OYlKwhBPHpilEEmHxXJPiS/9wZiw4Sc7QKXGsXxCa4KcJkBB2seQhZaCGioG8pSo0IPy
         sGc415Yx2tGLE12XrHLHQqd9JXSMkrYPfs1NThFz9T8Q5+yY+LJpxDXrPRJ71i4oOLm4
         OcYKEl1wkyai4n52pmt73XlG9N3j+biyxvMl3CAiG+qBeKhNbUeP0LJ8Cwu2wCci8d7r
         kqk3qVFA0fn01pQqvce4s1igRrdT8LCHigphCsMCY0F37Hl/xAeRVWY4VmCPz6dNnLt5
         ZBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314649; x=1747919449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjUlHFtMI8f20Jtv6Fvqvu3CcYDhIdV3+4h3uvtjAZ0=;
        b=i3EBSMl/XpOGuyq3SbPQC8CmxYAvNidV28SUcOg5bVS5VeedaFGEltijXo1e7mgi+w
         RP02G7MKE0UgXsa+oHCPk5HSJ7IZUgE9/129Tci3DdHojX7v1Av5OEg/jnVzcwXQ8rsC
         ULBI5mToJUL0cRChVJ/J2Vmk/yNwRyyJ3bJNiOk6kqfvL+i5lSFsRZlVTABbQeU5xp4q
         p86fLGYqYKbhvu8nZRzUuc98BhQVEGHL+jmqhD13xWwpLbGN5BiMi0mtJaOrHXJ+QYMx
         gQzOffNVPQ3tNtehX6lYCXOXw7vDVbbOc8FBcU0mcTdGSe8um8FrXtsKXC/gHVoe+/xU
         UKxA==
X-Gm-Message-State: AOJu0YynF71YpJd/jcavMJE3q6ULH+iIkWW39av+UUujoRrlGsV19ASA
	ACv6F7oUBmMqirSHlZ8oDZdA0asZEm3GqlBZI/q4XoaN1xRGmIi/P0LqCw==
X-Gm-Gg: ASbGncuR7+Jo3mQvLqrh/ZEjQGibet1edCRjxjq98nNzdnCtmysCGs2fwxu5DRi97Uq
	4+t1tMgESVLrSRzpVwYgp4VS+tpBzlGf6ZBmkUC1b0u/KP5AdAJrLh7SJ6q13NHHQSpefvZpQWN
	AslXhIiZnlh7Czn8vouB75cysI5yRQR09wKwLNBpi1919M0K4upSk+7a73ApEBJMCFWIwsTLifA
	7emaFQF0vceCXVHUPhn+RNbDeaWoSEjiMhpLpTKjqLnUQlWVGss/SjTdRfhJs4FO4XJVFc6S18f
	eoHAPG89dS2IMtctKssLACiCjSHVdF95xa3BJbRE/XifSNwrp5igrm5azsUIdchJArIp+iUD3bo
	AX1IF1TVgAtee3EGS2JjSlG0pq4U+/Qf3cGT/X8wJp3V5gNet7A1iFQ==
X-Google-Smtp-Source: AGHT+IGeFPpaqDvoAPd/GnF6hB05Sr5laNi3qx2e4xrTo4+YmjfnXzfIeREuoAFCQRL7wFsXa6EPMQ==
X-Received: by 2002:a05:622a:6110:b0:48b:4d30:fced with SMTP id d75a77b69052e-49495bb9582mr95098431cf.0.1747314648501;
        Thu, 15 May 2025 06:10:48 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 40/49] selinux: allow userspace to detect non-init SELinux namespace
Date: Thu, 15 May 2025 09:09:38 -0400
Message-ID: <20250515130947.52806-41-stephen.smalley.work@gmail.com>
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

Enable reading of /sys/fs/selinux/unshare as a way to detect
whether a process is in a non-init SELinux namespace. This is
to allow the selinux-testsuite to adapt based on whether it is
run within a child SELinux namespace. Whether or not we want
to retain this as a userspace API is an open question.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 831a326e79de..f15652d971c9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -329,6 +329,19 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	char tmpbuf[1];
+
+	if (fsi->state == init_selinux_state)
+		tmpbuf[0] = '0';
+	else
+		tmpbuf[0] = '1';
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, 1);
+}
+
 static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
@@ -390,6 +403,7 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_unshare_ops = {
+	.read		= sel_read_unshare,
 	.write		= sel_write_unshare,
 	.llseek		= generic_file_llseek,
 };
@@ -2342,7 +2356,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
-- 
2.49.0

