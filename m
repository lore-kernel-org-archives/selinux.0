Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1918049
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646377; cv=none; b=ZmQi++kTbuhX4ZZvuKEJcCBSMFy7Z4SIF7NtAM6pZueV1Y5/ETOaR6PqCaFN33H4YBSqrRuUWTkXon8Vzkjm1uC+gt09xhxfCgyR7JB/KwgoRCDE2HV9sB8iLANJhl0gz3WWdhueFvbRKeiNuNy0zhfyviQqKfI+iSigY9xiU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646377; c=relaxed/simple;
	bh=fvL7WoYVtfWDA0eSgIz2/uxmggKJ3caMkp6L58c1Vzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHz+pN9akWQRqJURd0CE4yY4AgoTfIP6jMMLY4ScPDic65GExY+/p8iUAihW5kl6lLZJjm6S6rclgv6ZsPIY52OEa6ioDCxoLfOTfXf9o4CXPH8jiwoCMxZzn7WLC+00Ey0wqNam5njlXbPIZ/RuU5fN5fEDbJMMSUt+zqWDlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SnCNfmRZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SnCNfmRZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787a2e56b11so15776685a.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646374; x=1709251174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrYECuMGVE9PrAxQaTbZ/EU8UxUGn9u8rh+su4zaWr4=;
        b=SnCNfmRZE61w2w4t2qa+dfe8kHcu5qjhidjN7DMpooHOkZPDW6yRxXd7++TqwUnmiH
         29mHjWYVask4dGOlFm+LyxKAzEuHr42LMX1guUTq6madXw/8TPeOGlxBisU9bRdSdnyS
         8+tie6g5GnfO4lwbiIfYtHqHrwA9wbYcDgy74j8y62MXPYHj7+rKmhnp65KdHAjDVRYx
         nq5IZSH1gt4xhDj0h8cqkjVV/HguCXI4WPEGvyu9bDxw5+BAiSr4WnOknz8jM9RlrjdO
         K1wSpvRSYsfpQvhBfWtAGmrIxd5CBtdNMRnmQXgiKDU1Kh0ULz6MyZM1zmGXwAwCR01N
         hxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646374; x=1709251174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrYECuMGVE9PrAxQaTbZ/EU8UxUGn9u8rh+su4zaWr4=;
        b=UTYkBOJXXseMiZ6ChPLUVpHnqmDpN7jvV05zEAKNB1fsb/c2G3uWRAW1mqOWE1/iLP
         4t+i5S0p6YwU79IoRRbGJIDdginXuPkzHiz4lrkVVNKTrA7LGvv6s/olgJVI2JOPkjke
         3smQludcPmSgld7b9pr4FgEL4KmC6hPqOXkWzcW/umVgvy/+uPMYDMYVm+9jlL4D1EMA
         +R5d2GzAptXY+EOYvX57ME2QNjSPmxpsPAeLT0SyENqR6xVxfcW2UBmYzz5JZRjPZU26
         uGqLCk4tP6c/IhMEqWsZi1ls0cZ5gWyjiLY+kNCZHGHzSPcUCY6VmCPTe8iGzylqVQlw
         GdvA==
X-Gm-Message-State: AOJu0YydppQ9Qd4MHuLIILVraa9Qu/A108HOLOJ8qiP63bb5qF6dzFO7
	Zn5dBnzd+9hSv8+w8S5oNqPJ33SN9t5hm65iPQcMlhIDl0SaDd1pXhmG2u1yTxazKnYdkRdmZdU
	=
X-Google-Smtp-Source: AGHT+IFOGw7RmDIztTNvTmK5NwvVqQ9Z2qktRtH7EJLz10mrWlVQQSQyHCH4ZCuRJi+rkgcQ1OoNGQ==
X-Received: by 2002:a05:620a:1727:b0:787:88a1:6852 with SMTP id az39-20020a05620a172700b0078788a16852mr730605qkb.16.1708646374294;
        Thu, 22 Feb 2024 15:59:34 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b007878458ba10sm2103168qki.59.2024.02.22.15.59.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:34 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 01/21] selinux: fix style issues in security/selinux/ss/avtab.h
Date: Thu, 22 Feb 2024 18:52:19 -0500
Message-ID: <20240222235708.386652-24-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5595; i=paul@paul-moore.com; h=from:subject; bh=fvL7WoYVtfWDA0eSgIz2/uxmggKJ3caMkp6L58c1Vzg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199UpyYtdgLaBUcvEp7Q425Na4B5rZo5ffzeI chK5iROot6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffVAAKCRDqIPLalzeJ c8hJEAClqTJhxDzqsCx5Uq3YxYi+ThgY+dsI7yjj75OQWfRCsKMpxl099+4QJ030AIhuEJLTzg1 SOOmTF+JWnqRC0ZKsBA0Yc87Acd1mH5v0wK2irrQ0A53wq5pWP1hL4lx6Lrcq7clikKbLRGMkew uUC3qwwKxJddvfkvCPwa7aPCsSAKa9YS2HWTCEQxR3mZCqHCqBK/kxzNyLq5atr0GOGVY/C3Xte MZynrLC+p5QQXmxW/53Hg9YVpblx5hzU8TYSbVHx92iZ+iowFcVDhqePutu9UWly5zPSH+bAN35 IWzHa+q0zUEQ56Eg5pNZg8A1jYdf0a7RoNoLpAyOeIpHqUzecXuVXsYvycQunbyW9h2Ge42a7jo GeI4uW/b2aSyOw0C7MYWdc1Vrc1kGV3xCJ6KyCVwulvKu1mK4VGlXlNjPd+wTd1Alhv8TZqNV9B Q5AlIpP+5fSbBQ+a57qMGA46R6rv7uleaTFTIlSLcyouml+2GIC25cq0AStYqoIM9g8vnFXI2Wh SKe469oXkeTrxrZsXJp6tPCoMA+dT+YEVt5YkzPIpjtFyU6qC8URup6W5X3DrwSSvNPDl3vAOrV vUoFdCMKel21yYlKNCOup263GFM8z3gXXBGZYUQuAtW/Kmv72vpyDnpVh9dOAdmyZ1ORPQO4JdA CJhJfAJJIMcQUHg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/avtab.h | 74 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 3c3904bf02b0..8e8820484c55 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -9,42 +9,42 @@
  *  Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
-/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
- *
- * 	Added conditional policy language extensions
- *
- * Copyright (C) 2003 Tresys Technology, LLC
+/* Updated: Frank Mayer <mayerf@tresys.com> and
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *          Added conditional policy language extensions
+ *          Copyright (C) 2003 Tresys Technology, LLC
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
- * 	Tuned number of hash slots for avtab to reduce memory usage
+ *          Tuned number of hash slots for avtab to reduce memory usage
  */
+
 #ifndef _SS_AVTAB_H_
 #define _SS_AVTAB_H_
 
 #include "security.h"
 
 struct avtab_key {
-	u16 source_type;	/* source type */
-	u16 target_type;	/* target type */
-	u16 target_class;	/* target object class */
-#define AVTAB_ALLOWED		0x0001
-#define AVTAB_AUDITALLOW	0x0002
-#define AVTAB_AUDITDENY		0x0004
-#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
-#define AVTAB_TRANSITION	0x0010
-#define AVTAB_MEMBER		0x0020
-#define AVTAB_CHANGE		0x0040
-#define AVTAB_TYPE		(AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+	u16 source_type; /* source type */
+	u16 target_type; /* target type */
+	u16 target_class; /* target object class */
+#define AVTAB_ALLOWED	 0x0001
+#define AVTAB_AUDITALLOW 0x0002
+#define AVTAB_AUDITDENY	 0x0004
+#define AVTAB_AV	 (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
+#define AVTAB_TRANSITION 0x0010
+#define AVTAB_MEMBER	 0x0020
+#define AVTAB_CHANGE	 0x0040
+#define AVTAB_TYPE	 (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
 /* extended permissions */
 #define AVTAB_XPERMS_ALLOWED	0x0100
-#define AVTAB_XPERMS_AUDITALLOW	0x0200
+#define AVTAB_XPERMS_AUDITALLOW 0x0200
 #define AVTAB_XPERMS_DONTAUDIT	0x0400
-#define AVTAB_XPERMS		(AVTAB_XPERMS_ALLOWED | \
-				AVTAB_XPERMS_AUDITALLOW | \
-				AVTAB_XPERMS_DONTAUDIT)
-#define AVTAB_ENABLED_OLD   0x80000000 /* reserved for used in cond_avtab */
-#define AVTAB_ENABLED		0x8000 /* reserved for used in cond_avtab */
-	u16 specified;	/* what field is specified */
+#define AVTAB_XPERMS                                      \
+	(AVTAB_XPERMS_ALLOWED | AVTAB_XPERMS_AUDITALLOW | \
+	 AVTAB_XPERMS_DONTAUDIT)
+#define AVTAB_ENABLED_OLD 0x80000000 /* reserved for used in cond_avtab */
+#define AVTAB_ENABLED	  0x8000 /* reserved for used in cond_avtab */
+	u16 specified; /* what field is specified */
 };
 
 /*
@@ -53,8 +53,8 @@ struct avtab_key {
  */
 struct avtab_extended_perms {
 /* These are not flags. All 256 values may be used */
-#define AVTAB_XPERMS_IOCTLFUNCTION	0x01
-#define AVTAB_XPERMS_IOCTLDRIVER	0x02
+#define AVTAB_XPERMS_IOCTLFUNCTION 0x01
+#define AVTAB_XPERMS_IOCTLDRIVER   0x02
 	/* extension of the avtab_key specified */
 	u8 specified; /* ioctl, netfilter, ... */
 	/*
@@ -82,9 +82,9 @@ struct avtab_node {
 
 struct avtab {
 	struct avtab_node **htable;
-	u32 nel;	/* number of elements */
-	u32 nslot;      /* number of hash slots */
-	u32 mask;       /* mask to compute hash func */
+	u32 nel; /* number of elements */
+	u32 nslot; /* number of hash slots */
+	u32 mask; /* mask to compute hash func */
 };
 
 void avtab_init(struct avtab *h);
@@ -92,6 +92,9 @@ int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 void avtab_destroy(struct avtab *h);
 
+#define MAX_AVTAB_HASH_BITS    16
+#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag);
 #else
@@ -107,7 +110,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    void *p);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
-int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
+		     void *fp);
 int avtab_write(struct policydb *p, struct avtab *a, void *fp);
 
 struct avtab_node *avtab_insert_nonunique(struct avtab *h,
@@ -116,11 +120,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key);
+struct avtab_node *avtab_search_node_next(struct avtab_node *node,
+					  u16 specified);
 
-struct avtab_node *avtab_search_node_next(struct avtab_node *node, u16 specified);
-
-#define MAX_AVTAB_HASH_BITS 16
-#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
-
-#endif	/* _SS_AVTAB_H_ */
-
+#endif /* _SS_AVTAB_H_ */
-- 
2.43.2

