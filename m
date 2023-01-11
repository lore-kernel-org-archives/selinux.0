Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E1DC46467
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAKPxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjAKPwr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:52:47 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B60C22
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:52:43 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy8so37807238ejc.13
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOOzlbm1Lq4acxSPZEJ3BrAOTxui4ZT95dHdAOyweCw=;
        b=jEcpYWF/Kp7BqO9h4D8478l7sy5Zs1L1sr87v7LePwd1sJxjoYgVBFxvRlrteG2iC/
         DPR9t2YVMRVqe/YToo4cwysJ6Nw8Fa7+RJdcC/ITngwzI6Ss4FgpmxyRHQcBJjTd/FYi
         jdHXiqTvNZmpaBdCTzRKUO252bKiNHwulZuuASiOrImfoTvWoEpqB2WqbqCLTNEmKpO/
         NxZje9nfqGfZ3Cr+7vDRSMdGRtCBaDWaTC9EPLCnbx+3VWvCTRDjSqiNoGK2t2OjXkyd
         zFmFfL+LjfuNjQ/nOL+ZHzt7J2iVCf9hq6m428J9Ug3i8R6EA44XfBk9hE9g8K+RsbIR
         54Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOOzlbm1Lq4acxSPZEJ3BrAOTxui4ZT95dHdAOyweCw=;
        b=YDccSq9/BTl3GV72uDXK67yd2gKRtuFp2XietEkb/Oy6a/uUimp9rQYxG+7N8UAcZt
         xJva0F/GtcTbEsM63DFuNHXAFy3HLXOj4zyn40M3Xib64ENTYGgqhC50WeslN4+NjtDh
         1hAO2V3r/mwHrwzjocILX4aWApHvJyhpg3JsimvnlrkN1d0hWqFuM2W/knYf/5jQ/rad
         sKQP7BCOl2znQzdwGy0q3T53Ea3APOSXG1VDzTF6zN/qzrhd7oI9zVehyuwR6ljm8WZW
         ZnVkdRwlUom+kx0Wb7LRkMUWTxJwqg0NIu8A/C243sch7uIrTCMG1zO8+qc8qfUl1AwW
         Fc0A==
X-Gm-Message-State: AFqh2kozH0qQKPMmMhMK3EkBsxuMJYsU2/RMiFh0BP/D6vc3ufmFB33O
        xlMWbzY1iUyHZTl7mooQwIN3P8sm+i7yOQU83fs=
X-Google-Smtp-Source: AMrXdXvc4LhX2xBGe/LnlZpialuAlgprRVkKgqTBePlZoVHii5KTC6v+ALvheJeBBPtZmgeAq/igIwlMTDCnoJt47Yo=
X-Received: by 2002:a17:906:9c91:b0:84c:a863:ebf3 with SMTP id
 fj17-20020a1709069c9100b0084ca863ebf3mr5698846ejc.100.1673452362008; Wed, 11
 Jan 2023 07:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20221220154134.25652-1-cgzones@googlemail.com> <CAP+JOzSVkSkuoOkCYmzqY9Gamg-t28D7pZRSK3QSV3AD_Ger3w@mail.gmail.com>
In-Reply-To: <CAP+JOzSVkSkuoOkCYmzqY9Gamg-t28D7pZRSK3QSV3AD_Ger3w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:52:31 -0500
Message-ID: <CAP+JOzSX0ALVWFTwVAnPj9Rj1sRdtsvAasWoB_TQmJgEM4hHvw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject attributes in type av rules for kernel policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 4, 2023 at 12:57 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Dec 20, 2022 at 10:44 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The kernel does not support type attributes as source or target in type
> > av rules (type_transition, type_member, type_change)[1].  Such rules
> > should have been expanded[2].
> >
> > [1]: https://github.com/SELinuxProject/selinux-kernel/blob/abe3c631447d=
cd1ba7af972fe6f054bee6f136fa/security/selinux/ss/services.c#L1843
> > [2]: https://github.com/SELinuxProject/selinux/blob/0a8c177dacdc1df96ea=
11bb8aa75e16c4fa82285/libsepol/src/expand.c#L1981
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  libsepol/src/policydb_validate.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 521ea4ff..469c14f4 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -770,12 +770,20 @@ bad:
> >   * Functions to validate a kernel policydb
> >   */
> >
> > -static int validate_avtab_key(const avtab_key_t *key, int conditional,=
 validate_t flavors[])
> > +static int validate_avtab_key(const avtab_key_t *key, int conditional,=
 const policydb_t *p, validate_t flavors[])
> >  {
> > -       if (validate_value(key->source_type, &flavors[SYM_TYPES]))
> > -               goto bad;
> > -       if (validate_value(key->target_type, &flavors[SYM_TYPES]))
> > -               goto bad;
> > +       if (p->policy_type =3D=3D POLICY_KERN && key->specified & AVTAB=
_TYPE) {
> > +               if (validate_simpletype(key->source_type, p, flavors))
> > +                       goto bad;
> > +               if (validate_simpletype(key->target_type, p, flavors))
> > +                       goto bad;
> > +       } else {
> > +               if (validate_value(key->source_type, &flavors[SYM_TYPES=
]))
> > +                       goto bad;
> > +               if (validate_value(key->target_type, &flavors[SYM_TYPES=
]))
> > +                       goto bad;
> > +       }
> > +
> >         if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
> >                 goto bad;
> >         switch (0xFFF & key->specified) {
> > @@ -821,7 +829,7 @@ static int validate_avtab_key_and_datum(avtab_key_t=
 *k, avtab_datum_t *d, void *
> >  {
> >         map_arg_t *margs =3D args;
> >
> > -       if (validate_avtab_key(k, 0, margs->flavors))
> > +       if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
> >                 return -1;
> >
> >         if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data,=
 margs->policy, margs->flavors))
> > @@ -845,13 +853,13 @@ static int validate_avtab(sepol_handle_t *handle,=
 const avtab_t *avtab, const po
> >         return 0;
> >  }
> >
> > -static int validate_cond_av_list(sepol_handle_t *handle, const cond_av=
_list_t *cond_av, validate_t flavors[])
> > +static int validate_cond_av_list(sepol_handle_t *handle, const cond_av=
_list_t *cond_av, const policydb_t *p, validate_t flavors[])
> >  {
> >         const struct avtab_node *avtab_ptr;
> >
> >         for (; cond_av; cond_av =3D cond_av->next) {
> >                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> > -                       if (validate_avtab_key(&avtab_ptr->key, 1, flav=
ors)) {
> > +                       if (validate_avtab_key(&avtab_ptr->key, 1, p, f=
lavors)) {
> >                                 ERR(handle, "Invalid cond av list");
> >                                 return -1;
> >                         }
> > @@ -996,9 +1004,9 @@ static int validate_cond_list(sepol_handle_t *hand=
le, const cond_list_t *cond, c
> >         for (; cond; cond =3D cond->next) {
> >                 if (validate_cond_expr(handle, cond->expr, &flavors[SYM=
_BOOLS]))
> >                         goto bad;
> > -               if (validate_cond_av_list(handle, cond->true_list, flav=
ors))
> > +               if (validate_cond_av_list(handle, cond->true_list, p, f=
lavors))
> >                         goto bad;
> > -               if (validate_cond_av_list(handle, cond->false_list, fla=
vors))
> > +               if (validate_cond_av_list(handle, cond->false_list, p, =
flavors))
> >                         goto bad;
> >                 if (validate_avrules(handle, cond->avtrue_list, 1, p, f=
lavors))
> >                         goto bad;
> > --
> > 2.39.0
> >
