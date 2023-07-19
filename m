Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DEEEB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 15:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGSPEh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjGSPEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 11:04:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BCEC
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:04:36 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635dd1b52a2so37375606d6.3
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689779075; x=1692371075;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvCb31k6AaSMVk10T7htY1/dGkoPwx9jkobRrkYxHZw=;
        b=CbF1oeJsmnL36bF10Vd0YtyisQVDAImrkSXxG0jtHAaJtRzrPtki/cJtea5lURou2J
         NmKgZWceJSsN0pJ2INnTbHzFjx6FAHHdvaJEmy9X1+IxaRcbA2yhX4ddHr95iJ4Uzx74
         d7pO5NjqOMVcwzS7Qx6v1vgjHiIwxuIIxOV8yvY4a413JrJ24A+YxaFw7VqnjulOMYBX
         Gn/xFXA6pXSZc5MBp8A2LJAv/PrACcts2V/33rmxftsq8NBYVVPtHImWMGSp3Bxifs7G
         TXAcIfqC293UFNRBG4qkTtZSD40A96HsbuPBvtBUTBIDD1NnO+y6xMutghY1WgYr6Ylp
         XjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779075; x=1692371075;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvCb31k6AaSMVk10T7htY1/dGkoPwx9jkobRrkYxHZw=;
        b=AJDc6bjqxbKvo9Sseln2P7h9SNSYEExGe6u90XQ0tWyOIn1C54VDJdWK2VXKX9r5FB
         igAxOpA9hKbfXZr5pm8Fm2nwCR2k/DCHXsZFr3jnpJQmXLF02QxHE0kDDVB8IxDkEEAw
         LY621VyzWvQ/Kbj4jFP38LpJted/339DDDSXd6WcDlFiJprtyWGu25FK1X8Pf1+kiS5s
         jluRpohbKx9k/rER4svL7KMcYcJszuAN4xK2PzL6Tcv/48ocne0B/xK471SPGfxRB8qe
         dt9ElZDgb1r2+PAUz1Q+oXVZdTYTdJWFRAFdyOwDQm8675k6xTan42HWOKAgxEAABuht
         0+9g==
X-Gm-Message-State: ABy/qLbrmSFqDACmS5+seae12grhYprrbOkpMR+U0siW97uRrJS+ZnH/
        ThQ1Nzla7KH1BOoJJdC9l4R1VHjudDpJzacx7w==
X-Google-Smtp-Source: APBJJlFrxgv86WliWEj+CWedBuL3slSLrzoQ4Oa4VUYnhINFlCEAbSUYTKZRTg1Zz7uEC/Pgz0rOYw==
X-Received: by 2002:a0c:e108:0:b0:635:ce65:38b2 with SMTP id w8-20020a0ce108000000b00635ce6538b2mr2112714qvk.62.1689779075171;
        Wed, 19 Jul 2023 08:04:35 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x19-20020a0ce0d3000000b0063c7037f85fsm1501346qvk.73.2023.07.19.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:04:34 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:04:34 -0400
Message-ID: <9b71e772b62ab89c5688a2f85ef5a128.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: drop avtab_search()
References: <20230718180627.91873-1-cgzones@googlemail.com>
In-Reply-To: <20230718180627.91873-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> avtab_search() shares the same logic with avtab_search_node(), except
> that it returns, if found, a pointer to the struct avtab_node member
> datum instead of the node itself.  Since the member is an embedded
> struct, and not a pointer, the returned value of avtab_search() and
> avtab_search_node() will always in unison either be NULL or non-NULL.
> 
> Drop avtab_search() and replace its calls by avtab_search_node() to
> deduplicate logic and adopt the only caller caring for the type of
> the returned value accordingly.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c       | 32 -------------------------------
>  security/selinux/ss/avtab.h       |  1 -
>  security/selinux/ss/conditional.c |  4 ++--
>  security/selinux/ss/services.c    | 13 ++++++-------
>  4 files changed, 8 insertions(+), 42 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
