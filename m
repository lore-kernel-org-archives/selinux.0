Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E8C433F5
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384667AbhLDKs5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384656AbhLDKsy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:48:54 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3CC061359
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:45:29 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u74so11067251oie.8
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ApkfZdL3GoC3mNyPXIzYg8zqibwZNEyAYzlsRz50V0Y=;
        b=Ev4SQbvwar84MyMg+JXPMCUky3lTMavMv+Mz0x7Fyj6xzv/q4q7KNTOXPznQnAJRqA
         ALt3pQEVA0xx6f6eYR9JQ/dN/ZPiWRmfOiywtvX73kHOum1HjBBqWdzabUy20laB/vJM
         7rlh+undlhSpH1FBkHAq7tIbm3Fm0WxGCfAGOnDXffF+b2kgbyPMcNVZ+KPFHQUPUhjy
         yfAfxc6Am+x69fIOwJ+OEciNEwAdGytYWEEEC7M4uJd2qHeWh8byYrdf2llCJlk1qTEL
         HhP57Yjq268ScR+5N4FnYq78cDAq5OsNOXKCKtc6b1rclUIRfjzLwQ1RTwA36vvLdhvG
         Il/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ApkfZdL3GoC3mNyPXIzYg8zqibwZNEyAYzlsRz50V0Y=;
        b=rEN9gaQPRYh2kydhUVmvce0/KRHMhoz9f+tGxhd8ZVtZYRI6rlclc6RppXfDDDkWZi
         qi8IE3W2T0LqcKWGAtaTjT2zBkbAmNa/5c5Kak8giwWSEjeg/1d4iffbbHLOXvzHxChW
         VKutUiQu1EMSHPSfFWixskHqbQ9fZGxXBK4wQZBSTkHpTqbOy+rMtXXM8ii57O8Shviw
         gPHC+PRHlNvSvvG+N87EGZuKYbgdYX8ziXq4isGUDdcE51Z3qxkpXodLQMiNxIxBmim6
         waVwr54rfyKcmdyVPad3RoSkDWBCcvua19LvsvkCTPsTtxe3We5LaioA0h3fzQvJhXug
         0hSQ==
X-Gm-Message-State: AOAM5311qkpnJVsY/Q0qPiRFVVYUeRusP+i9CFFkbkjW4ihRwe4D0Q7v
        qPg+iEUqR2wP7xIq0ThRBCzLzIuPZUWSTshAyg1Zzg0m
X-Google-Smtp-Source: ABdhPJzktV5fFDM2CksukEBV7QCTXU2NQG2iieNu5Q0+uviPLfWj+XVI9LJjOma/k8WObXi8mHWpxg2V8Iy17Rw06Rs=
X-Received: by 2002:a05:6808:1a02:: with SMTP id bk2mr14271854oib.52.1638614728577;
 Sat, 04 Dec 2021 02:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com> <20211124190815.12757-3-cgzones@googlemail.com>
 <CAP+JOzQ3hJGGDJOjL1i-YifaUhoQ3h+UPD3pO30MizaQ5GuXSQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ3hJGGDJOjL1i-YifaUhoQ3h+UPD3pO30MizaQ5GuXSQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 4 Dec 2021 11:45:17 +0100
Message-ID: <CAJ2a_DfrgUz-W_gHeZ8+p+jWSDBhODPR9uZet+sgtYy-3Nivrg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] checkpolicy: add not-self neverallow support
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 3 Dec 2021 at 22:56, James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 3:03 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add support for using negated or complemented self in the target type o=
f
> > neverallow rules.
> >
> > Some refpolicy examples:
> >
> >     neverallow * ~self:{ capability cap_userns capability2 cap2_userns =
} *;
> >     # no violations
> >
> >     neverallow domain domain:file ~{ append read_file_perms write };
> >
> >     libsepol.report_failure: neverallow on line 565 of policy/modules/k=
ernel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink l=
ink rename };
> >     libsepol.report_failure: neverallow on line 565 of policy/modules/k=
ernel/kernel.te (or line 30300 of policy.conf) violated by allow chromium_t=
 chromium_t:file { create };
> >     libsepol.report_failure: neverallow on line 564 of policy/modules/k=
ernel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:dir { create };
> >
> >     neverallow domain { domain -self }:file ~{ append read_file_perms w=
rite };
> >
> >     libsepol.report_failure: neverallow on line 565 of policy/modules/k=
ernel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink l=
ink rename };
> >     libsepol.report_failure: neverallow on line 564 of policy/modules/k=
ernel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t h=
ttpd_bugzilla_script_t:dir { create };
> >
> > Using negated self in a complement `~{ domain -self }` is not supported=
.
> >
>
> I am thinking about what to do with this patch set. If this is
> valuable in checkpolicy, then I would like it in CIL as well. But CIL
> obviously cannot support the above syntax.
>
> What would be lost if we used "notself"?
>
> We could define the behavior of "neverallow SRC notself . . ." so that
> if SRC was a type, the rule would be expanded so that the target types
> would be all types except SRC, and if SRC was an attribute the rules
> would be expanded into multiple rules with all combinations of the
> types in SRC used for the source and target except for the cases where
> the source and target type would be the same.
> That would make your examples work.
> "neverallow * notself . . ." would expand like "neverallow * ~self . . ."
> "neverallow domain notself . . ." would expand like "neverallow domain
> { domain -self } . . ."
> "neverallow domain notself . . ." and "neverallow domain ~domain . .
> ." together would expand like "neverallow domain ~self . . ." (I
> think)
>
> What would be missing would be the ability to express "neverallow
> domain { subdomain -self } . . ."
>

I would suggest to introduce `all` as a new keyword for neverallow
rules. Yes, this would break backwards compatibility, but in the long
run it makes a saner language and with appropriate communication and
good CIL error messages the transition should be manageable. Then one
could write something like:

neverallow * ~self:process fork;
(neverallow all (not self) (process (fork)))

neverallow domain { domain -self -foo_t }:dir create;
(neverallow domain (and domain (not (and self foo_t))) (dir (create)))


> A few minor comments below.
>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >    - fix neverallowxperm usage
> > ---
> >  checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
> >  checkpolicy/test/dismod.c   |  6 ++++-
> >  2 files changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index d3eb6111..f27a6f33 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2067,12 +2067,17 @@ static int define_te_avtab_xperms_helper(int wh=
ich, avrule_t ** rule)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (strcmp(id, "self") =3D=3D 0) {
> >                         free(id);
> > -                       if (add =3D=3D 0) {
> > -                               yyerror("-self is not supported");
> > +                       if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NE=
VERALLOW) {
> > +                               yyerror("-self is only supported in nev=
erallowxperm rules");
>
> "-self is only supported in neverallow and neverallowxperm rules"
>
> > +                               ret =3D -1;
> > +                               goto out;
> > +                       }
> > +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTS=
ELF);
> > +                       if ((avrule->flags & RULE_SELF) && (avrule->fla=
gs & RULE_NOTSELF)) {
> > +                               yyerror("self and -self is not supporte=
d");
> >                                 ret =3D -1;
> >                                 goto out;
> >                         }
> > -                       avrule->flags |=3D RULE_SELF;
> >                         continue;
> >                 }
> >                 if (set_types
> > @@ -2083,6 +2088,18 @@ static int define_te_avtab_xperms_helper(int whi=
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
> > @@ -2528,12 +2545,17 @@ static int define_te_avtab_helper(int which, av=
rule_t ** rule)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (strcmp(id, "self") =3D=3D 0) {
> >                         free(id);
> > -                       if (add =3D=3D 0) {
> > -                               yyerror("-self is not supported");
> > +                       if (add =3D=3D 0 && which !=3D AVRULE_NEVERALLO=
W) {
> > +                               yyerror("-self is only supported in nev=
erallow rules");
>
> "-self is only supported in neverallow and neverallowxperm rules"
>
> Thanks,
> Jim
>
>
> > +                               ret =3D -1;
> > +                               goto out;
> > +                       }
> > +                       avrule->flags |=3D (add ? RULE_SELF : RULE_NOTS=
ELF);
> > +                       if ((avrule->flags & RULE_SELF) && (avrule->fla=
gs & RULE_NOTSELF)) {
> > +                               yyerror("self and -self is not supporte=
d");
> >                                 ret =3D -1;
> >                                 goto out;
> >                         }
> > -                       avrule->flags |=3D RULE_SELF;
> >                         continue;
> >                 }
> >                 if (set_types
> > @@ -2544,6 +2566,18 @@ static int define_te_avtab_helper(int which, avr=
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
> > 2.34.0
> >
