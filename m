Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1714037D
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646386; cv=none; b=Me89+szyoTyB4xEzQ9b7MrhCUZlHpyhOQOgF//IkCWNqOrVP33Z6YVbD6+vkdkG6goqkpW1v3r3CMOZ+YGAtKzpcYFAOzUCLsWpXvN50/SeGsPSnJ8kFJt/+5eo6j+z6UtPfJbduASwLDfoDM2RRGY7O+RqmN5mJEZjffb/A1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646386; c=relaxed/simple;
	bh=ykE4MGNWCvoiBrtnN37K3r7n8RhH0lx2qkfzrVXbPas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6gjTSs4vhjnePqRrxsVIvSH3umJChhrHxCqq3KONgejSJuvhajkQcdwxymCZH+aPkLp/kVOkAi0xO2bP6E9+F05luBNhQq7Yt7rrIz+uahJrB6MY+zyhERJexc6wWNk3wkjYrdi1zLccw2A8fNizz5E1CUD9fukEf7yh/2dsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UTetIuM8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UTetIuM8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787ac650561so12666985a.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646384; x=1709251184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkPkc8Y4Z3tXq/BArg1NNkxPALBbMp8YkjYfD2KM9DI=;
        b=UTetIuM8eF8G74LHeRmzfSfQIBswbl6jIbYOSKbsSNfh3qEn7YIT0NrvWEPuMU/TaB
         jrQSHLtCMCdxYCa0t/K7pgf5oBUxoEq9sb6s2RV3BEMUQ4ZVp4EQgRt/vUHU2Stji5T+
         Ad2da+qUAYuWKu5ZkCbwr8x3PKIaNrW85D5O6hdSgsA0JTO5hP6pzt7nkuLUroHiLvEz
         7W0CIDUcuvTwlOTQl533XE7aHpb0onMN4HipDsNYiVL42+wxld1byPX4wZhuW47f9FJq
         YR4hREL46cEkxthJ0+2Fm13PuS9sMqDDOpk1nFIFq5B4LAkynW/FuPnx+3JStT7PePci
         11sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646384; x=1709251184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkPkc8Y4Z3tXq/BArg1NNkxPALBbMp8YkjYfD2KM9DI=;
        b=SyiBP2X5xqlCsvF6ArZIGLUXZsIuoPeXiwjMsrED7TQmkcJW9N1M50CqNiASJBJDgC
         n31RLrXisU+33OnhSU7PX7UQSbN91M1E+ibGFZNQuIvv6VzkHXLJJb5Z55wdYBSuU87y
         wm1HcT7ikShvZLAJcW8B2WLXWe5XwsY3q1bkElfsjX0nrWnN5aNbgmnkLrTmW6wpUGAG
         t57Sgv5Cfy6g9hFBA8BGSHyMgRDfIWk6vhZjuCAA4ZJ6m23EQGmzArYLdHAXSlrWedf/
         cHnanv2HlIL7wfPa9QCWxHnUr+V55dRfOxEjGV+Dm0QCL4bvSNgAJyy/+UFG8LavG4hZ
         pVfA==
X-Gm-Message-State: AOJu0YwhBKYwVn2fm6qMyfIW25zz84fVYY2VpZLmqTfiX6VP8hKz+Ptb
	NH1HRmtrLFCqNJHr6dtsTh6SrjxQ7FUF6YTqU2higebKFiH8KwZr3+Dlvi+fpreF+EUbOl4/eUQ
	=
X-Google-Smtp-Source: AGHT+IGGVZZQOcc9Kw+iJUGq/lBQ7/HOAdT/xoxHnQNRYMIrmbIsba9141nNGy902fgeIY4tIHYNKw==
X-Received: by 2002:a05:620a:4494:b0:787:49b6:774d with SMTP id x20-20020a05620a449400b0078749b6774dmr615819qkp.23.1708646384079;
        Thu, 22 Feb 2024 15:59:44 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ow39-20020a05620a822700b007872acdc390sm5835932qkn.9.2024.02.22.15.59.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:43 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 11/21] selinux: fix style issues in security/selinux/ss/hashtab.c
Date: Thu, 22 Feb 2024 18:52:29 -0500
Message-ID: <20240222235708.386652-34-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816; i=paul@paul-moore.com; h=from:subject; bh=ykE4MGNWCvoiBrtnN37K3r7n8RhH0lx2qkfzrVXbPas=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+TTaAMaKGNr+lPK4p8orgqURCBVqzHb4XuL 4TRcrlZ0tOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffkwAKCRDqIPLalzeJ c7KxEADTn60R5gfCz1rKJWymJdL2BAG9YRDBKcID9BnfQanVg+2JGGtZaxutdn6Ps6PQGp8gRGb f2eDC95EipRxPgJ2sRTTgY3JW09lQzIRnD2EwDl0+ZhbO/4a/iVqOl7gwOwdQAER0C0I9CuVzvz fFZtHhCDypMl56JIbbd0Lbj/32+h4buzgrqxCknk/WPOh3N8cS1Dd/YMPCjxFA63dUBdhxzFFlc OAUfE/y6kR4L1+P+C18ozYFQoNm++TBJoWu00Ctb39CDfrg4Oi/bXPw7pogTUSzDYZERsdUtIEj meA+5nnDWftwMjMiBz0axrhBP5GiLZgur9Z9/macAy4/DRWz0EvcxmW/5/dHrCsO7rRClni2Jcx lC61RYiAEKmeNoKZUvG6nPllYhq7LzPUwiDtW2qs8nY0mmHFK+2faRtDNfHpoEYqvvT59KUykon xrnZg2ZlcgprFcJe1NH6b+axxLw7nv+Wm4V+HDreY2txnVZZP+y3sj8QOq1sVThB83dkbCYRj+t RDSJJ6UlvAxOkyhsqvXLq+icHD1txdfkXK/OUv4HC84n5CW6AHfC1FtboOn1z8ueu+fNRyWmA1p G1quYd+/UQPOhxr2DL2j47DY4VvyYaqy6gD2R0JuqkughhQx+Og6yBRjmTOXEhLoeJxZEmtmpeK 5JF85pX8aYn0LMg==
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
 security/selinux/ss/hashtab.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index c05d8346a94a..754bedbde133 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -4,6 +4,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -47,8 +48,8 @@ int hashtab_init(struct hashtab *h, u32 nel_hint)
 	return 0;
 }
 
-int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
-		     void *key, void *datum)
+int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst, void *key,
+		     void *datum)
 {
 	struct hashtab_node *newnode;
 
@@ -83,8 +84,7 @@ void hashtab_destroy(struct hashtab *h)
 	h->htable = NULL;
 }
 
-int hashtab_map(struct hashtab *h,
-		int (*apply)(void *k, void *d, void *args),
+int hashtab_map(struct hashtab *h, int (*apply)(void *k, void *d, void *args),
 		void *args)
 {
 	u32 i;
@@ -137,10 +137,9 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 #endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
-		int (*copy)(struct hashtab_node *new,
-			struct hashtab_node *orig, void *args),
-		int (*destroy)(void *k, void *d, void *args),
-		void *args)
+		      int (*copy)(struct hashtab_node *new,
+				  struct hashtab_node *orig, void *args),
+		      int (*destroy)(void *k, void *d, void *args), void *args)
 {
 	struct hashtab_node *cur, *tmp, *tail;
 	u32 i;
@@ -178,7 +177,7 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 
 	return 0;
 
- error:
+error:
 	for (i = 0; i < new->size; i++) {
 		for (cur = new->htable[i]; cur; cur = tmp) {
 			tmp = cur->next;
@@ -193,7 +192,7 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 
 void __init hashtab_cache_init(void)
 {
-		hashtab_node_cachep = kmem_cache_create("hashtab_node",
-			sizeof(struct hashtab_node),
-			0, SLAB_PANIC, NULL);
+	hashtab_node_cachep = kmem_cache_create("hashtab_node",
+						sizeof(struct hashtab_node), 0,
+						SLAB_PANIC, NULL);
 }
-- 
2.43.2

