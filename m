Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF42248176;
	Tue, 10 Jun 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576195; cv=none; b=AruhP1z2g2wp/gOWhun1djgrs6p2ErRps/fFoHehf7z0J7PciGRPpCgu0cs9HM0dYoRdNIJMQpyuyIXB/kyKaIPLD4/dmjZXKWdsf5r+jUUs6NjENpC2Tj+4HChC2dfCE7n8ZQ8ipoIcHbOW06TqCXvhU7Y4fSOEAk/l9ST2BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576195; c=relaxed/simple;
	bh=izuz55jNu4ZgmiUnswDtuQ+1y8m1i190LxHqmgggGYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVF48S7wmMOdK5QZLoHa4oglF/VOWfMdYcSc+6LCTlMVnWnVqQTgrpr6DhnjgfybUnelJ6pNEF3ScvtW4oxAduNiZph2kV181LdndFHI7AHTWt4co1XXDcleuiNscwNAIqhOVpJMP4Yrsiq6chmcioIxCy+/SyY0o07iQzwmyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PykLc+Fb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PykLc+Fb"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c922169051so326098985a.0;
        Tue, 10 Jun 2025 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576193; x=1750180993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=PykLc+FbtrXSU7glIoGyCjiOrNZPOMHvfG01ujVyU6y3CHzHVhPmU8B3DOC0qYodLj
         A7s2LX23EKlb4IvaK97Of9NWhSRhae6fW9Yykf7bRgXR34vFIVrJ8WrsM34Wzj4dDtIo
         2J/abZJSAlu5fG6kokKqnb/Q86tbBZ2ELhMAe5vR9Uh8giTDfKTXSg56Qm5i0yz2sLBI
         hD9aXUe/ECXY1ZDwc4zIuieQZO+Z+o7JXiO4Xsbx23a/F57dicDQYUgPouodhbYL0Naq
         bCYp91zzIYAfiCSpVG7nX/tdu0FfZco62EqGR37817kL9ZXS51bLlpFs2SqA1L/08gYY
         nHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576193; x=1750180993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=G8hP7yR1YT0TIHdcmDbUoJhwmQteZtfNBNwr1PnDyy1splZOtHm7TifX0j7q4b313y
         9fJ1IxENutQvDD0b1AZAVCrpMkz0iJp1m2Z7ue3zNJiGvmWmYHoU0/iwNMvk6dz/2WuU
         3Q0MQxPAfL2CPqx3t7qaMAbIhKGQWXTcOtBFnFDwnOobsM5rhhM0FSkKwte5dNVeH4+L
         RE0M3UL8k20EvHa6I/wciFSLL7aoLUfvziS+fa8YMc3lHhQJSOdliNgx9KutS34bHQEw
         /epqoZ0Wxv9a20lpEpeVtNGabmPWxQLmukVrPkPVF5Q4NBQ15ML+NXYRd59McSJ1pJZI
         80ew==
X-Forwarded-Encrypted: i=1; AJvYcCVx0UMZM9TR1bAHVnRDfj75EzbXpurrGQpAKLi3VWVGBAjWVA6Wvr2gsz4IK6aCdNR8fAcQAGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXEYEilpmWFOGxygvg3hmb32LyUUo3JOS1nDLnny3BG88QmBu
	Ge5YpKswTIldMg5WByg0DvVDN41Gx2R7ncm6m3EtFBi3SpXXg7s4yo/B5NuHrQ==
X-Gm-Gg: ASbGncutfsye+w/95HjOS5j1EGqYnSUg7vU/8rrUiOqa8GREnG+hrPlRJZigIrsnhjN
	XPfGCaZEp81L3TLAQzF5PKhgHZV9efcK2TzHDotXxeEB1qz+oSLB4EYL3ghEz3EQlyzP9hEYe36
	tW9wTbp7H5R0xuph7LoIt0VjvJgdNOGbXquayCkaHyhOraxZZ9H/90UbHLx1jAk++OVNu2zkbnd
	yL8wQRuQgw1Ja/yTQNitXw9d0wDAfQlwnlWgH6Af6OuhlzzoPNN3sI50t3OaQezwPT/g6Lt235E
	g41MJzgfWb83UNIRDaxma8xhZT0CJydrw8Ml/DaNBj+RoncIQ+klEHNC5qlAwxa3MtkevNjfyDp
	+X3+SMiWQwxh6mO5o34rILeNfh4oycijG9k1gkUtlyRPNL9fK8QIxXrrECJDTLv2u90A/1Kgv4N
	B2
X-Google-Smtp-Source: AGHT+IF87ZswGeFWzqS+zb7ejooY53PJSnGeG8bJ8xuvpxbhN2trPiJ8FzwFzGc0k2dR7mSjJl9zfg==
X-Received: by 2002:a05:620a:4041:b0:7ce:f58e:7e9c with SMTP id af79cd13be357-7d3a88062c4mr36433585a.7.1749576192764;
        Tue, 10 Jun 2025 10:23:12 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 14/42] selinux: allow userspace to detect non-init SELinux namespace
Date: Tue, 10 Jun 2025 13:21:45 -0400
Message-ID: <20250610172226.1470741-15-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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

