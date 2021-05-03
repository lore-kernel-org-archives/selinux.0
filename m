Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA73C43460
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB448613B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 16:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhECQpw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 12:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhECQnt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 12:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620060175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=urZngWBYyqYOZvdMyDp5JZ3apgUdbSts9Kt/2XnTta4=;
        b=POAGk4CnI/6EW1BMI9YFBs2T5vDzfPKjix3+dSxKOG+s58TjmSg26Joz0vayyZgRwmdd0R
        rkAFQxiSpsKKNC2LqV6oCU+4smGA4LOdJDXdYBbtqIshJwpbcOnxb6coloDHI2Krh5hC7p
        dVMgzTGGKg4Jrsoddlx453hTyLMZ5q4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-fT5Ry9hbMcyYl0MWxhq7bw-1; Mon, 03 May 2021 12:42:52 -0400
X-MC-Unique: fT5Ry9hbMcyYl0MWxhq7bw-1
Received: by mail-yb1-f197.google.com with SMTP id a3-20020a2580430000b02904f7a1a09012so4661052ybn.3
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 09:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=urZngWBYyqYOZvdMyDp5JZ3apgUdbSts9Kt/2XnTta4=;
        b=QzjT6VFS5oQML1GnFexn0EnD28SSoH2aUO/cFU7glH5xXzg7eu4/bxguevNHGtd1OP
         NxNS5u/3TbC3SOgbeT1KlXttoiYp44tvv+SXo9EvW4slkvDQCGRBzJEyejhpJjv0748B
         YVcJ3EVgB+2NxT8mact3XnWz1Rek01Qu9HLAGlIiikc1g8xJYdkcUcS2+Zc1K6/5po6s
         UGN0mnkdHzxMml5xMCFlbKsMbc46Ft6o8CDVHzdqNjpLOhm06yYtr8PdpnYd7KfD3Ilz
         cJ02eF72X5b1QUOLhS7dNQHAVH2jyAT/5x3CFESEXvUha5hQQfprb32+WlxMpcLs3LG/
         Otfg==
X-Gm-Message-State: AOAM532k2Eg32TAg6ZCTd/IAHtEodHS7WcZimSDu29Y5yTRJoPBOaf/+
        odk9vggmsN56IILDWrvqzeuoya1E2+NSPycoKorhnxjd4hEttSQbY7YVMEkWgMg4PwyC8JHYdL2
        R65QYRSAJ391cDT5/d6mfAzd1o958XqJW1Q==
X-Received: by 2002:a25:e901:: with SMTP id n1mr10675969ybd.340.1620060172183;
        Mon, 03 May 2021 09:42:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9rLq+gf7osCDi3XGl/QsAUqwrKzNBMWgiM2MmI7KFvQ0Nw+DsWsW/+v+NYfB4QPPSiitmBeyscFoaiyDFCuQ=
X-Received: by 2002:a25:e901:: with SMTP id n1mr10675954ybd.340.1620060171988;
 Mon, 03 May 2021 09:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210501104419.20220-1-omosnace@redhat.com>
In-Reply-To: <20210501104419.20220-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 May 2021 18:42:40 +0200
Message-ID: <CAFqZXNvqE8LbmfXLn5GZnqC+whwU8VefJAQyGCZc9BpPDNzy1Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] ci: test also on F34 images
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 1, 2021 at 12:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Change the CI configuration to test also on an F34 image in addition to
> F33 and also test kernel-secnext on F34 instead of F33.
>
> We could of course test just on F34, but having an older release in the
> test matrix should help ensure that the testsuite will still work on
> older kernel/userspace versions as well, so I'd rather keep both.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  .github/workflows/checks.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
> index 59f1a47..d0e276e 100644
> --- a/.github/workflows/checks.yml
> +++ b/.github/workflows/checks.yml
> @@ -15,7 +15,8 @@ jobs:
>        matrix:
>          env:
>            - { version: 33, secnext: 0 }
> -          - { version: 33, secnext: 1 }
> +          - { version: 34, secnext: 0 }
> +          - { version: 34, secnext: 1 }
>      env:
>        FEDORA_VERSION: ${{ matrix.env.version }}
>        KERNEL_SECNEXT: ${{ matrix.env.secnext }}
> --
> 2.30.2
>

Also applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/58eaa31c9e0e0a0567990336ae355b4cd309e6e3

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

