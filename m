Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F0C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 13:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999122084C
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 13:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKVAdqEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEZNGn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 09:06:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728061AbgEZNGm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 09:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590498400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCsbPo8Rx7qkKPaeE6zMk1Tv+8aIwCunkkpJ3yPXdfE=;
        b=AKVAdqELHAErt37Pr3eKKcjUwZZE4MVLSv4cP+/rkA/WNpeleVhclMNQ9Wd02HpFk/G9Zr
        F4ONdf4aijY7W57f6eJ5zEvaAmJoEWXfIYX0+gYGmzF80IDUcSzbm7KoDPfiNF4ckVgueI
        MgT+LmN5yUXIRk7jKBDDlGdHB6c2884=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-mQXH3yrnM-GQ5rsmZzRpTQ-1; Tue, 26 May 2020 09:06:35 -0400
X-MC-Unique: mQXH3yrnM-GQ5rsmZzRpTQ-1
Received: by mail-oi1-f197.google.com with SMTP id i203so11071942oih.6
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 06:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCsbPo8Rx7qkKPaeE6zMk1Tv+8aIwCunkkpJ3yPXdfE=;
        b=KdctWmBWT3dFw4CnalpeRBRkH4xePnSwk4iHoy3WvKVVDQkriSf1VXGqW38OBRP1wT
         n2Bn/Dl7JmZYbHYm1kAQoS1Eb1PanTFka+VhGcnjz5Pulkv+4+HMNRI6qObCTEqJGtWx
         65ZD9+mmA2kBQZgjmfwQe367JzF7XikuQxJT6BsIMOKuIU/1xnpVwH+efyHgHovIalKO
         oZ7y2mEiXVZI6kMhKNXzeg1tcjvhVdhBNRxjkqo+0oDcWiNKZlsqzbaZ+sloEyFCzMcj
         trwMzKHddAZg2CfD17F22OF3TgB+IxTZ164z0Ao4dmSTBdIlrLQFxpDEord8hWAP6a9f
         ksLA==
X-Gm-Message-State: AOAM532VoZ4yKD2EHu+vxgfmqjOm70RYPqG8xiPlrpA0dBh8RCjNMNa7
        IMq7xavV0ldOYL1Bs9aumGD9pWe1yOCZ/8Fit5bWpX+n9w1K9ILoSeCM71ubBEZVmAVW7KB0iEO
        JX6yAup41oPzJusYEgR7phvPfDctfEbWbHg==
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr14676755oif.166.1590498394913;
        Tue, 26 May 2020 06:06:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoaMZZfE9flJwhg2G3LW9Ev+eentYjDRouQaY4AvhMlZFeDlozXYxe9KtLq17+UA+lOHiYuUZUrRDmKag0VxE=
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr14676738oif.166.1590498394661;
 Tue, 26 May 2020 06:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200520152538.23184-1-william.c.roberts@intel.com>
In-Reply-To: <20200520152538.23184-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 May 2020 15:06:23 +0200
Message-ID: <CAFqZXNumYyhzFhzGGrKZcFrAeRMgy4-WqaXvqVwKM1285vSgsQ@mail.gmail.com>
Subject: Re: [PATCH] README: Add kernel-modules for SCTP
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 5:26 PM <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Some Fedora images, notably the Fedora 32 cloud image, do not have the
> kernel modules package installed by default. Thus SCTP isn't available.
> Add the proper kernel-modules package for the running kernel.

Hm, I thought it wasn't possible to remove the kernel-modules package
for the running kernel, but it really is...

>
> Note: This applies to selinux-testsuite.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  README.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 1bec9fe85c91..1a4c70c40d56 100644
> --- a/README.md
> +++ b/README.md
> @@ -77,7 +77,8 @@ following command:
>                 kernel-devel-$(uname -r) \
>                 quota \
>                 xfsprogs-devel \
> -               libuuid-devel
> +               libuuid-devel \
> +               kernel-modules-$(uname -r)

Can you please put both the kernel-* packages together? I think it
would be best to always have both at the end so that anyone who uses
locally built kernels can easily copy the command without the two. Or
I can just amend your patch when applying if you're OK with that.

>
>  #### Debian
>
> --
> 2.17.1
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

