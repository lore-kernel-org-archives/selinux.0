Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C45C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiAKVzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A57C061212
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:00 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t66so392593qkb.4
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJSIYiK1iYgbVswXsUOfqMg9hjOoN19kqBrH9ke4030=;
        b=LsufjLZSXNFYKifPP/rlNjuKkf4J+0Pg+2t7nn/QJ80Hg2baAqiD2samqs8RDKHHZh
         zZF+lQt/cGoUvUCZcWxENUAT4OgCzNlMAZ0QI6eYIC9yqeub4LkCzo+Zc6Ib0Eorkh1E
         jlfSVWymRsyOVtInj9tk4XSbqzJdPs2Ak4COGt7ywZGLSrAvOkjF5i/RNsxrsHspGq0n
         scXwBig6Sk79VDLjPkSZwoNfLRUyKNaZAUloIaq3eAugJWKryRP7I2rBd6zsiOYCSvVb
         7M37ikNavGqsx6UdW4xe+oJ8CvYBqJSEBkA26oPOr0VIeicM4IF8LDX2aAQ/SaS29pQr
         Zaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJSIYiK1iYgbVswXsUOfqMg9hjOoN19kqBrH9ke4030=;
        b=UFUxBJR7v3o3GkAQcvYsd1a9DDNOO8JVQ7xwWwrLsWdn0LhUSfM4i8yZMpIRMmmBgY
         sA+F0/shqbpnDvNOWY75IO04qbwWSnWxVWtO5lpvPGVkeeijclkj9zVoxM7zqXPl44c2
         qriHSx5VRS6sBhjg8fLHwuj3OvS5FHTwYxlc8WIp4bez1yRkFOz88Zq9Mt2ikGbzfiu+
         hCqXdm/KdRZNZMaSTn2r3Gc96AK54KGS+dRieAM5Qciy1pOPz8hSGWqysioh2vjUToCh
         v6NE72+RSHzu9ujld2SoubVvnQGk8HL6Prbk1GS/i8SUpajcyaGi/8SxuWP0Xeo1P2Jj
         y5DA==
X-Gm-Message-State: AOAM533KRRS7n1PR7/SyHXoRPbj9XbcUgmckZGMlN04xIIFcw/FlGpjj
        j9gmifZo4gsFfVqys4/Qb6QtSs9rphs=
X-Google-Smtp-Source: ABdhPJzGQZ+hFVDBzSk8hZgFP79TasNWj64kNhDcvStrh8v3+H8MvExsB4+6tRG2aO9yhKJy6qn5+A==
X-Received: by 2002:a05:620a:12e4:: with SMTP id f4mr4638515qkl.249.1641938100073;
        Tue, 11 Jan 2022 13:55:00 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:59 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/16 v2] libsepol: Move check of target types to before check for self
Date:   Tue, 11 Jan 2022 16:54:36 -0500
Message-Id: <20220111215446.595516-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If a neverallow has target types as well as using self and a match
is found with the target types, then self does not even need to
be checked, since the rule is already in violation of the assertion.

So move the check for a match of the target types before dealing with
self.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index bd0dc4ed..7a1c4a5e 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -457,26 +457,28 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]))
 		goto nomatch;
 
-	if (avrule->flags == RULE_SELF) {
-		/* If the neverallow uses SELF, then it is not enough that the
-		 * neverallow's source matches the src and tgt of the rule being checked.
-		 * It must match the same thing in the src and tgt, so AND the source
-		 * and target together and check for a match on the result.
-		 */
-		ebitmap_t match;
-		rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
-		if (rc) {
-			ebitmap_destroy(&match);
-			goto oom;
-		}
-		rc2 = ebitmap_match_any(&avrule->stypes.types, &match);
-		ebitmap_destroy(&match);
-	}
-
 	/* neverallow may have tgts even if it uses SELF */
 	if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
-		if (rc2 == 0)
+		if (avrule->flags == RULE_SELF) {
+			/* If the neverallow uses SELF, then it is not enough that the
+			 * neverallow's source matches the src and tgt of the rule being checked.
+			 * It must match the same thing in the src and tgt, so AND the source
+			 * and target together and check for a match on the result.
+			 */
+			ebitmap_t match;
+			rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
+			if (rc) {
+				ebitmap_destroy(&match);
+				goto oom;
+			}
+			if (!ebitmap_match_any(&avrule->stypes.types, &match)) {
+				ebitmap_destroy(&match);
+				goto nomatch;
+			}
+			ebitmap_destroy(&match);
+		} else {
 			goto nomatch;
+		}
 	}
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
-- 
2.31.1

