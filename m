Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8236090
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lo2dIB4M"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so2203241a12.1
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704479741; x=1705084541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqXpYCRV97zce1n5LhK7SN0ZNlRYUAs9gjq5c5m87OE=;
        b=Lo2dIB4MbxEPbeMAkQzr6uofFNSOoo9+tHk+VTcsSaRRY0mYxw6+ieSmdnHezG+RJo
         wlF7q3l/+WyI941upy6TpQWRWymhJMJepzchJxOwnHbQ54T40+D6XcyI+8sO6jtKfBeg
         AdXepGGsz5Ey9qK8UpbVnyPB6KxMOQVx/GMvX72i3xf9XGt5YarrD7jOuDRGAkkYzdzJ
         XaLEqZexYB7cyn7PSm7fvBQbqOmdORMANwu2Fvf+QqJBiA61ZRsxiiUDv6VuQEtlX8ZM
         EYRyc6AUFIfv9pEUXsm7QV4vcl6ZzjCwn4KExGViU0Y3FMyZao9c3MSP2glRKDt2KCBh
         SM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479741; x=1705084541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqXpYCRV97zce1n5LhK7SN0ZNlRYUAs9gjq5c5m87OE=;
        b=TCVnY7l1p4V13GZLLBGUMWkiEbb7TRKJdO+pdcPE1S2ShrHD8azu0N5AL/sAQhhz/r
         aRGnWfGy1F4zoobkmxyMWQMsJKWOZt3vSUB8qJQNC1ihevHJNAz1py0D4PJtp7UvQ4YW
         o3KM8Fti+1eU2mCnM+RZGIG+kxgUoGIhbJNeqo1FtX5BxJ7S77kfGC3g0piFGw8lann1
         2ch6EKFMXEcY/wlmRxvDAH2od9cQFkaFdxbIVAqZm7dk9xH8YDMNszmhY/4sv7Hh0YUs
         ZXEOgt0hckO/V/y22ZLrOEuQqqbwVaKHoLWV2qRyK8+gvWTAMoc8OxD+9PeZoQANXXpR
         uv/A==
X-Gm-Message-State: AOJu0YwSpVZX2U78dUdvNeGYT4X/zIvthiHsR8T12FOMMhvJOYrw1kme
	P/Y3fafZQXbX1IBuUM5QDcnOsmYAJs0=
X-Google-Smtp-Source: AGHT+IFdBbCrz/2zXwU0A8afpUYVUGYVWiakssxS0LbjnUFC4LOJWPMTeUsdU1Vua+4uLy8x1OXHkg==
X-Received: by 2002:aa7:df03:0:b0:557:6a4:35f1 with SMTP id c3-20020aa7df03000000b0055706a435f1mr1579143edy.29.1704479741045;
        Fri, 05 Jan 2024 10:35:41 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-008-063-036.77.8.pool.telefonica.de. [77.8.63.36])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b0055267663784sm1231319edb.11.2024.01.05.10.35.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:35:39 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol: reorder calloc(3) arguments
Date: Fri,  5 Jan 2024 19:35:31 +0100
Message-ID: <20240105183534.1110639-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The canonical order of calloc(3) parameters is the number of elements
first and the size of each element second.

Reported by GCC 14:

    kernel_to_conf.c:814:47: warning: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
    kernel_to_conf.c:945:46: warning: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
    kernel_to_conf.c:2109:35: warning: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
    kernel_to_common.c:578:29: warning: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 2 +-
 libsepol/src/kernel_to_conf.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 4612eef3..2422eed0 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -575,7 +575,7 @@ static int sort_ocontext_data(struct ocontext **ocons, int (*cmp)(const void *,
 		return 0;
 	}
 
-	data = calloc(sizeof(*data), num);
+	data = calloc(num, sizeof(*data));
 	if (!data) {
 		ERR(NULL, "Out of memory");
 		return -1;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 83f46e0f..e6b449b4 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -811,7 +811,7 @@ static int write_sensitivity_rules_to_conf(FILE *out, struct policydb *pdb)
 	num = strs_num_items(strs);
 
 	if (num > 0) {
-		sens_alias_map = calloc(sizeof(*sens_alias_map), pdb->p_levels.nprim);
+		sens_alias_map = calloc(pdb->p_levels.nprim, sizeof(*sens_alias_map));
 		if (!sens_alias_map) {
 			rc = -1;
 			goto exit;
@@ -942,7 +942,7 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 	num = strs_num_items(strs);
 
 	if (num > 0) {
-		cat_alias_map = calloc(sizeof(*cat_alias_map), pdb->p_cats.nprim);
+		cat_alias_map = calloc(pdb->p_cats.nprim, sizeof(*cat_alias_map));
 		if (!cat_alias_map) {
 			rc = -1;
 			goto exit;
@@ -2106,7 +2106,7 @@ static int write_cond_nodes_to_conf(FILE *out, struct policydb *pdb)
 		return 0;
 	}
 
-	cond_data = calloc(sizeof(struct cond_data), num);
+	cond_data = calloc(num, sizeof(struct cond_data));
 	if (!cond_data) {
 		rc = -1;
 		goto exit;
-- 
2.43.0

