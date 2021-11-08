Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1DC433F5
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD96E61361
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhKHVnl convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Mon, 8 Nov 2021 16:43:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46882 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbhKHVnk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 16:43:40 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 557035605C1
        for <selinux@vger.kernel.org>; Mon,  8 Nov 2021 22:40:54 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id b4so16370041pgh.10
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 13:40:54 -0800 (PST)
X-Gm-Message-State: AOAM533I0UpbGgGnZogsN4fF46lqVJrbx2oWrHj2BSP4wvYAzzLTUUQE
        9zr26puH7FlG0e2DEVQjRHsZvDO/YSwXIOVtnJk=
X-Google-Smtp-Source: ABdhPJzxaxRjuiGabGL6XkCtXBMv7v8zfORfPQX0l1MBAnunAY0UxrXwQyNr327W3FlM5y87xaMzS41z5CCIUJaPPn8=
X-Received: by 2002:a05:6a00:b49:b0:49f:c8e0:51ff with SMTP id
 p9-20020a056a000b4900b0049fc8e051ffmr2566607pfo.36.1636407653189; Mon, 08 Nov
 2021 13:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20211021140839.7439-1-cgzones@googlemail.com> <20211105152937.36412-1-cgzones@googlemail.com>
In-Reply-To: <20211105152937.36412-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 8 Nov 2021 22:40:42 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n4rjs9mbqdcfMvYEMnyzUJssRR72rYT1NavCg0Ui4ggQ@mail.gmail.com>
Message-ID: <CAJfZ7=n4rjs9mbqdcfMvYEMnyzUJssRR72rYT1NavCg0Ui4ggQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: avoid passing NULL pointer to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  8 22:40:54 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 5, 2021 at 4:29 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> memcpy(3) might be annotated with the function attribute nonnull and
> UBSan then complains:
>
>     module.c:296:3: runtime error: null pointer passed as argument 2, which is declared to never be null
>         #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/module.c:296
>         #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:337
>         #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule_link.c:145
>         #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
>         #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32a9)
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
> v2:
>   include length addition into if block
>
> ---
>  libsepol/src/module.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 02a5de2c..b718751e 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -293,11 +293,14 @@ static int link_netfilter_contexts(sepol_module_package_t * base,
>         }
>         base->netfilter_contexts = base_context;
>         for (i = 0; i < num_modules; i++) {
> -               memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
> -                      modules[i]->netfilter_contexts,
> -                      modules[i]->netfilter_contexts_len);
> -               base->netfilter_contexts_len +=
> -                   modules[i]->netfilter_contexts_len;
> +               if (modules[i]->netfilter_contexts_len > 0) {
> +                       memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
> +                              modules[i]->netfilter_contexts,
> +                              modules[i]->netfilter_contexts_len);
> +                       base->netfilter_contexts_len +=
> +                           modules[i]->netfilter_contexts_len;
> +               }
> +
>         }
>         return 0;
>  }
> --
> 2.33.1
>

