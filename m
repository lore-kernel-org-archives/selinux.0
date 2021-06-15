Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD6C48BDF
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619A260233
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOS7I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFOS7I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 14:59:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C5C06175F
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l3so266111qvl.0
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A82cY5VugYjEHJ8cJ3D2NzwekF4oXFYbwzPpO10oLW4=;
        b=rF43jtRzz1SeMHPRJhEvINF0y2fMSwxLgGsDPCwIsAQcNm+zUsgKcQGGcmazKnnHzm
         8PIc9TqkM4uidkQVOzQ8SZ9686DB4cFs8pHpIyThPUg3GcxSO4iNq2jajFPIpSGMM42U
         ShgVicve7XXICo9U7ElAMfgUtO7708Hu0Nqnag98wuZZNPstQqLBS8kgoKeGGM4uNDsq
         3UAp1AiS0tKJ2QfNtfAoIrW0cSSMRJIzOZcpAvZkBl7KsjlZ+nWqJQ/uak0EZEJPw+/b
         Y1KD3dyyT5QAzR2YJ+AzfgYTHt28yAHZxeWn6NAVmeI0rxozjUps3b05ELo5cFjR1nAr
         985w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A82cY5VugYjEHJ8cJ3D2NzwekF4oXFYbwzPpO10oLW4=;
        b=OqlhBDnBHodhi7mcRlvj1jzyn+RzQAogjjYeUdMsfkq26c0w5ddQAQPXpW5BgOGZHg
         quEHpRELpeEI5FqcEqhA0ela+Fn6TDhQ5UQMTgld9MQcJsAwcUvfSJAtwuu5o8du4cg1
         mAY3qT4Bma12khFBybWK/ZrBYttXWhktqlwKYvt2tfad/4KyZXB88V2b3tFnvEcOhBLm
         dNQpRYR+vLeH4AzsOTfRh4um2RA/WkZPJyPcqh3QjSQbbDYQevgaF4aBvFiAY29O8ige
         vyNNlNrqyjSgFClnJx2w+U/R+BETfbIyjQ2NGY08SAhQGyXFA5QadKYMeJubb/LRIM7Y
         WT+g==
X-Gm-Message-State: AOAM533M6a6WOIkUygxC1LEBwXCE7J9iewkYLCVdQ55aBajNBqiko/q2
        WmZp1fgL4b6BEYQL6mPxvIt9sbe+jYy6MQ==
X-Google-Smtp-Source: ABdhPJzFcEiw10rLvlus6mf+/MpqyFANmLMiTwphQk+KhRBL9/D4toFeUcL/pthJPE68acgEksdiPA==
X-Received: by 2002:a0c:f085:: with SMTP id g5mr6918343qvk.18.1623783421457;
        Tue, 15 Jun 2021 11:57:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e1sm12746838qti.27.2021.06.15.11.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:57:01 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] secilc/test: Add test for anonymous args
Date:   Tue, 15 Jun 2021 14:56:55 -0400
Message-Id: <20210615185655.34064-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210615185655.34064-1-jwcart2@gmail.com>
References: <20210615185655.34064-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL has rules that allow names to be assigned to certain objects
like MLS category sets, MLS levels, MLS ranges, IP addresses, and
class permission sets. These objects can also be named as parameters
for a macro. A call may pass in a name for one of these objects, but
it also may pass in one of the actual objects. These objects are
referred as anonymous arguments.

Add CIL policy that can be used to test whether or not anonymous
arguments are being handled properly in macros. Also test the
equivalent named arguments to help determine if the problem is with
that argument type or just with an anonymous argument of that type.

The anonymouse arguments that are tested are categoryset, level,
levelrange, ipaddr, and classpermission.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/test/anonymous_arg_test.cil | 106 +++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 secilc/test/anonymous_arg_test.cil

diff --git a/secilc/test/anonymous_arg_test.cil b/secilc/test/anonymous_arg_test.cil
new file mode 100644
index 00000000..46f8ce73
--- /dev/null
+++ b/secilc/test/anonymous_arg_test.cil
@@ -0,0 +1,106 @@
+;; Test anonymous args
+
+(mls true)
+(class CLASS (PERM))
+(classorder (CLASS))
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(type TYPE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(allow TYPE self (CLASS (PERM)))
+(roletype ROLE TYPE)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
+
+(category c0)
+(category c1)
+(category c2)
+(category c3)
+(categoryorder (CAT c0 c1 c2 c3))
+(categoryset cs01 (c0 c1))
+(categoryset cs03 (range c0 c3))
+
+(sensitivity s0)
+(sensitivity s1)
+(sensitivity s2)
+(sensitivity s3)
+(sensitivityorder (SENS s0 s1 s2 s3))
+
+(sensitivitycategory s0 (cs01 c2 c3))
+(sensitivitycategory s1 (c0 c1 c2 c3))
+(sensitivitycategory s2 (c0 c1 c2 c3))
+(sensitivitycategory s3 (range c0 c3))
+
+(level lvl (s0 (c0)))
+(level lvl0 (s0))
+(level lvl3 (s3 (range c0 c3)))
+
+(levelrange rng ((s0) (s3 (c0 c1 c2 c3))))
+
+(user u1)
+(user u2)
+(user u3)
+(user u4)
+
+(userrole u1 ROLE)
+(userrole u2 ROLE)
+(userrole u3 ROLE)
+(userrole u4 ROLE)
+
+; Test categoryset
+(macro m1 ((user u)(sensitivity s)(categoryset cs))
+  (userlevel u (s (cs)))
+)
+(call m1 (u1 s1 (c0 c1)))
+(call m1 (u2 s2 cs01))
+
+; Test level
+(macro m2 ((user u)(level l))
+  (userlevel u l)
+)
+(call m2 (u3 (s3 (c2))))
+(call m2 (u4 lvl))
+
+; Test levelrange
+(macro m3 ((user u)(levelrange lr))
+  (userrange u lr)
+)
+(call m3 (u1 ((s0) (s3 (range c0 c3)))))
+(call m3 (u2 (lvl0 (s3 (cs03)))))
+(call m3 (u3 (lvl0 lvl3)))
+(call m3 (u4 rng))
+
+; Test ipaddr
+(macro m4 ((user u)(ipaddr nm)(ipaddr ip))
+  (nodecon ip nm (u ROLE TYPE ((s0) (s0))))
+)
+(ipaddr nm1 255.255.255.0)
+(ipaddr ip4 1.2.3.4)
+(call m4 (u1 nm1 192.25.35.200))
+(call m4 (u2 255.255.255.0 ip4))
+
+; Test classpermission
+(type t1)
+(type t2)
+(type t3)
+
+(classpermission cp1)
+(classpermissionset cp1 (CLASS (PERM)))
+
+(classmap cm1 (cm1p))
+(classmapping cm1 cm1p (CLASS (PERM)))
+
+(macro m5 ((type t)(classpermission cp))
+  (allow t self cp)
+)
+(call m5 (t1 (CLASS (PERM))))
+(call m5 (t2 cp1))
+(call m5 (t3 (cm1 (cm1p))))
-- 
2.26.3

