Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72280C11F64
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E2E6140D
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGASJD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGASJC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 14:09:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B81C061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 11:06:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hr1so8479120ejc.1
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+54+P8emBnW1pJVqo4/s6Z9GvpXn7pEunSiOisdiNaE=;
        b=Fsre4/kHxQh9fQmP89ZA2a2LL1XiZZMrbQfNpsJhcfc8F2ObzASz3VAxx+qqOi/4tW
         iyPaRpdGzArPnd1JfrrqrdoTO+HfBp2YPMG903hz1WrkQwZvVtw41L0z12IpNpGesMkG
         WE0TPtwgHCaQ/zQ0S58YO0PBVMWrf6dWWWMM+yvNDBe8eTp3/51L+Xm9Mv9N531Bkv5Y
         ns3Jbteg73r97NrUkLabY44HswHi81lVV8bTJbdJlV0/ew5RVWsASlCZbKGJ/MC0NKT4
         XHOX61sc4d5k9QkdiBmojSQklSy3GuaeHozyvWkohm1OsVKcOut9w9J+wWCwPYGlW2j3
         28Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+54+P8emBnW1pJVqo4/s6Z9GvpXn7pEunSiOisdiNaE=;
        b=cnjek0nvoAHLakJERtru4iSwqK8viAnO7xHs3mbUCkQtwXXsB8imD4PrpLbW1YBIxG
         AMCrAynXU7TdUtZ+zPW+ROxrHilN/NGRyGDKZaqt7BTM7ZCsm5Ao8kPn0nPUtf0vYiBH
         5OivytF/OB0f/eOoj91E2hmc05r74CNBpUpUn0SA+ezsFuwXKyxhIWIaXDljOvgKOfsE
         27o1iiOBU6Pbz45oJvk0XctLKTsnfPkjUL97JCOcsfK77x3usxhoUNRuNBKzdo0InbEY
         S88crgjAF8TZB5K683I7EGI8CKq+yV4TqmC+7fn1aGareGyxXXbkMiNEaiMNDkLZYhbU
         lDcQ==
X-Gm-Message-State: AOAM533oywu17Yi2f2yS1RCX8kjWclsC8oTaXSM33gJHAveKYqOWionL
        m5tFwENO1Bmh66Otu2YDsPquy2gmztQ=
X-Google-Smtp-Source: ABdhPJyg8WUQQvbmZaSLAeCrKCh/nwkc3RhJvmbuGQ6nVY0bPDAIiUAs8f9urCq+IVtPa+/9083J0g==
X-Received: by 2002:a17:906:fa09:: with SMTP id lo9mr1181420ejb.533.1625162789203;
        Thu, 01 Jul 2021 11:06:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-223-136.77.6.pool.telefonica.de. [77.6.223.136])
        by smtp.gmail.com with ESMTPSA id j24sm243002edv.48.2021.07.01.11.06.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:06:28 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/3] libsepol: ignore UBSAN false-positives
Date:   Thu,  1 Jul 2021 20:06:22 +0200
Message-Id: <20210701180622.119708-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-5-cgzones@googlemail.com>
References: <20210608155912.32047-5-cgzones@googlemail.com>
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

Annotate functions, in which unsigned overflows are expected to happen,
with the respective Clang function attribute[1].
GCC does not support sanitizing unsigned integer arithmetic[2].

    avtab.c:76:2: runtime error: unsigned integer overflow: 6 * 3432918353 cannot be represented in type 'unsigned int'
    policydb.c:795:42: runtime error: unsigned integer overflow: 8160943042179512010 * 11 cannot be represented in type 'unsigned long'
    symtab.c:25:12: runtime error: left shift of 1766601759 by 4 places cannot be represented in type 'unsigned int'

[1]: https://clang.llvm.org/docs/AttributeReference.html#no-sanitize
[2]: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - use a common macro as suggested by Ondrej Mosnacek
  - mention that GCC does not support unsigned integer sanitation

 libsepol/src/avtab.c    |  1 +
 libsepol/src/policydb.c |  1 +
 libsepol/src/private.h  | 11 +++++++++++
 libsepol/src/symtab.c   |  4 ++++
 4 files changed, 17 insertions(+)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 88e9d510..37e8af07 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -52,6 +52,7 @@
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
+ignore_unsigned_overflow_
 static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
 {
 	static const uint32_t c1 = 0xcc9e2d51;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ef2217c2..0721c81e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -789,6 +789,7 @@ static int roles_init(policydb_t * p)
 	goto out;
 }
 
+ignore_unsigned_overflow_
 static inline unsigned long
 partial_name_hash(unsigned long c, unsigned long prevhash)
 {
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 72f21262..e54cefdb 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -47,6 +47,17 @@
 #define is_saturated(x) (x == (typeof(x))-1)
 #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
 
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
 /* Policy compatibility information. */
 struct policydb_compat_info {
 	unsigned int type;
diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index 9a417ca2..a6061851 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -8,9 +8,13 @@
  */
 
 #include <string.h>
+
+#include "private.h"
+
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
+ignore_unsigned_overflow_
 static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
 {
 	const char *p, *keyp;
-- 
2.32.0

