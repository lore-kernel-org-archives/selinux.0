Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D41C4167B
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLOVel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLOVek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F726494
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:39 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u10so357502qvp.4
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uusRpokKpQ3+PbC7R/Qz08DFxU0sqOvyURhfskaDO/g=;
        b=KiGtNPfC2a0B5NW5DZ+RRnYWN+AQDQgaPnixmyPKn5miauXVHSOWqPJx36RDPy+5P+
         rd1/sG1rKxrXL5Etu2Mwisx+1RaV2aPjPwyx65FkG12vVyGG2jSphefFZC0du7shoFrF
         jzRmAg13Aw2NCe45FRTkZteDCjwEvJwaKBhJrlV6GF16hLXRroM5iR2khqeekPvTcUDm
         MDmUMDcO3wTlyrZHEPcsR9b5aPW8JKRSzKs31LzkEFOvlR8G4yUrMSN0LeOWcdGnMPRO
         fnpabapAaiBaroyErXYcKvfZImrIK7IqYUhhYG291eH0DCRXgedawYp00K1ZPe0IOydn
         gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uusRpokKpQ3+PbC7R/Qz08DFxU0sqOvyURhfskaDO/g=;
        b=Ykoo2XoN5rFSKPPqsIn+iyRafs9W3NMCgwlJ43of6ecTKFGlISYUZ6Xgscoi98ygie
         imsfyX8S7z+XXahViLkoi8nXDyAyp+giSAe8/0iyVV4icssDBG2GC4OzL+TqaJrgpDJq
         e1DYir62GWKmiDRS0Fx+lmYnPF6wPD91gmJRtaviwUniv4THwCt1FkhWp9XpDY1E53e6
         11RvhpPmafXwL4FYY8bOGqe3ExB8xM4ANXOKGydbOzy/WHE62uhcPlsWoR2KpNCX6h8k
         ISKzNS4vYwzln3nETiG70Z73VCLK4Got+RBa0CTGan6dFRj81i6U2idIv+I9B7lXEavu
         0xbA==
X-Gm-Message-State: ANoB5pn0wBwlW1OAJJW2AtJx4YNYGnZ6UO1LfNFSZgA3YL2Tu6LRXjZf
        BwT0SCejSiujonpN92plFVwDFJxmPTE=
X-Google-Smtp-Source: AA0mqf56zEMO+54VUsPmz0BorQlStvj9RbmQRpMAYm1xma5vDBgKQ26Qt801BS7Ra68IF1HBYw/g4Q==
X-Received: by 2002:a05:6214:1eb:b0:4c7:2533:4f2e with SMTP id c11-20020a05621401eb00b004c725334f2emr39633435qvu.4.1671140078602;
        Thu, 15 Dec 2022 13:34:38 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:38 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 2/9] libsepol/cil: Add cil_list_is_empty macro
Date:   Thu, 15 Dec 2022 16:34:22 -0500
Message-Id: <20221215213429.998948-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a macro, called cil_list_is_empty, that returns true if the
list pointer or list head is NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
index 6b4708a0..f974fddc 100644
--- a/libsepol/cil/src/cil_list.h
+++ b/libsepol/cil/src/cil_list.h
@@ -44,6 +44,9 @@ struct cil_list_item {
 	void *data;
 };
 
+#define cil_list_is_empty(list) \
+	((list) == NULL || (list)->head == NULL)
+
 #define cil_list_for_each(item, list) \
 	for (item = (list)->head; item != NULL; item = item->next)
 
-- 
2.38.1

