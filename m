Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E83E487
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328237; cv=none; b=Hb2iUgcOrj37ctp/RtDMqFAW4ZSxD2+91sdw3WY6Wp0tgbkIDr1G2WrU6q0ipXIIDQb09FJpzu5OUIhDFmJRsQO4zFQudXv3a3qgB79dnwHu7xVXDrcV266tCSRqxlr12UeaLGHmNI7e67NhzWYSCDai3wP6HoIJyAtArvSa1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328237; c=relaxed/simple;
	bh=4ztcL+6BxWfIXGDdOQTJ5sUO27kSgcY4Sb1LRf6H2V4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXrn4reOQmL61P9lBO01MCiMYs4zhNfzt1163EJzxvTQy+jNibpKZOgNG+Flx9MwODVbm+1QWTwZru/3QOsdSKnxybByDJfsEM4hRZr0sytdnWwRq6p76Ztq7trqSGSO8TS583z9y8e0uVL4FcrLNnBVA/KDorq1I+7LcXoyBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PdZH++dL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PdZH++dL"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45c006ab82so116697966b.3
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710328233; x=1710933033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roO1ax7ZDubGjOE2RNNW66GkRYFmH52w/HjwQWhI3fk=;
        b=PdZH++dLWmM/94G/0YzkWAEMevgUYbso6qjMfL0XLUAWRwjoWCvVtqBtFQ8q2Cu39X
         aetL0WAgYL8gYYWZpZvQUz+o92D7n4V1AAFisRnwAxRn3xQm4h9gM6tObu2+vZ55Mx16
         ZaEW6vws3bkxm0YP8kpyHNgd7mx8z8Bg1mlt3f3sBTKVJBlWICO90txbkxEhtK1t2wCQ
         oDzzkNT12CgxuDtFuE7DArusP/L+LQQgXhXMFy4e0mQaaXtZ195nswB5R+VaBk5hPNLH
         0LwuRGNf0Ba0wJZ77AMHT67DaEXfTyrB0D7UmpVf1J4rtokUDZSLsWA7kdi1CdIrV3lu
         B/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328233; x=1710933033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roO1ax7ZDubGjOE2RNNW66GkRYFmH52w/HjwQWhI3fk=;
        b=CPY7sB3B1ds8OMkiK2+3ch1wZqjnrwj2ANaA+/64cvAW4Iez8KGd0VLxLV7jQuE4l5
         Fw5aM3eNKvj0dbrcxHDRPJAZg7Q9vD95tN3PHzQNA5D3qila3msbeWv0IY6AARLdLqh0
         R//G2uyj7qQuzqFoYsd+2m46zdZqUFcrBqey5MX29T5DIN/+ONjy9Z8LqZoJk/yBrPcF
         GiZoIVc/PZXP1v4EVRi2COXxtu80w8U/jYWBlfjdxgkhohqrgO9epl+3oE31aSjGm1Ld
         ZT6MGHbNyw7l8Ezh4Ij/Xxdd22OBQE5zPXNGJLfW9WKugGsGJLp9MhQ1CMjgV9smDR3Z
         C3hg==
X-Gm-Message-State: AOJu0YwNe4NJrx57gvVbdZ+WgQzNLoRaPlEbsz1JGyDXB2f7iXHnq3H3
	8suwEZK6jAaxB36gkwAu0kopUUwgYX3m/Mi6LNtsc3b0sZncqnFCbQfBaKS2P8M=
X-Google-Smtp-Source: AGHT+IFxNZvB7D/Wmb6VcoqpO9R03H2YN41RnsI68m4+Yh/tYe7tGe5Qkx8KREAnn5/fdW2f7Ijycw==
X-Received: by 2002:a17:907:160c:b0:a46:4548:aba6 with SMTP id cw12-20020a170907160c00b00a464548aba6mr4122213ejd.56.1710328233416;
        Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-077-001-104-044.77.1.pool.telefonica.de. [77.1.104.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00a463c821e4dsm1794319ejc.10.2024.03.13.04.10.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 4/5] libselinux: free data on selabel open failure
Date: Wed, 13 Mar 2024 12:10:24 +0100
Message-ID: <20240313111025.43720-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313111025.43720-1-cgzones@googlemail.com>
References: <20240313111025.43720-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case the init function for a selabel backend fails, free the possible
already allocated data:

    Direct leak of 16 byte(s) in 1 object(s) allocated from:
        #0 0x5e7e2bf001e3 in malloc (/tmp/destdir/usr/sbin/selabel_digest+0xc71e3)
        #1 0x7233764baa65 in selabel_media_init /home/christian/Coding/workspaces/selinux/libselinux/src/label_media.c:226:30
        #2 0x7233764ac1fe in selabel_open /home/christian/Coding/workspaces/selinux/libselinux/src/label.c:227:6
        #3 0x5e7e2bf3ebfc in main /home/christian/Coding/workspaces/selinux/libselinux/utils/selabel_digest.c:125:8
        #4 0x7233761856c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

    SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c                  | 5 +----
 libselinux/src/label_backends_android.c | 3 +++
 libselinux/src/label_db.c               | 3 +++
 libselinux/src/label_file.c             | 3 +++
 libselinux/src/label_media.c            | 3 +++
 libselinux/src/label_x.c                | 3 +++
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index d2e703ef..06d743ec 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -225,10 +225,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	rec->digest = selabel_is_digest_set(opts, nopts);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
-		if (rec->digest)
-			selabel_digest_fini(rec->digest);
-		free(rec->spec_file);
-		free(rec);
+		selabel_close(rec);
 		rec = NULL;
 	}
 
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 33a17236..49a87686 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -246,6 +246,9 @@ static void closef(struct selabel_handle *rec)
 	struct spec *spec;
 	unsigned int i;
 
+	if (!data)
+		return;
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &data->spec_arr[i];
 		free(spec->property_key);
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 2ff10b2f..40d5fc4a 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -178,6 +178,9 @@ db_close(struct selabel_handle *rec)
 	spec_t	       *spec;
 	unsigned int	i;
 
+	if (!catalog)
+		return;
+
 	for (i = 0; i < catalog->nspec; i++) {
 		spec = &catalog->specs[i];
 		free(spec->key);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3b2bda97..2732972e 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -904,6 +904,9 @@ static void closef(struct selabel_handle *rec)
 	struct stem *stem;
 	unsigned int i;
 
+	if (!data)
+		return;
+
 	selabel_subs_fini(data->subs);
 	selabel_subs_fini(data->dist_subs);
 
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index fad5ea6d..94a58062 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -167,6 +167,9 @@ static void close(struct selabel_handle *rec)
 	struct spec *spec, *spec_arr = data->spec_arr;
 	unsigned int i;
 
+	if (!data)
+		return;
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &spec_arr[i];
 		free(spec->key);
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index bf569ca5..f994eefa 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -194,6 +194,9 @@ static void close(struct selabel_handle *rec)
 	struct spec *spec, *spec_arr = data->spec_arr;
 	unsigned int i;
 
+	if (!data)
+		return;
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &spec_arr[i];
 		free(spec->key);
-- 
2.43.0

