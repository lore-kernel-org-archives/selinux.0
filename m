Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD2C433EF
	for <selinux@archiver.kernel.org>; Sat, 11 Sep 2021 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B24660FE6
	for <selinux@archiver.kernel.org>; Sat, 11 Sep 2021 18:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhIKSgG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhIKSgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Sep 2021 14:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631385293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygP7YLhmwkNujKf1H4CegsZoJqHJDfcEiFXiIKcFHf0=;
        b=Ccx6oHb4IRHtGExgxZYoyQzV69Z5U4WEQyUdLMEBMUVsalgz2nIdNyfYT9b/8GEOeCxU7H
        C4Q+cuA/KviZxTsNcDx4oxWgwTtBbVNjCTETvFrxGU5qFYpAck3GFq7dufHzZ6OsMTWiki
        rSN/K5vf3BK/RYwCUM03Df64TYvBBPs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-ljABgdQ0NqSxueRcrnZOZQ-1; Sat, 11 Sep 2021 14:34:51 -0400
X-MC-Unique: ljABgdQ0NqSxueRcrnZOZQ-1
Received: by mail-yb1-f199.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso7144287ybq.10
        for <selinux@vger.kernel.org>; Sat, 11 Sep 2021 11:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ygP7YLhmwkNujKf1H4CegsZoJqHJDfcEiFXiIKcFHf0=;
        b=wCFHAu+A8wbKjoqqWDiRc5TV6UEkJL46Qp+8mlP1n9gV89rqMAF6bTDbI9CHKvPSAQ
         AjY2FqXeg0tNNso6S5xsjnU9c33Z0acHN/5vY/3T3qcS2Ppw1Dh25wLP0g95XghRfzmk
         ykglAEKNs5SxDnfQdUUv7NA4tM+erlaSjWUqg4LZ8Ml3s9/TYeYzpImrGMoI08AIWs9n
         Jks3BMPUhyHrXM98FEmDCd3d0c7DQ8aj+8ixseIdNIyFxKsLhCmV/3EhvOVxNLJhicCK
         ZHc814i4mYnlmup+A6IEEwjlTstenFsoHiKQiglBrR8tgF2woYBg3d4JP9EB4owbVRed
         qjDQ==
X-Gm-Message-State: AOAM530ZFb1IHm3hsZuDf8N2p+rgie620slG7RLBdqivLnGB4A8xoPeC
        blWvd6jj4OEmwQhcPU9CNt8Q8bcqQTNEHGoSDIJ1uPi77isshbu6696HiYqw58PKtm2DolnAShE
        JBbxS30uUsK8B8mhfLIhgmIeuE4BIHh18GQ==
X-Received: by 2002:a25:ddc7:: with SMTP id u190mr4553316ybg.479.1631385290963;
        Sat, 11 Sep 2021 11:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxHxbYHeqokOLr1xdNFwqgUNAlhgdVYtcxVgruSF2aGpBoibjfNUQahXcEF0evXJd8wdxvojeU3nkkwTqlJAY=
X-Received: by 2002:a25:ddc7:: with SMTP id u190mr4553298ybg.479.1631385290698;
 Sat, 11 Sep 2021 11:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210906105435.96417-1-omosnace@redhat.com>
In-Reply-To: <20210906105435.96417-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 11 Sep 2021 20:34:37 +0200
Message-ID: <CAFqZXNutrW7WsQ19VwwXFn378ZBs3B_tsWKefMUiCpicNE121Q@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/2] tests/module_load: simplify the clean target
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 6, 2021 at 12:54 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> No need to guess all the wildcards to remove the intermediate files from
> module build - we can just use the kernel module build system to clean
> them up for us.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/module_load/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> index b6eba25..ce34241 100644
> --- a/tests/module_load/Makefile
> +++ b/tests/module_load/Makefile
> @@ -9,4 +9,4 @@ all: $(TARGETS)
>
>  clean:
>         rm -f $(TARGETS)
> -       rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers modules.order
> +       $(MAKE) -C $(KDIR) M=$(PWD) clean
> --
> 2.31.1
>

Both patches are now applied.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

