Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D284C77B7C
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjDTPgI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjDTPgH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5114215
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so1084944a12.2
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004964; x=1684596964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVbQbb6YjTClV1kKmKgH6XmStC2ewwGeLiT4GUd5xns=;
        b=V9bUiRNdaeo+7KKZmo1hI/IA9PrUaL5tov1r8lWEsIUPlkV05nEtB89RM70xJt5Fhz
         DNCw5+TOgpmqWfZM6aubXwHHc+gkpKId2ZZbjjiBGBOUcwN0OZJCYuugvzTyO8J5l8jV
         0X5wG1MHyLegdfZKYlwbfxKob+kLyKNbF1OhADcUFeQ/4Nzw2DlOPnw8+YZwJedU2uPg
         jtkBj/PJADuh3Kq/jhAyJVq1GV13UkIZZ59w1+cdR35Z007XmbmPf0U/oJbM1AEpfxme
         iMQnhpdquAq5kZs3D/AOaGLInHVHyLGXisZGcvJUCKR5W2ctuZJ5d2eUDP5F3Pql1e++
         z/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004964; x=1684596964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVbQbb6YjTClV1kKmKgH6XmStC2ewwGeLiT4GUd5xns=;
        b=U8//49RdVWFD35ZoFSd53OFRtMZjq3bXEtGECDQix6f4X7uAZI1JXqjXgjtydmdoV1
         uavOr6KeQK9ASyBnFmzfwSdOwaDkReUP4bHBwYKTLIKjrlgOgyRkmn9fWi2D1mgAw2N/
         leDYwf/moyOrMMqQn9sXloVCF+9GILcynKl41sbAbXh7dq4jwxaWf8ZT6b9iv2+kZb1R
         WwHebmo1mje926kUNpSkQ3PIX4dcEysGy4NOmfQm3GEySv3gt9+f4kFxZjfW3adu9xn/
         XET8XimjrcUHOc3mGOVxkXY9OJ5WK8qjloYtY0yDSvMgpNUlJg9ISoySkZE3sFUh5buK
         DS7g==
X-Gm-Message-State: AAQBX9eHHm/iztbmU4eSJFxZvP7MMXf+WT+W5ohR+sMD+NZu2mhFzhdM
        928rIBN4NUohCB75AobdtezmCNbNVI0=
X-Google-Smtp-Source: AKy350ZAqmd2mOpBZKfWZRpCi8yKLX5CO+Vz1y8LosIfyht30q0wq71Bb9Gzmci+UuDR5naPivnsIg==
X-Received: by 2002:aa7:c952:0:b0:4fb:d620:bd27 with SMTP id h18-20020aa7c952000000b004fbd620bd27mr2193635edt.23.1682004964500;
        Thu, 20 Apr 2023 08:36:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/6] checkpolicy: rename bool identifiers
Date:   Thu, 20 Apr 2023 17:35:54 +0200
Message-Id: <20230420153556.32115-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420153556.32115-1-cgzones@googlemail.com>
References: <20230420153556.32115-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 8 ++++----
 checkpolicy/test/dismod.c | 8 ++++----
 checkpolicy/test/dispol.c | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b0c36807..2485142d 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -354,14 +354,14 @@ static int display_cond_expressions(void)
 
 static int change_bool(const char *name, int state)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(policydbp->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(policydbp->p_bools.table, name);
+	if (boolean == NULL) {
 		printf("Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(policydbp);
 	return 0;
 }
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index bda8d4e9..929ee308 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -602,14 +602,14 @@ int display_cond_expressions(policydb_t * p, FILE * fp)
 
 int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(p->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(p->p_bools.table, name);
+	if (boolean == NULL) {
 		fprintf(fp, "Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(p);
 	return 0;
 }
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 6561366d..9ab6533f 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -262,14 +262,14 @@ static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 
 static int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(p->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(p->p_bools.table, name);
+	if (boolean == NULL) {
 		fprintf(fp, "Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(p);
 	return 0;
 }
-- 
2.40.0

