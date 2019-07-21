Return-Path: <SRS0=0060=VS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB3C76191
	for <selinux@archiver.kernel.org>; Sun, 21 Jul 2019 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44E206B8
	for <selinux@archiver.kernel.org>; Sun, 21 Jul 2019 22:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfGUWx3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Jul 2019 18:53:29 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44140 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGUWx3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Jul 2019 18:53:29 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5A81F561258
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 00:53:26 +0200 (CEST)
Received: by mail-ot1-f42.google.com with SMTP id b7so38183039otl.11
        for <selinux@vger.kernel.org>; Sun, 21 Jul 2019 15:53:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXca1RdFyofnj0lcGh2n/t3OJ0b8QLbDe1SZMv4KF0npxCurHDj
        wbIyXQMKkaLCHdyWjdpeJKl5B6otz0KXX616A/0=
X-Google-Smtp-Source: APXvYqwM7QrETGLmeNSlVjoTL+ZrmwMZwRCnN5mig9G+VPSTV/04jbWqOanDMmfKjdgADhUsP3/3KOseIQxWJllwxZc=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr45067525otp.189.1563749605328;
 Sun, 21 Jul 2019 15:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190708133701.32317-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190708133701.32317-1-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 22 Jul 2019 00:53:13 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nxAN0XsH8ChEeW1J55-3CqFisa2bAS8k-3Y4spkF-2Hg@mail.gmail.com>
Message-ID: <CAJfZ7=nxAN0XsH8ChEeW1J55-3CqFisa2bAS8k-3Y4spkF-2Hg@mail.gmail.com>
Subject: Re: [PATCH V2] libselinux: Fix security_get_boolean_names build error
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 22 00:53:26 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 8, 2019 at 3:37 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> When running 'make' from libselinux on Fedora 30 (gcc 9.1.1) the
> following error is reported:
>
> bute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wstrict-overflow=5
> -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND  -c -o booleans.o
> booleans.c
> booleans.c: In function ‘security_get_boolean_names’:
> booleans.c:39:5: error: assuming signed overflow does not occur when
> changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>   39 | int security_get_boolean_names(char ***names, int *len)
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:171: booleans.o] Error 1
>
> This is caused by the '--i' in the: 'for (--i; i >= 0; --i)' loop.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Your patch looks good to me. Sorry for the delay (I had some issues
getting a reliable Internet connection lately, which have been fixed).

Merged, thanks!
Nicolas

> ---
> V2 Change: Simplify the free loop.
>
>  libselinux/src/booleans.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ab1e0754..a9154ce8 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -81,8 +81,10 @@ int security_get_boolean_names(char ***names, int *len)
>         free(namelist);
>         return rc;
>        bad_freen:
> -       for (--i; i >= 0; --i)
> -               free(n[i]);
> +       if (i > 0) {
> +               while (i >= 1)
> +                       free(n[--i]);
> +       }
>         free(n);
>        bad:
>         goto out;
> --
> 2.21.0
>

