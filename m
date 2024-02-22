Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92C17C6B
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646386; cv=none; b=g2ZAFPfHOCAckQPcPLMSACgCu11wz79srt8MjW6h9yci7X6uvV2BR7njXRYvzsT31dHG39VNe5CyVsTCxfxPy3g51Ro3zd0Xo0AgTO4N0b2Q4o5J9RY5D1tRIu6fDtqGx47KI21gUIFep3PTeDjDUS3yQUTMyz30FidfH1v9kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646386; c=relaxed/simple;
	bh=+cHF7sSQC5d599SYzT8pAFGlUiNcrmMwJHCpKGYqWv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3pEZcIH2+saJlhFxAwygCUubc5XHEySJjpIC5n5u84MNgrRTZyU6smh4VJ8zBXoX/EwXqyi7trucGTmsE/9MpiuVj1IKr8EjTE43cHM51JHMLUfXE94TzpUuG9BBPz92wrJEk4kQBjeiUI4kh+SYVpE02q8vTkxguUhHKgc1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dwi9uhz1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dwi9uhz1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42e323a2e39so2619171cf.1
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646383; x=1709251183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOArciuZ8srbs0iBxL3Baqw1i4J8+zhAZs4Cj/MRiIk=;
        b=Dwi9uhz1sMzf9iT6kLjp+hnIHXJ0ZJf6enExOAulCLjDvkBZj83njw7VEzoRLAlhKt
         9Si+jEEZxrYlbXftF/sni2wertn8nKI1iCfTvatahlhIfOSxAwxsvzODZDzj1cpPwZee
         vzvoICqQqmPMiRPMyQsnyrIjN1hwpqs5o6mJeHazLZiWstmsYtcZ9b3KCwfUOYj5Bk+k
         olTppGOWKizEa29DqesQwMj9xlPkqzOYECoyr/bWdzW4zOFCac83SemtXde5G+HHSaRP
         h8MAZPKcNV9rY7307l8gQRnNmYLTkdDfn9k26CH/hLBEMStynysSn22LFDsgf/Q0U8SR
         k7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646383; x=1709251183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOArciuZ8srbs0iBxL3Baqw1i4J8+zhAZs4Cj/MRiIk=;
        b=Z5o6MrCGcoF9hQX8rWNt5E0MbSh0rtFw7k23PGqPFWKyP50rdyDklVPm7p3xQ/kPfE
         hIPcWsmkK6/zjgb1OqWBVGIi4UYDvNYN0lv5fzAecv1dklUoQ/jdy+Qk1M1fzkx8lpcM
         WmRfFveGC0a4UU1zTRHhWPJpHYoxN/Z8TfuRqWkQeMgnRi5qbHk/yHF/OXrgIT/aiYQ9
         iCuatcCz2GGvKjIHfjcjgxBoE20MfBDjTy0MR/19P+BXj3AklhVihaMN9/0vXBdjWsSy
         2g/wQtUQ4y/wCqP7NljzqZ2Xt0llL6bhV8lXt7Of5sN0kv11+YwJCuTtWqN3IWMTq9Bm
         vNcw==
X-Gm-Message-State: AOJu0YxSqE8qEO4ejwuf4NewcqHq1aL76xOzkRshPRonZD6SrVDmCerD
	gMW2RO3z+m7+nU7SCfO5qMhYpJjhcVzBjiSi1pZC58oGEHhtyqV5FJDkl+G/5c1RZ7Qh8UPOTLw
	=
X-Google-Smtp-Source: AGHT+IHdDoqvQWfEplCkBht7Q0RLMg79FFRAvS96axMn4bBMDyJl9/8bNKMbmBEfPBrFSVDSLQsuHw==
X-Received: by 2002:a05:622a:15c7:b0:42e:6299:6cf2 with SMTP id d7-20020a05622a15c700b0042e62996cf2mr8007qty.4.1708646383173;
        Thu, 22 Feb 2024 15:59:43 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ks17-20020ac86211000000b0042e56fb8e0bsm734732qtb.93.2024.02.22.15.59.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:42 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 10/21] selinux: fix style issues in security/selinux/ss/hashtab.h
Date: Thu, 22 Feb 2024 18:52:28 -0500
Message-ID: <20240222235708.386652-33-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677; i=paul@paul-moore.com; h=from:subject; bh=+cHF7sSQC5d599SYzT8pAFGlUiNcrmMwJHCpKGYqWv0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+Na8YRZ6/2zHwg9SiSFZKvHcXrVSxZ4NReA /unXFf6HxGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffjQAKCRDqIPLalzeJ c161EACBrc5/koOqhxUrmih9q2dJ05b9ABeFgLsyOLyi3MM3jCqj/qDsJxb70JeqRUxg91Xcjlo y3jr308nemgfMPJRuj8xOkGUO/xrW/XPee8m/LG1mz2n4XqmlN/dCgHSHT4w1hkbkRSwYWrtFXS MUx0bN43rzPxxkbjLp6XuLIqTtgrQFDSjdZhA5wm8vKqubP5sYryTjeg9clpMZ1wq1WypjQ4tKj lXE8mHQ/lIQOB4u1XfhnApKzZbpVngp3+/9Y00zvVcdU/ClFazj+VkqRoBhi4v87VxSqiMLWxuP mtEXp1nPtzjhFJePpVcEzPLKGB6biz0qCvF5qM6VyS9S3T4JH2UaA6B7OqHt8VR5r8PAh5apjJF x01DxGfTQsKQt2n0TbdGzsQNiIxSCNVrtXQ4mpChroR28xCR+9Wq3fLA05wY9uoR41FbtwQhDWg gYcpj5GlhABMkVhpG9mo9WHFzesvZKlLGEv3OilQZzxG8qSUxsYD/01cxZEqyb4N8K3XvHGXos4 ARtuyunq5HS5Y0GRgShXyKQSj3qfke+/C97nX0xbCYdM289pkGEMPXuBu1WG4WNLV4G37yTAJKc w/QIsShxGgrbGV4ZDMmJoIx2VeZIFPg2G8pGsAnIeOX/f0imOPANrEx3RpRJCstR3z67M0WgEbA o5RgWDF1rRlmVxg==
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
 security/selinux/ss/hashtab.h | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 09b0a3744937..5f74dcc1360f 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -8,6 +8,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_HASHTAB_H_
 #define _SS_HASHTAB_H_
 
@@ -15,12 +16,11 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define HASHTAB_MAX_NODES	U32_MAX
+#define HASHTAB_MAX_NODES U32_MAX
 
 struct hashtab_key_params {
-	u32 (*hash)(const void *key);	/* hash function */
-	int (*cmp)(const void *key1, const void *key2);
-					/* key comparison function */
+	u32 (*hash)(const void *key); /* hash func */
+	int (*cmp)(const void *key1, const void *key2); /* comparison func */
 };
 
 struct hashtab_node {
@@ -30,9 +30,9 @@ struct hashtab_node {
 };
 
 struct hashtab {
-	struct hashtab_node **htable;	/* hash table */
-	u32 size;			/* number of slots in hash table */
-	u32 nel;			/* number of elements in hash table */
+	struct hashtab_node **htable; /* hash table */
+	u32 size; /* number of slots in hash table */
+	u32 nel; /* number of elements in hash table */
 };
 
 struct hashtab_info {
@@ -48,8 +48,8 @@ struct hashtab_info {
  */
 int hashtab_init(struct hashtab *h, u32 nel_hint);
 
-int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
-		     void *key, void *datum);
+int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst, void *key,
+		     void *datum);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
@@ -84,8 +84,8 @@ static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
 		cur = cur->next;
 	}
 
-	return __hashtab_insert(h, prev ? &prev->next : &h->htable[hvalue],
-				key, datum);
+	return __hashtab_insert(h, prev ? &prev->next : &h->htable[hvalue], key,
+				datum);
 }
 
 /*
@@ -133,15 +133,13 @@ void hashtab_destroy(struct hashtab *h);
  * iterating through the hash table and will propagate the error
  * return to its caller.
  */
-int hashtab_map(struct hashtab *h,
-		int (*apply)(void *k, void *d, void *args),
+int hashtab_map(struct hashtab *h, int (*apply)(void *k, void *d, void *args),
 		void *args);
 
 int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
-		int (*copy)(struct hashtab_node *new,
-			struct hashtab_node *orig, void *args),
-		int (*destroy)(void *k, void *d, void *args),
-		void *args);
+		      int (*copy)(struct hashtab_node *new,
+				  struct hashtab_node *orig, void *args),
+		      int (*destroy)(void *k, void *d, void *args), void *args);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* Fill info with some hash table statistics */
@@ -149,7 +147,8 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
 #else
 static inline void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
+	return;
 }
 #endif
 
-#endif	/* _SS_HASHTAB_H */
+#endif /* _SS_HASHTAB_H */
-- 
2.43.2

