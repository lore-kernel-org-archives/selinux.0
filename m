Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68313BAD8
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646382; cv=none; b=RYvoiogE7T1yMQLATrP/Gl4RDWleQzebni3fu3DEXQnOv0MUnxwtBQ/fDh4UIf3a+K+oUiCNBxcck4LYfuAMlTyHdGyvRVfCVXCymThBeLl8MdMnt++HQ6lwMD0BAM/OHWYWS+SWGziJHUTpELRN7Spkb+Uko1HW5MkKNUMn35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646382; c=relaxed/simple;
	bh=nWclI/WNaY953BNWPwF0H3A/2zAf4SLm8p/pX6i8ELg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PybEAwCbTAJmTYN2x4ILJOs3NG2W1nCOrqo2Kg/kUEb416u+iJ2/cxHO/921dICP/c/POUhJkG3aou+qxvM+8fnj4VgMOkfOZQakBwbU2/ZldvTmHTKh6tGYQRVkDLmb42aUkwJEA5Y/+apFeoeHko5d/dMLT7ohhVbZgxC8DqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gOa97s6R; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gOa97s6R"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785d60ae6d5so17463285a.2
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646380; x=1709251180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhRMDzIqMN9vAgL7g4G+De5ERjBqKSmTwN4GVi7IUac=;
        b=gOa97s6Rth76G3ByhQA+KRvpdfkWlzvNjqeQr1Dtp9cDJ83kHnqwoCM7yrbsK05PR3
         B/M1CYQnRlzkm0BE0e6nrNNcbIrMUSrzkDny1ft5CA1PH3RUJffy2Tsd2NmdAGBvIWGn
         0N8JNxWKBt80a4XxA6dpDQkTBaMPCe+nauIxysrCaYMQPJ4NmgfCl1wIrPa8d779awal
         YPN0/zNQuOLkKrI/dX6uDJn75h4tkooFkNsLjaqijanxUU5YWi5k6xM9P4V+YiFLFjOq
         6MkL3f04Ue1uoOJKonHSA56q389g2ClGMQvsBGz88sBBoTxFGd8SybbVhZAox9sscWHr
         nFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646380; x=1709251180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhRMDzIqMN9vAgL7g4G+De5ERjBqKSmTwN4GVi7IUac=;
        b=LZcJ4il4CfE+VuaGuMTA/dvqPLo9SoBEeKlqa1AvJI5OQY5Hkf6eGue6hc/AEd4ZGG
         CgImMyCNjIRVpqFtCnHmWTa1uXkSbkIrPBgDFWwo/gu4rYvX/3J4m9qOEvy+X07GNpSs
         +JXiV1rYp6yvTAI7650u/4B4aO9yyUWMB4M6zg9bIhtmkgmo4hwudKFr0Rjm9VyCsrwr
         BHuo8rhcqim2PxN7Z+d0krKFS4G6eeN/YzWdTEvWIhj1YB60uAN9sngGX/QW+Rbsk/gJ
         zwXHbEDhcdcyCc0VAED5bQ9vWbb9r12nd9T7OkTMZyWbwMb/1x5FGuD2cE0fSGDqWG1v
         OYLA==
X-Gm-Message-State: AOJu0YziqFWPfW3OXx4x86+788aBX7C5Iy22RMLyuA/2J+x8+JqwVmdj
	bB/59txUZ0wVrsYjKsYR8XQ2B56RBNJ8ObQiC2dnVTXjrKFjAHcFwzzunXUTXw+e+wIKgQpJpQU
	=
X-Google-Smtp-Source: AGHT+IHu9aAH4ZGz6CWdA6vIG0/BwWXPtH7hC7B9rkkOb+YgVhJdzhUbEWTSLozGOw6t7Hu/B7+E4Q==
X-Received: by 2002:a05:620a:ec7:b0:785:ce02:4f82 with SMTP id x7-20020a05620a0ec700b00785ce024f82mr634123qkm.17.1708646379287;
        Thu, 22 Feb 2024 15:59:39 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id u3-20020ae9c003000000b007873306737fsm5833299qkk.87.2024.02.22.15.59.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:38 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 06/21] selinux: fix style issues in security/selinux/ss/context.h
Date: Thu, 22 Feb 2024 18:52:24 -0500
Message-ID: <20240222235708.386652-29-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4730; i=paul@paul-moore.com; h=from:subject; bh=nWclI/WNaY953BNWPwF0H3A/2zAf4SLm8p/pX6i8ELg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199zOeOr5DsTx3StwAehE3ck5MryfzdVXkNLr euyIyfQIUmJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffcwAKCRDqIPLalzeJ c6jVEADeTrp2S0+NkvBw+lJ/fc2t6brZyQOS1XCvUfohcbCMRwxJJdLwzW1DK+S9ysXgUPE67G9 OOKnLadGqO7A1mJawvswslRgX5H3UWrmK6xVnMK2KhCynj/CvTE7CNC1Dco/8e5tz8YWT4UfPie irC3oJ6cjOXhHxtxUY2e8TfX2pQhFO0IKZmy3eNkFFt3tpWsifX6CwPaK9xrib+cXe+emYmsKAf 7THmPOxKuoI3Z22P8+LvKr6qYmNVlHQJmADalTt2gm1Dg3wg3DBDCGW9UyvDGRBrNDeXKqf3Us6 gpwvRP/oPOuma+KNbHZTS+OaCFmoVXsdtDG7Ner+fCgJIQaMb2aIiFonhAtVHu7sXniaTacETva v6OKjv026qgLS/loNTWtA0OxRL9y5pwtGu+Ifr0xIrtuxYP/LiRxQDk4aAHuqvvbQ8IRhh6PQ74 8UQzo6rcBhbvDBDNgoegsm9dVSqCNe9CcjwuLchGMWqS6Csp6mC4fjoz0VLzTCTi9x/Vk02ZTts J6HNrTrJ5YB9cWsdIygkLNhTTPvETmvSdyl1U7io58E6fifZGu0STnw5HD578WYtahTIypze8dP nmRm/pXFW2SvLKLodU3FrQWG/5rYHo5clZ7hXMSlbiKSeg081XTatIuJQvl8AGN0Nj9ul0HxA0H Npk04EGneXmjTqw==
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
 security/selinux/ss/context.h | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 1f59468c0759..7ccab2e6965f 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -13,6 +13,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_CONTEXT_H_
 #define _SS_CONTEXT_H_
 
@@ -28,9 +29,9 @@ struct context {
 	u32 user;
 	u32 role;
 	u32 type;
-	u32 len;        /* length of string in bytes */
+	u32 len; /* length of string in bytes */
 	struct mls_range range;
-	char *str;	/* string representation if context cannot be mapped. */
+	char *str; /* string representation if context cannot be mapped. */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -38,7 +39,8 @@ static inline void mls_context_init(struct context *c)
 	memset(&c->range, 0, sizeof(c->range));
 }
 
-static inline int mls_context_cpy(struct context *dst, const struct context *src)
+static inline int mls_context_cpy(struct context *dst,
+				  const struct context *src)
 {
 	int rc;
 
@@ -58,7 +60,8 @@ static inline int mls_context_cpy(struct context *dst, const struct context *src
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
  */
-static inline int mls_context_cpy_low(struct context *dst, const struct context *src)
+static inline int mls_context_cpy_low(struct context *dst,
+				      const struct context *src)
 {
 	int rc;
 
@@ -78,7 +81,8 @@ static inline int mls_context_cpy_low(struct context *dst, const struct context
 /*
  * Sets both levels in the MLS range of 'dst' to the high level of 'src'.
  */
-static inline int mls_context_cpy_high(struct context *dst, const struct context *src)
+static inline int mls_context_cpy_high(struct context *dst,
+				       const struct context *src)
 {
 	int rc;
 
@@ -95,9 +99,9 @@ static inline int mls_context_cpy_high(struct context *dst, const struct context
 	return rc;
 }
 
-
 static inline int mls_context_glblub(struct context *dst,
-				     const struct context *c1, const struct context *c2)
+				     const struct context *c1,
+				     const struct context *c2)
 {
 	struct mls_range *dr = &dst->range;
 	const struct mls_range *r1 = &c1->range, *r2 = &c2->range;
@@ -114,13 +118,13 @@ static inline int mls_context_glblub(struct context *dst,
 	/* Take the least of the high */
 	dr->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
 
-	rc = ebitmap_and(&dr->level[0].cat,
-			 &r1->level[0].cat, &r2->level[0].cat);
+	rc = ebitmap_and(&dr->level[0].cat, &r1->level[0].cat,
+			 &r2->level[0].cat);
 	if (rc)
 		goto out;
 
-	rc = ebitmap_and(&dr->level[1].cat,
-			 &r1->level[1].cat, &r2->level[1].cat);
+	rc = ebitmap_and(&dr->level[1].cat, &r1->level[1].cat,
+			 &r2->level[1].cat);
 	if (rc)
 		goto out;
 
@@ -128,7 +132,8 @@ static inline int mls_context_glblub(struct context *dst,
 	return rc;
 }
 
-static inline int mls_context_cmp(const struct context *c1, const struct context *c2)
+static inline int mls_context_cmp(const struct context *c1,
+				  const struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
 		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
@@ -183,19 +188,17 @@ static inline void context_destroy(struct context *c)
 	mls_context_destroy(c);
 }
 
-static inline int context_cmp(const struct context *c1, const struct context *c2)
+static inline int context_cmp(const struct context *c1,
+			      const struct context *c2)
 {
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
 	if (c1->len || c2->len)
 		return 0;
-	return ((c1->user == c2->user) &&
-		(c1->role == c2->role) &&
-		(c1->type == c2->type) &&
-		mls_context_cmp(c1, c2));
+	return ((c1->user == c2->user) && (c1->role == c2->role) &&
+		(c1->type == c2->type) && mls_context_cmp(c1, c2));
 }
 
 u32 context_compute_hash(const struct context *c);
 
-#endif	/* _SS_CONTEXT_H_ */
-
+#endif /* _SS_CONTEXT_H_ */
-- 
2.43.2

