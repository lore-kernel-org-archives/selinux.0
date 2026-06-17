Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D33AFCE9
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726228; cv=none; b=MPpe7Jdq1PmMBnNfmzkYGZCDkj1kPh5T8phXD1k5DN1gdoxQbUQLLAKM4GArSEVy3bdxZOVHzw5/7QnWqmY1HyDk0gxxR3c450Kqinp6bVunqC672R9NunvO9gZd9pJjhIBeA6IkpR2dbbF7BLxIWAswBiTiyLM5EYp4ELPrNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726228; c=relaxed/simple;
	bh=YyLSWE3YpmQ4SnM4J0W8w56nXO+pESywoGhd1InHaeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLS8PpCtujXOimp4Ev7gXSLFjTuC1ZIvO931+FJ01EdPMw9T+6M6AVXLCQ39lfiEIUn6dM+aA1yd9x7mw5ZpiFxJEysot7TMq7hbKVDm0caTUP6OZEsfvZQ2MgNQb3SQovhNCUfXSkXzPmRM9UMJFjIwQVkPMv3Uj7XpYea+Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Uq+Ocf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Uq+Ocf"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517b1f2c668so1797401cf.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726222; x=1782331022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIISft9EUAYfHOCCdcX15ADiSHTJUKfHgofoWNgSa5Y=;
        b=Y4Uq+OcfY2UkiZVrf9dk5iZaID8sS8takvyAf9LWh0TXZ3Umh8XVK7OjRMaq2Apg+i
         sCHg+91PYDnYCND5rQBVotSu4vmFPlwmjkiHJrvXtSSNjTMrTmiwaXc2+7No/shujDnV
         aMGfX29YyM3prlyrkvRytU2OXxCzKvfPOLIaLUPv+Gd7UbSUx8gOZRWhbWtA6S75+9uj
         L5LjWl5ABc4zxwNCQMpnh705WA3wtdEsjiXWJ33aNGFO3Dc0C9rH3+w+pISLv0LcsyBJ
         m7eWWdfA0EfWUhIyk0s7ubQJsk3Lw7DRQCXZgiYYyhTODpX3vCnX4uEvvgn2JhhM0A4y
         0vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726222; x=1782331022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIISft9EUAYfHOCCdcX15ADiSHTJUKfHgofoWNgSa5Y=;
        b=oJX5TSEcQdV5nNuxJFE64f7q+LQBaGs+o397v6vC/Sm7iTyu8LdHhE+6aVvj+7s/4I
         gJfhJvLQdNAoI9BQTVDZr/+IwjujV/NO2jRuEes7tDTLveHLbF7ISSr1teIgBnSEZYkr
         lvLqM5ZY8mcjRzD0zHTQlh2JB+KoDdxH66YdVc52IK5IEO4JHVBzwQx/JyLr1LJBnzmm
         oQqZM8gWxo4lrX0dboG0oLlag6l+yShh9hVxFFv12FkHrwn/0ogxh7ihqyjhxVqWtlTC
         Tty3cB7LKyXwfPs7+XpPV7VDz0kVPCanct4SSsOA1jToOIbKOu79cgUOJ8/vym8jiHom
         c1Cg==
X-Gm-Message-State: AOJu0Ywofw5WMG8Px0uQ9DcxKL7d8ljMjaD/em+63pQhx5N+4SAhOBFR
	1Uy60N8bz4h3yh0UgiXxVD3tQv/4FzbIooGT4OUWsHe5LdkMB6kALP7Ppx9OmA==
X-Gm-Gg: Acq92OHwpHZtzpFznQh06oQe1R6HOG/Z2yFIr5/biF5SGehzdfIQqUGSBgnmFjw+x9U
	n6phDk1xUQN049HyDjk+9qD+3EUtUFBcE4RNxG+YYhFsihwMw/i0WjbZ/dEgwVNKfOWqU7rFrXj
	IsWr45nUj/0iw+ai2ydTM0dUzSwMEkYopqcdt+uAYb6vTUmeUpzjWg3lZjQWjeZO+hDBardzgPl
	7IS+hn45gesA6kwwQhd9SFsrJ0F7cyaRY3PtzzimATKut4ar27nYE6X2UwSC0iItP6kzjYhvL2I
	tgU0i+IwXfy4OZy/jxtmTw7bEz8TJJ53CJFd/CWY/QViNk21pPpSkxJtDA15cYZM6itbAFmgg9r
	y2QJhOHDyYNZMbCawg4sAzFOWJ1b1FerlN1QGMhODn22XpL4Fg37IryTU3Vzg8+qC+/c4Gp3R5J
	K89kmduIQk9gRCYbD3A733RroiyED7deyzBWw=
X-Received: by 2002:a05:622a:790a:b0:517:6fb4:5796 with SMTP id d75a77b69052e-519a8e5c1bcmr67551011cf.30.1781726222182;
        Wed, 17 Jun 2026 12:57:02 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79c5absm171767341cf.18.2026.06.17.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:57:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4 v2] libsepol: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 15:56:45 -0400
Message-ID: <20260617195645.96604-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617195645.96604-1-jwcart2@gmail.com>
References: <20260617195645.96604-1-jwcart2@gmail.com>
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
v2: Add check in strs_init

 libsepol/src/kernel_to_common.c | 18 ++++++++++++++++++
 libsepol/src/module_to_cil.c    | 12 ++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..6bdaca02 100644
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
@@ -61,6 +63,8 @@ int strs_init(struct strs **strs, size_t size)
 
 	if (size == 0) {
 		size = 1;
+	} else if (size > MAX_NUM_STRS) {
+		size = MAX_NUM_STRS;
 	}
 
 	*strs = NULL;
@@ -117,7 +121,14 @@ int strs_add(struct strs *strs, char *s)
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
@@ -169,12 +180,19 @@ char *strs_remove_last(struct strs *strs)
 
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

