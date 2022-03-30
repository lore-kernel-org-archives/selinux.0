Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846AC433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 19:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiC3TEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbiC3TEV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 15:04:21 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A184EED
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:02:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w127so22988278oig.10
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1sFyajWUAuCoYlSsPNxamOdX2MeqjUKJi/CpsHe6Z0=;
        b=io6rHed8FTVqPRswLe7qR7Umn9YdlL5MX5WBplzr/CQTEdz9eCjoa5pN/EILsyr2wI
         SYVVCE+XSwbxN7WoI/YBGrzMPGqpCU551pah4nRgBbsIXMernXSOJ9srvQVAG2LfTuq+
         9vhfLi3lkXVGQp3pkjnIp4bLckWskibDCXuU87K+hC7Odd+ypMiY39YEmyLkJAvfKrAx
         EH+NO2Xj2hNLfWMLoAmJ1HX38e4ED9RtkDwshwlLdrMcLxm0fEo1ev/UEcbEfyX/Oyl5
         V7XI3+EPg0VFKtP5zOWVdXz0BPa3yir3dcMWwXrgM/pkEAce33gyaBwZoIvwz2uEKivv
         dr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1sFyajWUAuCoYlSsPNxamOdX2MeqjUKJi/CpsHe6Z0=;
        b=pc7DRh9bNSk81DC5vXBEQeLX0vhXNCyuZz4JPq/nm2+3YyHwDePXsV7KRVYPoQu3qy
         UA7shV4a8Ck4ISBqY9q8y/XgYCHgd0wzQd/U2iSvJ3Xn98tCFWanLsh8u/rrO8flD9k5
         3X6giLfxmD3ysFdWesggiHrLl04kLv7e1GYUsOykHTaEF6qR0Zfd31mxHPaDhw1sWD7l
         Ms5//t98IWzXLEByjYVMs+I1l2SxHQkTpHHN2xUgHEkCGluEZXkRGB/o+soFNUliLXNk
         nb0JLsLGBywbKawkf/ATbFUcqx/KvOl3+CpqsJNgPcvOgOXdcWnkOz8anJlKbfCLdg8l
         3GRA==
X-Gm-Message-State: AOAM533NOytx4miyg85toFni3cdeCE4Oi6O8DOwzj5U9KEEqY8yaNEW3
        ev8v5hWjhtUuCLqc+wUc8DdaCzUXaUb8hRe6HlewLbIY
X-Google-Smtp-Source: ABdhPJzEnZxUOxAOhFV6jL5gZSJIRYzy1UMCUCtapfu+9PB5O+twCdCsl4lqbQdVWO1iwsFrHPsvliYyA9zNxg1IRKI=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr709034oiw.182.1648666954723; Wed, 30
 Mar 2022 12:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211212184944.8681-1-toiwoton@gmail.com> <CAP+JOzS7Ft0B2Ap5MQwtZcVBhAbeBbiDvdLnq+=ah+Z85zXKCQ@mail.gmail.com>
In-Reply-To: <CAP+JOzS7Ft0B2Ap5MQwtZcVBhAbeBbiDvdLnq+=ah+Z85zXKCQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 15:02:23 -0400
Message-ID: <CAP+JOzRRBZt0s+UiJZ+PTR5_vpD68kxXwBE5r8SWDEdg7qazhQ@mail.gmail.com>
Subject: Re: [PATCH v2] secilc: kernel policy language is infix
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 1:33 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Dec 12, 2021 at 4:22 PM Topi Miettinen <toiwoton@gmail.com> wrote=
:
> >
> > Prefix / Polish (CIL): and a b
> > Infix (KPL): a and b
> > Postfix / Reverse Polish: a b and
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Sorry, this dropped off my radar.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

And merged.
Thanks,
Jim

> > ---
> > v2: improved commit message
> >
> > v1: https://lore.kernel.org/selinux/20211119213728.19331-1-toiwoton@gma=
il.com/
> > ---
> >  secilc/docs/cil_reference_guide.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_refer=
ence_guide.md
> > index 1e63e680..ac800b12 100644
> > --- a/secilc/docs/cil_reference_guide.md
> > +++ b/secilc/docs/cil_reference_guide.md
> > @@ -189,7 +189,7 @@ Expressions
> >
> >  Expressions may occur in the following CIL statements: [`booleanif`](c=
il_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_stat=
ements.md#tunableif), [`classpermissionset`](cil_class_and_permission_state=
ments.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#t=
ypeattributeset), [`roleattributeset`](cil_role_statements.md#roleattribute=
set), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constr=
ain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constra=
int_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statement=
s.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsv=
alidatetrans)
> >
> > -CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fi=
x.html) or Polish notation and may be nested (note that the kernel policy l=
anguage uses postfix or reverse Polish notation). The syntax is as follows,=
 where the parenthesis are part of the syntax:
> > +CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fi=
x.html) or Polish notation and may be nested (note that the kernel policy l=
anguage uses infix notation). The syntax is as follows, where the parenthes=
is are part of the syntax:
> >
> >  ```
> >      expr_set =3D (name ... | expr ...)
> >
> > base-commit: f7ec4b4a84aaf3e60b099e267dbfdabbfb1878c7
> > --
> > 2.33.0
> >
