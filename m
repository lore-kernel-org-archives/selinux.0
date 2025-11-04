Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB0224AE0
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289574; cv=none; b=MBDSdKzWUfB8a2DMXvVsMJ0skHmaNTHgisNR9CRjDNTKijuJZymufS7Gzh57DVDiS7lnkblvGkwB1wKR4+PuiDYe8ZSNqNL573SQq9dtmMp04twmw3+Ah6KTFDHw+41On5tl96sO5QJ7H/aXwnYFX8RPrvywKNWXtpJo4V4ihEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289574; c=relaxed/simple;
	bh=HRoq0xqYvwrk+mdM9L60nNgrUWG7Uwzyvb4gtadgDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGv3tfX1e5zvu+TAUk9KvJSTvcOqHVt0VeTIgnC75UHEbVLhXN4mx+rlEFyDhPdx6v4OrNEjh4RMJrCZzlrgcz4OaUxi8LeOaX+XjA0vTfiHbf6N/cIVB+2yyre5TRoplVOM/4fjOIpOXuULNKUabLjpGuYqxLhyQU5oBBFRcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWABdFzy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWABdFzy"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e89ac45e61so53901501cf.2
        for <selinux@vger.kernel.org>; Tue, 04 Nov 2025 12:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289571; x=1762894371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fccDfwhFc6swDtqThEGLuo47VM6s9WsSi+q5THme3Eg=;
        b=EWABdFzy4bk7lcyvTPYQ1GanEuL4x67/VuIWQ70eaOLEXAKrSAUUWMV717Z9V2oK8P
         eALDe+aWFXaSDh+XtfPPyVOtdvsWpt3GE98pShuA9/C+qiDf0ZjvX2WHpB7SXFrSEjt4
         3FwHW9tw5M/LWDygm6Cp6d7WO6SpvE+MwiH+KLF6vbt2XYJ1a7pZLk1QQDG3GVBjPrRh
         +PrkNOB2WaddXSxWCMjK1zOCdWURE2eGAnAe7Wy6kSfEc/ruZZRTCV3yKMUsi0K0MaS1
         Alsv4A5HTNPJvaD9BP8VZ5elNAiiEUFwfV7YrCj1SCrU0nl4AiV/3ek0BeA50bDxhXG5
         rwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289571; x=1762894371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fccDfwhFc6swDtqThEGLuo47VM6s9WsSi+q5THme3Eg=;
        b=cIXi/6s4Xzhic0iA7B1hKs/AnFR+OPZPWo+EALVjRYvBQw/o18USroFkA4hEIq2t8r
         AHinBuco+bOBi6Bdnzzky9Lemo0zidR+asEZOktENNCOHdXHOOk5t595e+ySAbvNWwug
         Miwt+W4cA30SJsAy6QnfXXgVeY2x+VqkWtNnH/eHeVFENHKUAyQHWuas3F1W4NCNiXpA
         fc9XCNvQ4oBjFoB7AUs0DFJWOsUS9YHzux5dVmmvj7dfHSKmKbfkdW4jaW/ZikpVI2Gc
         KODnqp1uLiBZ/JGwAhhdV0np2Nh3UfI5G9foMK3GHhMHet4JOI3ka1dxGSlTAftjzHVr
         l9AQ==
X-Gm-Message-State: AOJu0YyxnOO4alHcxl3Con7cX3hhMBrPF21KZIHG0XOffHfXFK+ZtsBW
	UX0oA5a2dJ55oakdRb442e2SYw1RFwo/NlMIJOZqn+0krNCtEGYNb0t4dV09YA==
X-Gm-Gg: ASbGnct+ZAwzMjwGPlMyG1ylbIcN/bMehSKIna4CaqWR5p+GIkzbGin2P5BGmUKSsSu
	nv5Nq6RAc8/0fV6B7an6Br6J14rv8VX/f6AncH4/C/uhEjMU/0GGkZNFiB3NiMVZ1TIp6SwT1X+
	COwepfpbU802MP/awxd7eTNNtsL4Kk/SzNymZR4qpqRDTBq0GCRE96o+WLL93lgCo1hdBcUBqLE
	jxa6qVcgjuImLCBq7H//s4f+27asEGkqG1gUUtCI3SZslKojbh/roHdVMEon5AKSQrcF8HDV8CO
	sCl+BhQP7qhIci331Gia8Unuxtg9+ZvGk/HmBV39FuPJeAAwdnTX5RoNUjtBwAw5QQFcIbFbTni
	PQiU0s9VG67LwLXxpNRU4xKsnjsCnqUH4ByXdOyodYGefxNDub3jZ6nQ/V7JdTXKjrCyrtkP4GK
	y1+XD+hg3U
X-Google-Smtp-Source: AGHT+IElGtsQIq4ai8REIFlxkDBZHjFzE6vw2QGdL54eU1kzKSKlUriO++BmuFOb9MjhOvTysPLtIQ==
X-Received: by 2002:a05:622a:11c7:b0:4ba:add1:abb4 with SMTP id d75a77b69052e-4ed72609951mr10180141cf.44.1762289570845;
        Tue, 04 Nov 2025 12:52:50 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbe2c2fsm23472791cf.21.2025.11.04.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:52:50 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	russell@coker.com.au,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Fix sid handling when writing out policy from binary
Date: Tue,  4 Nov 2025 15:52:35 -0500
Message-ID: <20251104205236.60931-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial sids are stored only as unsigned 32-bit numbers in a
binary policy. When a binary kernel policy is converted to CIL
or a policy.conf or a binary base module is converted to CIL, a
mapping in kernel_to_common.h is used to determine the name of
the initial sid.

A problem can occur when policy converted from binary to text is
once again compiled. The initial sids will not be the correct
number if there are gaps in the list of initial sids. This will
cause the effected initial sids to be interpreted by the kernel
as a different initial sid.

When writing out sid and sidorder statements in CIL, write out
all the initial sids from kernel (which is initial sid #1) to the
initial sid with the highest number associated with it. In the
same way, when writing out sid statements for a policy.conf, all
the initial sids from the first to the highest numbered must be
written out with no gaps.

No changes are needed when writing out statements associating
an initial sid with a security context. There can be gaps in
these statements. The numbering is taken from the declarations.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c    |  47 +++-----------
 libsepol/src/kernel_to_common.c |  48 +++++++++++++++
 libsepol/src/kernel_to_common.h |   1 +
 libsepol/src/kernel_to_conf.c   |  41 +++---------
 libsepol/src/module_to_cil.c    | 106 ++++++++++++++++----------------
 5 files changed, 121 insertions(+), 122 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 4da63ba5..06cf4498 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -565,54 +565,31 @@ exit:
 static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 			     unsigned num_sids, struct ocontext *isids)
 {
-	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
 	char *prev;
-	char unknown[18];
 	unsigned i;
-	int rc;
 
-	rc = strs_init(&strs, num_sids+1);
-	if (rc != 0) {
-		goto exit;
+	strs = isids_to_strs(sid_to_str, num_sids, isids);
+	if (!strs) {
+		ERR(NULL, "Error writing sid rules to CIL");
+		return -1;
 	}
 
-	for (isid = isids; isid != NULL; isid = isid->next) {
-		i = isid->sid[0];
-		if (i < num_sids && sid_to_str[i]) {
-			sid = strdup(sid_to_str[i]);
-		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
-			sid = strdup(unknown);
-		}
-		if (!sid) {
-			ERR(NULL, "Out of memory");
-			rc = -1;
-			goto exit;
-		}
-		rc = strs_add_at_index(strs, sid, i);
-		if (rc != 0) {
-			free(sid);
-			goto exit;
-		}
+	if (strs_num_items(strs) == 0) {
+		strs_destroy(&strs);
+		return 0;
 	}
 
-	for (i=0; i<strs_num_items(strs); i++) {
+	for (i=1; i < strs_num_items(strs); i++) {
 		sid = strs_read_at_index(strs, i);
-		if (!sid) {
-			continue;
-		}
 		sepol_printf(out, "(sid %s)\n", sid);
 	}
 
 	sepol_printf(out, "(sidorder (");
 	prev = NULL;
-	for (i=0; i<strs_num_items(strs); i++) {
+	for (i=1; i < strs_num_items(strs); i++) {
 		sid = strs_read_at_index(strs, i);
-		if (!sid) {
-			continue;
-		}
 		if (prev) {
 			sepol_printf(out, "%s ", prev);
 		}
@@ -623,14 +600,10 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 	}
 	sepol_printf(out, "))\n");
 
-exit:
 	strs_free_all(strs);
 	strs_destroy(&strs);
-	if (rc != 0) {
-		ERR(NULL, "Error writing sid rules to CIL");
-	}
 
-	return rc;
+	return 0;
 }
 
 static int write_sid_decl_rules_to_cil(FILE *out, struct policydb *pdb)
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index e4338ec6..99e46865 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -382,6 +382,54 @@ int strs_stack_empty(const struct strs *stack)
 	return strs_num_items(stack) == 0;
 }
 
+struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_sids, struct ocontext *isids)
+{
+	struct ocontext *isid;
+	struct strs *strs;
+	char *sid;
+	char unknown[18];
+	unsigned i, max;
+	int rc;
+
+	rc = strs_init(&strs, num_sids+1);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	max = 0;
+	for (isid = isids; isid != NULL; isid = isid->next) {
+		i = isid->sid[0];
+		if (i > max) {
+			max = i;
+		}
+	}
+
+	for (i=1; i <= max; i++) {
+		if (i < num_sids && sid_to_str[i]) {
+			sid = strdup(sid_to_str[i]);
+		} else {
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
+			sid = strdup(unknown);
+		}
+		if (!sid) {
+			ERR(NULL, "Out of memory");
+			goto exit;
+		}
+		rc = strs_add_at_index(strs, sid, i);
+		if (rc != 0) {
+			free(sid);
+			goto exit;
+		}
+	}
+
+	return strs;
+
+exit:
+	strs_free_all(strs);
+	strs_destroy(&strs);
+	return NULL;
+}
+
 static int compare_ranges(uint64_t l1, uint64_t h1, uint64_t l2, uint64_t h2)
 {
 	uint64_t d1, d2;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 3ba97dfc..d3283658 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -115,4 +115,5 @@ int strs_stack_push(struct strs *stack, char *s);
 char *strs_stack_pop(struct strs *stack);
 int strs_stack_empty(const struct strs *stack);
 
+struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_sids, struct ocontext *isids);
 int sort_ocontexts(struct policydb *pdb);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 6d608443..a8126d58 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -463,53 +463,30 @@ static int write_class_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 			      unsigned num_sids, struct ocontext *isids)
 {
-	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
-	char unknown[18];
 	unsigned i;
-	int rc;
 
-	rc = strs_init(&strs, num_sids+1);
-	if (rc != 0) {
-		goto exit;
+	strs = isids_to_strs(sid_to_str, num_sids, isids);
+	if (!strs) {
+		ERR(NULL, "Error writing sid rules to policy.conf");
+		return -1;
 	}
 
-	for (isid = isids; isid != NULL; isid = isid->next) {
-		i = isid->sid[0];
-		if (i < num_sids && sid_to_str[i]) {
-			sid = strdup(sid_to_str[i]);
-		} else {
-			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
-			sid = strdup(unknown);
-		}
-		if (!sid) {
-			rc = -1;
-			goto exit;
-		}
-		rc = strs_add_at_index(strs, sid, i);
-		if (rc != 0) {
-			free(sid);
-			goto exit;
-		}
+	if (strs_num_items(strs) == 0) {
+		strs_destroy(&strs);
+		return 0;
 	}
 
-	for (i=0; i<strs_num_items(strs); i++) {
+	for (i=1; i < strs_num_items(strs); i++) {
 		sid = strs_read_at_index(strs, i);
-		if (!sid) {
-			continue;
-		}
 		sepol_printf(out, "sid %s\n", sid);
 	}
 
-exit:
 	strs_free_all(strs);
 	strs_destroy(&strs);
-	if (rc != 0) {
-		ERR(NULL, "Error writing sid rules to policy.conf");
-	}
 
-	return rc;
+	return 0;
 }
 
 static int write_sid_decl_rules_to_conf(FILE *out, struct policydb *pdb)
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 8647d928..1c4e80d1 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2544,71 +2544,71 @@ static int context_to_cil(struct policydb *pdb, struct context_struct *con)
 static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_string,
 				unsigned num_sids, struct ocontext *isids)
 {
-	int rc = -1;
-
 	struct ocontext *isid;
-
-	struct sid_item {
-		char *sid_key;
-		struct sid_item *next;
-	};
-
-	struct sid_item *head = NULL;
-	struct sid_item *item = NULL;
+	struct ocontext **isid_array;
+	struct strs *strs;
 	char *sid;
-	char unknown[18];
+	char *prev;
 	unsigned i;
 
-	for (isid = isids; isid != NULL; isid = isid->next) {
-		i = isid->sid[0];
-		if (i < num_sids && sid_to_string[i]) {
-			sid = (char*)sid_to_string[i];
-		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
-			sid = unknown;
-		}
-		cil_println(0, "(sid %s)", sid);
-		cil_printf("(sidcontext %s ", sid);
-		context_to_cil(pdb, &isid->context[0]);
-		cil_printf(")\n");
+	strs = isids_to_strs(sid_to_string, num_sids, isids);
+	if (!strs) {
+		ERR(NULL, "Error writing sid rules to CIL");
+		return -1;
+	}
 
-		// get the sid names in the correct order (reverse from the isids
-		// ocontext) for sidorder statement
-		item = malloc(sizeof(*item));
-		if (item == NULL) {
-			ERR(NULL, "Out of memory");
-			rc = -1;
-			goto exit;
-		}
-		item->sid_key = strdup(sid);
-		if (!item->sid_key) {
-			ERR(NULL, "Out of memory");
-			free(item);
-			rc = -1;
-			goto exit;
+	if (strs_num_items(strs) == 0) {
+		strs_destroy(&strs);
+		return 0;
+	}
+
+	for (i=1; i < strs_num_items(strs); i++) {
+		sid = strs_read_at_index(strs, i);
+		cil_printf("(sid %s)\n", sid);
+	}
+
+	cil_printf("(sidorder (");
+	prev = NULL;
+	for (i=1; i < strs_num_items(strs); i++) {
+		sid = strs_read_at_index(strs, i);
+		if (prev) {
+			cil_printf("%s ", prev);
 		}
-		item->next = head;
-		head = item;
+		prev = sid;
+	}
+	if (prev) {
+		cil_printf("%s", prev);
 	}
+	cil_printf("))\n");
 
-	if (head != NULL) {
-		cil_printf("(sidorder (");
-		for (item = head; item != NULL; item = item->next) {
-			cil_printf("%s ", item->sid_key);
+	isid_array = calloc(strs_num_items(strs), sizeof(struct ocontext *));
+	if (!isid_array) {
+		ERR(NULL, "Out of memory");
+		strs_free_all(strs);
+		strs_destroy(&strs);
+		return -1;
+	}
+	for (isid = isids; isid != NULL; isid = isid->next) {
+		i = isid->sid[0];
+		if (i < strs_num_items(strs)) {
+			isid_array[i] = isid;
+		}
+	}
+	for (i=1; i < strs_num_items(strs); i++) {
+		if (isid_array[i]) {
+			sid = strs_read_at_index(strs, i);
+			cil_printf("(sidcontext %s ", sid);
+			isid = isid_array[i];
+			context_to_cil(pdb, &isid->context[0]);
+			cil_printf(")\n");
 		}
-		cil_printf("))\n");
 	}
+	free(isid_array);
 
-	rc = 0;
+	strs_free_all(strs);
+	strs_destroy(&strs);
 
-exit:
-	while(head) {
-		item = head;
-		head = item->next;
-		free(item->sid_key);
-		free(item);
-	}
-	return rc;
+	return 0;
 }
 
 static int ocontext_selinux_isid_to_cil(struct policydb *pdb, struct ocontext *isids)
-- 
2.50.0

