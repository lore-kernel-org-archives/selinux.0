Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC3C4332F
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbiAKVzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F57C06175A
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:02 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 82so357497qki.10
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5IQn+wjR96hczfWvjDPMValHg7jyFmrTziQGvCJVSQ=;
        b=YtJTmO7vaueueQSIxNYp5P27mcvUJuNSVR+lxWbiee2tbQ6z5ZKg5pnvbKavppxShO
         9izWR9dGp21CwTgsUDqeBjXcjWmBCI5nE7m6DRxeXzBta/R4p60TSwtuLPEN4MKX2Qna
         dRi9ghE56fPK4/Q6de/+Tkm8QnD1sQjbm+eqM9d6AmLeB7XP2fiI+ccPTHRD57lPagcT
         4NrT2DLsiEQ67txBQj0egv0PLbLvtOk1+c8q1lVf+jnN9TXgIy/bXGpbZT8jAPAeBrhZ
         GHYQlnPN++jGlbWISKLEEUE17spgy/7LanolxMpOL2xjbRvjXhKQUFO4KkIMRepRq5GH
         t28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5IQn+wjR96hczfWvjDPMValHg7jyFmrTziQGvCJVSQ=;
        b=Ce75vqFl5fHRZtCB/p8UaZw5CVIRe1FSqZStk8tzMqbV0AYKYppWWhzpN2VjgF2ulO
         qGBuOWMJpxiBq7G4ZYehvlrKt5WELVLTv/PM1jT3NXlPurfRBv4eYL6AH2EePOEVf2Yg
         hUsZGS9YKCXa/gF9gYOnOwzTWJgZRLKVxOLn/oodwHfs+MHDP9+GNGxE4JHWFAIpW16n
         fbWySSNL97o048WHF+hU3Y8k+24NgHm6tmRKZruSuQgeFYH7QHs7iy0KpAupAQQDjvlg
         /k5MH0UqxarVXlLFcFUELfTSIe7MO+mpsLIMp+Zn78s40ytjPHG2ptPGPgYUKl2eseT4
         v8Mg==
X-Gm-Message-State: AOAM533AuxbFxLiWlnduAT0hPP6LmSDX3b50yVzXuEaKJJ1y9LBgCSGy
        V4FN5v/v8CvfcUe40NvHEJODMPFYyIs=
X-Google-Smtp-Source: ABdhPJzxL5SVrH1Kjhg537ND5UjXeGLxaKMRgAWB+to0Czal4Wv+uICIG5haGHDU9guZfoJFWaNsDg==
X-Received: by 2002:a05:620a:178b:: with SMTP id ay11mr4513672qkb.420.1641938101639;
        Tue, 11 Jan 2022 13:55:01 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 09/16 v2] libsepol: Remove unnessesary check for matching class
Date:   Tue, 11 Jan 2022 16:54:39 -0500
Message-Id: <20220111215446.595516-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
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
index b48169ef..42fa87d9 100644
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

