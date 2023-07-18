Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E9C001DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGRStb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 14:49:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F511F4
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so8517690a12.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dw8NjoOxJVN2ydB0JGcjkp++KVa2ZJ3WwcRXMfk8Efw=;
        b=H1R8TuuZzaXtrRZO5DNPPFM3YloMQmRmmKsVkWFuwPjqEoY5UAJ/iCOOr0FrCHegRR
         uPM+MoZEidA/01j7yN2u845PAz96FuBCzSgBfA98MxBjH7xMACNiFoV3/1jIPAQWi8Ft
         an+oP99xVHqSUsoT4ga+h2duO3aiHyMn0M9HQbKVrTdogVYAZVOhZHTMuxTDEKUClA/3
         hqiILBi0PhfLBqQj5hX0LIksRMCpjJNZxHAzPLEU5dgcFXgOLhFoK5Xvp9aWtX83dsYD
         5eXn6LKJJqcEXh5Sg5E3z42F3Mt4DnUGbJxzh11RT8O4GunnMMvwnFAaCODswSHp+MY9
         fXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw8NjoOxJVN2ydB0JGcjkp++KVa2ZJ3WwcRXMfk8Efw=;
        b=l8RMH4z5aqtJVkXnZqk9wc6wE4JZQZgaYnATpBiSzo/0+fxsLZ4c3i8kj2EgyoIL0w
         LqsfVbYzbPaPXxJkkbKP3ZYoYyW6Dl8BP/kyu8UcBl6NjXEXHZQHLZhFf3ZzedP19W24
         bgI+BWQ+J31yLs3VXUP2athyp3hbWLNMfXLzm2eF44ivFdBGIsi8/IJKdVCJALJCwDvG
         zlQnfKlRx7V2ZAbFcNXq3rRZOQ8oFx4sh2Wj6jmELuucMA4H9eRz5MhfMe//KT9v6bHq
         eajmZJEaegyrM6g46/JM4mPLecxmgcIT5o/2YKaqhvaTenT3kkiC6msbTFp1be21yI1H
         rESA==
X-Gm-Message-State: ABy/qLZ5SAsOShD9qdszKCuYu4NSgz9iwgq2ahx/MOESETzbftQJX7Qo
        5pXpYy4i1vjsDmAUsUL2pKAflerXkcLR9A==
X-Google-Smtp-Source: APBJJlEvtQ5vE5NnKCDXD3A5qjRdjLiu3lKGrMX0pmHbL0vOY+OJT39OEkQm361Z+XCodVf76OZjHg==
X-Received: by 2002:aa7:c1d1:0:b0:51e:cc7:534d with SMTP id d17-20020aa7c1d1000000b0051e0cc7534dmr531619edp.24.1689706166836;
        Tue, 18 Jul 2023 11:49:26 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-119-136-221.95.119.pool.telefonica.de. [95.119.136.221])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b0051e1660a34esm1603758edw.51.2023.07.18.11.49.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:49:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] selinux: move debug functions into debug configuration
Date:   Tue, 18 Jul 2023 20:49:20 +0200
Message-Id: <20230718184921.112786-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718184921.112786-1-cgzones@googlemail.com>
References: <20230718184921.112786-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
the configuration SECURITY_SELINUX_DEBUG is enabled.

Move the function declarations and definitions under that configuration
as well.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c   | 2 ++
 security/selinux/ss/avtab.h   | 3 +++
 security/selinux/ss/hashtab.c | 3 ++-
 security/selinux/ss/hashtab.h | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..1f44d277ff61 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -354,6 +354,7 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 	return avtab_alloc_common(new, orig->nslot);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
@@ -384,6 +385,7 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
+#endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..0ea1ee9d4dae 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -92,7 +92,10 @@ int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
+
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag);
+#endif
 
 struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3fb8f9026e9b..b44e62f2b1e4 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -103,7 +103,7 @@ int hashtab_map(struct hashtab *h,
 	return 0;
 }
 
-
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
@@ -129,6 +129,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
 }
+#endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*copy)(struct hashtab_node *new,
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 043a773bf0b7..7836c0995871 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -142,7 +142,9 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*destroy)(void *k, void *d, void *args),
 		void *args);
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
+#endif
 
 #endif	/* _SS_HASHTAB_H */
-- 
2.40.1

