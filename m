Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919FC04A94
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHKQ2B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjHKQ2A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:28:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F3419AE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf3f59905so297180466b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4mOkP4buA/cUMg+O2uX8hOSOHZy6mCesro8TRYnTAY=;
        b=GVU+M9HAg+BGISRP+2QgQ+WWEQvRYkNaFly7cuNmudzh4Fm3LXSDWGhnzkC/JEKeIK
         BW+G2wzevbay4DWyeRuADpMRppLvjRx7lwnYcaym4xTK9XDu8O9F3YffgVbjpeizuwsH
         mhEuOLFc+32a8WLKHNNNT31wphwfMkZEf03zFAPh/cGJseU/E2V2ZRkDLg6Ps7Kd6NQG
         OAqXlkeuTYKukYBkokwWazWClpC0SRq5Qot2Sm/0XBKMTf1KNrr2rIn5DxBWqPffN60Y
         SnecgqQQlJ7O6ekLqbXXtggHnZ0LFhc19UZvhuVULCAUqJwDllh44GW6zP9h+D0nN+TY
         8uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4mOkP4buA/cUMg+O2uX8hOSOHZy6mCesro8TRYnTAY=;
        b=iUdDseFE6HrYeiqQX7QWyHaqgTKl44MUKZcm8Q94ILAHg+S9QWp1P84TmZ9RJAy+xO
         fdE0BVlv6QLvvn/Nbl5ER9wdYPS7ODO0ITzpvgXsQVi2fG++Ie8/c6d8SGKfWNc1SyXI
         4Z3QsTDGgWgQ0ndtquWsgbLzRTMDcyUVDz3rpViY/4ZJRNDnSfeosSAqcHgDOZn1cDm9
         Kruf8KWGBEY6ep6etUMUD3NeQ3H+o52itA1oYfrnH/C1KNUzDMnQbBpya5D2zzIN7TgX
         lyK8OsrlR73pk73Rb972v1fjxIDfKAGV6VLSQrbXiFU0TepTEV83huSeAnWpAjfGABcu
         o9mQ==
X-Gm-Message-State: AOJu0Yw1l4cTxNcVoNy4U2osRAvorbCs8U4zI306dsSC0zaFh/8l+zat
        lDU0ZodvTq9myOyukZeV4YqxFgOjySU8Mg==
X-Google-Smtp-Source: AGHT+IH6nsQWoffqx6FLH+CDtmcC3iik/HSX2//fGwaTLABAos9pCpnEpxIcUkdeW28Y7GwRVE19kw==
X-Received: by 2002:a17:906:7693:b0:997:865a:77e5 with SMTP id o19-20020a170906769300b00997865a77e5mr2100990ejm.45.1691771278683;
        Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 20/24] libselinux: check for stream rewind failures
Date:   Fri, 11 Aug 2023 18:27:27 +0200
Message-Id: <20230811162731.50697-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

