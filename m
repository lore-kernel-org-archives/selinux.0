Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A28C35274
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiC3OyS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347913AbiC3OxR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 10:53:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024949C82
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 07:51:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so15067873otj.1
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzqLBgpY30JTEq8g+zmI8I7A5W+i5ZMNjej7xz9ffmE=;
        b=XUUJd5FKAo591QgvSED0pCa1g4vduxBAsTiGM5hSsnnDVSVSyRrakU0aAZ9fsI7XAc
         AXK8CytO0/9lQnXJzmxMqsRSTpCNCx2eWEB0L4uMKqC1e5JOhvHuP+B6QnDs3CqzYljr
         qEJMN1NCPP4AiJorWK5QgRrachl5XXo74O0/Icbj+Lu5xXqB5S73ut7Fs9jqxWc8Bu8y
         IUJMXaDzoGoEfMGYh7QxVsQR3/whHdVRvgsxXsvDp01sgRF3/kfbIy9I1vJtLPPKdzcX
         OO1K2N8jcXS7f46qwuHAkZRzGdT5tznVoj1EARRyB6AKdsK29Mpp/RuJVWDV4fIdv/Ey
         FyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzqLBgpY30JTEq8g+zmI8I7A5W+i5ZMNjej7xz9ffmE=;
        b=2j3kd/HZQaifhxodaN/JeVyi0PB85xWby3QRV94IgSRKOxtCBL585D9cmdHxF8AeQ0
         KAkQr6S5rjslcdhBtpj2PZQY0LfEKPdphB0tiWAIDwq0gKLujbb1gu0nFmZUS48hhgA+
         Ixl/fW61SiyhdAnk7YRbR2bg8ko8Lm1rA+Zg3MLmomDKLi60emtNibzDncnKQwpyK07X
         LnQ8kyIVaw3z0t9KKJtcmb0OwAco+PdXJXcUf5zWgblqrh+Rk7Ti6g2X2oCheLqFw2Ha
         xNKFY6a4MMfgAwZFAHWrq0Hg1T8VxHIlD3UnoR28c2whwJ4qsiE7ZZnGqiVMHN4wPO78
         j60g==
X-Gm-Message-State: AOAM5323bJd/tGOfJfJu963qZ96y50hK5lODpM2O32Z/MsUlSMyQ4MSU
        fH366tld0QIcfKS3vXpq0AAvNwvQoY6aZ1Sf0W99lzna
X-Google-Smtp-Source: ABdhPJzt15SxFSQDmjpSFQwZ2CCfueQK/bDeP/yWWrbBQin4VvG4YndXmHVGnExae/vw9dSFmsay8WxqvbHhFVsDzsk=
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id
 c2-20020a9d7842000000b005b24dee79c2mr3374200otm.53.1648651892204; Wed, 30 Mar
 2022 07:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
In-Reply-To: <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 10:51:21 -0400
Message-ID: <CAP+JOzSm3S4xkzRAwvs+5Diy39LimcSr44dH48_gqjTwcwG1EA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 9:55 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Use calloc() instead of mallocarray() so that everything is
> > initialized to zero to prevent the use of unitialized memory when
> > validating malformed binary policies.
> >
> > Found by oss-fuzz (#45493)
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/conditional.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index f78b38a2..a620451d 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> >         if (p->bool_val_to_struct)
> >                 free(p->bool_val_to_struct);
> >         p->bool_val_to_struct = (cond_bool_datum_t **)
> > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> >         if (!p->bool_val_to_struct)
> >                 return -1;
> >         return 0;
> > --
> > 2.34.1
>
> Why not change the mallocarray macro to use calloc? I see a number of
> mallocarray calls that should be audited if this approach is taken.

Many of the calls to mallocarray() should be replaced by calloc()
because the array is initialized to zero right after the mallocarray()
call. I guess all of the calls can be replaced if you don't mind
having the memory set to zero and then immediately setting the array
to different values.

I will merge this patch and send another patch replacing mallocarray()
where appropriate.

Jim


Jim
