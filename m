Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F2EE14AD
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjIFPrH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIFPrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 11:47:06 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430ABC
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 08:47:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-573921661a6so2405575eaf.1
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694015221; x=1694620021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKGo3CjJzhyDWFU4WTNz1H54iLYzmT4iQJPpEwhKzj8=;
        b=YlcnTh+Z3Ku4tLlj9nnKkrWOTFCyzJ5ZnHhqXV9MZch5UKPIK0IJBX7GokN/BjQqZ6
         yYSlBC/6O8uStTB8rz64WHqRXF4YBFasb0GUuqWqPbDkHaMZnWw3hw02oBAy4r6maoW6
         my0ezL+hH0maIwuRHig6PZ63L6C+ON2WuamrSfe24pEFyGM+cDODJ+IcTiRivcczCzNh
         Q/Ph1uDllG2hTD5bA3HHmhz+dBuZGlmUgM97OqeYSaW9iR4KNdSOHlV+1BLCIBuedhWM
         bBjc/lNZ+T7Jny+v+3phUAxt+c+KLEZGB1g8UjX1GcZXJaeXJQyJuUSj0ll0NQE7ZOqG
         nycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015221; x=1694620021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKGo3CjJzhyDWFU4WTNz1H54iLYzmT4iQJPpEwhKzj8=;
        b=GIF5cFaE7pq81IZv3QwYBx9DgWHj+0tLHWu/nqe9AOfNVEEW9kcQr4orIllyjPawex
         VE3dbHhObIF2IVSo1JQSTczsNAPE5U+yPStUDyaXrtusMWh4cayVTmYz2J81UNgyKzpe
         t6oGg0KRef2hikrBevTXg6nHhPukEAwKQNlmaX40MEuAycnjnAMH2KOr16h2skDAq0oX
         nkaql4AcUYboBrp9GxN1ilDBWaG6brwKHvXRmPwcDXwsbBfMLBvl0QOB5yTTQUDmwnNj
         wN8lSmAy98EQS1hE5JjlqgaPaMJ9ommbqYzH91vL+rmbPMy7D36KZyBeKqj9xMWLNRA4
         +LRQ==
X-Gm-Message-State: AOJu0Yxh1zZrx0fHax8ptDPYLacZjRlZOzjRt4JJ6IDy/TP+v1e25XUb
        6/WJmXy9zQYLfxDq9GlaJXPLRIXfrqg=
X-Google-Smtp-Source: AGHT+IHHLEnnpVedssSXJi/vOfjJKKKQhEdLYL/flSDcYkY6QkqHs2SvTxUawUWzPBCGjh/oCMLzDA==
X-Received: by 2002:a05:6358:560a:b0:13a:319f:a56b with SMTP id b10-20020a056358560a00b0013a319fa56bmr3237353rwf.20.1694015221224;
        Wed, 06 Sep 2023 08:47:01 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g25-20020a0caad9000000b0064f778c8165sm5518835qvb.64.2023.09.06.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:47:00 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 3/3] selinux: hweight optimization in avtab_read_item
Date:   Wed,  6 Sep 2023 15:46:06 +0000
Message-ID: <20230906154611.31762-4-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906154611.31762-1-jsatterfield.linux@gmail.com>
References: <20230906154611.31762-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

avtab_read_item() is a hot function called when reading each rule in a
binary policydb. With the current Fedora policy and refpolicy, this
function is called nearly 100,000 times per policy load.

A single avtab node is only permitted to have a single specifier to
describe the data it holds. As such, a check is performed to make sure
only one specifier is set. Previously this was done via a for-loop.
However, there is already an optimal function for finding the number of
bits set (hamming weight) and on some architectures, dedicated
instructions (popcount) which can be executed much more efficiently.

Even when using -mcpu=generic on a x86-64 Fedora 38 VM, this commit
results in a modest 2-4% speedup for policy loading due to a substantial
reduction in the number of instructions executed.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index b7a11f417f0a..b0e455fb395c 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -17,6 +17,7 @@
  *	Tuned number of hash slots for avtab to reduce memory usage
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -516,11 +517,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		return -EINVAL;
 	}
 
-	set = 0;
-	for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
-		if (key.specified & spec_order[i])
-			set++;
-	}
+	set = hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AVTAB_AV));
 	if (!set || set > 1) {
 		pr_err("SELinux:  avtab:  more than one specifier\n");
 		return -EINVAL;
-- 
2.41.0

