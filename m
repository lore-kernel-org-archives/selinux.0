Return-Path: <SRS0=laxl=VE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F2C48BDB
	for <selinux@archiver.kernel.org>; Sun,  7 Jul 2019 21:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EB020684
	for <selinux@archiver.kernel.org>; Sun,  7 Jul 2019 21:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGGVDN convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sun, 7 Jul 2019 17:03:13 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47338 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfGGVDN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Jul 2019 17:03:13 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5E44656470D
        for <selinux@vger.kernel.org>; Sun,  7 Jul 2019 23:03:10 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id e8so14148689otl.7
        for <selinux@vger.kernel.org>; Sun, 07 Jul 2019 14:03:10 -0700 (PDT)
X-Gm-Message-State: APjAAAURLb+trIe2Fr+9J8WV+Ljs9hUDsQycOPPOU1nqzLKGQ46VysKp
        q/gjuf56ABhgDjrqZErjLt4tHb2URrNygZNfSGA=
X-Google-Smtp-Source: APXvYqy1KyIzBLb2odO1sAhe1xPGp2o5PNRsnmDt0139hsr4Wk2N+sZwA0mvNQlbg9Wzm2bkkb3BW/4/wsb0tL3A3zw=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr11188604otp.189.1562533389553;
 Sun, 07 Jul 2019 14:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190703141255.6321-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190703141255.6321-1-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 7 Jul 2019 23:02:58 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==rnxFKiUtNg0FFXLM7_F6qCPVWJAwBK86EaZsyKp-ktA@mail.gmail.com>
Message-ID: <CAJfZ7==rnxFKiUtNg0FFXLM7_F6qCPVWJAwBK86EaZsyKp-ktA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix security_get_boolean_names build error
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul  7 23:03:10 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 3, 2019 at 5:22 PM Richard Haines
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
> ---
>  libselinux/src/booleans.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ab1e0754..882a5dca 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -81,8 +81,13 @@ int security_get_boolean_names(char ***names, int *len)
>         free(namelist);
>         return rc;
>        bad_freen:
> -       for (--i; i >= 0; --i)
> +       if (i == 0)
> +               goto bad_freen1;
> +       else if (i > 0)
> +               --i;
> +       for (; i >= 0; --i)
>                 free(n[i]);
> +bad_freen1:
>         free(n);
>        bad:
>         goto out;
> --
> 2.21.0
>

Hi,
Thanks for your patch. It looks more complicated than it should be.
Why do you introduce a new label instead of a simpler if statement?
For example I think of this code (I have not tested it and it may
contain issues):

bad_freen:
    if (i > 0) {
        for (--i; i >= 0; --i)
            free(n[i]);
    }
    free(n);

>From my point of view, this would be easier to maintain. If you have a
good reason for using a new goto label, please add some sentences
about this in the patch description or/and in a comment next to the
modified lines.

Thanks,
Nicolas

