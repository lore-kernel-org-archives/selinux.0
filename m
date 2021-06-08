Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A9AC47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1942460FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhFHQCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:30 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:47045 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhFHQC2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:28 -0400
Received: by mail-ej1-f51.google.com with SMTP id he7so14012746ejc.13
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cilr5VJh6Rx+zDBjugNMcKX9tEVL15YNgChmc2XaUzw=;
        b=mt1+FZOGyzulAydIUylaOxWuVaLzwhl6HH2fKcFRXqf3Th2QfbZVA5GLeC6gNKgtgc
         x88Sj8MdkuahAamq0SIDgWZM5Nx9x00E5pYzWiOO3LK4sQYdgJgoSLho1RGidYUgf4Oq
         5vXQxV5R8Anr/fqctBTzwNRJ6bFIMDZHK4/ZLfaO9n7FfjBQEpK7lAcdrHYki6S0ENuo
         hkwx3LEXnSa0W3QxaBZY0vZVVB3pr8K2ACrPyKvz9evy1eVrCsNc52hwKb+9hgCvFV85
         X33w0W+f5A0p7yXqP0sGBzhKBpaTEMtKAwiAdELLglzdU41vePUPNWfE962qbkCSPzum
         OYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cilr5VJh6Rx+zDBjugNMcKX9tEVL15YNgChmc2XaUzw=;
        b=HvxaVyi1Z1+udXGdX+r6UlLVdHck6r6LnTmqI6iPrYOMmRCnPCr5ZCHg/mTGodrs/7
         mbX7k55idqjx/w8lEorcT/YByayQq3ViW2iMZ7up3LJkx+5T65bgx3qsGNdtCaDLzyP+
         7KC8GDUXvcgeLpYdUbc0dVm/7lUO9R/5gYo/EQs/zZ7eM216cu/a5ygZCCxbEQojkh9u
         YeH+m592eEk8L0duH3gQI319cooqpiFCZ7avOdku+Pu3UtkbhkRAEnLViWJzzApYF8F2
         y3CcgzYovJxjDIWfNXYig/JXSo5sgNdwxZFQG0rjfpnK1CEANNaiQ0ucoFlhRtyiH0jD
         7D1A==
X-Gm-Message-State: AOAM530t+R7r+HxiRojeMJra2wbyJ8ugqijC9Zjk+pGqvJJvJUCTN9Zh
        xt1DMPV+LjAfI9zOW5i+PRI9VQe93UE=
X-Google-Smtp-Source: ABdhPJzACwPHZstIWYZhOu28rIS8QvDsrB6n7mjfSZKflY8N0UOPYxpdTXrB7dQW3GC5+Obhl20lZg==
X-Received: by 2002:a17:906:1dc5:: with SMTP id v5mr23788609ejh.212.1623167961499;
        Tue, 08 Jun 2021 08:59:21 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 04/23] libsepol: ignore UBSAN false-positives
Date:   Tue,  8 Jun 2021 17:58:53 +0200
Message-Id: <20210608155912.32047-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unsigned integer overflow is well-defined and not undefined behavior.
But it is still useful to enable undefined behavior sanitizer checks on
unsigned arithmetic to detect possible issues on counters or variables
with similar purpose.

Annotate functions in which unsigned overflows are expected to happen.

avtab.c:76:2: runtime error: unsigned integer overflow: 6 * 3432918353 cannot be represented in type 'unsigned int'
policydb.c:795:42: runtime error: unsigned integer overflow: 8160943042179512010 * 11 cannot be represented in type 'unsigned long'
symtab.c:25:12: runtime error: left shift of 1766601759 by 4 places cannot be represented in type 'unsigned int'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c    | 6 ++++++
 libsepol/src/policydb.c | 6 ++++++
 libsepol/src/symtab.c   | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 257f051a..c2ccb005 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -52,6 +52,12 @@
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
+#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
+__attribute__((no_sanitize("unsigned-integer-overflow")))
+#if (__clang_major__ >= 12)
+__attribute__((no_sanitize("unsigned-shift-base")))
+#endif
+#endif
 static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
 {
 	static const uint32_t c1 = 0xcc9e2d51;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc1d0711..cbe0c432 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -789,6 +789,12 @@ static int roles_init(policydb_t * p)
 	goto out;
 }
 
+#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
+__attribute__((no_sanitize("unsigned-integer-overflow")))
+#if (__clang_major__ >= 12)
+__attribute__((no_sanitize("unsigned-shift-base")))
+#endif
+#endif
 static inline unsigned long
 partial_name_hash(unsigned long c, unsigned long prevhash)
 {
diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index 9a417ca2..738fa0a4 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -11,6 +11,12 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
+#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
+__attribute__((no_sanitize("unsigned-integer-overflow")))
+#if (__clang_major__ >= 12)
+__attribute__((no_sanitize("unsigned-shift-base")))
+#endif
+#endif
 static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
 {
 	const char *p, *keyp;
-- 
2.32.0

