Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299F1CD210
	for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616799; cv=none; b=M+LMGKDB/oTQv65EtVFdzeoqETs9OlWX4bK2zUBvCH+5f1CZxYGO2ifaW1jMnnyZ/aT7tOyHNtSbP/+vn5E5bL9QuC2RT0OFp99rqjX1lpFlUgiujNwsVip3LUrhqNB8PXexzAG/yMQTpaC+44eQCOBKyqCwYc/wJ5qNHM//bUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616799; c=relaxed/simple;
	bh=sdEzIVtsfnSYIUDSWn3S6LzxgJKfDvct3S8KUK6M7UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muworwP6HDd1duIiTiogj9s7ETvfJ3h7BoQVYXji+WlvxjKJZFbUx4qn+fOrJLCjLmXYAiUaab//i4tEYfMJKAuzOD1De1o11LrHD5Y+5VkgaHXxJTkf6TyNtbVx7yadYqm1ox4CgrtWltZFIIuNfJlnasXJZqFpnams80Uz6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UVfpZNIT; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UVfpZNIT"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732616795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwx9QABFoZ/GFUWjEk25WviYDLBReBa2xu/sq/fzgS4=;
	b=UVfpZNITEq2PGH1nIh17FdAUw4I8Xh1ld1MBTXeVo1LN2YkZg4XsP+OiKGoXwbX7UMFRKn
	3XRtMMQRypj/kAV3aKxspYVcUGheOmKpzhfBlK63U6ERcrj6mstc0OZo9YV35BkhLKnmSa
	C35oG0R9vBzxFL+r3bIf1h9kR+Lcc1Cjd2CUGBmjHLxcozrWR4bqD3ygJhdgnhNupXFNli
	BCWCkFm6ueT6VWKKfgIKaZF4EPAXLKDvUCSKRmN91TumrA95yVsImEryIM2PNnhhMMEf8H
	0RtAZmY2fy6PJAy6tnBZciH9OPnotH/oeSUlmJfJvYSuKovMJRPuQYqQ3lETkw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 3/3] libselinux: simplify string formatting
Date: Tue, 26 Nov 2024 11:26:21 +0100
Message-ID: <20241126102621.20253-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241126102621.20253-1-cgoettsche@seltendoof.de>
References: <20241126102621.20253-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Instead of using asprintf(3) and heavy string formatting just manually
concatenate the substitution string.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/src/label_file.c | 38 +++++++++++++++++++++++++------------
 libselinux/src/label_file.h |  1 +
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 8050ef1a..ef308309 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1130,9 +1130,9 @@ static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
 	free(subs);
 }
 
-static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src)
+static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src, size_t slen)
 {
-	char *dst;
+	char *dst, *tmp;
 	uint32_t len;
 
 	for (uint32_t i = 0; i < num; i++) {
@@ -1146,8 +1146,14 @@ static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, co
 					len = ptr->slen + 1;
 				else
 					len = ptr->slen;
-				if (asprintf(&dst, "%s%s", ptr->dst, &src[len]) < 0)
+
+				dst = malloc(ptr->dlen + slen - len + 1);
+				if (!dst)
 					return NULL;
+
+				tmp = mempcpy(dst, ptr->dst, ptr->dlen);
+				tmp = mempcpy(tmp, &src[len], slen - len);
+				*tmp = '\0';
 				return dst;
 			}
 		}
@@ -1183,7 +1189,7 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *ptr;
 		char *src = buf;
 		char *dst;
-		size_t len;
+		size_t slen, dlen;
 
 		while (*src && isspace((unsigned char)*src))
 			src++;
@@ -1204,8 +1210,14 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! *dst)
 			continue;
 
-		len = strlen(src);
-		if (len >= UINT32_MAX) {
+		slen = strlen(src);
+		if (slen >= UINT32_MAX) {
+			errno = EINVAL;
+			goto err;
+		}
+
+		dlen = strlen(dst);
+		if (dlen >= UINT32_MAX) {
 			errno = EINVAL;
 			goto err;
 		}
@@ -1224,8 +1236,9 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 
 		tmp[tmp_num++] = (struct selabel_sub) {
 			.src = src_cpy,
-			.slen = len,
+			.slen = slen,
 			.dst = dst_cpy,
+			.dlen = dlen,
 		};
 		src_cpy = NULL;
 		dst_cpy = NULL;
@@ -1259,19 +1272,19 @@ err:
 }
 #endif
 
-static char *selabel_sub_key(const struct saved_data *data, const char *key)
+static char *selabel_sub_key(const struct saved_data *data, const char *key, size_t key_len)
 {
 	char *ptr, *dptr;
 
-	ptr = selabel_apply_subs(data->subs, data->subs_num, key);
+	ptr = selabel_apply_subs(data->subs, data->subs_num, key, key_len);
 	if (ptr) {
-		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr);
+		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr, strlen(ptr));
 		if (dptr) {
 			free(ptr);
 			ptr = dptr;
 		}
 	} else {
-		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key);
+		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key, key_len);
 	}
 
 	return ptr;
@@ -1787,9 +1800,10 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 
 		clean_key[len - 1] = '\0';
 		key = clean_key;
+		len--;
 	}
 
-	sub = selabel_sub_key(data, key);
+	sub = selabel_sub_key(data, key, len);
 	if (sub)
 		key = sub;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 436982bf..122894a2 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -72,6 +72,7 @@ struct selabel_sub {
 	char *src;				/* source path prefix */
 	char *dst;				/* substituted path prefix */
 	uint32_t slen;				/* length of source path prefix */
+	uint32_t dlen;				/* length of substituted path prefix */
 };
 
 /* A regular expression file security context specification */
-- 
2.45.2

