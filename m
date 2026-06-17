Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4D37B407
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722563; cv=none; b=BKEVuraZiM/XwrmA7Bza4T9rns2QaFlX/D6P1AbBepXanwEAgbosOxQ204PzvS+gyvF3yKslXDonc76+f9R3ABjj/uF/zweFbWwVDFOouKWA3kue4P7jlI3cUrHj1GtbPKrKKYT7ESDCQeQ7ffpnzK9lH8UDFjKv1rN8cCYAJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722563; c=relaxed/simple;
	bh=9hQEeVFCnbbhnH67CZxR4vx2xJg50PrSLWIbNoG0ixI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpxTH7gJAXvyQFQSb/F69Ngu5yzgLsvM9FiT4HLaQtWo3296h24E6vpMJ1MhOHm7vce+TwFXnp5h7v2B7cNi3sSmw1DMYUYdDy9vZmKqm7AzoMpleR8rb2be2aE0bDNOxP+7xA/bXwU0Vn5294pnsbqzRr6GPF5fVS1JMlvTFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2eRRXHV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2eRRXHV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176bbb9384so913611cf.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781722561; x=1782327361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXT921rKfTFtghX8g23tVqSJgSVdgR5IdkI6kBOvMWU=;
        b=J2eRRXHVK5UGqWVKPDcVJQfIkQ16L8Qkicmt4cKvmfn8qfNKWZyW6Tn/9q3WbAM1/b
         fElBBuKcumwgfhp0q4GsnA0zPYBv4WzrSj+Kr315zyi6rk180wQh6EuGQBYq5cYo5Xor
         Fj/vKBwhopp08wgdNkd6yrb9WvGwEt1TEpirP2O5ynwtt2v1WZfWdHTHeTtoh4DBt0jN
         jSjpMb2Z1eiWa06AXrbmsa7xWQNfOwtRgkF5xuv5At51HS/XRWaZa7U/ynOsx4zrsPCu
         q0MF8prp44u71t9iqB6SGyD9hzjy49T9I4R20AHdBLgTkmwK9RAq/U0qPsZ2urmV/OJU
         SM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781722561; x=1782327361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXT921rKfTFtghX8g23tVqSJgSVdgR5IdkI6kBOvMWU=;
        b=PcI7GEuYOeKswo2vhMMCw6Ww9c/P3vFUW43r3dl0fLRf2lm8lnObZ4rPpbPHTeCkXV
         TLu91jIo6pYRVhSrQPnKySnwVqgDqNQt2+ll84loYvvDOek8ObzAqQFn5ICY7TbIk1hS
         lKnSvRu7ru7sH22ri7OXYjbUFkGkcFQ/I0jYKp2lKX/gHKASiuxST3ZDzaUb5EeuOHeL
         uJlyLrls8YHzhSeM+xetaOK3S0URDOE1yAR8Q7jgvuvzClP+tq17zxgiPTH9YOZR4Zx2
         qp4aG9xKHl9XYL/H2fnoOhn4U80YCQGdziTAaHjIMoMRWs9se+K2AklxQE4Mmk5Jh5R6
         g6WA==
X-Gm-Message-State: AOJu0Yy39eXea9oEHs95HZqhDzAPJbvg9iH0Sf2nf0pV1VhhdVqWJAdm
	2z8wNqnVa4wnSfvjz2RVxzqkrEPv70iYk7FkupneVqgcGxaFo/y4iz5iPRq/eg==
X-Gm-Gg: Acq92OHKyJolqhyDffzGDyWqraWhTRsgZ3Qu04okddo+6hEc5yQLVMGwNUlml/+/lJ+
	Q/XOVv9lxZC6wpbWsXUXxg0rBTpWRCCwUrr6uFng6I1Ne7i3P+5in+cKDLC9wyQeX+pQWXLWUcq
	Ns9Ii9rdo0On2zFWKhXus7WMKAQkdtMpzVsVwUPeP7L4MnTCP6I/LH9prbVvMxM23qGz2Jolbtt
	sCyro+kfQ0ZSIEnghhCUhQRM11g7Tp3y8QySqWcgPSFYW5EvY+FMiq7t7SruZMXcBfeYzKLcsp0
	uGL24Yb+p8aHkQN2EIuvaBDGnQV94CHkDzFHiYow1PNsI9fvrVWE5Sx9A+rxL97TvZHA8wTsw/w
	4UGDlrXtjkLvSEjKvdJKPTRBhSbDpBV7mV6mvsrI+Zg7oo5a6G3BVFwvBJo7XT56ujWKSP+w7B0
	paZnIHPUpOaretEJAAZ8zK6M262+mTplrb4ECyD4WPrTHkig==
X-Received: by 2002:a05:622a:8346:b0:517:85e1:38a2 with SMTP id d75a77b69052e-519a8f939d8mr66980901cf.31.1781722560958;
        Wed, 17 Jun 2026 11:56:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm182953451cf.20.2026.06.17.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:56:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4] libsepol: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 14:55:43 -0400
Message-ID: <20260617185543.91749-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617185543.91749-1-jwcart2@gmail.com>
References: <20260617185543.91749-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common idiom to grow a list or buffer is to use "len *= 2", but
it is possible for the multiplication to wrap on overflow. This
would result in the new len being smaller than the old len and
could lead to problems.

Add checks to prevent doing the multiplication if it would wrap.
The multiplication can always be done if len <= MAX / 2 and
should not be done if len > MAX / 2.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_common.c | 16 ++++++++++++++++
 libsepol/src/module_to_cil.c    | 12 ++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..9ffd452b 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -22,6 +22,8 @@
 #include "private.h"
 #include "kernel_to_common.h"
 
+#define MAX_NUM_STRS 1UL << 24
+
 void sepol_indent(FILE *out, int indent)
 {
 	if (fprintf(out, "%*s", indent * 4, "") < 0) {
@@ -117,7 +119,14 @@ int strs_add(struct strs *strs, char *s)
 	if (strs->num + 1 > strs->size) {
 		char **new;
 		size_t i = strs->size;
+		if (strs->size == MAX_NUM_STRS) {
+			ERR(NULL, "Too many strings");
+			return -1;
+		}
 		strs->size *= 2;
+		if (strs->size > MAX_NUM_STRS) {
+			strs->size = MAX_NUM_STRS;
+		}
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
 			ERR(NULL, "Out of memory");
@@ -169,12 +178,19 @@ char *strs_remove_last(struct strs *strs)
 
 int strs_add_at_index(struct strs *strs, char *s, size_t index)
 {
+	if (index >= MAX_NUM_STRS) {
+		ERR(NULL, "Index too large");
+		return -1;
+	}
 	if (index >= strs->size) {
 		char **new;
 		size_t i = strs->size;
 		while (index >= strs->size) {
 			strs->size *= 2;
 		}
+		if (strs->size > MAX_NUM_STRS) {
+			strs->size = MAX_NUM_STRS;
+		}
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
 			ERR(NULL, "Out of memory");
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 00db3d7f..ae7d700e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -447,13 +447,16 @@ static int stack_push(struct stack *stack, void *ptr)
 	void *new_stack;
 
 	if (stack->pos + 1 == stack->size) {
-		new_stack = reallocarray(stack->stack, stack->size * 2,
+		if (stack->size > INT_MAX / 2) {
+			goto exit;
+		}
+		stack->size *= 2;
+		new_stack = reallocarray(stack->stack, stack->size,
 					 sizeof(*stack->stack));
 		if (new_stack == NULL) {
 			goto exit;
 		}
 		stack->stack = new_stack;
-		stack->size *= 2;
 	}
 
 	stack->pos++;
@@ -4595,6 +4598,11 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 	while ((read_len = fread(d + d_len, 1, max_len - d_len, fp)) > 0) {
 		d_len += read_len;
 		if (d_len == max_len) {
+			if (max_len > SIZE_MAX / 2) {
+				ERR(NULL, "Buffer too large");
+				rc = -1;
+				goto exit;
+			}
 			max_len *= 2;
 			d_tmp = realloc(d, max_len);
 			if (d_tmp == NULL) {
-- 
2.54.0

