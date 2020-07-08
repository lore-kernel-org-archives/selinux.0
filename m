Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC4C433DF
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28440206E9
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWjWqNTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgGHNne (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgGHNne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 09:43:34 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B0C061A0B
        for <selinux@vger.kernel.org>; Wed,  8 Jul 2020 06:43:34 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x2so1678552oog.5
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DopFc55/SZB3zGhYTZuJACJazLhNrETVPUa+d4CYbE=;
        b=aWjWqNTpiSC8+gUNgZN0PEukE7Kuy383+h7yPRUAN8qcce2sGHrLVnYgGekIFBrvLO
         xdSNBHufPtiX/8b4cpJ9iy5GCRcIsqCVTWKUG5DWVV9nlllySuM7incSkHI8+xWZsovQ
         ZSIj3EhGgO6A1EwmhTYYbHioVuu2mf00RRfB+lzNUPrQA1xvZq+zV3uoIboDb8Fo7V+O
         mx09FPDmIQinsd0ijp5w7NQpsvUTIqZ6DkuOG829biulMjKRhlbrLMldi9wl8h4dkBEP
         KFSWzqkMraDA9GgCqHlpe72v1mW3xE398XC66NokR99KpTD1e9ryBgPttulvgerzERf8
         52hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DopFc55/SZB3zGhYTZuJACJazLhNrETVPUa+d4CYbE=;
        b=PMhVrjaoFo97Beu6upSvEV7HFbI9xnUHi+tX5KH9Va/Kfb4kf108DCXokQtHf5pxE9
         oI8YSo6giTwTGXC4QLG/0bw3PJd8MAhc+7vTy4CX7qCL3ZWL10YysF7IoHwLfzSH5NfC
         lGpmfCLNmtvNmxWfcoEJXp3GvrcLWoxmMPVklHDkVajc/HKPbbt3nqFN5xROjDv6cu2g
         cEhC3+HNh1d6YuZQQ/HA9z0ObCQd50S7CyY4XiXSVbvoO+EmUd8PKHFU+KYrb4c9koGX
         fUT5cwiCjL/joYU+yaG/AIOCLcUePD1HiFxF7OHG6yUy2+o7d1gWg01cN10vI7iZTUx6
         3/ZQ==
X-Gm-Message-State: AOAM531W+q7qVOPl7g2D2AyZq4MKwawZSD4JmF6S4pYUikPNB7GzuyE1
        P5uX0xVvftFBPyBEbFEYuo7rRL2xF7sJlQpf1DqlgqH7
X-Google-Smtp-Source: ABdhPJwDlXdRHLnc99UazKI7H1F5kQPJFN3e1I3LxPZNHa/SHxPXkP/9muMWa5YF1HX+ch2oYzYGaB4ro3W1In1C42c=
X-Received: by 2002:a4a:4555:: with SMTP id y82mr43522863ooa.71.1594215813906;
 Wed, 08 Jul 2020 06:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-4-omosnace@redhat.com>
In-Reply-To: <20200708112447.292321-4-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 8 Jul 2020 09:43:23 -0400
Message-ID: <CAEjxPJ7Py0qB92XWUH+aPmkqdtyaarve7OBeVPbLYgkyqvUFEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: complete the inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Move (most of) the definitions of hashtab_search() and hashtab_insert()
> to the header file. In combination with the previous patch, this avoids
> calling the callbacks indirectly by function pointers and allows for
> better optimization, leading to a drastic performance improvement of
> these operations.
>
> With this patch, I measured a speed up in the following areas (measured
> on x86_64 F32 VM with 4 CPUs):
>   1. Policy load (`load_policy`) - takes ~150 ms instead of ~230 ms.
>   2. `chcon -R unconfined_u:object_r:user_tmp_t:s0:c381,c519 /tmp/linux-src`
>      where /tmp/linux-src is an extracted linux-5.7 source tarball -
>      takes ~522 ms instead of ~576 ms. This is because of many
>      symtab_search() calls in string_to_context_struct() when there are
>      many categories specified in the context.
>   3. `stress-ng --msg 1 --msg-ops 10000000` - takes 12.41 s instead of
>      13.95 s (consumes 18.6 s of kernel CPU time instead of 21.6 s).
>      This is thanks to security_transition_sid() being ~43% faster after
>      this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
