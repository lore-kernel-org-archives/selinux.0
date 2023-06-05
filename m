Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18FC7EE23
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFEUIR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFEUIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 16:08:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AC899
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 13:08:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b6865c7cso42061681fa.3
        for <selinux@vger.kernel.org>; Mon, 05 Jun 2023 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995694; x=1688587694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPOMwgp/0vQpjNxPeXq/iM+aiKypVXcZDjnZ8fn+4Ug=;
        b=eNUbQkWFhtCKpg/iWifoBo2YFSB3oAbBM9VafacnfX+iTOWv1kOeeWvOAuZXf+7Oxw
         X6KP3vQ6QdpmEsFPLRDfNKNDnGTJeRHiBd8qkxlb3gFEHQTvvDUl6PUGYE2+kmginsWc
         e2zW6+/s2wd3cbrBk3QsjJsAJmQEaxhLJR40SopJqwZ0hXEr6bB74f/r9GnIeGTpUd/Q
         Okv0QzrGT6cW5eURk1uRYoAau3d3nbO2E1DbIjwznJf3lp6Mc9C2mptwYgQSZ27a6//c
         pp5dvELqeT7acy+HYuL5oY3lTHUajzJ0UFFQjQRJwKf4e3TxMSmolNDikqAHj92V8Alm
         3Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995694; x=1688587694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPOMwgp/0vQpjNxPeXq/iM+aiKypVXcZDjnZ8fn+4Ug=;
        b=Z8K4J2iNVNsVvKdQfSArkKxww3GXlUEOKWbNo7yAGiOa3ATQDZesurGd6CTlf8qDhC
         Dz2FIAHPTe3gqXfQLHPdf31E2B3rFsMPSM56coUzb/iwDrX8/M9AmGnxeH2bz1hLL7Nt
         kguwHYJ6UnIKIt3QKJe1ZPkFoqC3fyHkTj4+BzByWK5rqpx04bAIOyjf8F1C0jkI1DpE
         oCWtWlm3Ktacc+sYtur+KBMkrJM2DE/DXHX9Vr+gHdLS5qY/DtTrA4TGy0N9dbdB331N
         jebMidUGADTmAT/13a6yPs+lxUMAgSTNkB7orjaQaJ5a9v2BOK9t5urOvWcZnNkFXNUQ
         z91w==
X-Gm-Message-State: AC+VfDxLLLGflM8KRUfQDvlBOK5XjzC7dDzaLBSxONlNFpi8mBd55Ulu
        3QScjT5IMhahOxFLuFXSi67LIrBdd6GEEz16gOg+buui
X-Google-Smtp-Source: ACHHUZ78975G3w/qwXyQbp6XeRhdNQwjekJui5w1ySCVFRzRWwEsEtA6xM/CdCry0rmkVgRbiqDePOg0zwDxS7qJ5Ss=
X-Received: by 2002:a2e:7302:0:b0:298:ad8e:e65 with SMTP id
 o2-20020a2e7302000000b00298ad8e0e65mr185072ljc.21.1685995693550; Mon, 05 Jun
 2023 13:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230512092311.42583-1-cgzones@googlemail.com> <CAP+JOzSwY830VyjN6o4-NuFwuBpq_LWO4LCTY5utEhgiztFRPQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSwY830VyjN6o4-NuFwuBpq_LWO4LCTY5utEhgiztFRPQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 5 Jun 2023 16:08:02 -0400
Message-ID: <CAP+JOzRxaBCSHxaW6UF-JQAscfmw-0=0KxKxfDvYJSgMtuVcqA@mail.gmail.com>
Subject: Re: [PATCH 1/4] checkpolicy: drop unused token CLONE
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 25, 2023 at 2:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, May 12, 2023 at 5:24=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The token CLONE is never used in the grammar; drop it.
> >
> > As side effect `clone` and `CLONE` become available as identifier names=
.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These four patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_parse.y | 1 -
> >  checkpolicy/policy_scan.l  | 2 --
> >  2 files changed, 3 deletions(-)
> >
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 45f973ff..da32a776 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -85,7 +85,6 @@ typedef int (* require_func_t)(int pass);
> >  %token PATH
> >  %token QPATH
> >  %token FILENAME
> > -%token CLONE
> >  %token COMMON
> >  %token CLASS
> >  %token CONSTRAIN
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 9fefea7b..2c025b61 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -77,8 +77,6 @@ hexval        [0-9A-Fa-f]
> >                                       source_lineno++;
> >                                   yyless(1);
> >                                 }
> > -CLONE |
> > -clone                          { return(CLONE); }
> >  COMMON |
> >  common                         { return(COMMON); }
> >  CLASS |
> > --
> > 2.40.1
> >
