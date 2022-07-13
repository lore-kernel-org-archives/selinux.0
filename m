Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E2C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 13:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiGMNnz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiGMNnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 09:43:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B413221242
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so13424784edd.13
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVCQjuE4rq4BsATRPowf3jYYOLjF1n8SI07aqJ9Dpns=;
        b=ltIPfdzfyIaUlTJ27guHwQuEbuq9a4O17tVRYYDVO2bIADpkqv4Z6DUnARfcvoQJ6x
         UKRpNEO99VNLldPYDLkV0l2fQvJyKfNexoupfDa5a8U515hx+XpZ+pGtvAAen7ZAuMG1
         osAFPTWBzfmsABs33B9IxcuHH6AZ05vqCxLHnaRJv9ZgWgKsBatld1z8k2LpiQuhCP4X
         aEcHnWirZw59L8QBlREIVwuoi7oNEgDWq0P9uzmOKqAXfQlZgl8DXPsOR1/Xv55Wmwk9
         cE7v6pJh8P15J61FQiSOyZ72iegTWukf5vuv0fuGo2QNX0PzBy0x9akMppG42pHLJ/xh
         sc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVCQjuE4rq4BsATRPowf3jYYOLjF1n8SI07aqJ9Dpns=;
        b=5BRwQaRNJNFAP8lXlUhyI+1IkTO16yIYx3wdxRWZ3X5r41nMYy9/z7Mqkb58RBdocq
         mw9dJE7wn8x9VS7psFo6GqfWijd+wiFSkLj0ZwPEFOhDkFaVyU3Y28BNN2hNdMq/WJpg
         6sMORb/IDjbuKktmxHPA1s54wa/jPvGNecPmU0meFVgn55bqPc5O0/qfr9tbr2iSerRm
         5JSdYLY75M96WGQFPNHUJFWlKZA8CU6+5TOvq5MhfRaN9Hyq6i+4pP6m4U9POlcyNw+g
         oNwX3qcLx2NUWMyhMKNwUPzc7lQaAXosAMOdQw9TEp4ZlZ/SiY8qmynjuvRNa1fKLrAM
         FuDw==
X-Gm-Message-State: AJIora8mO6zY1xAgrmD/NYfZwqx8PLJUgZOltJ+m5K9lYhKdcFsR86gK
        oilFM22WNevFuNvgAZkWUVKJEMj0tX4t2A==
X-Google-Smtp-Source: AGRyM1v/tBkS0DDJQcHAPotRMcl+r26TiPmzcm533lTQCYhkgdumugIBdYIhPCLgSSqqDpk/yUMnow==
X-Received: by 2002:a05:6402:40ce:b0:43a:918d:a73f with SMTP id z14-20020a05640240ce00b0043a918da73fmr5074647edb.387.1657719829587;
        Wed, 13 Jul 2022 06:43:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906539200b00722fc0779e3sm4973763ejo.85.2022.07.13.06.43.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:43:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: break circular include
Date:   Wed, 13 Jul 2022 15:43:41 +0200
Message-Id: <20220713134343.19811-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since `struct type_set` is forward declared including
policydb/policydb.h is not necessary and creates a circular include.

Also drop the unnecessary forward declaration of `struct policydb`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/constraint.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/include/sepol/policydb/constraint.h
index b91fc4e9..82335e21 100644
--- a/libsepol/include/sepol/policydb/constraint.h
+++ b/libsepol/include/sepol/policydb/constraint.h
@@ -18,7 +18,6 @@
 #ifndef _SEPOL_POLICYDB_CONSTRAINT_H_
 #define _SEPOL_POLICYDB_CONSTRAINT_H_
 
-#include <sepol/policydb/policydb.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
 
@@ -70,8 +69,6 @@ typedef struct constraint_node {
 	struct constraint_node *next;	/* next constraint */
 } constraint_node_t;
 
-struct policydb;
-
 extern int constraint_expr_init(constraint_expr_t * expr);
 extern void constraint_expr_destroy(constraint_expr_t * expr);
 
-- 
2.36.1

