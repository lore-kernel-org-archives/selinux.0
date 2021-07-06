Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AAEC07E9B
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147A361C3F
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhGFRjf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhGFRjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:39:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A1C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:36:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x12so29092977eds.5
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a8o7EbOA7+oDfa8+Y0ZInoPoo3EakOIpSw+RMJ0eTq8=;
        b=Ohyo/NqtCB/brRvvVczIPKtXhjDlxfvRYCCq3yUrCKZL1MC3wuy+6aqE7T6GZr5Bem
         fyhnJhB7vjvBgeT59CrhdCEoQcqRPFQHPNXhJ537I9USURujHciBsqOZQZ3P0R+pidp3
         cDpZKvOTdU9cLAhYHyJIsCJuLkqQV5oFx4Tk/bUgNDzZ53XNM9TRl2ammnl2uBxB0ztl
         axIc2JoCtNwHE9ltFJb3SiNFjJ3PXxOIi0tEs/H+3nM2kBrjtHLwZpcVCO7UWLop3aV8
         09RglK0wRagveoBp6a7Q7FRHF1Q1VTULShfcfJuGCznnC4f/6WVUm6R5qnA3JqSI8MRm
         5aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8o7EbOA7+oDfa8+Y0ZInoPoo3EakOIpSw+RMJ0eTq8=;
        b=dCDFiL9egOmfeMnxq3T/Nfyj1v0tgW66/Qo3mWV7F8YZhrx+UveVoyciEJS9uX3J67
         pnO9xSnU7Qpx0POEBnhZ3b8+/ij1w7aQTZr/KE5Jnm2X2lOkeY26ZrNRwo1adJJLSDjr
         MxUj/dTSYMZd7k2fMRXgpKlNJ6CQbGQvLrj5UAT3mhCJOVJrXtgNfYedxlSU64gWHHKO
         fbc6Pj11j3vqCn11qHS/VVvk1N8CabekmxHlVjxTcaYs7jFv1rEJBJJ5oSQWcvRjIEWd
         WFurEq15UIa/2H9uq8TctE/O9J/3pQMDAipIF3XwWZYS2L29XAvq55L0yT2CZ632d6MR
         XsQg==
X-Gm-Message-State: AOAM532AOYjHrTOZK/K7EIV9ZCLarZr+lAWhp3tmyI2sRfdmV9BTuRsv
        pM2kxl/L2C6GiMz/98s2iAQ5inA+fYw=
X-Google-Smtp-Source: ABdhPJzX7sfnU19hizsGIEyqTs4njCDAcsn0F6MTHk/pR7xnIHsiSlNQ/cg7eQV1KygR5AFh9COGSg==
X-Received: by 2002:a05:6402:520c:: with SMTP id s12mr25307244edd.357.1625593014306;
        Tue, 06 Jul 2021 10:36:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id f9sm5868514edw.88.2021.07.06.10.36.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:36:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3] libsepol: avoid unsigned integer overflow
Date:   Tue,  6 Jul 2021 19:36:29 +0200
Message-Id: <20210706173629.22032-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701183430.145934-1-cgzones@googlemail.com>
References: <20210701183430.145934-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unsigned integer overflow is well-defined and not undefined behavior.
It is commonly used for hashing or pseudo random number generation.
But it is still useful to enable undefined behavior sanitizer checks on
unsigned arithmetic to detect possible issues on counters or variables
with similar purpose or missed overflow checks on user input.

Use a spaceship operator like comparison instead of subtraction.

    policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'

Follow-up of: 1537ea8412e4 ("libsepol: avoid unsigned integer overflow")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 10 +++++-----
 libsepol/src/private.h  |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ef2217c2..0398ceed 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -817,11 +817,11 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
 	const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
 	int v;
 
-	v = (ft1->ttype > ft2->ttype) - (ft1->ttype < ft2->ttype);
+	v = spaceship_cmp(ft1->ttype, ft2->ttype);
 	if (v)
 		return v;
 
-	v = (ft1->tclass > ft2->tclass) - (ft1->tclass < ft2->tclass);
+	v = spaceship_cmp(ft1->tclass, ft2->tclass);
 	if (v)
 		return v;
 
@@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
 	const struct range_trans *key2 = (const struct range_trans *)k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = spaceship_cmp(key1->source_type, key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = spaceship_cmp(key1->target_type, key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = spaceship_cmp(key1->target_class, key2->target_class);
 
 	return v;
 }
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 72f21262..c63238ab 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -47,6 +47,8 @@
 #define is_saturated(x) (x == (typeof(x))-1)
 #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
 
+#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
+
 /* Policy compatibility information. */
 struct policydb_compat_info {
 	unsigned int type;
-- 
2.32.0

