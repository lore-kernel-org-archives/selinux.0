Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F0C6FD1D
	for <selinux@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC3Tmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjC3Tmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Mar 2023 15:42:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E4D512
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:42:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so80928276edd.5
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680205353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfGaDbzank0wVCpoV5Ac2vHNLimg/n1UE+xRDuWVffA=;
        b=J9X2P33hyeFT2xhwSVYMmNVgDaeSdseTFR1yUVFKe6KejZCLCKAA/W3HEdEkKBpi91
         puGm/ptCPJyfwDW2WuEG+kTdjhHqu1yrgmE9Beus/TgSSO7kpzzBGkTs91Gi9n+aa447
         S7YKz4/4XEQds/0YDtQqzOeKx3hsdblr5azua099br/UMrr38MwMxt+y0S8FM5kycB3N
         31LQds+WqBiK1M2bJBAWv1VsPEeOdCsIDRhOHHiDXtP6ZrHxODZB1iZL+GMWWBIvlQhv
         /oIhNtYLZt5AdhcuiFJuPNHqbdSV/wxZwtBHU91BU5lSx3Ef+3/qKuezX7gy0fPaK9f4
         1OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfGaDbzank0wVCpoV5Ac2vHNLimg/n1UE+xRDuWVffA=;
        b=3dpTV34aBlsPjvvUB37yXd7H1+tNuP0iyqILo9tbWEh8YWr32XWT5aOCnKF25ASllf
         pUjpQDqPTfn+9FYjYVp87xWy1Axh5aIKscNxRgoe0AKfVUkR4Ne7EBHegEr4gyCBgP5s
         MCy1OFZGcfMkZBxt7EveLLYBfrtun0xhHyBN/YAUCcoHEJqOFk/oMI9Uqyj6Jit8MAvq
         +FonY2iy9TqjyCo6V4cDdKT3bmMUQHZTQlAYssbyOai4U2eFRvts5ZXAotuU7UlOXegY
         kt82bgjeYPvUHEJIIHeYBCHG5UUGZ2GkpNcGqyFITt9XxEmN2K0LosuWZVk9Sf4Fr9Z2
         OkzA==
X-Gm-Message-State: AAQBX9c09VAuCQ8iTUrmTfyiuil71gTHx1cMVTqr3WXVXnZGOBr/Z6HK
        r72lWVJZatsC7emubAdFWnKBnT8YAS5u0+KCmvQ=
X-Google-Smtp-Source: AKy350bEeDzWUw+OTtkf+Ln59hRB1vjbwoBI+9W/OpLZLzsKjhbQn3SmMacoMZlj12lfIWVVkQNk+4g9JEH02dTNCpA=
X-Received: by 2002:a17:907:8688:b0:931:c1a:b526 with SMTP id
 qa8-20020a170907868800b009310c1ab526mr12515385ejc.5.1680205352945; Thu, 30
 Mar 2023 12:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com>
 <20221125154952.20910-4-cgzones@googlemail.com> <CAP+JOzReU_OK=DjJo_-09WK1i6Cgo7uajDQuPXnWoD+LG6FAyA@mail.gmail.com>
In-Reply-To: <CAP+JOzReU_OK=DjJo_-09WK1i6Cgo7uajDQuPXnWoD+LG6FAyA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Mar 2023 15:42:22 -0400
Message-ID: <CAP+JOzTGU202MGyn68knXvdTDd9HfmgpSrk_sO16G0o8q_4XaA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/6] checkpolicy: add not-self neverallow support
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 9:32=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add support for using negated or complemented self in the target type o=
f
> > neverallow rules.
> >
> > Some Refpolicy examples:
> >
> >     neverallow * ~self:{ capability cap_userns capability2 cap2_userns =
} *;
> >     neverallow domain { domain -self -dockerc_t }:dir create;
> >     # no violations
> >
> >     neverallow domain { domain -dockerc_t }:file ~{ append read_file_pe=
rms write };
> >
> >     libsepol.report_failure: neverallow on line 584 of policy/modules/k=
ernel/kernel.te (or line 31357 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink l=
ink rename };
> >     libsepol.report_failure: neverallow on line 584 of policy/modules/k=
ernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_t spc_=
t:file { create };
> >     libsepol.report_failure: neverallow on line 584 of policy/modules/k=
ernel/kernel.te (or line 31357 of policy.conf) violated by allow container_=
t container_t:file { create };
> >     libsepol.report_failure: neverallow on line 584 of policy/modules/k=
ernel/kernel.te (or line 31357 of policy.conf) violated by allow chromium_t=
 chromium_t:file { create };
> >     libsepol.report_failure: neverallow on line 584 of policy/modules/k=
ernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_user_t=
 spc_user_t:file { create };
> >     libsepol.report_failure: neverallow on line 582 of policy/modules/k=
ernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:dir { create };
> >
> >     neverallow domain { domain -self -dockerc_t }:file ~{ append read_f=
ile_perms write };
> >
> >     libsepol.report_failure: neverallow on line 583 of policy/modules/k=
ernel/kernel.te (or line 31356 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink l=
ink rename };
> >     libsepol.report_failure: neverallow on line 582 of policy/modules/k=
ernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:dir { create };
> >
> > Using negated self in a complement, `~{ domain -self }`, is not
> > supported.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
> >  checkpolicy/test/dismod.c   |  6 ++++-
> >  2 files changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 41e44631..74f882bb 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2075,12 +2075,17 @@ static int define_te_avtab_xperms_helper(int wh=
ich, avrule_t ** rule)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (strcmp(id, "self") =3D=3D 0) {
> >                         free(id);
> > -                       if (add =3D=3D 0) {
> > -                               yyerror("-self is not supported");
> > +                       if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NE=
VERALLOW) {
> > +                               yyerror("-self is only supported in nev=
erallow and neverallowxperm rules");
> > +                               ret =3D -1;
> > +                               goto out;
> > +                       }
> > +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTS=
ELF);
> > +                       if ((avrule->flags & RULE_SELF) && (avrule->fla=
gs & RULE_NOTSELF)) {
> > +                               yyerror("self and -self are mutual excl=
usive");
> >                                 ret =3D -1;
> >                                 goto out;
> >                         }
> > -                       avrule->flags |=3D RULE_SELF;
> >                         continue;
> >                 }
> >                 if (set_types
> > @@ -2091,6 +2096,18 @@ static int define_te_avtab_xperms_helper(int whi=
ch, avrule_t ** rule)
> >                 }
> >         }
> >
> > +       if ((avrule->ttypes.flags & TYPE_COMP)) {
> > +               if (avrule->flags & RULE_NOTSELF) {
> > +                       yyerror("-self is not supported in complements"=
);
> > +                       ret =3D -1;
> > +                       goto out;
> > +               }
> > +               if (avrule->flags & RULE_SELF) {
> > +                       avrule->flags &=3D ~RULE_SELF;
> > +                       avrule->flags |=3D RULE_NOTSELF;
> > +               }
> > +       }
> > +
> >         ebitmap_init(&tclasses);
> >         ret =3D read_classes(&tclasses);
> >         if (ret)
> > @@ -2537,12 +2554,17 @@ static int define_te_avtab_helper(int which, av=
rule_t ** rule)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (strcmp(id, "self") =3D=3D 0) {
> >                         free(id);
> > -                       if (add =3D=3D 0) {
> > -                               yyerror("-self is not supported");
> > +                       if (add =3D=3D 0 && which !=3D AVRULE_NEVERALLO=
W) {
> > +                               yyerror("-self is only supported in nev=
erallow and neverallowxperm rules");
> > +                               ret =3D -1;
> > +                               goto out;
> > +                       }
> > +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTS=
ELF);
> > +                       if ((avrule->flags & RULE_SELF) && (avrule->fla=
gs & RULE_NOTSELF)) {
> > +                               yyerror("self and -self are mutual excl=
usive");
> >                                 ret =3D -1;
> >                                 goto out;
> >                         }
> > -                       avrule->flags |=3D RULE_SELF;
> >                         continue;
> >                 }
> >                 if (set_types
> > @@ -2553,6 +2575,18 @@ static int define_te_avtab_helper(int which, avr=
ule_t ** rule)
> >                 }
> >         }
> >
> > +       if ((avrule->ttypes.flags & TYPE_COMP)) {
> > +               if (avrule->flags & RULE_NOTSELF) {
> > +                       yyerror("-self is not supported in complements"=
);
> > +                       ret =3D -1;
> > +                       goto out;
> > +               }
> > +               if (avrule->flags & RULE_SELF) {
> > +                       avrule->flags &=3D ~RULE_SELF;
> > +                       avrule->flags |=3D RULE_NOTSELF;
> > +               }
> > +       }
> > +
> >         ebitmap_init(&tclasses);
> >         ret =3D read_classes(&tclasses);
> >         if (ret)
> > diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> > index ec2a3e9a..a2d74d42 100644
> > --- a/checkpolicy/test/dismod.c
> > +++ b/checkpolicy/test/dismod.c
> > @@ -124,7 +124,7 @@ static int display_type_set(type_set_t * set, uint3=
2_t flags, policydb_t * polic
> >         }
> >
> >         num_types =3D 0;
> > -       if (flags & RULE_SELF) {
> > +       if (flags & (RULE_SELF | RULE_NOTSELF)) {
> >                 num_types++;
> >         }
> >
> > @@ -169,6 +169,10 @@ static int display_type_set(type_set_t * set, uint=
32_t flags, policydb_t * polic
> >                 fprintf(fp, " self");
> >         }
> >
> > +       if (flags & RULE_NOTSELF) {
> > +               fprintf(fp, " -self");
> > +       }
> > +
> >         if (num_types > 1)
> >                 fprintf(fp, " }");
> >
> > --
> > 2.38.1
> >
