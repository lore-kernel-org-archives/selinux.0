Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB231280CFA;
	Tue, 20 May 2025 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742477; cv=none; b=qfEUBhYvNgfz6bXit7Vdtl+05ldv9VgWxDLOsVdnN8ACOa4wdlQwHro5uqcaUNVUQnqN3eQEsWpo7WbL3/N1EIQYnncryF29I318D/mRexo9R3K3+Qo7ybb2PbzdUIFENQ7F/Ro5GGCbeg93fqco6BGmwCu1Xmz0a+HISQG43us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742477; c=relaxed/simple;
	bh=GfmMIoKWn8PdCJ1d+kB8+iTrLO6rfZtiX8AhENbYXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG578jjPXouOcDOPRKD8dO5FpuYPkiEGajtkVbKttHFarsUfHqKn1VA56SpVfGKpGL3OSLPwk03djMxSc8PjvHC0NyqrHVIC5h1iG62/FpK+Xk2GRW9/U+u52+AVxDggeyNZovqEljZCEIAVzETOBKfBRpA3zI5R27u1Hyjipt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW/DfGCz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW/DfGCz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52617ceae0dso1485411e0c.0;
        Tue, 20 May 2025 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742474; x=1748347274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV2Z5eXwtJlDOv5lEytFDYwGtZ3t+Llb5onxXt5Y3SA=;
        b=mW/DfGCzwQYtP3RqILBaXzWlUK0tOx9TH513hGMSUq3OAyfc34tcFl3LvvPuc1Sedn
         rYZVngESvQqwsxsJYzmMiFv4WHLMkF9jodqdIpXarIuMeMjMzUjrgM5BAoE1XTOfuUjN
         VCpyisysvjkin/MjObJPqSo4firQwSdLXJEa1ZoNTSc+cbiGafuxIs5jaZ7Mlom3qWNc
         yoLeak0TpK/hJ2YQNDHL+TpDsAWibqoLYJND12kpJTEvtu+aoSB8cvmoMcYXake3rtnX
         dLyl1FE/8X/r6hnpWbizuHLbk9OdwgyiARYDpO90ftZyt0psV6Ql/bteBJt/gxj5nqh7
         YUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742474; x=1748347274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV2Z5eXwtJlDOv5lEytFDYwGtZ3t+Llb5onxXt5Y3SA=;
        b=O0z+wUtBUYtdLaK8ts5EQLgmM//PGk269t+/4UJ4bXiO7Y7hL6clUAP3YGERJkFegq
         E5uIy0BC71XlgPf+Qh7SH+S47eDY9WNcAjnAMdbG4DRWwD7VbsknO8Y8CIKOJHLD/V52
         3lUnh1YqZ268i58wn0nOA8a6RubpE9R6cDpRrv8FDrj1WdoshYfckbxUJtYIJfM/YTEQ
         MVxtHmnzyS7GSpwDfm+ZvVwMwFDOz+n4aPRAa3kSWMzG02OqElI5+qeoweKp7hvrs9c7
         ZBf8SqlubOOVrlsMdoNRY7TIWJWPSE2UmNavYdrp+9IppWCZtFlYKJGfp5VHvWatT778
         3H8w==
X-Forwarded-Encrypted: i=1; AJvYcCXHje9Ysss8fpE7aN4iBCmy7eR/23ZrAlAaTno/pukSSrjPYKnl5LNUmQDP5ouIux2BZp18c6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DKx+v9HoR0QqOC4XtIXmJnPF4aww85L9y2N2+jvNVuH9ckkJ
	9PpLVW6OIylpsbCA5e+LFY9Oi9XqnOzczi5Sot6mRd93QTF24IENwGcfZ+qDTA==
X-Gm-Gg: ASbGncuthRCBKm+9x5DVBeVp6K4LjDpfTMllNHxzmgwzS0LD1M7jn6tYildnHBbbY/A
	y4/eNRwPn7RhBXuA44wLwd+nhhLvuHV8r9r/T0YHyGtcAAjGv/AGUb5w2ZA6hVNgVMQ/6gtYu3c
	1A9SCcrcoIKbMAzaZuLE4CpQTlscXgMUy0oa4ZBayRAMrxUlW1EqiPHU4XrApKRyBw7SccRpbdI
	f97Wb61WrnHQ9zo8vfOutdW+tVCYJOJHzxjtyn49+fCWu5iMyyf5oEz94aigV1QDJmpMUNn2nQM
	PrFh93/0ZIKqxtTPsjx31b1DD1X/8SHgGSWepmgsY+TeV0QCWkRZpv0vF2WvHVSMfN38c20QeAH
	HKHc6oGV5rEbqkO9TK1c9ueP1fZ3Bn5JG7qdHpF8L9tW0X5csLtLoIg==
X-Google-Smtp-Source: AGHT+IFCBbu8NuDZR6fmqyeAbjGjC5aY+QHYPnfwRYl02Fb6751YIASm0cwSn1a7zaUTiMhdLaI6jQ==
X-Received: by 2002:a05:6122:6170:b0:529:d7e:d13f with SMTP id 71dfb90a1353d-52dbce756a5mr12327798e0c.9.1747742474381;
        Tue, 20 May 2025 05:01:14 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 13/42] selinux: allow userspace to detect non-init SELinux namespace
Date: Tue, 20 May 2025 07:59:11 -0400
Message-ID: <20250520120000.25501-15-stephen.smalley.work@gmail.com>
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
index c7e74229d2e3..40d2d2cae2a6 100644
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
@@ -2236,7 +2250,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

