Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nagKGUS0"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC1C5
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so5116925e87.1
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306116; x=1702910916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPPqqtehm+rjYHqFPkgT3lkvCjySc5xpbwpYfeiKO7M=;
        b=nagKGUS0Wh0ORwPks77CgpU5oshNCnTl87RPi/mFTT4ynRgIViuvo/dT/gt2BWIjOC
         I2gjZacwEeyxrlI6/dI0MxZSB3YbHrbdLf1kSLc10NRjEq7PCmf71kcUVBFXve+KKpzW
         MXfYaB2Hojf9K7wl1lufM9i0YtUvjGzD2XSOTtMc+vg9qq1jdAV5JVOm0LJH160XklXm
         ydlXZ9KClbg5McQDLnXkq//tXZbEZJSocPF6O6iS1jdgVx5BPkKEm198MhkCwBhxsm/N
         uCSI0EmxHa0MBWdJsg3li5tbwluIy0JRPBkhT3j4oYi95ExbwJGeIsGD1n9nKgNmBsjn
         pPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306116; x=1702910916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPPqqtehm+rjYHqFPkgT3lkvCjySc5xpbwpYfeiKO7M=;
        b=DzWjN9ikKVIWEXxRx60GTPUhXgaKVxpnAnNnZcLdev0xGGqqaR9Y3FX6ZfqyRt+6kM
         BSqsT9F/v1dtuQ1lsu9m/en2Er3CKq5Eehb2ofzeFXZ3gHTWbrCEEoIU9H0xPyPTtG1e
         TMF5bO0u0paePtJZNa72gYOtVCucVsceja5lHbnCDJJnwMGFFqNVT2XWRVHLBc9B1kPC
         vYcJOUv0xtw7Ji2NFUcKJ0r3flBcCxvg69Q7p/fykuVJELPraFQWeS3pwQh1efPzhFxQ
         YvWJn8eRZWhTeeceYJV7KG6gRNauiC/mbq9HZLhw9CxLVUuM9pyNaXzma+lQaU/HixQd
         f+Dg==
X-Gm-Message-State: AOJu0Yz/E/YNqWM1ecLGYxvVVMiLsoPZXzVBYPyL40J994gUMC+It6eW
	TojY3ayET0edCIq1RIO+eHVIEEfqzDo=
X-Google-Smtp-Source: AGHT+IEOodU1iVjVCfDKA8ltBLyNPAnGM13xuLhWhOt4lg8b/AAlBcsEBo4ZU8DFIVSwiJEnsSAa5Q==
X-Received: by 2002:a05:6512:46b:b0:50b:ff86:c46f with SMTP id x11-20020a056512046b00b0050bff86c46fmr1795761lfd.63.1702306116448;
        Mon, 11 Dec 2023 06:48:36 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id bq18-20020a056402215200b0054db440489fsm3669228edb.60.2023.12.11.06.48.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:48:36 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: constify tokenized input
Date: Mon, 11 Dec 2023 15:48:24 +0100
Message-ID: <20231211144827.121636-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The input string to be tokenized is not modified.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/util.h | 2 +-
 libsepol/src/util.c                    | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index db8da213..4ea5a346 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -40,7 +40,7 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
  * The tokenize function may be used to
  * replace sscanf
  */
-extern int tokenize(char *line_buf, char delim, int num_args, ...);
+extern int tokenize(const char *line_buf, char delim, int num_args, ...);
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 2f877920..571f6c93 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -221,9 +221,9 @@ err:
  */
 
 /* Read a token from a buffer */
-static inline int tokenize_str(char delim, char **str, char **ptr, size_t *len)
+static inline int tokenize_str(char delim, char **str, const char **ptr, size_t *len)
 {
-	char *tmp_buf = *ptr;
+	const char *tmp_buf = *ptr;
 	*str = NULL;
 
 	while (**ptr != '\0') {
@@ -273,9 +273,10 @@ static inline int tokenize_str(char delim, char **str, char **ptr, size_t *len)
  * contain the remaining content of line_buf. If the delimiter is any whitespace
  * character, then all whitespace will be squashed.
  */
-int tokenize(char *line_buf, char delim, int num_args, ...)
+int tokenize(const char *line_buf, char delim, int num_args, ...)
 {
-	char **arg, *buf_p;
+	char **arg;
+	const char *buf_p;
 	int rc, items;
 	size_t arg_len = 0;
 	va_list ap;
-- 
2.43.0

