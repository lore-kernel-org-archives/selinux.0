Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F47CCA482
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiGLQJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiGLQJK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5427FEE
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x91so10736395ede.1
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vk5+pyuzjefxFiWp65Xv/Z+qbOCjYTIjYInRaaxVfts=;
        b=PjF1jh+QqyY5WOmra8Mw863m4IJnTJXJPKj/SSCsG98ugvA09EhhZB4LGVY+vHcMaj
         GynHVHoVzRPu29zzHnBGS9Iol4qcPv+iEW12kHOVSRZKXmdC5J9IpH/KvcOhYYk74FEt
         eJxtJqcKqGRq8BdjQ01l4oMN+ELKNzYpJjDxU7lFx/Lquiuvd8rChcQWSMp08p6AK+4f
         pr4NJduINqxv9NrDfw4h5HaEvtvhFRW61gMSJS7xLpaddO0cK8p7RrKKcsk3XouGbmce
         1DRbacfcjO1D8Aj2vyy4RtpNCWI6JprpI30RNeBTHaGBs7OPI+KSsFSBDhrX8nJtnQmn
         6rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vk5+pyuzjefxFiWp65Xv/Z+qbOCjYTIjYInRaaxVfts=;
        b=3zeaz/X7Zpym07BOCWnEqJOzlTvE1j2drJREYEZAnZUSAyc1cvmP3adlltoYSMq9yn
         i1VRXjk3YcoyUmwXbXnPnDMh2IDU8pG+ShKyX08UbsfRxL0tuMjPig2kUfja/u9KzE9W
         NTjB2OVY2Wx0/Drsv6zHmq91A2dPUytR/Yklv2jR2ekvjbkIIKl06CH9wa9sIVTIYm0T
         2pK90VBNdZF3lV7xHSMoQouy9OVSktmLNyrStoMFM+PVZaqzMA6T99KVC0gPEt+Aaf9L
         Jdt7jgM+N8YxiKrqFfqhj0C5ixUty8jjHc9d3L22Vm07daD0D46Aj1QQw0LtKJ7sZ7we
         d6ZA==
X-Gm-Message-State: AJIora++gNVh7H1xbChJoznHMZ1shxDb3OredS77HP6vPh62wkcUcXlj
        52p2G6gAnali92rn2ybhRtyVrzgxYMQlGA==
X-Google-Smtp-Source: AGRyM1vPQERbBoVbncri0KBrt7uE8s15EHRoEtUXm3VBEtGbHSp6o/NMpyQ3jYn7I18YxWpZuhJUNA==
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id y13-20020a056402270d00b0043ad1e8460bmr16464192edd.40.1657642147885;
        Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 7/7] libsepol: skip superfluous memset calls in ebitmap operations
Date:   Tue, 12 Jul 2022 18:08:58 +0200
Message-Id: <20220712160858.22677-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
References: <20220712160858.22677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The three members of struct ebitmap_node are all unconditionally
initialized.  Hinder compilers to optimize malloc() and memset() into
calloc(), which might be slightly slower.  Especially affects
ebitmap_or().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index e0541abb..d0f7daba 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -31,7 +31,6 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 			ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
-		memset(new, 0, sizeof(ebitmap_node_t));
 		if (n1 && n2 && n1->startbit == n2->startbit) {
 			new->startbit = n1->startbit;
 			new->map = n1->map | n2->map;
@@ -289,7 +288,6 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 			ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
-		memset(new, 0, sizeof(ebitmap_node_t));
 		new->startbit = n->startbit;
 		new->map = n->map;
 		new->next = 0;
@@ -429,7 +427,6 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 	new = (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
 	if (!new)
 		return -ENOMEM;
-	memset(new, 0, sizeof(ebitmap_node_t));
 
 	new->startbit = startbit;
 	new->map = (MAPBIT << (bit - new->startbit));
-- 
2.36.1

