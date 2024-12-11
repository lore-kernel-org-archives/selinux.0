Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D81DB940
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933665; cv=none; b=c9/yLhJLHkZjy9jd9Gu419f960nxsN5dFEsZ78Ka24fhPYMalS+bv95Zt98RO6KrNTAPUpdkjuIGw2ELD9Itx3MyUN/0D0dE31arpHYJS1/URiSTONKcDFTTZlce4FDoXgsLCXYjRL4ubtJWGG+Zvo+9/OUgF/UpZg137j1miXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933665; c=relaxed/simple;
	bh=t2r1JApQRqdd8MoL21SFf6AK16w+rM1ngLPfW2dFisg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwLfOrHxdFvsWISGrI610FGARRVcQl9sWADVfpCBrdXaSLeIW0ymOXmuCGRZiij/fkxbpsfvdfpyLuStPjflF1bMMiTTK1R+WiPA90TOgpsjLo1ddejsF4/4uGVSIfqTraAgueVQFpjyU6VZjoCTHnKKlTI3gyuxo2jQvA4wx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt6WmSkz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt6WmSkz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e34339d41bso58004017b3.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933662; x=1734538462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51OKo3ZitjUqAYAB6/2PFJggGx5Qs9Q250ODhA96/4A=;
        b=Qt6WmSkzz+KF0j4cIvJvU4EUdHF9U/3kNUoXwfpC5cgiQ5ac2Xc6bQoBPbw0B0/VQc
         +Yq3ihc21f00GolmMUR3ghG37jjQOM1TRVNWNULf6KBavVRjlPaVXmNaIy6Zloex+cN5
         kYIQS3vs2o5lX7WcC5dFpJ5Dfcge5AmIGJu3uE2WeodEN9Ue5jVhDX1yTNtgobHLXUw5
         3iEgvfcQqw06ebrZd+DQQzIXYjAuoi8r7B6CUejBw+eQPiZjSemswISAdcsTSfuKyGZG
         Je1XHKKINXYDezTUTl8rDkZmasuRLjYN2On/3eRBGphEhwgJJo6faBi+tbRu/h5Kj2aT
         k7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933662; x=1734538462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51OKo3ZitjUqAYAB6/2PFJggGx5Qs9Q250ODhA96/4A=;
        b=rJbH+ruxqK4GWYmsasfJ2CdAeNgME/l1WgvaZQuX/kCH4lEkAqCJa4+D/sr/Umq3BE
         6E87nar4JanXSgMrHaQpcfDmUuukqHLa1rlSGZjLZz6W11/szGqjMvBi3ToJoi9jrL/s
         Rupk6A260wTW0yT16CyqUyZWWBew9ptvqXAqdpbW4xJPBnUD36kKRKaC4dFehNeI98KA
         Lggg41gHProV466QBxQm7JUS/+dcn64PsT78ZoxubxgW3ysQLnP8g315GhUIWbcSXaJ8
         EHjWX3XGSYUVqIf1BDE+ZIycj97Y37CTm/AqkqZTk8uFHtdN3nnZW515j58BFwJdJ2wE
         s4BQ==
X-Gm-Message-State: AOJu0Yyt3pRIZkSpfKM/rRzKcFSdb+m3Ou/HeASun3d+jm+H5PdNp8L/
	al9S/RMrmK+Qa+GpWOlJAs4nUagfI+TW48jibtRyXwygX9D1/mm1Y6iVJw==
X-Gm-Gg: ASbGncto7gIziYvDdcnpEoxnlmpckfT1MwjwXSWOZZtdrsIh1alnOpbekbT8/6ZhMGx
	2BW/Utx5CQ3+bTIPBmXVn/qj/g2B4K7aLdeOAgFPdUUFlzT7k5JNQf4eiHxFaJ1vnj4AY39ZmLA
	J/vJ7kp9gXzHD4h+U6jb34wcoxahyRWCGD2CN9pcPCGnlbQBbF+ywTn2SrnJ3aEJywiUbNVneg4
	AX62S4uP5AA/Z6B5J37CkdKaAtUcJqvKEQ9Iol8zvos3XO0B/ZDKVpZSYHXPSWaDYaN80UySoob
	+CZaXcHiEZ0=
X-Google-Smtp-Source: AGHT+IFLYilLPxMmPd0uHhGWrMcdsX4mIHezz9L/9xjf3IEcCwJ4LIFeeucb0XQC5kZ98+caZyByvQ==
X-Received: by 2002:a05:690c:dd1:b0:6ef:8177:c322 with SMTP id 00721157ae682-6f19e4f0e29mr797487b3.13.1733933662506;
        Wed, 11 Dec 2024 08:14:22 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:22 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/9] Revert "libselinux: simplify string formatting"
Date: Wed, 11 Dec 2024 11:14:00 -0500
Message-ID: <20241211161417.126236-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211161417.126236-1-jwcart2@gmail.com>
References: <20241211161417.126236-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3ff5f9efdb03378887af5986c76b55d0e1648801.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label_file.c | 38 ++++++++++++-------------------------
 libselinux/src/label_file.h |  1 -
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 80a7c5ab..b7ff8c09 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1198,9 +1198,9 @@ static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
 	free(subs);
 }
 
-static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src, size_t slen)
+static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src)
 {
-	char *dst, *tmp;
+	char *dst;
 	uint32_t len;
 
 	for (uint32_t i = 0; i < num; i++) {
@@ -1214,14 +1214,8 @@ static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, co
 					len = ptr->slen + 1;
 				else
 					len = ptr->slen;
-
-				dst = malloc(ptr->dlen + slen - len + 1);
-				if (!dst)
+				if (asprintf(&dst, "%s%s", ptr->dst, &src[len]) < 0)
 					return NULL;
-
-				tmp = mempcpy(dst, ptr->dst, ptr->dlen);
-				tmp = mempcpy(tmp, &src[len], slen - len);
-				*tmp = '\0';
 				return dst;
 			}
 		}
@@ -1257,7 +1251,7 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *ptr;
 		char *src = buf;
 		char *dst;
-		size_t slen, dlen;
+		size_t len;
 
 		while (*src && isspace((unsigned char)*src))
 			src++;
@@ -1278,14 +1272,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! *dst)
 			continue;
 
-		slen = strlen(src);
-		if (slen >= UINT32_MAX) {
-			errno = EINVAL;
-			goto err;
-		}
-
-		dlen = strlen(dst);
-		if (dlen >= UINT32_MAX) {
+		len = strlen(src);
+		if (len >= UINT32_MAX) {
 			errno = EINVAL;
 			goto err;
 		}
@@ -1304,9 +1292,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 
 		tmp[tmp_num++] = (struct selabel_sub) {
 			.src = src_cpy,
-			.slen = slen,
+			.slen = len,
 			.dst = dst_cpy,
-			.dlen = dlen,
 		};
 		src_cpy = NULL;
 		dst_cpy = NULL;
@@ -1340,19 +1327,19 @@ err:
 }
 #endif
 
-static char *selabel_sub_key(const struct saved_data *data, const char *key, size_t key_len)
+static char *selabel_sub_key(const struct saved_data *data, const char *key)
 {
 	char *ptr, *dptr;
 
-	ptr = selabel_apply_subs(data->subs, data->subs_num, key, key_len);
+	ptr = selabel_apply_subs(data->subs, data->subs_num, key);
 	if (ptr) {
-		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr, strlen(ptr));
+		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr);
 		if (dptr) {
 			free(ptr);
 			ptr = dptr;
 		}
 	} else {
-		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key, key_len);
+		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key);
 	}
 
 	return ptr;
@@ -1868,10 +1855,9 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 		clean_key[len - 1] = '\0';
 		key = clean_key;
-		len--;
 	}
 
-	sub = selabel_sub_key(data, key, len);
+	sub = selabel_sub_key(data, key);
 	if (sub)
 		key = sub;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index c7fe3a48..d5dd2be1 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -72,7 +72,6 @@ struct selabel_sub {
 	char *src;				/* source path prefix */
 	char *dst;				/* substituted path prefix */
 	uint32_t slen;				/* length of source path prefix */
-	uint32_t dlen;				/* length of substituted path prefix */
 };
 
 /* A regular expression file security context specification */
-- 
2.47.1

