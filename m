Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7256C433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhLQSTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhLQSTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:31 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF9C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:30 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so3486305qtj.9
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpNG+8vcUjTjEvJKJLgCUrfT5YbXg7xDonKfrSoLuY0=;
        b=NBfcMNYxHPMsamyGsnedxv10v8Ix4uKSAh+ln8/CqNqgTaurkZJBuPKbf/4Hx6TKob
         akBGoFZqTFuFxRHr4p3Xl54h8YOSaNvFFRqCA3MxOijPVPgNTeSyRK3fZCF7KPjrOC0M
         91BEP5DKKvpmPX599s+YTTGXhPEghsbqtXt6rghwuhdjOY3hCKCvm8lir0ijAg24Ym+M
         2V2oOTi3JEFfFtOrghcdQmCwgDCVFvkMS+hTSYAdESbPLHhY7wggpBqd9fEFpc8d9g5l
         zgJafNZ7c/8rQGGUfH8pjaIcfO46Foynj0Q3ye7gZXwXmFyWTI5cA1HbO1dP+QNmnP8v
         gubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpNG+8vcUjTjEvJKJLgCUrfT5YbXg7xDonKfrSoLuY0=;
        b=Y6MYkiaPz/QDZdkqljjyKHq2q5ggSZ3bEogFuZXIcPGo+HQB9vZl9MJH9+d0lk5Kyu
         a2TcAys9TkyyGqQUaccMEce6KrxzGqL5sbUUR794lQcwVLupxKL0bxF99blVj1XYntd7
         XPhMTjhXQr1cLx37xhhfyCPdN7Pl9j2MB2t1aeYSqchltlDbXPw3cWIGAcG9vVMuAb9p
         4q6G56blKu2iKi2QwYY3voT5YzdEjoPO+LAiuyhD3xX8+75OVfLctgE5Q8VMIA5r2TTh
         TG2NLop0T+w2TOI0Vv31DrdxPuLBKCGJEPzqWdFOcWdhrvHS4eQf34WaXqt9CZF9daaX
         pJaA==
X-Gm-Message-State: AOAM533bzybd4qTptDstuajJjS2QtdChSM59+Ddfpk1jIT+VHRqkc6QG
        lAV+Me/bURrGD1EZqcITurk8qQHt+/I=
X-Google-Smtp-Source: ABdhPJz5YWK8fgwo+7fOf/zlPSe0DGGwd2FpHhBN07Lfw+WZ5u0ytrzN0XtDdwe/Nclrr9ur5MPo0w==
X-Received: by 2002:ac8:7d8a:: with SMTP id c10mr3577712qtd.415.1639765169866;
        Fri, 17 Dec 2021 10:19:29 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:29 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 09/16] libsepol: Remove unnessesary check for matching class
Date:   Fri, 17 Dec 2021 13:19:06 -0500
Message-Id: <20211217181913.336360-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When check_assertion_extended_permissions() is called, it has already
been determined that there is a match, and, since neither the class
nor the permissions are used, there is no need for the check.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index cf10e41d..7aaaf303 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -377,7 +377,6 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	ebitmap_t src_matches, tgt_matches, self_matches, matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
-	class_perm_node_t *cp;
 	int rc;
 
 	ebitmap_init(&src_matches);
@@ -421,15 +420,11 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		goto exit;
 	}
 
-	for (cp = avrule->perms; cp; cp = cp->next) {
-		if (cp->tclass != k->target_class)
-			continue;
-		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
-			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
-				if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
-					rc = 1;
-					goto exit;
-				}
+	ebitmap_for_each_positive_bit(&src_matches, snode, i) {
+		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
+				rc = 1;
+				goto exit;
 			}
 		}
 	}
-- 
2.31.1

