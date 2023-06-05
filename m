Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E88C7EE24
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 20:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjFEULR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFEULQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 16:11:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9C98
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 13:11:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f620583bc2so2789176e87.1
        for <selinux@vger.kernel.org>; Mon, 05 Jun 2023 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995873; x=1688587873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp1YkwgevkDLN8OmQYgKzVwJ2vkG4xGkmXWPMSgdgJA=;
        b=oOBhlTnZdnkikqwT9XTn4SISkFEY2XELO2EMuAZSscB3zXCgb2TSdL2E8cxcxF1w3R
         riTvJa7gltSEWD1SzkjbB0eLsbxoqruBFwz5QVnR69xnGqYQDU2WIC4zfWvmP8Rh5ngK
         5xDm8fyfg+cAjmW3b2CaMCSDYtdkrIC3gHJL9hFZxNEEiutKfVB8VihN76oGfnDRQyzS
         nXdDiGawA+5UQTfztek/3DbVpwTDLaB/AByoITCywajkbdYxQw3G/X6DMVTxmE0aGQy9
         BWj9oYKabbQAeuDit2LSug/lS9E+z0SUKaho+866EgvmGJBKx7CDo5cXPa2Off/zKQtw
         Uc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995873; x=1688587873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp1YkwgevkDLN8OmQYgKzVwJ2vkG4xGkmXWPMSgdgJA=;
        b=OnnUNRpwwVMODwGAJGtwj8OxgtHOrGoZR9zMZBECRmQ0CgfUl/ytquaHLshICkPHar
         KY0B80CIGavqHLc16m9Kmx0Z5yT8k7F7xOPvPDKq1jyBjbTH95K8nj+JvqcCnDIKsXeQ
         0llhQP4vusieKIoYACxh2XIF5ofLa/KeoQW9S4iajMN30dPey3xh35oapb3gZhf3eAPu
         OrExIDE8hbbiuoC3J286tl7Osr5XAEETMO/ol0pg6VM8/HONtDMJX+YBOd3+CdKWnsE4
         LCZV1Z0JIgvAg4ma/BhX0wAKOJG5CZzreErxmn5M5h/p6LVio4msm8cySj1c7SAQgq8g
         wknA==
X-Gm-Message-State: AC+VfDwTjtWHU6mPD3HsBo9aWo09Lavdh7bYqotOZsNJzLxuAq7cViO/
        iCvoNWdLzh1TlOTLFRAffgzHC5xsIKJse2Xd/cc=
X-Google-Smtp-Source: ACHHUZ6VGZfm9hzrfYC3RsdaaPyjIRGMVOEgKhpvLOJB2IBORNdkzaCkEWFrcBwp6sw6dojY3DXqRueER1XmkUqtbqo=
X-Received: by 2002:a05:651c:10d:b0:2b1:e369:40 with SMTP id
 a13-20020a05651c010d00b002b1e3690040mr168954ljb.27.1685995873245; Mon, 05 Jun
 2023 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230602130608.24586-1-cgzones@googlemail.com> <CAP+JOzS1suo3BcDq4rZUqpSxRaEmJcH5+xM7buuwJ42d+0dVqw@mail.gmail.com>
In-Reply-To: <CAP+JOzS1suo3BcDq4rZUqpSxRaEmJcH5+xM7buuwJ42d+0dVqw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 5 Jun 2023 16:11:02 -0400
Message-ID: <CAP+JOzRY8s8vwLdOHCnhc_YjFYSDqotdiC9TNJHp-cEpKX2kfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol: drop message for uncommon error cases
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 2, 2023 at 4:24=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Jun 2, 2023 at 9:07=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Match surrounding code and the message were quite generic too.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For all four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These four patches have been merged.
Thanks,
Jim

> > ---
> > v2:
> >   added signed-off
> > ---
> >  libsepol/src/kernel_to_conf.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index c48a7114..cb7cb740 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -2886,7 +2886,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out=
, struct policydb *pdb)
> >         for (pirq =3D pdb->ocontexts[1]; pirq !=3D NULL; pirq =3D pirq-=
>next) {
> >                 rc =3D snprintf(pirq_str, 21, "%i", pirq->u.pirq);
> >                 if (rc < 0 || rc >=3D 21) {
> > -                       fprintf(stderr,"error1\n");
> >                         rc =3D -1;
> >                         goto exit;
> >                 }
> > @@ -2894,7 +2893,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out=
, struct policydb *pdb)
> >                 ctx =3D context_to_str(pdb, &pirq->context[0]);
> >                 if (!ctx) {
> >                         rc =3D -1;
> > -                       fprintf(stderr,"error2\n");
> >                         goto exit;
> >                 }
> >
> > --
> > 2.40.1
> >
