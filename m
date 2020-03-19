Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529EC43333
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3660D20752
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a/IcgURB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSKxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:53:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSKxj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 06:53:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so1623022wme.1
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4Co//o65J2oR3885FmQhAGcBUr/bvtTrN98tEE5+t5U=;
        b=a/IcgURBby/lh63A/8tYWWCqSdJDqef+qAbgLDbVnJQiwnLRWnuElXSTm8z9i2kl4L
         iOj6tc25mFta2IU3Let+iWddeU1wVzzLX22Tb5fLZKRjd6mNACTuj8HRgkON0U88yPRC
         4pOjc7kDksND2UhNvOg28dioWmhIIpdkNBWOODOhaZ2rhkDFPRZZtOlpoy9OcHtWar8N
         y+A4J3uNn9aHModN/R58fCC6WV/y6n6x6JhzYC+vCfdnspA+Be63bB3/iWw91qTPttV3
         0+z9E8wcQ9xITN3wj99LjZjhZvhR49pwzUuF7Ou966/qbD23d+FC9d5DcdrYPk8473pZ
         9cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Co//o65J2oR3885FmQhAGcBUr/bvtTrN98tEE5+t5U=;
        b=oBEKGvAwifY3HrrvMBSHJ+P5AykQlzfw+p7uz/ys8Uqnfu4w5iV+9Tq0jW6SyG9Qh6
         ir4GN+bc8MVKB/J4P4opXeN0L3R7bM4pIcCc/gVlmzrdSu7OjR2tKCvpTVLrYstiNHl+
         bBGfQN6O08pbzswsFid2vX0uteL0Ezkpz5haK0kaW1AdOdnllLHDfzWXg+81NK6JBDAl
         SDV7AfeWqyHoIZWWxA9nFj3qgS4Jfhv6oEzImBMYpPFANxEXhBBkwHg+e1K/6Q/y3szr
         1puN8swSHEYDhJ75whajAf9qSQnyCIoMCKPqkv5HDbczWIhyCPs5ORjdG6R6MlpaBdd7
         4GFA==
X-Gm-Message-State: ANhLgQ30YypuTVQ7MVAH9wKZBKzw1GHbJHuTqAuj+Bipk7753QmuOFN9
        knbA7uwiuduxecHt4nSYcSof64W5
X-Google-Smtp-Source: ADFU+vuXbnxh8xUMXHCt9kVHF+cb9MMuqChMVBn5knMrhVUNz9edCoVyNylYS0lTnMq+Q0BLr+uYlQ==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr2902489wme.23.1584615215299;
        Thu, 19 Mar 2020 03:53:35 -0700 (PDT)
Received: from debianHome.localdomain (x4d01d445.dyn.telefonica.de. [77.1.212.69])
        by smtp.gmail.com with ESMTPSA id t9sm2926879wrx.31.2020.03.19.03.53.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 03:53:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: set correct second argument of (t1 == t2) constraint
Date:   Thu, 19 Mar 2020 11:53:27 +0100
Message-Id: <20200319105327.17295-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
References: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently a constraint `t1 == t2` gets converted to the invalid cil syntax `(mlsconstrain (class_name (perm_name)) (eq t1 ))` and fails to be loaded into the kernel.

Fixes: 893851c0a146ef392b8d77de737d52245345129e ("policycoreutils: add a HLL compiler to convert policy packages (.pp) to CIL")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Added Signed-off-by

 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 6fe7d336..a87bc15e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1745,7 +1745,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			case CEXPR_ROLE:                 attr1 = "r1"; attr2 = "r2"; break;
 			case CEXPR_ROLE | CEXPR_TARGET:  attr1 = "r2"; attr2 = "";   break;
 			case CEXPR_ROLE | CEXPR_XTARGET: attr1 = "r3"; attr2 = "";   break;
-			case CEXPR_TYPE:                 attr1 = "t1"; attr2 = "";   break;
+			case CEXPR_TYPE:                 attr1 = "t1"; attr2 = "t2"; break;
 			case CEXPR_TYPE | CEXPR_TARGET:  attr1 = "t2"; attr2 = "";   break;
 			case CEXPR_TYPE | CEXPR_XTARGET: attr1 = "t3"; attr2 = "";   break;
 			case CEXPR_L1L2:                 attr1 = "l1"; attr2 = "l2"; break;
-- 
2.26.0.rc2

