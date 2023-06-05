Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89065C7EE23
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 20:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjFEUKG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFEUKF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 16:10:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459E98
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 13:10:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1a6777dd8so64022141fa.2
        for <selinux@vger.kernel.org>; Mon, 05 Jun 2023 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995803; x=1688587803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL8bavdR/k+eBcyzgIqSu+2j4hMW7sfaF6VnWRAW2v8=;
        b=J+gUQltG9ojNwjkIxv0iDyVe0pGdJcRaL98sX0I3XFvTJb1M/EhN4U6hJ60d+QH1MA
         gyV0d4K8NFwaUMcF6SUGV31l31ytZHNmEgkIMBuiu5BmGSF5zP8I7TF3trnZAc1Q3cua
         MFu1jDi3WJfMxvmUrJVnvOiD8hkGfX3xPEI4FW2ajy0TyWaTrc5KeLVGP8DMN1WUm4HE
         BEtVA3VDM+HHTetub/Fn9vsksqy0RmF65p3upmQjOjwR0MUQTTgyHj2npyuREtrkZjsJ
         sA7pRMWzfP9U4K5CNsa2YP6tsf47MciKNS4P4STy1VJchOzc/lYPkn+99/3NSW9DCfrk
         GbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995803; x=1688587803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL8bavdR/k+eBcyzgIqSu+2j4hMW7sfaF6VnWRAW2v8=;
        b=aSzDRQ3wuM7t9TQmPRbSHRtkZWxTwVjdkbuMN6Ck+UQLysRuqfutYZD8OdiMfiJJai
         NuS6ue5X6qq5W/78bjUj3+OzgWd1KltFVaKYrlA3p32hiI2+3HFdpY+kpgjC+rdKcGig
         /cfxMmqNXIqur8l1lcVV8khWLtSEjCMGUaRHcHqhnXNtDZsUHirblZfSz3HrLOgnW7Kl
         33QgIIh2xNuhfmwRObk/n/JjL4zNQZwTf+dShtDEoNxwXPMw8v1HKHZptvjqv+3Ucq7t
         pzTnGRUpMpDdJgq37YGKbKgG5p1FYpPIVjSSrg8EpmVdZtc0JT9yoWAxyCihcGClJ5Mu
         SrFw==
X-Gm-Message-State: AC+VfDwummGhhXyCKkfHHdO0FDuCYj1dQzZ0mFRVQUWp30nIyimPa5pH
        b7KsBItY/w/2QFdFZhP3jApk573UtWrdnLyaqFY=
X-Google-Smtp-Source: ACHHUZ7DbFBfTlMEvbr/4sz/TA02ZKIT2jIKmUB90KHkVn47faM7Pg2yNFyC5+M/vygkdsv/44Yzoq6g9pqHd3aWsXs=
X-Received: by 2002:a2e:9859:0:b0:2b1:bf75:4482 with SMTP id
 e25-20020a2e9859000000b002b1bf754482mr151396ljj.36.1685995802549; Mon, 05 Jun
 2023 13:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230512093001.49208-1-cgzones@googlemail.com> <CAP+JOzRJVORDra0SZ=X+mfaYtj=5NMv5-6CeM9xAewO+6P7uwA@mail.gmail.com>
In-Reply-To: <CAP+JOzRJVORDra0SZ=X+mfaYtj=5NMv5-6CeM9xAewO+6P7uwA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 5 Jun 2023 16:09:51 -0400
Message-ID: <CAP+JOzSboBwmsUPavaC43gXkbfJ1wk2LoFrm5HAMj58ziuohXA@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol: validate some object contexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 25, 2023 at 4:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, May 12, 2023 at 5:32=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Ensure various object context entries have a name, since they are
> > duplicated via strdup(3), and the order for ports and memory regions is
> > valid.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these five patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These five patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 301aa200..e0d290ff 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1149,6 +1149,8 @@ static int validate_ocontexts(sepol_handle_t *han=
dle, const policydb_t *p, valid
> >                                 case OCON_NETIF:
> >                                         if (validate_context(&octx->con=
text[1], flavors, p->mls))
> >                                                 goto bad;
> > +                                       if (!octx->u.name)
> > +                                               goto bad;
> >                                         break;
> >                                 case OCON_PORT:
> >                                         if (octx->u.port.low_port > oct=
x->u.port.high_port)
> > @@ -1163,6 +1165,34 @@ static int validate_ocontexts(sepol_handle_t *ha=
ndle, const policydb_t *p, valid
> >                                         default:
> >                                                 goto bad;
> >                                         }
> > +                                       if (!octx->u.name)
> > +                                               goto bad;
> > +                                       break;
> > +                               case OCON_IBPKEY:
> > +                                       if (octx->u.ibpkey.low_pkey > o=
ctx->u.ibpkey.high_pkey)
> > +                                               goto bad;
> > +                                       break;
> > +                               case OCON_IBENDPORT:
> > +                                       if (!octx->u.ibendport.dev_name=
)
> > +                                               goto bad;
> > +                                       break;
> > +                               }
> > +                       } else if (p->target_platform =3D=3D SEPOL_TARG=
ET_XEN) {
> > +                               switch(i) {
> > +                               case OCON_XEN_IOPORT:
> > +                                       if (octx->u.ioport.low_ioport >=
 octx->u.ioport.high_ioport)
> > +                                               goto bad;
> > +                                       break;
> > +                               case OCON_XEN_IOMEM:
> > +                                       if (octx->u.iomem.low_iomem > o=
ctx->u.iomem.high_iomem)
> > +                                               goto bad;
> > +                                       if (p->policyvers < POLICYDB_VE=
RSION_XEN_DEVICETREE && octx->u.iomem.high_iomem > 0xFFFFFFFFULL)
> > +                                               goto bad;
> > +                                       break;
> > +                               case OCON_XEN_DEVICETREE:
> > +                                       if (!octx->u.name)
> > +                                               goto bad;
> > +                                       break;
> >                                 }
> >                         }
> >                 }
> > --
> > 2.40.1
> >
