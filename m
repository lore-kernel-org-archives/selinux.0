Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE272ED141;
	Fri, 20 Jun 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441534; cv=none; b=U9kb1icACpR0bKus6X+0lAnh2+jhOQFPpCdmDGgpCons0EClIwcNlwGhx/JO/3Ol2JW1Kc3fXRACbz/E3J14Wq+f7HvssUg9jC7MgOYBGyUw7vCkkI6dbWIYh2oJrUxUiq0zA86WuQQNzEXFqytLJEvitZIwzNyXmY7nYkO10sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441534; c=relaxed/simple;
	bh=izuz55jNu4ZgmiUnswDtuQ+1y8m1i190LxHqmgggGYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e58CP+y8sdrRSPCkovXIXI2DakOJ/yRWWrU8/eR4HK/Ncp5nSyAZGXhRUA+gnvgtmW1H++e6eRPhnsj5E8mOjoGjCmb7FtifRl07QX5BHRlTCmKwOldgZ2rfj9OWS5UwPBNdmJUvYzi7WUqy4VWV5SZbhxQ/G9sqKrqznwWI0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeUKieJt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeUKieJt"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso20361856d6.3;
        Fri, 20 Jun 2025 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441531; x=1751046331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=GeUKieJtc1taa6VoZ+qwQDSWBrOm/9Jj8zULcLEjIUMTGOMIVBnC5B7uMOU+XAMyJt
         lFUkB4ZfikYYrcSNiI2hndsBv0Gxt7DvjWIcISKTVs6GZ4rKxcBsZz5nJJq7iM9jvCAu
         uIG/ju+Q+qTFOHl2dh3Ioa+Ba9lQWUilKYxS22QMtQXBq114++4qGxyp4DdShQ/Ogfcv
         8TTb18C1roB6Dql/MX6/PXu9rxrHJRxGttrx7n38kvjJhfd5McGo5cbCOuWoJtwIL1MK
         WaMY8J67qXGzzGfRpneCYvmJ6IYCE2UGolvX5QngJZ4FQYAl0b1bkcXlZhiX0+Vzvh3C
         4D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441531; x=1751046331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=rAH6lZ/I7q8cPBwXZc+5iUsnsVCE6k/rBGiSePlCVSnGfBOXuTeTpxYkJm1SuX+8Lo
         udpu5OYkd4HlMkFV9dbqjVbJXGvnzxShOz7ax3dB/YL/uMF8pdHfUeMPPW+8KNRmzQwB
         DOVUa42fMklA0T8rPm1Ea+OAwU7HkwVhucuMX0P9o6JD+hWB6d4JYO/It37H+z6lonFI
         IF5M+Z02GsbxNkeeNSoD+uMgraVDUx1WgDS2tE9D30FP06/qz8TKO9wH5l1oTza3Y5wX
         5P4QzlBSF1GYPY1jDhsZl9nTOmxgXTxd2URNzpOhrSXjzuEeeuq8PDaPastJAnB13d3k
         bcYA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ti5Ql/Dpj6KlnHoidHp9JvoL0Rxbc5a+vsOHMKkKJclomkr6AW5qzjHUlHPCETZAhqTv12Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FjAroP8lU9ODv7HKPJ9Yrr8mfVNqZ0TRY6k4THHH3PVW//DK
	gqAK2YgSjR7dC7zzTILW8HIGP3Vf6NPksE3ajC+ZTIw7ecF/CQIDx+pWYwvFIg==
X-Gm-Gg: ASbGnctaINU/DXyfFVswZUfIw/fsv2PPOjoV5qHP+UXsYHyWihWSAGUJUylhi8pj/l0
	2MONFfKUbQPMQuuSJPFKZPGxWHCWI9uIfPsVHeQPDnduYcpFyyOiGnZfe8fX39exKYuIkBtLyKG
	FsvsoZ/iqfIyZNP63iD3jyrMNLHSMZd8HIK9YxK3zIbKaDWAa9UF0izdTxcUos8V2TAjBxavSmQ
	3yJdxICzMKzecm5faxEMiSg2wD4qiUTeGxJ1mq6HEwaJs6yKoIHlXRV0lKI1SSLMbXfU5XrDu18
	kr0YkwF5KQhJxMROogDCeo7S3Id96AVBN6Cakbx2BbLMvADtSa76MRgFIjqBD9HDnINdf53YW7I
	ZHSNEVglQuYYDkRU9m6BzLug1W66YogquvUpqvNMNXXjGIEY+ZSxl23FmoW6WXs/s0k0ToEoBd7
	JB
X-Google-Smtp-Source: AGHT+IHn+gzxaytXxDcKXHIb7IRMXkND4hnx8pU1ZY8cQF2nGPU6YnTbEqeIfgqviuWMhnGlqUsY0Q==
X-Received: by 2002:a05:6214:3f84:b0:6f8:bfbf:5d29 with SMTP id 6a1803df08f44-6fd0a45620emr76508146d6.5.1750441531029;
        Fri, 20 Jun 2025 10:45:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 14/42] selinux: allow userspace to detect non-init SELinux namespace
Date: Fri, 20 Jun 2025 13:44:26 -0400
Message-ID: <20250620174502.1838-15-stephen.smalley.work@gmail.com>
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
index 0508ad18eb73..39a60d221143 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -321,6 +321,19 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	char tmpbuf[1];
+
+	if (tsec->state == init_selinux_state)
+		tmpbuf[0] = '0';
+	else
+		tmpbuf[0] = '1';
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, 1);
+}
+
 static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
@@ -373,6 +386,7 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_unshare_ops = {
+	.read		= sel_read_unshare,
 	.write		= sel_write_unshare,
 	.llseek		= generic_file_llseek,
 };
@@ -2237,7 +2251,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

