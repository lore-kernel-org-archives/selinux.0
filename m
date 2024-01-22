Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3D3D3A3
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931725; cv=none; b=b2ssxgv/yXKe7SLt17FDBFjkP+/o+da2Mkcgulfq/XuZc6a7giWvVnMqWmUi3NSDjF3AwLk4DCBwopj8O2HflPufZnD2sfHFfQ+PAAMLHyQucW8/V9sYIladqcS8l89HC7c0rQaQA96QxPFw6j6O9jpOx9O98W/rpKEdHd3gVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931725; c=relaxed/simple;
	bh=hX9XKOHOs2CUXcpte3IpXup/Em9uXyuctqoZtUexqJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBuPDNv4VEkD/101yhJyOEQVJdlrvm8wc80y9jj+jdc1/LUbRiEAlz+K5BbIuOluzSVhOcgOaMjx1kLeu83bwN/BABYZ4d16dAipnY2has9dhTkF8QuronkOKXKaD4wqcrsPrjEtmLBc874m92moKux5chfUYzN5ux/D9bCF3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N6aZKI4L; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N6aZKI4L"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so4158464e87.2
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931722; x=1706536522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iuLBGoHN3UA5yGbsra7kXnzAw73qWxCvjU4gDmr85c=;
        b=N6aZKI4LcMBj7iXEmRb8iWYM3TVo45ckUikkmX7y35KFXnYT483DhNADlETrH/UFUm
         StyQiaKt4Meaqb1q9+hV3ETUzyt1rPoZJ3A9SQNiZxgFhYOPGDzNlCCDOUxJZOY9LXq2
         9if4xNnN+QF/b70z5Kz5uB4W1SaD4V3HC2joFHScflaIOCB6oCLvZNsIKtS7fVJCZX0r
         N4V4hUEJ7GCekhiai6QzzyVqMKfqchdies1FW/VBawqPCetHDliCFpsY1EyzE735uYte
         7vhdGjWM6jFHWWdNQWVsye/goU8phMe/euZckU7Vdu3lBwR2NS1rwxrV2MxfHx8MEXWk
         7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931722; x=1706536522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iuLBGoHN3UA5yGbsra7kXnzAw73qWxCvjU4gDmr85c=;
        b=oZqlq9rrBBahzYKZwMeRLqR/8qrF9r1qgXBPPvFl+8WGHzyn2V+4IlNnA2U/NGUiAE
         yXU7FNUIE93MBumxQ/h7tv6c6DqeN2tGInlAPumUg6sGIXbGo1eVaX9ea9zalazBmwiG
         sKsfZmYbdNs8HCwk46rcCyvY+1v61I1EBhlBf0tlPS+SjcE5pRlZxlYIX9hVN/BFx0yb
         gSL+HndrDbjLAWSbDZCk9f99BuKAVUIYWYVnyFIgFBdwgXHFe6zjUmsSANeJG6EsajSr
         ITF1lAzXXddiUf5j8eqaxMf+D/vZaFtC2RUDZwYEjpawVos9IUBL8NIk1zHgj9AVMsiT
         mvgg==
X-Gm-Message-State: AOJu0YyZKUBAI5qqVPwVLjSWB8sZZJ8tNO8APDtovi3ivwFqkQr2hT3U
	CWUtjCOVTEzDg9ciG87BWxBuBkM4mgFeXGjnE/AFBk6YJANQtq9OR69foVyu
X-Google-Smtp-Source: AGHT+IHj/zwrbq3pLrWHK60LY2UrVQEyrd6TGx60/g69fQnEcRmweEubeSeNfhWV+RDqeLRyjN2RIQ==
X-Received: by 2002:ac2:4e11:0:b0:50e:9eaf:98ec with SMTP id e17-20020ac24e11000000b0050e9eaf98ecmr2052920lfr.54.1705931721899;
        Mon, 22 Jan 2024 05:55:21 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:21 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 15/15] checkpolicy: misc policy_define.c cleanup
Date: Mon, 22 Jan 2024 14:55:07 +0100
Message-ID: <20240122135507.63506-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sync function parameter names.

Drop superfluous return value.

  The function avrule_merge_ioctls() has no failure conditions and
  always returns 0.

Drop duplicate include.

Use native type for ranges.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 27 ++++++++++++---------------
 checkpolicy/policy_define.h |  2 +-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index cd49cae3..79d67a78 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -44,7 +44,6 @@
 #define IPPROTO_SCTP 132
 #endif
 #include <arpa/inet.h>
-#include <stdlib.h>
 #include <limits.h>
 #include <inttypes.h>
 #include <ctype.h>
@@ -1096,7 +1095,7 @@ int define_level(void)
 
 	while ((id = queue_remove(id_queue))) {
 		cat_datum_t *cdatum;
-		int range_start, range_end, i;
+		uint32_t range_start, range_end, i;
 
 		if (id_has_dot(id)) {
 			char *id_start = id;
@@ -1932,7 +1931,7 @@ error:
 	return -1;
 }
 
-static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
+static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	struct av_ioctl_range_list *r, *tmp;
 	r = *rangehead;
@@ -1949,7 +1948,6 @@ static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 		}
 		r = r->next;
 	}
-	return 0;
 }
 
 static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
@@ -2070,8 +2068,7 @@ static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
 	/* sort and merge the input ioctls */
 	if (avrule_sort_ioctls(&rangehead))
 		return -1;
-	if (avrule_merge_ioctls(&rangehead))
-		return -1;
+	avrule_merge_ioctls(&rangehead);
 	/* flip ranges if these are omitted */
 	if (omit) {
 		if (avrule_omit_ioctls(&rangehead))
@@ -3854,7 +3851,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 	return 0;
 }
 
-int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
+int define_conditional(cond_expr_t * expr, avrule_t * t_list, avrule_t * f_list)
 {
 	cond_expr_t *e;
 	int depth, booleans, tunables;
@@ -3866,15 +3863,15 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 		yyerror("illegal conditional expression");
 		return -1;
 	}
-	if (!t) {
-		if (!f) {
+	if (!t_list) {
+		if (!f_list) {
 			/* empty is fine, destroy expression and return */
 			cond_expr_destroy(expr);
 			return 0;
 		}
 		/* Invert */
-		t = f;
-		f = 0;
+		t_list = f_list;
+		f_list = NULL;
 		expr = define_cond_expr(COND_NOT, expr, 0);
 		if (!expr) {
 			yyerror("unable to invert conditional expression");
@@ -3940,8 +3937,8 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 	/*  use tmp conditional node to partially build new node */
 	memset(&cn, 0, sizeof(cn));
 	cn.expr = expr;
-	cn.avtrue_list = t;
-	cn.avfalse_list = f;
+	cn.avtrue_list = t_list;
+	cn.avfalse_list = f_list;
 
 	/* normalize/precompute expression */
 	if (cond_normalize_expr(policydbp, &cn) < 0) {
@@ -4117,7 +4114,7 @@ static int set_user_roles(role_set_t * set, char *id)
 static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats)
 {
 	cat_datum_t *cdatum;
-	int range_start, range_end, i;
+	uint32_t range_start, range_end, i;
 
 	if (id_has_dot(id)) {
 		char *id_start = id;
@@ -5527,7 +5524,7 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	class_datum_t *cladatum;
 	char *type = NULL;
 	const char *sclass;
-	int len, len2;
+	size_t len, len2;
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("genfs not supported for target");
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 075b048d..bcbfe4f3 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -13,7 +13,7 @@
 #define FALSE 0
 
 avrule_t *define_cond_compute_type(int which);
-avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
+avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *sl);
 avrule_t *define_cond_te_avtab(int which);
 avrule_t *define_cond_filename_trans(void);
 cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
-- 
2.43.0

