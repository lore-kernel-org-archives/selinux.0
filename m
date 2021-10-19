Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E5C433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8677E60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhJSPQG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhJSPQF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:16:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE98C06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:13:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r18so14372009edv.12
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BZ5znyCloerhgiE+j5r0ZxYBROkiAGoc1JT7APAmkvg=;
        b=GcoppWRlZeL0nEm2kYZif7FvCIHpYW9KLnHvO2dNQYcfPpLYC8+EZKjgCOj+WxOT/W
         E7IzDKgMAFoCRW/agHdQB9uHqZsO47hAtu2tyVhnPAdZrxnR6k1yoEO9ntbyUmyAm8xF
         B1zA22HHmYFuAz3ZPwi/Gbc6Ql42PpIHVUkB9mnJcK8Y83qQ4fw4GxD9+lF+UD+PsLxN
         e61FResiUjKRVofNRwnpvZZLFUTgqGbfcTuswB7NwLo7oiMjGXzpUL/Qmh+W2dOekllK
         ZkHVejICky3FliV4WEQsxwdhSRtdnR0EXfIB45EZ0REiVP1Hhjb0DlNnGMPkeRX+MzDz
         EbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZ5znyCloerhgiE+j5r0ZxYBROkiAGoc1JT7APAmkvg=;
        b=EsIlpp75iM8lolp/NLGtgJGX1udyupNelQ9jXa8O2ui9PuMxfjZLYpNsP+bUtdUTgJ
         NPitQjC04e1wJVwBkuiKKOTR/DdBZPPzIPhjpNOKTTyOx8ncbTjeolD3lnrs009pol6+
         uXIvSj1870kpmudUctnqscrKQEEutTQyZSnNlmWdQvhaGX8MeZ5fvdz0h08OoaIbQeh4
         NPw5Vjj2i+0aDcXDttqDgpCIKD5BH2nolaa7RFwSnSHC25CGYINYOmG3uWaix93AjAwI
         Dry9DdVNjacrss3b10VDKDJfMpf742c/Mjzn0WOGCwxHrdzizQsJhj3j380xdIg4Ltbm
         QuJg==
X-Gm-Message-State: AOAM531glTtQNyClLwHHEQopWDeKMWqXtH/sSO3E/bxRl1iDCQ1Di8Bg
        v+KP+EShcw2cSGTK0HKkdpJ1x84dHHk=
X-Google-Smtp-Source: ABdhPJwBNJ6qmczZw6ovv1vxxGJrQ1+b0iEwt4fq895oQVi7WoxgMyUs+J9Lkix4zh6T6uGs1pZd3w==
X-Received: by 2002:a17:906:ae54:: with SMTP id lf20mr38033935ejb.195.1634656291707;
        Tue, 19 Oct 2021 08:11:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-035-102.77.0.pool.telefonica.de. [77.0.35.102])
        by smtp.gmail.com with ESMTPSA id t6sm11724801edj.27.2021.10.19.08.11.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:11:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/3] libsemanage: do not sort empty records
Date:   Tue, 19 Oct 2021 17:11:22 +0200
Message-Id: <20211019151123.10335-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019151123.10335-1-cgzones@googlemail.com>
References: <20211013125358.15534-1-cgzones@googlemail.com>
 <20211019151123.10335-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not sort empty records to avoid calling qsort(3) with a NULL pointer.
qsort(3) might be annotated with the function attribute nonnull and
UBSan then complains:

    database_join.c:80:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   add brackets around if blocks
---
 libsemanage/src/database_join.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index b9b35a61..a49a6226 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -77,10 +77,14 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
 		goto err;
 
 	/* Sort for quicker merge later */
-	qsort(records1, rcount1, sizeof(record1_t *),
-	      (int (*)(const void *, const void *))rtable1->compare2_qsort);
-	qsort(records2, rcount2, sizeof(record2_t *),
-	      (int (*)(const void *, const void *))rtable2->compare2_qsort);
+	if (rcount1 > 0) {
+		qsort(records1, rcount1, sizeof(record1_t *),
+		      (int (*)(const void *, const void *))rtable1->compare2_qsort);
+	}
+	if (rcount2 > 0) {
+		qsort(records2, rcount2, sizeof(record2_t *),
+		      (int (*)(const void *, const void *))rtable2->compare2_qsort);
+	}
 
 	/* Now merge into this dbase */
 	while (i < rcount1 || j < rcount2) {
-- 
2.33.0

