Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A6C04FDF
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbjHPMjO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245341AbjHPMjE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 08:39:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685E26AD
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c4923195dso878622366b.2
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692189541; x=1692794341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRKI2CkRVXkPU8ujHaTJKF3+4wx1OlgSghxDrBnixgA=;
        b=L2lS569m9knaVmLxglzcTUdnSVlncl9RmWQUCK9HWbXchD/OM1h1ktRr9qWDoq+YuC
         hpS3IWzjhcVmjRApK5sQMWxJY94zRmiJVOmYRS7cnCihYJlgvZBcnWB1dGc7kWKagQX+
         qh7R1ftajv8WeV1ZoFNFRFOOdbHeyJMwN+uXce6LPB4tmydNvVI8Idigo6jNSFCiAuRx
         daxKmiu/B9DA6Od5E9zAcf9qFeXJnuDfo9Fvywo1u1VPeFVEOPRYWzM/+/QjoG0rfHvg
         xWufCBuNw5WTbwTu14ke5bhfSBc7xu/+453Tg0L5nyroOrZ/41X7pLfULyJK1nwyG8GH
         Debw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189541; x=1692794341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRKI2CkRVXkPU8ujHaTJKF3+4wx1OlgSghxDrBnixgA=;
        b=GDcblcz5XEo5URW4FI0QrIIq4jixmQK31akyx/S2fO3itqjdOpo4L8kq/tjmVmcM9p
         0xG0XoNJq7UwN6iNwVM9uYPkLVSv63fEzyWnHbG5HDowpG5cnspJFu17eYqH48l0MsjX
         /gyALCxPrVo29YCerYKolJSPYldFae6rFW9whm+cq8/CeDihmK2P12nfqngfUhxBeKNJ
         3MkD452JntOGN3zycrdVXH0k6M8nKJ0CdeKqp27uSbCu0m6/3YR71APmPWTIAboR7ntY
         O9D2CaVKh8v1MrS3JaKkg3xcsb3etOpcZD5dAEMUo1S0JKLpWoSeC1UbWMVMyFkgs8bO
         DG1Q==
X-Gm-Message-State: AOJu0YzCgZeCvuozDBEl7ursqP9I4evqzeYKWFMNHSKZ0dZE6P5hxxrh
        6gAlr7cQ3FKhIAs2K/oqbMM5U0Q062waQ2ZC
X-Google-Smtp-Source: AGHT+IHFQX6PLwKaFUaZhVjYMAXgLBBOGJGTL+u/f0TIFTWuxDi3l8LDkc5mxtFjUYpt1X++Esu5Cg==
X-Received: by 2002:a17:907:784b:b0:99b:dd1d:bc58 with SMTP id lb11-20020a170907784b00b0099bdd1dbc58mr1335170ejc.41.1692189540762;
        Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-001-094-128.77.1.pool.telefonica.de. [77.1.94.128])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm8434075ejk.137.2023.08.16.05.39.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] newrole: use DJB2a string hash function
Date:   Wed, 16 Aug 2023 14:38:45 +0200
Message-Id: <20230816123845.80171-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816123845.80171-1-cgzones@googlemail.com>
References: <20230816123845.80171-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hash table implementation uses `& (h->size - 1)` to truncate
generated hashes to the number of buckets.  This operation is equal to
`% h->size` if and only if the size is a power of two (which seems to be
always the case).  One property of the binary and with a power of two
(and probably a small one <=2048) is all higher bits are discarded.
Thus a hash function is needed with a good avalanche effect, which the
current one is not.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index d9efa68a..5a1a1129 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -229,16 +229,13 @@ static int free_hashtab_entry(hashtab_key_t key, hashtab_datum_t d,
 
 static unsigned int reqsymhash(hashtab_t h, const_hashtab_key_t key)
 {
-	const char *p;
-	size_t size;
-	unsigned int val;
-
-	val = 0;
-	size = strlen(key);
-	for (p = key; ((size_t) (p - key)) < size; p++)
-		val =
-		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
-	return val & (h->size - 1);
+	unsigned int hash = 5381;
+	unsigned char c;
+
+	while ((c = *(unsigned const char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash & (h->size - 1);
 }
 
 static int reqsymcmp(hashtab_t h
-- 
2.40.1

