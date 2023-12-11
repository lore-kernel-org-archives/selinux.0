Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HKtQrkvr"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06CC8
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso4520030a12.0
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306117; x=1702910917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezZLq3fqkfped24WevWlAmJy57hEGle7WFPFjo4CTyA=;
        b=HKtQrkvrlbTSlxBTHsUcLAAYjJMc/PEdsUNHogpQSoKcyqvaICvo3usKBjul6cnrCK
         6Y/kjzieVRNeKFo4M0erGy3SCbnhdS/vROUshvefpc5ZDbnj9BD+DQqdR7gyT2PanZaa
         Y8XSx8UChwkiGtn+FbN2xtN6adAtDLrarbYr6ywi3SRuUJ6n3IF9QcKOJgfQVHoaHdKX
         BTNm5bAK46nj1I6srzfjzsaR9dvBqvQtWPjCh+zqMDzP16G9wIU4HbK5qjdwwiNWGqrY
         uJVLFK5jquqURybRIHhRAzqIJJC7D94kSUw2nEzL6ctiEX7MPsVAMqV43w9jU3FgebnL
         i+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306117; x=1702910917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezZLq3fqkfped24WevWlAmJy57hEGle7WFPFjo4CTyA=;
        b=iqF8BDc2h8/fZ9IFFzTubK3Jj567oEj/NJX8ea1X4GZcdZ/cf30P8kTu5omJthMo8H
         E+oGcJNt1a4bIrRYe87VfHdlwpX5qTT+fazuD2AK7wmKHuCCpEbZlkDLFfCyM8Ti6BTO
         ySmnYzRb3kn11PUq+RIR6K+5IYwQvLf7S7MgohbYxiKSnZVn4rnRzgMetZg4MScfXvAG
         ANvb3rXoA4Nkh6nsLYh9Rd+KB80V/vIVIv7KzQ4FYWA+OVptVyJPPbdHxxsRhS1EgfZ6
         pbDmuRW62QmF+OLNFr3/iyEiHqTHLfQgV1b0rFSmVqF1jJK5JIApr1JCr8wYSeSJz7du
         DuRA==
X-Gm-Message-State: AOJu0YxPZcISMtsDLuSZc+bDa0ao7qu1ngG4uYX2By0RTqpNes6jPR0+
	F+9Fg4rG6nCo41PGpXUNwn80ugnOxIU=
X-Google-Smtp-Source: AGHT+IF9kvNNdESW2RdtJIi0CfyAjSLUt7pqHXbh1tEvF2iG45HY+vhwHBvk8BwR53GnS6zO6uglfg==
X-Received: by 2002:a50:9ea1:0:b0:54b:d16:4c0e with SMTP id a30-20020a509ea1000000b0054b0d164c0emr2707043edf.15.1702306117421;
        Mon, 11 Dec 2023 06:48:37 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id bq18-20020a056402215200b0054db440489fsm3669228edb.60.2023.12.11.06.48.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:48:37 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: extended permission formatting cleanup
Date: Mon, 11 Dec 2023 15:48:26 +0100
Message-ID: <20231211144827.121636-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211144827.121636-1-cgzones@googlemail.com>
References: <20231211144827.121636-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Declare the read-only permission parameter const.
Use a more readable overflow check, which is also resilient against
changes of the growth factor or initial size.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/util.h | 2 +-
 libsepol/src/kernel_to_cil.c           | 5 ++---
 libsepol/src/util.c                    | 5 ++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index 4ea5a346..abaff698 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -34,7 +34,7 @@ extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
 extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 				sepol_access_vector_t av);
 
-char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
+char *sepol_extended_perms_to_string(const avtab_extended_perms_t *xperms);
 
 /*
  * The tokenize function may be used to
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index bcb58eee..119b657b 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1627,7 +1627,7 @@ exit:
 
 #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
-static char *xperms_to_str(avtab_extended_perms_t *xperms)
+static char *xperms_to_str(const avtab_extended_perms_t *xperms)
 {
 	uint16_t value;
 	uint16_t low_bit;
@@ -1644,8 +1644,7 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 	}
 
 retry:
-	size *= 2;
-	if (size == 0)
+	if (__builtin_mul_overflow(size, 2, &size))
 		goto err;
 	p = realloc(buffer, size);
 	if (!p)
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 4a6f7d11..687336c8 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -126,7 +126,7 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 
 #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
-char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
+char *sepol_extended_perms_to_string(const avtab_extended_perms_t *xperms)
 {
 	uint16_t value;
 	uint16_t low_bit;
@@ -142,8 +142,7 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 		return NULL;
 
 retry:
-	size *= 2;
-	if (size == 0)
+	if (__builtin_mul_overflow(size, 2, &size))
 		goto err;
 	p = realloc(buffer, size);
 	if (!p)
-- 
2.43.0

