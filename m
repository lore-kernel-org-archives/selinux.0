Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DAC18E72
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjHNNVW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHNNVF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB0173C
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso573970966b.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019252; x=1692624052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4mOkP4buA/cUMg+O2uX8hOSOHZy6mCesro8TRYnTAY=;
        b=SdZnu8bpfMA1owOzmJaQJZWMaPIVQV3j5W1t+8Dyn8Lh3y3iDTJfr/crNpBv+8OVXJ
         PHju7tLh/NNSYvZWe7+4M0M+naQPvJSvyF5ib1bsxs9FykkpoPySPZPqzHD+mhT9xMAO
         v+hYuEpWhtJ4nsQUOElr2zwrRoUBA+ajucKS1U5/1J23BTcdfwxnXTcoA6q4bauyGPdo
         Ke6pWpyzg1jM0nBedbSxCziniJfVlkJCy0b2++Q0uqpPzf2tr+lkcdEqzCWfoKX1J6Ks
         yVzCKeq/hrc5KG8CDBbTGtKYF+T9nB9TyloUaPO3G8Gl30jSMnv0DLGbHkbqp9crdmMd
         lA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019252; x=1692624052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4mOkP4buA/cUMg+O2uX8hOSOHZy6mCesro8TRYnTAY=;
        b=d9u+PbjJCaVNo67PAZAJ0zSLT9Eb/PN6EHIO6ZUiuVwr31EMD6guAp8c0OwP3Toh0H
         P2wDRA84awv/4GxwqVx8yOEoy/TmS+RGdypOfKD6r75DCRd9MFPwzF22gnGoV10jZN0A
         NAMVS7e1YvlGJ/UiIGjxVkNKE5boykEbC+X9uBgvBpRfah/R0c01UYiG6M0bfLSGgDV8
         B7Kk1zBdZYPNuyljqhmpvtuX7H4rrhcpBKdA82vd5ewyPSycvQUPN07K0n/rIzkPnMVt
         yJB/mP5puLnzcahcItaGBlvgT8l/4Aw3dER7R516SGdK4wzqvM2y42CNwPaMtxVV22gC
         k4gQ==
X-Gm-Message-State: AOJu0YyLOFB5/M8bwWh1U80s3DSTlcaL8yxgZVax+jJZwYfGQtNrQwLy
        b9EKzwez1bCBlXdXrRKDgPDJgXOzWtYV+ywOGzk=
X-Google-Smtp-Source: AGHT+IGryLZycBpKYKUk+pJT49kjITtZwAHnNIhvE9sHJkLEqczcbyxBufZCts9+xHHmsLVW3sS0iw==
X-Received: by 2002:a17:907:2c61:b0:99b:dea3:8d44 with SMTP id ib1-20020a1709072c6100b0099bdea38d44mr7885719ejc.71.1692019251767;
        Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 20/27] libselinux: check for stream rewind failures
Date:   Mon, 14 Aug 2023 15:20:18 +0200
Message-Id: <20230814132025.45364-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use fseek(3) instead of rewind(3) to detect failures.

Drop the final rewind in digest_add_specfile(), since all callers are
going to close the stream without any further action.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/is_customizable_type.c   |  7 ++++++-
 libselinux/src/label_backends_android.c |  5 ++++-
 libselinux/src/label_file.c             | 16 +++++++++++++---
 libselinux/src/label_media.c            |  5 ++++-
 libselinux/src/label_support.c          |  5 +++--
 libselinux/src/label_x.c                |  5 ++++-
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index f83e1e83..9be50174 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -31,7 +31,12 @@ static void customizable_init(void)
 	while (fgets_unlocked(buf, selinux_page_size, fp) && ctr < UINT_MAX) {
 		ctr++;
 	}
-	rewind(fp);
+
+	if (fseek(fp, 0L, SEEK_SET) == -1) {
+		fclose(fp);
+		return;
+	}
+
 	if (ctr) {
 		list =
 		    (char **) calloc(sizeof(char *),
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index c2d78360..6494f3cd 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -208,7 +208,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 
 			maxnspec = data->nspec;
-			rewind(fp);
+
+			status = fseek(fp, 0L, SEEK_SET);
+			if (status == -1)
+				goto finish;
 		}
 	}
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 471fd56b..a5677411 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -519,12 +519,16 @@ static char *rolling_append(char *current, const char *suffix, size_t max)
 	return current;
 }
 
-static bool fcontext_is_binary(FILE *fp)
+static int fcontext_is_binary(FILE *fp)
 {
 	uint32_t magic;
+	int rc;
 
 	size_t len = fread(&magic, sizeof(magic), 1, fp);
-	rewind(fp);
+
+	rc = fseek(fp, 0L, SEEK_SET);
+	if (rc == -1)
+		return -1;
 
 	return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
 }
@@ -622,7 +626,13 @@ static int process_file(const char *path, const char *suffix,
 		if (fp == NULL)
 			return -1;
 
-		rc = fcontext_is_binary(fp) ?
+		rc = fcontext_is_binary(fp);
+		if (rc < 0) {
+			(void) fclose(fp);
+			return -1;
+		}
+
+		rc = rc ?
 				load_mmap(fp, sb.st_size, rec, found_path) :
 				process_text_file(fp, rec, found_path);
 		if (!rc)
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index f09461ab..b3443b47 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -130,7 +130,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
 			maxnspec = data->nspec;
-			rewind(fp);
+
+			status = fseek(fp, 0L, SEEK_SET);
+			if (status == -1)
+				goto finish;
 		}
 	}
 	free(line_buf);
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 94fb6697..f7ab9292 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -174,12 +174,13 @@ int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 	digest->hashbuf = tmp_buf;
 
 	if (fp) {
-		rewind(fp);
+		if (fseek(fp, 0L, SEEK_SET) == -1)
+			return -1;
+
 		if (fread(digest->hashbuf + (digest->hashbuf_size - buf_len),
 					    1, buf_len, fp) != buf_len)
 			return -1;
 
-		rewind(fp);
 	} else if (from_addr) {
 		tmp_buf = memcpy(digest->hashbuf +
 				    (digest->hashbuf_size - buf_len),
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index e80bf107..e15190ca 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -157,7 +157,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
 			maxnspec = data->nspec;
-			rewind(fp);
+
+			status = fseek(fp, 0L, SEEK_SET);
+			if (status == -1)
+				goto finish;
 		}
 	}
 	free(line_buf);
-- 
2.40.1

