Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528EC43461
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976FB20C09
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ/8Thw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIU1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIIU1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:27:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C0C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 13:27:11 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y6so3696358oie.5
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TufWtqTTEQmAWuk9bODy/DZJx+obxUgO9E7fvG4N7Yw=;
        b=NZ/8Thw9lcwQhMlnhDsNQlr+Vx3mk4hcJfyv8reldGqBJgHLu/RuEf0rWqVpivzqcw
         GY0Uojp7HOJJdxx1pxl0Nrsr/nQyOEGGrUFC6J8c6ujLLWbKFk4pCpfuuET6MCdzQFjj
         jrHCz9sg5BqB3ZJbb4mOa2jMZiZdqM9r12sYvbheKlld/AhDpvkrSZSP7+QIptJUUaD9
         D9L7aWQDwuT1u7aMvQzl5m9lzB/zKnMjtTDKQKUKtwjNeQE2oHqGXXsspTyi63WCm4UL
         xj8ePBl66v9xtID1qkkFTR3V0CRHw4h4iA+D5VDQRwyHSdjXGATx4RuqRpkUZ0ejj+ZZ
         QLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TufWtqTTEQmAWuk9bODy/DZJx+obxUgO9E7fvG4N7Yw=;
        b=ZQg3ygKPcwvhj+KouGrnLsueUNN2DiSoYZlwi2xK8tnZZSwoiqb8tbho4MGUds4rdy
         RkSa6jDmowmxtdVoUj3VwUoFZZLKkSgrVwoD/DdilcDsUIConCu7fnk3Sdo55fcghRir
         MR3XHuZcwTwEVGyV+2P6kX6HL6mafV9kRpt+Ndt0rohDO0EpedVkwwzrcNvDNBSaYi63
         qL/siRXs31CsM6KlO20NOTnPD2TKMjRBiX/58nB7RzvxUzlgUkPaBlENhaKRLz3nx5DA
         UQPUi/SmWXK/uS0AmkPhQ0npH5H3vp3PdBZ+dmMfq82WAcBSBvMWwEubF5WtTJ5ihmyd
         kEfQ==
X-Gm-Message-State: AOAM531pGbv9hnEPR4qBXBdvPfvbOrKvEtPuZfD75NLk1nbLiUM45wFa
        Zunm56GpYm+mrte/LV8UeHEvgaXaBAB9GWJhm3w=
X-Google-Smtp-Source: ABdhPJztvlSmijArzqa6iB1eg12hC38xTqLDX6k8UzWoLjvyoWwfynZP8qVLLw90cDoweaJudxRCjpp3Now8AGOY8ak=
X-Received: by 2002:aca:53c2:: with SMTP id h185mr1786816oib.128.1599683230308;
 Wed, 09 Sep 2020 13:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200909194222.263841-1-jwcart2@gmail.com> <CAEjxPJ4Ss39iMLX93N_uMaAze0yw2t1+SdB0cdWCNGQj4z=JZQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Ss39iMLX93N_uMaAze0yw2t1+SdB0cdWCNGQj4z=JZQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Sep 2020 16:26:59 -0400
Message-ID: <CAP+JOzSX=Yik59-CDT-t_52QhCgmu8QMZ0w=_43NPU=ZpQ3Sfg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Validate conditional expressions before
 adding to binary policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 4:09 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 3:43 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of conditional expressions
> > which prevented it from giving an error when the max depth was exceeded=
.
> > This allowed invalid policy binaries to be created.
> >
> > Validate the conditional expression using the same logic that is used
> > when evaluating a conditional expression. This includes checking the
> > depth of the expression.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_binary.c    | 43 ++++++++++++++++++++++++++++++++
> >  libsepol/cil/src/cil_build_ast.c | 26 ++++++-------------
> >  2 files changed, 50 insertions(+), 19 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 77266858..d30233c4 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -2176,6 +2176,44 @@ static int __cil_cond_expr_to_sepol_expr(policyd=
b_t *pdb, struct cil_list *cil_e
> >         return SEPOL_OK;
> >  }
> >
> > +int __cil_validate_cond_expr(cond_expr_t *cond_expr)
> > +{
> > +       cond_expr_t *e;
> > +       int depth =3D -1;
> > +
> > +       for (e =3D cond_expr; e !=3D NULL; e =3D e->next) {
> > +               switch (e->expr_type) {
> > +               case COND_BOOL:
> > +                       if (depth =3D=3D (COND_EXPR_MAXDEPTH - 1)) {
> > +                               cil_log(CIL_ERR,"Conditional expression=
 exceeded max allowable depth\n");
> > +                               return -1;
> > +                       }
> > +                       depth++;
> > +                       break;
> > +               case COND_NOT:
> > +                       if (depth < 0) {
> > +                               cil_log(CIL_ERR,"Invalid conditional ex=
pression\n");
> > +                               return -1;
> > +                       }
> > +                       break;
> > +               case COND_OR:
> > +               case COND_AND:
> > +               case COND_XOR:
> > +               case COND_EQ:
> > +               case COND_NEQ:
> > +                       if (depth < 1) {
> > +                               cil_log(CIL_ERR,"Invalid conditional ex=
pression\n");
> > +                               return -1;
> > +                       }
> > +                       depth--;
> > +                       break;
> > +               default:
> > +                       cil_log(CIL_ERR,"Invalid conditional expression=
\n");
> > +                       return -1;
> > +               }
> > +       }
>
> Missing a return here.
> ../cil/src/cil_binary.c: In function =E2=80=98__cil_validate_cond_expr=E2=
=80=99:
> ../cil/src/cil_binary.c:2215:1: error: control reaches end of non-void
> function [-Werror=3Dreturn-type]
>  2215 | }
>       | ^

Thanks, V2 coming up.
Jim
