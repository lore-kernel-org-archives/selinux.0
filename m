Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED59AC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C9164F65
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhBDRGl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhBDRGd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 12:06:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19298C0613D6
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 09:05:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g10so4428958wrx.1
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vGbgWQizAH1pnJ7dtPQE/gygRFynB0tUurKOjoHp620=;
        b=fMbgdrBr84DFYywdxVJZnB3TiT58VhDyqu1DUEqrseiLmctfOarzDRvVtUWa3Gc1ae
         B0fS1/g2BlrEE9qtD7yiilhFAxo4yOgoufYl90XJpYze0BNdFK+dVy98mjSXbcdwjp+B
         rRJ0idyXSpdZSkBf2fqjvUa6B6G/G14UYDzyS5Qpdn25KRWqk67tApqM7lVR1acJmS7T
         aEdBm+b6+7v5a82mAzPwnZCzy74lAy7loWsvGuRQxXZuRuB9x/lI3Q348edwwQ1dP2FD
         ZvuRjcNF5duvFQRjc19ecem0E4uuXrx7bsqxgJhG3cyEr2j3YqFql3ZFpbuTG0soFbBA
         vLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vGbgWQizAH1pnJ7dtPQE/gygRFynB0tUurKOjoHp620=;
        b=BlJzk1w2aTe5a7wE4X2FjhXFXtIXCpP9ersb9P2206y9dkuUXqLfvbFyBwVP3Q492h
         23+AXx9rvcvJod0wuHQbaKGWU0V0fvd7WQtOjaDpq1zX7klDONOvzd7FSmbpqPc7ajlP
         1XGIWpzzDSmdQleBTVzwf0Jbf0ruWnzhjL+qcjF1GDZZkrpT2p3UpSm7bo5bbqkWDIvG
         IRV6W2ckYh/kKn6ZQ6jHqBh/UwjG7mHHCmtkdjDZNyG8NYH1gVC7k3VR9DVxZlmRi72X
         OZ7UTLOZncHW94Fgap8SEtfOOF7/COZEnuIIjmvevETBkeCJkr5t9jrRvEoZmgc2umqI
         A/0A==
X-Gm-Message-State: AOAM530mfGC33AFaq4BELex2b3b8jOEzuN8ftmF7wvlHGuTOmXtT4NvT
        CHnK6MCesOXrnwygcvo201ltJcixOzE=
X-Google-Smtp-Source: ABdhPJzzaALyiwNfsPDmIk0bHSBCHiB+wu2Q309MJeoQesZXiG37y1oEwYT9wgDkoiRgEQ9CtHAVHw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr289794wrp.243.1612458351858;
        Thu, 04 Feb 2021 09:05:51 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id t205sm6784910wmt.28.2021.02.04.09.05.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:05:51 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
To:     selinux@vger.kernel.org
Message-ID: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
Date:   Thu, 4 Feb 2021 18:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

To make editing the secilc docs easier, I've modified it to use fenced code blocks around all cil examples.
This way editor syntax highlighting can do a better job and as a result I've found 3 minor bracket issues that are also fixed in patch 1.

To allow pandoc to also do syntax highlighting I've written a rudimentary syntax definition in the format consumed by pandoc (https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format) and enabled it.
However pandocs default themes aren't the best, some of them don't highlight every keyword I've added, color scheme doesn't fit, etc ...
On the other side It's very hard to just find 6 colors that work well together.

I've uploaded an example using the default pandoc theme:
https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide.html
https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide.pdf

bauen1 (2):
  secilc/docs: use fenced code blocks for cil examples
  secilc/docs: add syntax highlighting for secil

 secilc/docs/Makefile                          |  12 +-
 secilc/docs/cil_access_vector_rules.md        |  33 ++-
 secilc/docs/cil_call_macro_statements.md      |  10 +
 .../cil_class_and_permission_statements.md    |  42 ++++
 secilc/docs/cil_conditional_statements.md     |  16 +-
 secilc/docs/cil_constraint_statements.md      |  16 ++
 secilc/docs/cil_container_statements.md       |  16 ++
 secilc/docs/cil_context_statement.md          |  10 +
 secilc/docs/cil_file_labeling_statements.md   |  14 ++
 secilc/docs/cil_infiniband_statements.md      |   9 +-
 secilc/docs/cil_mls_labeling_statements.md    |  50 +++-
 .../docs/cil_network_labeling_statements.md   |  16 ++
 secilc/docs/cil_policy_config_statements.md   |  12 +
 secilc/docs/cil_reference_guide.md            |  27 +++
 secilc/docs/cil_role_statements.md            |  26 ++
 secilc/docs/cil_sid_statements.md             |  12 +
 secilc/docs/cil_type_statements.md            |  50 ++++
 secilc/docs/cil_user_statements.md            |  42 +++-
 secilc/docs/cil_xen_statements.md             |  20 ++
 secilc/docs/secil.xml                         | 224 ++++++++++++++++++
 20 files changed, 644 insertions(+), 13 deletions(-)
 create mode 100644 secilc/docs/secil.xml

--
2.30.0

