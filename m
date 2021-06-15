Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E532C48BDF
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C738611EE
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOS7G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOS7F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 14:59:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044F4C061574
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 5so5092440qkc.8
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3Qgic1GBtFK+ZlwAoexqkLj8pF1u5JvTNIUFyKTaA0=;
        b=JHHi1UkXjGQJClXA22lzBhoNIetYGsojTD9jLpJ4ET0w7PQDvTvzU7Ympv0gaqCnc2
         GWCbyFaWDQWy2o14P1kiJ4Nrt7jJi53hhhkB9VdzsPfJlcQj7/7vPQWSZNz2Oa2sOeUT
         hiPMx9tp1Qjz5SdfENf+CPtPFU0FYm9C9EjL5z7wB5qiGk9mzVyUT/HIk1vYhrT+t/0x
         Uq3EVgLZX61h2grTff3VQqyxr0zWqMaNxdUFJXhxAXm32BKEc9INcMrOP0vFn8NpDOLh
         VwtLqi7XhcxOeIFJCZ4qdWr3UWmUUGb7OoSu9hWKk0+64k1TouJbl2yLhFF74E8J6j6U
         b1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3Qgic1GBtFK+ZlwAoexqkLj8pF1u5JvTNIUFyKTaA0=;
        b=OHkiqx8MQkPQ6RUPgMXC2hVkSbEH3Lm4HKWcr+pNFijZguSY7z7vkEvVvjeXolPXCr
         7VxE43fyfBiOAvKyb2Kn66lKNZY5+1kDyF5C70+gEJTBCEpeuRo3f92yjV+CzyAYZUKD
         J8+5XH5B4QiLFG+0En3hS+Jhgkd0C0QSO9EorvAc93pJbLGUH5tIGkBg2GYNTnRL6SGy
         XBpvm1t5AOkfaieLpgtFvbVqoA9NsqwjWo6AwGePY6rzjPjZMV8EiI+1RhoFBH+nVDeM
         iICKT+6B6Mfrc7o7W8A/+bEYcS8MHEkCJ/AsFTBqfDatR1dTXpJN4NSNRzUzxXyeBAqx
         i7+g==
X-Gm-Message-State: AOAM532GKTo/WHSLBwRU3AFiPW2XTRokOmkQdNe+H41qRI45Yy49UfBH
        AUj188KU7RJJPpsguQNdowUzlr5Qh0t/ig==
X-Google-Smtp-Source: ABdhPJzj3s/igamW8/qH9j0Gkj0bCDHbkJ21YxVsK8Bf40lKCo+vWGVNHaghELh6Q7VuYKXgRMsCiA==
X-Received: by 2002:a05:620a:136a:: with SMTP id d10mr1129796qkl.422.1623783419027;
        Tue, 15 Jun 2021 11:56:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e1sm12746838qti.27.2021.06.15.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:56:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/3] Fix problems with CIL's handling of anonymous call arguments
Date:   Tue, 15 Jun 2021 14:56:52 -0400
Message-Id: <20210615185655.34064-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For more information on anonymous call arguments, see the third patch.

The first two patches fix a couple of bugs in the handling of anonymous
call arguments.

The last patch adds a test policy that can be used to test the handling
of anonymouse call arguments.

James Carter (3):
  libsepol/cil: Fix anonymous IP address call arguments
  libsepol/cil: Account for anonymous category sets in an expression
  secilc/test: Add test for anonymous args

 libsepol/cil/src/cil_build_ast.c   |   4 --
 libsepol/cil/src/cil_resolve_ast.c |  47 +++++++------
 secilc/test/anonymous_arg_test.cil | 106 +++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 24 deletions(-)
 create mode 100644 secilc/test/anonymous_arg_test.cil

-- 
2.26.3

