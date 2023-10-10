Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F3CD8CA5
	for <selinux@archiver.kernel.org>; Tue, 10 Oct 2023 15:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJJPSm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJJPSm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Oct 2023 11:18:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB29A7
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 08:18:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so74608941fa.3
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696951116; x=1697555916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNpDvnClIIY6MIRte7kTrIAtaeYWPrlhU1Prpgzlp10=;
        b=irh/Jitle9k5UI43sTltJC7UfjT6EoiAHwBS2f9hhoM82mWRAlFUkjMWo5MyrbIBjV
         n7JyCcvyI+4q7WGi3D9P7nXDbFdP8MmRl8HUWpz+g6zN6lMbA+7lCEm9stfas2Bdlt1y
         rNjR+MbAOs+Ugeq1k+NWNBtb/DLQdy6PYU4Ab4tY6NnF2G/VcJdnnIuC5+dEvAPWwonu
         eKQk+fgCbO1gEZA8Kal8vdnYRP1QkPXQQQOkFRWm0LQqNj5OnapmegXlYq3Cm8bQ8rRl
         cdro/6Rq7mLNNrE/K65fwOMOTuoaSNw6PTFJLgHlYHksB++9TtzE78K2GbuEAWXRCIRS
         xPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951116; x=1697555916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNpDvnClIIY6MIRte7kTrIAtaeYWPrlhU1Prpgzlp10=;
        b=twHnjZFKgawDjZb6CNa+YU8zUoTq1Z2MEwgKIdtvPlAL610OYeJ+CO2FwLP2Ya7p7u
         1GMAtyKb8nxtEn9s9c8L/AstKBaArr49zdUYPQvQryXEf1zMv0hYQKxH8dhl+DzlYLP3
         Ej/L8y2++v5FGgdegXYvq9ezZNKprNGwr8GOhm1GLzwzz+leev0sx4GPb3QP4dW71biS
         l3UVl7y94nn2o0PecDQLGEr8jRcOMk/TaZO5Pf1Xm/5ZmCIgnyAq1N17Mnuu0kO4BvLE
         /7/8Tty0Hj4l9m1T0c1jDi17AWG3NmHtgAx/65nigVOfCw7o6PavV284jpKk3/vg+Ruh
         Nw9g==
X-Gm-Message-State: AOJu0YxRynshWPcwe4smCd184+Kv4bCk2brnBQmNCbnt0n4YmPFT3h9C
        Qc3iXw79KIvUpHfOxkoaAFLKjr9V0902wHk3pYdstLbk8bs=
X-Google-Smtp-Source: AGHT+IFwhUoACW93fG8tRKUgxQO3/zi9xp0rryicqpe5wdnVuOhRwqzXA7C5mycqru8slA2bP3XSy0GEIrZTZQ9Ummc=
X-Received: by 2002:ac2:5e6f:0:b0:4ff:7046:984a with SMTP id
 a15-20020ac25e6f000000b004ff7046984amr15055220lfr.7.1696951115597; Tue, 10
 Oct 2023 08:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-17-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-17-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Oct 2023 11:18:24 -0400
Message-ID: <CAP+JOzSGjo0xFmyfTajV-S0VA47fXE12SLdj0HS2Ds8ztirGuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/27] libselinux: update string_to_mode()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Drop parameter NULL check since the only caller does a NULL check on the
> argument.
>
> Avoid strlen(3) call by comparing by hand.
>
> Drop unreachable return statement.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.h | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 190bc175..1363c83c 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -97,15 +97,10 @@ struct saved_data {
>         struct selabel_sub *subs;
>  };
>
> -static inline mode_t string_to_mode(char *mode)
> +static inline mode_t string_to_mode(const char *mode)
>  {
> -       size_t len;
> -
> -       if (!mode)
> -               return 0;
> -       len =3D strlen(mode);
> -       if (mode[0] !=3D '-' || len !=3D 2)
> -               return -1;
> +       if (mode[0] !=3D '-' || mode[1] =3D=3D '\0' || mode[2] !=3D '\0')
> +               return (mode_t)-1;
>         switch (mode[1]) {
>         case 'b':
>                 return S_IFBLK;
> @@ -122,10 +117,8 @@ static inline mode_t string_to_mode(char *mode)
>         case '-':
>                 return S_IFREG;
>         default:
> -               return -1;
> +               return (mode_t)-1;
>         }
> -       /* impossible to get here */
> -       return 0;
>  }
>
>  static inline int grow_specs(struct saved_data *data)
> --
> 2.40.1
>
