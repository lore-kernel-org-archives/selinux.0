Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA2C2BB3F
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 15:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjKTPrs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjKTPrr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 10:47:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41534B4
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 07:47:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so6683446a12.0
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700495261; x=1701100061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5gn7MUwpSyyse82fEzGPwg8kwvDBHEZxdb1Lzj4H1I=;
        b=ISNlJGI+aVFUqUvoyNqZzqJXmonvh7MaRzRSMMrK3M3ID9UfcoU2GzqfLDTNHs8VGV
         YnC5mYgqBZkhsTf79pqFuRTLRqq9jzCG2dvZ3mpyG762o74Hte7rJfD2rMd+VFNek0Vq
         AL/6H4BnkxfDnlnUCBOtwp3s+s99AHP1p6c0tA+EjNn4YGwYJsVQYBKIlMK6Vn5MoFMD
         AqRYmArWJ81ZXqgPgeFcWrAVBujNDvAENKrrhR917A8dKrTXHZul0OCY0nBeoExogkbI
         uS435znxmo9LkY91eL6lJ0AXRVTb0km52NVb3MRN5FYU4JT3PHb6NCQmnUPNrYtb5EdK
         SkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495261; x=1701100061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5gn7MUwpSyyse82fEzGPwg8kwvDBHEZxdb1Lzj4H1I=;
        b=JyGqyF+c2v+zdlkC+sMGvGgVxg/j0lHYEJxHZCejM83LpDw+6hFQ+gCJk3TFm4Zfy7
         1PdnMVJJm+obkXwW9SIQE36LUeTF/vgMrBI09koovi+khZ5WU94ynrCJ0eIKd3Mr/UHJ
         Paa7JhNvAC3xHvk6CBr1AiegOIEJclaa+mPE0+lPuubWVyRyQWO734ZiLm3z1w6LFP3k
         ABJPuStXu4vohbOdnF8QLkY90nVR6u147/3xHTW0jOepjMgM7d/TcIXk9KWYQb93R8ps
         cIfvCQa/ubsJ7Kfwmc66MgJxjb2vZDtFGgdha1Ie+9UB6t17Sd76DB3jgsrMmItNeuvv
         499w==
X-Gm-Message-State: AOJu0YzYUW9gqcrXMGoqTM8QtS11U/mtAgdhSzOOa4zhj/jA3DNxEFSo
        JurWqa3XOedYXwtMRF1RdFtRK1w/2wQP36hM
X-Google-Smtp-Source: AGHT+IHmu+HNro4f+WS2GceSyfX6km1VVBU+2T/OzO0U8vVOqAMjuBcDZK+FENHB9GUGqERnoyB/lA==
X-Received: by 2002:aa7:c6c5:0:b0:548:564d:959a with SMTP id b5-20020aa7c6c5000000b00548564d959amr6344994eds.3.1700495260652;
        Mon, 20 Nov 2023 07:47:40 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-118-211.77.10.pool.telefonica.de. [77.10.118.211])
        by smtp.gmail.com with ESMTPSA id p1-20020aa7cc81000000b0052ff9bae873sm3660008edt.5.2023.11.20.07.47.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:47:40 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/2] libsepol: avoid fixed sized format buffer for xperms
Date:   Mon, 20 Nov 2023 16:47:35 +0100
Message-ID: <20231120154735.450915-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120154735.450915-1-cgzones@googlemail.com>
References: <20231120154735.450915-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An extended access vector rule can consist of many individual ranges of
permissions.  Use a dynamically growing sized buffer for formatting such
rules instead of a static buffer to avoid write failures due to
truncations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   reset in_range on retry
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dismod.c     |  9 +++++-
 checkpolicy/test/dispol.c     | 10 +++++-
 libsepol/src/assertion.c      |  7 ++++-
 libsepol/src/kernel_to_conf.c |  9 +++---
 libsepol/src/util.c           | 57 +++++++++++++++++++++++------------
 5 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index fa7117f5..9f4a669b 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -347,6 +347,7 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		avtab_extended_perms_t xperms;
+		char *perms;
 		int i;
 
 		if (avrule->xperms->specified == AVRULE_XPERMS_IOCTLFUNCTION)
@@ -362,7 +363,13 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
 			xperms.perms[i] = avrule->xperms->perms[i];
 
-		fprintf(fp, "%s", sepol_extended_perms_to_string(&xperms));
+		perms = sepol_extended_perms_to_string(&xperms);
+		if (!perms) {
+			fprintf(fp, "     ERROR: failed to format xperms\n");
+			return -1;
+		}
+		fprintf(fp, "%s", perms);
+		free(perms);
 	}
 
 	fprintf(fp, ";\n");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index b567ce77..944ef7ec 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -196,6 +196,8 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 			fprintf(fp, ";\n");
 		}
 	} else if (key->specified & AVTAB_XPERMS) {
+		char *perms;
+
 		if (key->specified & AVTAB_XPERMS_ALLOWED)
 			fprintf(fp, "allowxperm ");
 		else if (key->specified & AVTAB_XPERMS_AUDITALLOW)
@@ -203,7 +205,13 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 		else if (key->specified & AVTAB_XPERMS_DONTAUDIT)
 			fprintf(fp, "dontauditxperm ");
 		render_key(key, p, fp);
-		fprintf(fp, "%s;\n", sepol_extended_perms_to_string(datum->xperms));
+		perms = sepol_extended_perms_to_string(datum->xperms);
+		if (!perms) {
+			fprintf(fp, "     ERROR: failed to format xperms\n");
+			return -1;
+		}
+		fprintf(fp, "%s;\n", perms);
+		free(perms);
 	} else {
 		fprintf(fp, "     ERROR: no valid rule type specified\n");
 		return -1;
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index b6ac4cfe..6de7d031 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -178,15 +178,20 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				rc = check_extended_permissions(avrule->xperms, xperms);
 				/* failure on the extended permission check_extended_permissions */
 				if (rc) {
+					char *permstring;
+
 					extended_permissions_violated(&error, avrule->xperms, xperms);
+					permstring = sepol_extended_perms_to_string(&error);
+
 					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
 							"allowxperm %s %s:%s %s;",
 							avrule->source_line, avrule->source_filename, avrule->line, policy_name(p),
 							p->p_type_val_to_name[i],
 							p->p_type_val_to_name[j],
 							p->p_class_val_to_name[curperm->tclass - 1],
-							sepol_extended_perms_to_string(&error));
+							permstring ?: "<format-failure>");
 
+					free(permstring);
 					errors++;
 				}
 			}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b0ae16d9..b5b530d6 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1683,7 +1683,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	uint32_t data = datum->data;
 	type_datum_t *type;
 	const char *flavor, *src, *tgt, *class, *perms, *new;
-	char *rule = NULL;
+	char *rule = NULL, *permstring;
 
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1738,13 +1738,14 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 		rule = create_str("%s %s %s:%s { %s };", 5,
 				  flavor, src, tgt, class, perms+1);
 	} else if (key->specified & AVTAB_XPERMS) {
-		perms = sepol_extended_perms_to_string(datum->xperms);
-		if (perms == NULL) {
+		permstring = sepol_extended_perms_to_string(datum->xperms);
+		if (permstring == NULL) {
 			ERR(NULL, "Failed to generate extended permission string");
 			goto exit;
 		}
 
-		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, perms);
+		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, permstring);
+		free(permstring);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 0a2edc85..2f877920 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -132,21 +132,32 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 	uint16_t low_bit;
 	uint16_t low_value;
 	unsigned int bit;
-	unsigned int in_range = 0;
-	static char xpermsbuf[2048];
-	char *p;
-	int len, xpermslen = 0;
-	xpermsbuf[0] = '\0';
-	p = xpermsbuf;
+	unsigned int in_range;
+	char *buffer = NULL, *p;
+	int len;
+	size_t remaining, size = 128;
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
 		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
 		return NULL;
 
-	len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { ");
+retry:
+	size *= 2;
+	if (size == 0)
+		goto err;
+	p = realloc(buffer, size);
+	if (!p)
+		goto err;
+	buffer = p;
+	remaining = size;
+
+	len = snprintf(p, remaining, "ioctl { ");
+	if (len < 0 || (size_t)len >= remaining)
+		goto err;
 	p += len;
-	xpermslen += len;
+	remaining -= len;
 
+	in_range = 0;
 	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
 		if (!xperm_test(bit, xperms->perms))
 			continue;
@@ -165,35 +176,43 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 			value = xperms->driver<<8 | bit;
 			if (in_range) {
 				low_value = xperms->driver<<8 | low_bit;
-				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, value);
+				len = snprintf(p, remaining, "0x%hx-0x%hx ", low_value, value);
 			} else {
-				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", value);
+				len = snprintf(p, remaining, "0x%hx ", value);
 			}
 		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
 			value = bit << 8;
 			if (in_range) {
 				low_value = low_bit << 8;
-				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
+				len = snprintf(p, remaining, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
 			} else {
-				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
+				len = snprintf(p, remaining, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
 			}
 
 		}
 
-		if (len < 0 || (size_t) len >= (sizeof(xpermsbuf) - xpermslen))
-			return NULL;
+		if (len < 0)
+			goto err;
+		if ((size_t) len >= remaining)
+			goto retry;
 
 		p += len;
-		xpermslen += len;
+		remaining -= len;
 		if (in_range)
 			in_range = 0;
 	}
 
-	len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "}");
-	if (len < 0 || (size_t) len >= (sizeof(xpermsbuf) - xpermslen))
-		return NULL;
+	len = snprintf(p, remaining, "}");
+	if (len < 0)
+		goto err;
+	if ((size_t) len >= remaining)
+		goto retry;
+
+	return buffer;
 
-	return xpermsbuf;
+err:
+	free(buffer);
+	return NULL;
 }
 
 /*
-- 
2.42.0

