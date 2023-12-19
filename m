Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052921D548
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eCSEADX2"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e23a4df33so4889326e87.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002219; x=1703607019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/m8IMvq/snFxkoQogejsaFXSTRjzN8V96JGaHPR9tc=;
        b=eCSEADX2NzPAbYZ7AvROAi9xL5Bi8f/A9dCUQX2EMBeFfdGeQE0DDvAPTVNetqBR85
         /mnnbe9B4a49s2bYdOz6UEN7uFG+xRKc9Lb3S2BemY4vwS/rnptP6bAwJTV13LP5ZQ34
         Fwx0fi+HX71t98wNWLiDGlEQAnutLjlI/PczRApkC58P5AzRFqWYkJTV21vlrqsq0t5p
         b/2QtRD15O3tHoaLiHXQ6XLoTAed9ry5EVNZw3dPjK+XV9yOzSecmF7hFf5ywFbgIWr2
         lJpShIUmTD67+E7n7wPPYhbO+JOLQX/wDa1IYGH4a4YKLC3HjANU3329kl6nBksVYb3H
         1NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002219; x=1703607019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/m8IMvq/snFxkoQogejsaFXSTRjzN8V96JGaHPR9tc=;
        b=V+Q3oSam6Kpxwsg86UE1otfI/pOKvc9DuSwoBGB6ZVTYv9f1aFtGDerDuxBJkur/1G
         SjIBYh//tQfxmKqy2scmKkHX88bygQ5GH0gp6NBvBJFmDbTXMmO9a8GxGy98JKC/Ux0p
         xlmd2tBX6CnDxDQdS8vqK9xAljXu/B9cB83vPblallGAE0RKW/Lcrry2letLeRD900yY
         aWmHuAClwJPSfxw2+rucx8sIlOMmwHkG2YBMNEqUEdWWpZ0txOJM631/x4HA51Jw3mIy
         RBj80nFVsEpKSVVfwcbo8GFAGGDbmzWlw5LjbV8b/jvAFHkyQYlQ2WDpSZRa6l5h7+2r
         WnsA==
X-Gm-Message-State: AOJu0Yx8Rd+5GKGIySp1Kyqai1NtOHpFYujpGSpQLWOV3Id+IozN6zhK
	0N39oHwhBST9T5yLXsNb5H27oSJSw8I=
X-Google-Smtp-Source: AGHT+IGrBJ7mGx/gun45lGAN6KJCQqPEhIMvNyhPLdD1fQW72n6aewqTuAYoHS32XpFu6gywYtKN3g==
X-Received: by 2002:a05:6512:2312:b0:50b:f6d2:8569 with SMTP id o18-20020a056512231200b0050bf6d28569mr10583728lfu.129.1703002218804;
        Tue, 19 Dec 2023 08:10:18 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:18 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 10/11] libselinux: enable usage with pedantic UB sanitizers
Date: Tue, 19 Dec 2023 17:09:32 +0100
Message-ID: <20231219160943.334370-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clang's undefined behavior sanitizer supports checking for unsigned
integer overflow and underflow, and implicit conversions.  While those
operations are well-defined by the C language they can signal logic
mistakes or processing of unchecked user input.

Annotate functions deliberately making use of integer overflow and adopt
the remaining code sites.

Example reports:

    stringrep.c:348:7: runtime error: left shift of 2147483648 by 1 places cannot be represented in type 'access_vector_t' (aka 'unsigned int')
    seusers.c:98:14: runtime error: implicit conversion from type 'int' of value -1 (32-bit, signed) to type 'gid_t' (aka 'unsigned int') changed the value to 4294967295 (32-bit, unsigned)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c                    |  4 +++-
 libselinux/src/avc_sidtab.c             |  1 +
 libselinux/src/label.c                  |  7 +++++--
 libselinux/src/label_backends_android.c |  4 +++-
 libselinux/src/label_db.c               |  3 ++-
 libselinux/src/label_file.c             |  6 ++++--
 libselinux/src/label_media.c            |  4 +++-
 libselinux/src/label_x.c                |  4 +++-
 libselinux/src/selinux_internal.h       | 11 +++++++++++
 libselinux/src/seusers.c                |  2 +-
 libselinux/src/sha1.c                   |  3 +++
 libselinux/src/stringrep.c              |  4 +++-
 12 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 5e1c036e..ce87ac16 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -229,13 +229,15 @@ int avc_open(struct selinux_opt *opts, unsigned nopts)
 {
 	avc_setenforce = 0;
 
-	while (nopts--)
+	while (nopts) {
+		nopts--;
 		switch(opts[nopts].type) {
 		case AVC_OPT_SETENFORCE:
 			avc_setenforce = 1;
 			avc_enforcing = !!opts[nopts].value;
 			break;
 		}
+	}
 
 	return avc_init_internal("avc", NULL, NULL, NULL, NULL);
 }
diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index e396a938..3303537b 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -13,6 +13,7 @@
 #include "avc_sidtab.h"
 #include "avc_internal.h"
 
+ignore_unsigned_overflow_
 static inline unsigned sidtab_hash(const char * key)
 {
 	unsigned int hash = 5381;
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 4a7c6e6d..d2e703ef 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -60,7 +60,8 @@ static inline struct selabel_digest *selabel_is_digest_set
 {
 	struct selabel_digest *digest = NULL;
 
-	while (n--) {
+	while (n) {
+		n--;
 		if (opts[n].type == SELABEL_OPT_DIGEST &&
 					    !!opts[n].value) {
 			digest = calloc(1, sizeof(*digest));
@@ -112,9 +113,11 @@ static void selabel_digest_fini(struct selabel_digest *ptr)
 static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 					  unsigned n)
 {
-	while (n--)
+	while (n) {
+		n--;
 		if (opts[n].type == SELABEL_OPT_VALIDATE)
 			return !!opts[n].value;
+	}
 
 	return 0;
 }
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 7ddacdbe..33a17236 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -152,7 +152,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	struct stat sb;
 
 	/* Process arguments */
-	while (n--)
+	while (n) {
+		n--;
 		switch (opts[n].type) {
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
@@ -165,6 +166,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			errno = EINVAL;
 			return -1;
 		}
+	}
 
 	if (!path)
 		return -1;
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 2daf1770..2ff10b2f 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -263,7 +263,8 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	 *   the default one. If RDBMS is not SE-PostgreSQL, it may need to
 	 *   specify an explicit specfile for database objects.
 	 */
-	while (nopts--) {
+	while (nopts) {
+		nopts--;
 		switch (opts[nopts].type) {
 		case SELABEL_OPT_PATH:
 			path = opts[nopts].value;
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 315298b3..3b2bda97 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -68,7 +68,7 @@ static int find_stem_from_file(struct saved_data *data, const char *key)
 /*
  * hash calculation and key comparison of hash table
  */
-
+ignore_unsigned_overflow_
 static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
 {
 	const struct chkdups_key *k = (const struct chkdups_key *)key;
@@ -801,7 +801,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	int status = -1, baseonly = 0;
 
 	/* Process arguments */
-	while (n--)
+	while (n) {
+		n--;
 		switch(opts[n].type) {
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
@@ -820,6 +821,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			errno = EINVAL;
 			return -1;
 		}
+	}
 
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 	char subs_file[PATH_MAX + 1];
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 4c987988..fad5ea6d 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -80,7 +80,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	struct stat sb;
 
 	/* Process arguments */
-	while (n--)
+	while (n) {
+		n--;
 		switch(opts[n].type) {
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
@@ -93,6 +94,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			errno = EINVAL;
 			return -1;
 		}
+}
 
 	/* Open the specification file. */
 	if (!path)
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index f332dcb6..bf569ca5 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -107,7 +107,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	struct stat sb;
 
 	/* Process arguments */
-	while (n--)
+	while (n) {
+		n--;
 		switch(opts[n].type) {
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
@@ -120,6 +121,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			errno = EINVAL;
 			return -1;
 		}
+	}
 
 	/* Open the specification file. */
 	if (!path)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index af69ff04..b134808e 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -102,4 +102,15 @@ size_t strlcpy(char *dest, const char *src, size_t size);
 void *reallocarray(void *ptr, size_t nmemb, size_t size);
 #endif
 
+/* Use to ignore intentional unsigned under- and overflows while running under UBSAN. */
+#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
+#if (__clang_major__ >= 12)
+#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow", "unsigned-shift-base")))
+#else
+#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow")))
+#endif
+#else
+#define ignore_unsigned_overflow_
+#endif
+
 #endif /* SELINUX_INTERNAL_H_ */
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 16d69347..5a521f81 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -99,7 +99,7 @@ int require_seusers  = 0;
 
 static gid_t get_default_gid(const char *name) {
 	struct passwd pwstorage, *pwent = NULL;
-	gid_t gid = -1;
+	gid_t gid = (gid_t)-1;
 	/* Allocate space for the getpwnam_r buffer */
 	char *rbuf = NULL;
 	long rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 9d51e04a..452b0cc2 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -26,6 +26,8 @@
 #include "sha1.h"
 #include <memory.h>
 
+#include "selinux_internal.h"
+
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //  TYPES
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -62,6 +64,7 @@ typedef union
 //
 //  Hash a single 512-bit block. This is the core of the algorithm
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ignore_unsigned_overflow_
 static
 void
     TransformFunction
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index d2237d1c..1b460224 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -337,13 +337,15 @@ void print_access_vector(security_class_t tclass, access_vector_t av)
 
 	printf(" {");
 
-	while (av) {
+	for (;;) {
 		if (av & bit) {
 			permstr = security_av_perm_to_string(tclass, bit);
 			if (!permstr)
 				break;
 			printf(" %s", permstr);
 			av &= ~bit;
+			if (!av)
+				break;
 		}
 		bit <<= 1;
 	}
-- 
2.43.0

