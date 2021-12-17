Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42948C4332F
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhLQST1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhLQST1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:27 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40498C06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:27 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kj6so3222614qvb.2
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1f7Wd27K5moNxwApZyWDj3kwRyGoa6lCjO7N9A2Dlc=;
        b=l/Aq3sWrgk5lyHfa8cD7LmGhlNxXuMXHNTqa8mk32+rQrVmSESGrreho8i0vOns2Ct
         7wp1bXXtWVpg8An2tNN1GPqqN6fz+mk2RC80Z/+ggeSpad7/DH/09VxT4STetQPPvDrH
         Zcunp+oV9+elkdnswsrMg+69UQAEkqTPJxGN1Bg+6K4hHSH/SyzeYTrM20yOsMNJ+HTb
         ncYJ+KDNY/u6bHJrhHjuP/C3elUkZTGkMyaGb1gRDQJ8Qp2vdaMI3Li3wqXpqwjZXX3d
         a7cHWHNllGm8SLNjGdhwOHWA8CNbNwG0n41a+kpcZ6HNFWWPxPMs3LxO8MNKzLHWMHg8
         1EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1f7Wd27K5moNxwApZyWDj3kwRyGoa6lCjO7N9A2Dlc=;
        b=1GgsXIJhwO5M0a3RpWPAOMkOSDIesxVoqXqXTNjbLyj0od2MVIoexilaK50VscuJic
         Sunul9f39LWCgekkx5Th/uv+UUknzByd2oRocF1CgFmqEtON3SefUWPkUCulQINK1nl5
         IMnj0vvjMbyS0f7fdjdhhdnPE/sTTb7l+FjZbOxboB8Hdq/JOyl2ibApByS+X/9++8mb
         rfhisRwy4HJ81le46i4MGLRKak1IMTpFCEWqpAVlA4qsel/IJ1ZaH05kL/QEWufG1xRv
         1745g6tPekJ6qH5GdGhRbjhfc+jrZX3TpGxVfsnfpyOK7wWwo2x9tPp8yE+DPUhTo4+g
         31ng==
X-Gm-Message-State: AOAM532AXc5SE8GHQ+iuWvBqx8CS9cu5wu1RFcXOlYpxwE8pldxp9OJ9
        cJLamX+wDOjV7sy7WnFIXlodnHooe1M=
X-Google-Smtp-Source: ABdhPJxe3fBfIALCXKd6cbU8M5grhiBRHiWEBg9e4XpaPGpdaR4O5wy+9cptsZikYHI7iSAuSZqnyQ==
X-Received: by 2002:a05:6214:76e:: with SMTP id f14mr2585187qvz.43.1639765166380;
        Fri, 17 Dec 2021 10:19:26 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:26 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/16] libsepol: Remove uneeded error messages in assertion checking
Date:   Fri, 17 Dec 2021 13:19:00 -0500
Message-Id: <20211217181913.336360-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An out of memory condition is unlikely and the general message
that an error occured while checking neverallows is sufficient.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index d716450f..832d3749 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -278,11 +278,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 			}
 		}
 	}
-	goto exit;
 
 oom:
-	ERR(NULL, "Out of memory - unable to check neverallows");
-
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
@@ -436,8 +433,6 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	goto exit;
 
 oom:
-	ERR(NULL, "Out of memory - unable to check neverallows");
-
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
@@ -495,7 +490,6 @@ nomatch:
 	return 0;
 
 oom:
-	ERR(NULL, "Out of memory - unable to check neverallows");
 	return rc;
 }
 
-- 
2.31.1

