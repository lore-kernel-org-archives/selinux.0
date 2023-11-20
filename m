Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC19C5AD4C
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjKTOcS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 09:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjKTOcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 09:32:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446598
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 06:32:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso6488019a12.3
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 06:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700490731; x=1701095531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMG1ygiAnJlCKnpM1rmB9Q4LqR4oXzg0x3gOGbJrF74=;
        b=eWztbpIOi9s7A14q3ktcWeaD7xcrzLPgFE8101xp+fa/YxNUQfhvW9bKml6auPcx59
         fz+b85PgroANgcyGJn4zYFWfGhvttoWQtVO3vbQgomzCsIWW4Jjz9AnPnu3b8d9cdJCz
         VghtG6UO3cySAZj7mNxPw6nIDDfVZg74Rv0nKwaf7cK4H6yadHc793YQaKd0lgY2b7r1
         HeWZBmHtJR90UdX81ABDXG0BJ3FvAeXGU+q1y5pCnJxoEFODNhpU4jSnBNu1oYwXNj7m
         s2+j8VMZyftBQKgs4FQ68VMb6eprOvnlKz2S9KeG0l5YVb5FU9ktDrWwH+cjMVv9VDna
         Z+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490731; x=1701095531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMG1ygiAnJlCKnpM1rmB9Q4LqR4oXzg0x3gOGbJrF74=;
        b=MrnAlFye+QSfxS3AJWuBLWp+//RVNSMuUld6krHi/aHm2TXxsPiIhRkgEcQFq37CN3
         CvUaJfdk6G/hM9FNKp7iY2ASzxkycAZ9RDsSC+TntsqO+pCEZCRHRTQP8hTZShoUNRZq
         GPXhgVfF4kRanNERbx7ZW8jnUVn9R/mrFadApBPm9zBuaAklsezE7PVVCa8LcfL9LEWF
         xzZTEa6PIej1Nl9eYcd68fGgf9OAj7NhEVj2de4tgevoD3OUYv6jZwDTVsAeQIVuCmm5
         D51OEyCTWWyucsTEmzTdpvBx6jkND1RwDh77jOzT7ZvEzLFRvUCKkrL0thU+LpnHEmcb
         k+qA==
X-Gm-Message-State: AOJu0Yy3OpNK4yPcLaJs6BJdI+FyBG1V7G+4riwkuMfbsS714AwZVWRn
        +xrYxwSsJiklrkgW9tczuvZcSjg4txre4RxY
X-Google-Smtp-Source: AGHT+IG0ee7Du/I56ar8NO8xcuSwdb+tCwUEi5+riFtMSufoAiEDZKdlCUrpml3nA1Bt8BODHJ/7mw==
X-Received: by 2002:a50:aad7:0:b0:548:e9b5:2632 with SMTP id r23-20020a50aad7000000b00548e9b52632mr187500edc.29.1700490730664;
        Mon, 20 Nov 2023 06:32:10 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-118-211.77.10.pool.telefonica.de. [77.10.118.211])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7c904000000b00548a2d1737bsm1632282edt.35.2023.11.20.06.32.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:32:10 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: avoid fixed sized format buffer for xperms
Date:   Mon, 20 Nov 2023 15:31:45 +0100
Message-ID: <20231120143145.28831-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120143145.28831-1-cgzones@googlemail.com>
References: <20231120143145.28831-1-cgzones@googlemail.com>
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
 checkpolicy/test/dismod.c     |  9 +++++-
 checkpolicy/test/dispol.c     | 10 ++++++-
 libsepol/src/assertion.c      |  7 ++++-
 libsepol/src/kernel_to_conf.c |  9 +++---
 libsepol/src/util.c           | 54 +++++++++++++++++++++++------------
 5 files changed, 64 insertions(+), 25 deletions(-)

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
index 0a2edc85..25a3ed55 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -133,19 +133,29 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 	uint16_t low_value;
 	unsigned int bit;
 	unsigned int in_range = 0;
-	static char xpermsbuf[2048];
-	char *p;
-	int len, xpermslen = 0;
-	xpermsbuf[0] = '\0';
-	p = xpermsbuf;
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
 
 	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
 		if (!xperm_test(bit, xperms->perms))
@@ -165,35 +175,43 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
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

