Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE03C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbiAKVzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343494AbiAKVzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:02 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B6C061245
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id r139so363784qke.9
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1f7Wd27K5moNxwApZyWDj3kwRyGoa6lCjO7N9A2Dlc=;
        b=WslQzrcTTM8zlNkkl14E1pRcYTBCm5+MYEeinBgITGK8Bporof+1C7a8Cp6ujACvyQ
         dn4FdzE718qmAtlm68zyb/rbCR4WHCAZPS7V9OPIn5rjAQxkWon3LghoEcSJIybFAA/b
         qHAm4UknIVWLJo7oFVpUGPQgSg9pZiZNN7byK3msyK3uQ4MaOkkZCEKS7vIIeMziyGrn
         XXOMslGEXMYMR3qfqjc+frn/Av/OwKGjq1s2cYktTm2FtCrmutiOUUgsR3bWk4G1ldbu
         5hBkZsvXzSCODfDPYLFs7602KQea0ua1uHBehkixX3XM2nBTQed1miNAN5fZEmq5R4d2
         Y/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1f7Wd27K5moNxwApZyWDj3kwRyGoa6lCjO7N9A2Dlc=;
        b=U7bGDVRQzQPWdUm40X3Cu7vNGNr2yLyqCKsxRW18zV7VWRlIMCY/PnENF3F8Fun0B5
         igVeAnQcTfA+NIG57vfBumxxbXb3gfj0Rvn0Z08pXIe6ahFj8g6NALvUqlJjJEmkreIx
         SgzF++f70FAugDfpzMfNeYqsQ0ijrs8uq9Rb2p7PmJwSMVHKA03WiKzomW7IOJPVokbj
         e4ocxZuy2+BxPxbTVmoWetLDTe307pkcdgjy5ln1gJ1HunJZAPZp65NcqZHFuXKQ4hK3
         Jv10OWn/RF1Hrg8zBaUyRBQhj////1gPMp5J/GC+CQ8PV3cJg3zuJaObNaBlWxdh6dp5
         yCyA==
X-Gm-Message-State: AOAM530XuGsUsl2SKGhws4N3dtfpDmPIZz5gbcU9Mzez7gn139DF7UWJ
        Vkll3wN4HHS1W9/9nDiPlV+/cU+x2rc=
X-Google-Smtp-Source: ABdhPJwBt88PW7eIsutlPv1ao04TxXKtyRs+GLgi2b0DSD9rz8UvKUGYP5WuvMU5L/Un70xNv4Ix4Q==
X-Received: by 2002:a37:d205:: with SMTP id f5mr4613536qkj.698.1641938098485;
        Tue, 11 Jan 2022 13:54:58 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:58 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/16 v2] libsepol: Remove uneeded error messages in assertion checking
Date:   Tue, 11 Jan 2022 16:54:33 -0500
Message-Id: <20220111215446.595516-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
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

