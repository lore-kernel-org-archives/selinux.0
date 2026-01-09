Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE5341AA0
	for <selinux@vger.kernel.org>; Fri,  9 Jan 2026 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998388; cv=none; b=nVR5VMXS1b+dH8Nz8HmoTpbd1UfExwpJXE777rkwkVYgNsJkuUZPsPAJMrsVEo+igQ0K0k7fTgO6OBXx0bJ8QxGn0ERLN+WhxRhbp+G/M91/m+dW/szlZIgBpL8kK7SKdd9yG2MPyLJlm+cnLGu2zhccaZWV88D5l7exbyMO12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998388; c=relaxed/simple;
	bh=oAg/Azhaj0EZROOTMz7G56RYKqjA+Z0PBwykIz2cjQk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f3TQfrDJPLn40ZmDtZDDSSY3vOGJIxWc6Kd3ImezVF8BJ42p9Og6EO5vo6RE8xgUh9Ho/MvncRjhkz8DKr2owrC4BJHEk6AEvXlQirQqMS+cfXYPE85FuY22xwT/GCOWnXwF0TQp+bCE48xmNc61WSN750N4+7axMndZVtyO3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RpzeeQP/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RpzeeQP/"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4fc42188805so49996371cf.3
        for <selinux@vger.kernel.org>; Fri, 09 Jan 2026 14:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767998377; x=1768603177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrBa4X53IcoyTenSMIrU9SHyZjxtG1DilOtuvhN6JPk=;
        b=RpzeeQP/Wrs/TxRSHB0UAHY1rNUgHcWcbPWIShkr30ZbQzH7Jd+h3obTAJR9hS5Gnl
         kmmmjlWSfG8RJLh95wbQ/M9X4eEYHc68vwnWyzzKXs+z2RAkXdAJgc2LOTPaop/Xn4I4
         RmVGO4FOQQwu1YSTTzABtvCFPnH9TVixY78pcm9TW5IYIpCBu3IqORcvccvCugASgcQx
         67e3g8yd+fet+cZ/koG4K0srIjZJGt2G9Kj5aeGpAclKJIKF0SK8JgevkTqN/MFvzJsA
         byj77n6bHVGNQjtx35YCfNlwexwcxGUiJ2geGmSFliTVorQIy2LKDWbCXTbXbzSaw0tz
         qRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767998377; x=1768603177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrBa4X53IcoyTenSMIrU9SHyZjxtG1DilOtuvhN6JPk=;
        b=IbkI1mpeyAuMQGju/p/9E6rUWnjxfLOTO2lmrYtGvlN5USfkKaLe77VouqNobF3h5f
         TFQgOddDVgrr+5fvz9ZYYoE1PYQId2GiIRDs+quEEBX8ibnwtPlATUuPwkk/ZNTyKDmJ
         anO6H7JUAtBDj7HT5LnJ5sfwgp+mSLLOBbWbD8E209LoSL1ViMzM5AZncpRhwQMRWtP0
         dlm/ulZoxrquIGQT+GDJMNnNhyGzKhFE9CG/dABtVrHQ+j242SGJnTSHtBnoHM+MY+e3
         rpcdTRRML+E5+amTzsrwVDQsrlosnICzh71IiFd0dg1e2nzkjh/xLg3PLmUbsqIYZscc
         cUIg==
X-Gm-Message-State: AOJu0YwhTZvJhh6+YYA4GsJVfqkui3abagK2SAU3E5lQn+4eoBHA470G
	SLQ/x7XtUcjA/uz8achAzG//N0AQERm3zbxYEfm4+1LZUYk9BZx5EWmec2NEf0tO411YY3gmj2z
	Xa1Y=
X-Gm-Gg: AY/fxX6MVk7+/OcWFbuAweSgxVADWNAvCon9KcjRJNZmadzvAqujxc00AALWqpblzeb
	zhCoS7re01rAjFhCu5VSRIn06Plvag95DevFXagFERKjkkFyBQKn0iDJUxJz+GE5NJbDyru6uhf
	/kAp5wZvb1azZKkCOmCOde+sETVU/BFh7FMTmD2C5aZ/0I7FTxt3iPTfWXummyijf0EixwIpiIY
	cQV56+BPjmd61AIz4CeAXjHdVPPl5MmEghvxJyiWll+YSySHsFNQqMRyLcRz0g5pw5sn2YixJT/
	D/lNe9RHf8uKjI7I6TW6DgoMdTcsTovrOSMLqDDLcYv6BBzVMajFJ2fpvRlaXJ1mr/Sw+RWaFfK
	cj+qCTMPlJJxvw10P9Qqqd7coIDqlGJ3XpSyLLbKJupkl2fHWaaGn7qG+FTebK77xS3GBRLxnRX
	GY+pcCRNtfva1cd/vNPz90h0xk8ifKgkTVkUixgmcYtoZINC3WSLth0Ap2
X-Google-Smtp-Source: AGHT+IEEGwWgLg3ECOzl2advxo5I6Q/c6mwUQ0f95kcMDr8jvFoL+fn+htz3yu64nZkpvz2i3ltXIw==
X-Received: by 2002:ac8:58d0:0:b0:4ee:2510:198a with SMTP id d75a77b69052e-4ffb499cb8amr154780121cf.39.1767998376985;
        Fri, 09 Jan 2026 14:39:36 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e5d4c8sm76977471cf.28.2026.01.09.14.39.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:39:35 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: move the selinux_blob_sizes struct
Date: Fri,  9 Jan 2026 17:39:32 -0500
Message-ID: <20260109223931.393478-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896; i=paul@paul-moore.com; h=from:subject; bh=oAg/Azhaj0EZROOTMz7G56RYKqjA+Z0PBwykIz2cjQk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpYYOj34qTFGVrZhSs7ResZXKJLYNCHn/digUbP OzUub7fWN+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaWGDowAKCRDqIPLalzeJ c9JgEADIr8xzN10PA/Tr1oTmvlpY9ivaLNe8oYxmbfZKfXlTYnbZNasyqAJpay3Bc07GY+rj23j ZVkSP44YwfinuU/+IYf1aAqfHzffPQ0N/fvVXas+eXOWchj5Nw4lvVzKEKXVqEEj0FAuaqIO4Qq q0fDwD8Abw3Dn+nJcNpeZSW0aapl/5i6JIks62GGth0khSyF5ay4aYx0FwTV3uoU4kn2YieSig1 AToCXpAOYKsHQ4pXKvgNGq5497+FPsBwmWapYXNePeC2X1Uz6Y0I1wBIHZ3Bs6C2VW3Mw0MQYBJ cT4ore85mVdYGu7QSFMvZEtMhu2Mm1trarrgGawupdNrGbYpERoaLjTm1KIl4EGSSx7MSnXdaqS IBGfck/BZ79a3cCAh0iQ0i4nBUbUpKL5/taKlxJFK0+w1vqMlWVfes/eMpwtPJ1heBRdtI+poGU rir5znJE42cAv1IFkjCre8r+gd4aIECkd0JYf6eiYzNIjpGPPnIXqpD1WbapGd3oOpW1CMAAW2Q M8P8DDJmDVJqjc3TRYpD8QYwkA7rn1DTzl74bWPKXPZVJ8QhVMLsk5B+fcfn7qcAxMx48zg00Cw iCzVqpzJ4i0Uq+Cxd2QCNimMF2P7rsAKVbalIgS4sYtZpjWweOFdbjj2KZIGJw0ldXLExLtPNI8 XVvEvDi0GszFQYw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the selinux_blob_sizes struct so it adjacent to the rest of the
SELinux initialization code and not in the middle of the LSM hook
callbacks.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d053ce562370..bb9bf848df4e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7158,27 +7158,6 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 }
 #endif
 
-struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
-	.lbs_cred = sizeof(struct cred_security_struct),
-	.lbs_task = sizeof(struct task_security_struct),
-	.lbs_file = sizeof(struct file_security_struct),
-	.lbs_inode = sizeof(struct inode_security_struct),
-	.lbs_ipc = sizeof(struct ipc_security_struct),
-	.lbs_key = sizeof(struct key_security_struct),
-	.lbs_msg_msg = sizeof(struct msg_security_struct),
-#ifdef CONFIG_PERF_EVENTS
-	.lbs_perf_event = sizeof(struct perf_event_security_struct),
-#endif
-	.lbs_sock = sizeof(struct sk_security_struct),
-	.lbs_superblock = sizeof(struct superblock_security_struct),
-	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
-	.lbs_tun_dev = sizeof(struct tun_security_struct),
-	.lbs_ib = sizeof(struct ib_security_struct),
-	.lbs_bpf_map = sizeof(struct bpf_security_struct),
-	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
-	.lbs_bpf_token = sizeof(struct bpf_security_struct),
-};
-
 #ifdef CONFIG_PERF_EVENTS
 static int selinux_perf_event_open(int type)
 {
@@ -7297,6 +7276,27 @@ static const struct lsm_id selinux_lsmid = {
 	.id = LSM_ID_SELINUX,
 };
 
+struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
+	.lbs_cred = sizeof(struct cred_security_struct),
+	.lbs_task = sizeof(struct task_security_struct),
+	.lbs_file = sizeof(struct file_security_struct),
+	.lbs_inode = sizeof(struct inode_security_struct),
+	.lbs_ipc = sizeof(struct ipc_security_struct),
+	.lbs_key = sizeof(struct key_security_struct),
+	.lbs_msg_msg = sizeof(struct msg_security_struct),
+#ifdef CONFIG_PERF_EVENTS
+	.lbs_perf_event = sizeof(struct perf_event_security_struct),
+#endif
+	.lbs_sock = sizeof(struct sk_security_struct),
+	.lbs_superblock = sizeof(struct superblock_security_struct),
+	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
+	.lbs_tun_dev = sizeof(struct tun_security_struct),
+	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_bpf_map = sizeof(struct bpf_security_struct),
+	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
+	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
-- 
2.52.0

