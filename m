Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD1C001DE
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjGNSo1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbjGNSoZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:44:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6942D75
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7198363a12.1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aooVCiHnIacDoOXvzUxoLi7lG615UJA3D4Lrk87dy8=;
        b=Ozlodnl5xFO+6pIpikmIvOJybPBK2u7RAwuIC/UsMZP0o31h9nHXPEwfG1QNclcov/
         P7rgHocbSOLr9BorEKoqhSc3MulkJ6ST3VGlNl4ooUuDE0wZvYhuzKBOUpMUimon1Z3F
         N6Z7LjCFkf2oeRaS2s+MXloR1wtnXePtF1vGvcYVBZUY7JXE2GU7qNx3RkKuzdnGp2u1
         Fzrbu9sDDPTZkmnTYeH2NScMW+qW2nqyEWrbbD8Utrt5X/jz7Mw0Z0XCZRKGaJJyBPRf
         0RDfU8Q+JqMd3ypH3tmyhxgrxfs67B2lwhsDLSFWVYo6FUmy2oeOzI94KbIH2rPHBj8A
         ReyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aooVCiHnIacDoOXvzUxoLi7lG615UJA3D4Lrk87dy8=;
        b=egHpEa+chYBIZUwWgq9Ll+vfAzhaSo8xavE9fa6AvadZBgO0dcqT/M5eyrA+I4znxV
         pegTRXwObDoHKEyFIoscHRd/Q7Svi38h9eo6sSyj1vnkUki07/ntD9C4yM8eLDKrgqUI
         fL91VNkrr8mfxPwgh6s++UR2g8SqOdTcpDk8dp2pQiYtFtW743X5O+M6C40qEwLqG4R2
         Gfva/8Pg3B1H3EWaK3sjv/ambwk9Q4BAOb1IZ5rXQajlTWJ2i8wzFj/vbnaHY7a7O1iA
         Z77rndefcU7swKXGmGDV/FsM734R/3zzMNi+kTVVreNqw7yhVDkipH7UBJCuTe+aMYP1
         GVWg==
X-Gm-Message-State: ABy/qLYVmJQNHuyVbGkzouNtfb4bq1f2H5kHfZPGYcFrmtW5JYBzZQXV
        rTb3GcjDuV9U/kdbtok75oKKqy5oU/bkxQ==
X-Google-Smtp-Source: APBJJlG20jk0usQ0hirH6DeLqCm8XdK3BAfkeuVIeimMmZDzosFAdrNG3fX4C+me/IgXsd67gNr7bA==
X-Received: by 2002:a17:907:3c1e:b0:98d:4ae:8db9 with SMTP id gh30-20020a1709073c1e00b0098d04ae8db9mr3731970ejc.19.1689360262076;
        Fri, 14 Jul 2023 11:44:22 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm5692167eju.215.2023.07.14.11.44.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:44:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] hashtab: update
Date:   Fri, 14 Jul 2023 20:44:12 +0200
Message-Id: <20230714184414.40724-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714184414.40724-1-cgzones@googlemail.com>
References: <20230714184414.40724-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid overflowing number of elements in hashtab_insert().

Use identical type for hashed values to avoid implicit conversions.

Declare tag parameter of hashtab_hash_eval() const since it is only
printed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Might be related to oss-fuzz issue 60583, but could not reproduce.
---
 libsepol/include/sepol/policydb/hashtab.h |  2 +-
 libsepol/src/hashtab.c                    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 354ebb43..583ac08e 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -108,7 +108,7 @@ extern int hashtab_map(hashtab_t h,
 				     hashtab_datum_t d,
 				     void *args), void *args);
 
-extern void hashtab_hash_eval(hashtab_t h, char *tag);
+extern void hashtab_hash_eval(hashtab_t h, const char *tag);
 
 /* Returns number of elements in the hashtab h or 0 is h is NULL */
 static inline uint32_t hashtab_nel(hashtab_t h)
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 922a8a4a..6f01d094 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -103,10 +103,10 @@ static void hashtab_check_resize(hashtab_t h)
 
 int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 {
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t prev, cur, newnode;
 
-	if (!h)
+	if (!h || h->nel == UINT32_MAX)
 		return SEPOL_ENOMEM;
 
 	hashtab_check_resize(h);
@@ -144,7 +144,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 		   void (*destroy) (hashtab_key_t k,
 				    hashtab_datum_t d, void *args), void *args)
 {
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t cur, last;
 
 	if (!h)
@@ -176,7 +176,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t cur;
 
 	if (!h)
@@ -240,10 +240,10 @@ int hashtab_map(hashtab_t h,
 	return SEPOL_OK;
 }
 
-void hashtab_hash_eval(hashtab_t h, char *tag)
+void hashtab_hash_eval(hashtab_t h, const char *tag)
 {
 	unsigned int i;
-	int chain_len, slots_used, max_chain_len;
+	size_t chain_len, slots_used, max_chain_len;
 	hashtab_ptr_t cur;
 
 	slots_used = 0;
@@ -264,6 +264,6 @@ void hashtab_hash_eval(hashtab_t h, char *tag)
 	}
 
 	printf
-	    ("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+	    ("%s:  %d entries and %zu/%d buckets used, longest chain length %zu\n",
 	     tag, h->nel, slots_used, h->size, max_chain_len);
 }
-- 
2.40.1

