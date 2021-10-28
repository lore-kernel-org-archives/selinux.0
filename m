Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0CC433F5
	for <selinux@archiver.kernel.org>; Thu, 28 Oct 2021 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1690360F70
	for <selinux@archiver.kernel.org>; Thu, 28 Oct 2021 18:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJ1SMI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhJ1SMD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Oct 2021 14:12:03 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A63CC061570
        for <selinux@vger.kernel.org>; Thu, 28 Oct 2021 11:09:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so9833398ott.2
        for <selinux@vger.kernel.org>; Thu, 28 Oct 2021 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ot1o4GhoW9du5qR4M3vXTohcaJA3muhiz2eCwZXukYg=;
        b=G33P4siqju83LTwALK4apqJo9GG0Gnib0Fs7sMKOZdToTGE8gFVEDaB4I4CG6COqrn
         P/0b76XB920gfOFMETtD5q4Nmr26wLXloImaynaposRT5Ysu3tBDgKyZB3+I46hHJBLl
         xSig3EYMhU4Njh/SL432x3/RsYu6vQMUehkffBtXp5eGpMFs8FXsJHHV14c8zE1/F3VT
         3TjrEPYu61Hsrvig64H3NW3BTHfw5Y/zuk2X8guSegqWOmA30T1SExAQ/J8lQQ2kzvCc
         LtwsYN0NAVxC7c7vm8xzvJNx+Ngu147kOLhQ/Y4SjoxQDiuKfOnO+gfz/B2t3xqwIpgI
         2unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ot1o4GhoW9du5qR4M3vXTohcaJA3muhiz2eCwZXukYg=;
        b=aaM8ai21StYZDjJEZ+4kq3YMnTuEeOmOYJ4kFATRbqki1QSeZe6EOLSBedyhfA/SXD
         WcR67mAxPfihkn6Nyb5LrKZCQ81vuaDKGFD2MD3DPtpPExtp5v9TG30rKkSsFQdTvoaP
         1ufpbfd08kZ0TmJImdOtcYGUJhSz30T/nNpqtHjdlHLEnyPS4CQ3xsbjYeyHv4fczTFb
         IujtVc3xfxaYoPNDWwvfgj2zAUhMRlTT99sHaWZQIthVk3vkXAsNGO3w0qzsfabUkdNH
         GketDz1AvGEX0z+augsND/ocnKGO2irVrPHJ2SmVUOD8HjA8tUgycoQMNjbhGo4EFGKH
         eyZg==
X-Gm-Message-State: AOAM530XbM91zRL+5rOiSrMBohFs6V+TRNt0ldQ8t+EN65urPOScVn8J
        B/9lBuTIkOUgdKdvSEJcv/n8cyUAgfH2GTAlItY=
X-Google-Smtp-Source: ABdhPJzLEdKFZH4xCRgyU5hZxwbNBY56EkAsTTKNquCehyC5HPSA9Jlbbnu42q45OgD85fUW24sWVccPeE7L9kEE3/U=
X-Received: by 2002:a9d:6346:: with SMTP id y6mr4861022otk.154.1635444574865;
 Thu, 28 Oct 2021 11:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211021140839.7439-1-cgzones@googlemail.com>
In-Reply-To: <20211021140839.7439-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 28 Oct 2021 14:09:23 -0400
Message-ID: <CAP+JOzSRiwA9Vr3R6VYU2uYRQYDR6csY-BBS=Rr6dhO0WhXcLQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid passing NULL pointer to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 21, 2021 at 10:09 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> memcpy(3) might be annotated with the function attribute nonnull and
> UBSan then complains:
>
>     module.c:296:3: runtime error: null pointer passed as argument 2, whi=
ch is declared to never be null
>         #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/modul=
e.c:296
>         #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:=
337
>         #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule=
_link.c:145
>         #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
>         #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32=
a9)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/module.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 02a5de2c..ed777f8e 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -293,9 +293,11 @@ static int link_netfilter_contexts(sepol_module_pack=
age_t * base,
>         }
>         base->netfilter_contexts =3D base_context;
>         for (i =3D 0; i < num_modules; i++) {
> -               memcpy(base->netfilter_contexts + base->netfilter_context=
s_len,
> -                      modules[i]->netfilter_contexts,
> -                      modules[i]->netfilter_contexts_len);
> +               if (modules[i]->netfilter_contexts_len > 0) {
> +                       memcpy(base->netfilter_contexts + base->netfilter=
_contexts_len,
> +                              modules[i]->netfilter_contexts,
> +                              modules[i]->netfilter_contexts_len);
> +               }
>                 base->netfilter_contexts_len +=3D
>                     modules[i]->netfilter_contexts_len;

This line should be in the if statement as well. There is no point in
adding a 0, since the check for > 0 is already being made.
Jim


>         }
> --
> 2.33.0
>
