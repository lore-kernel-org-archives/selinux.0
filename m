Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09018C61D92
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjKUOMM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjKUOML (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:12:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71410C8
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:12:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50797cf5b69so7607043e87.2
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575926; x=1701180726; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0YABw48qAFQHd8yHwWjtw2FFdUhrE+RrQFZbZ5LdG8=;
        b=dv9Jx2gVfuSi39O4R3yOQcfVcbIfDwsbIdjIBTZG2RMCjaJsUS07K/BBPO5bjUg5os
         qEwNl4KQpmdAtrGjbRGwhGfdvbZL7FBxONtXkpzR9cudiPgLJTBtuhWaF6LDPN/JE5XJ
         hIDhxEXwUBnJPc1EUHB6Bn5ihFr0OgfF8Ujpkbw6lF6oy0zvM+zFS21wpRmlSHqkSZZY
         3GEuU+M+5TJXypgsdD9wGzF8WdCYMGJqOZB7eBuWn7uDPg/WQuH5Nnj5d4UQd6Pcz7TG
         yuWZw7cpjtHLZUAQX1u1q+tvlfTpdU66wFXzEOFzZnx6lG81F0VJzNSpyZ/WRxjTMxHb
         G9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575926; x=1701180726;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0YABw48qAFQHd8yHwWjtw2FFdUhrE+RrQFZbZ5LdG8=;
        b=P1tQRXaIMQAfZNYn70MJRzq1uF5ZN1JLbeOrGvAF8ogAwZQMTq9XBdjuGekkJMSXNc
         rbgnCWKslNunOnWQDysh+sabg6y7mzK5xMQUIJ70nmh7f3kiTgdMWTvJL7QNHEXND50R
         9LwIRhc3ghhFHBuNigdGbby+3mlGNXVh5D5vd+OxwK2xaPqB0RPt+z87xknVsh4FDUnE
         5loridfWWNry6vQHX+uL9+bX29/6+JBuhxM1dcLgpd/iILNyoO2JH/zlAtdd2o3ElwX/
         RzgVgakBhe6KUaRhc1y2G5g2x0jG6bLgfq4utBHhW9ApaHHkohFiGnsM/ybS7Z4VWwus
         8nIg==
X-Gm-Message-State: AOJu0YzQ8k0qf6tjI8UY73a3OzxkeOqgsdrCeLBuj5WG3yAeGMwKL+kV
        uFzs6WCMGkp2+xvZfNFlaxzWK8uMbDdC5S06wrhhLtut
X-Google-Smtp-Source: AGHT+IFIseymFP/P9cgAdlgH4B6EFk/05h9xoAOFM6keU3PXNrxn1p2c7COm65MzYNnpVLZoiAPzhM4VnwiwSLovyFc=
X-Received: by 2002:ac2:5296:0:b0:507:ceba:a94d with SMTP id
 q22-20020ac25296000000b00507cebaa94dmr7920260lfm.14.1700575925780; Tue, 21
 Nov 2023 06:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20231013135207.1462729-1-jwcart2@gmail.com> <CAP+JOzTTa_BnpocHZ5_AAJO99z3gF2FbtBj7L=_iOU93LYPVKg@mail.gmail.com>
In-Reply-To: <CAP+JOzTTa_BnpocHZ5_AAJO99z3gF2FbtBj7L=_iOU93LYPVKg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Nov 2023 09:11:54 -0500
Message-ID: <CAP+JOzQuQd=rjPZQ2fQx+9+Wo3=0yLvK4f6vg_Rch5guvOOPOw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not allow classpermissionset to use
 anonymous classpermission
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 17, 2023 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Oct 13, 2023 at 9:52=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Macros can use classpermission arguments. These are used in two
> > different ways. Either a named classpermission is passed (which is
> > declared using a classpermisison rule) or an anonymous classpermission
> > is passed (something like "(CLASS (PERM))").
> >
> > Usually this will look like either of the following:
> > Ex1/
> > (classpermission cp1)
> > (classpermisisonset cp1 (CLASS (PERM)))
> > (macro m1 ((classpermisison ARG1))
> >   (allow t1 self ARG1)
> > )
> > (call m1 (cp1))
> > or
> > Ex2/
> > (macro m2 ((classpermission ARG2))
> >   (allow t2 self ARG2)
> > )
> > (call m2 ((CLASS (PERM))))
> >
> > The following would also be valid:
> > Ex3/
> > (classpermission cp3)
> > (macro m3 ((classpermission ARG3))
> >   (classpermissionset ARG3 (CLASS (PERM)))
> >   (allow t3 self ARG3)
> > )
> > (call m3 (cp3))
> >
> > The oss-fuzzer did the equivalent of the following:
> >
> > (classpermission cp4)
> > (macro m4 ((classpermission ARG4))
> >   (classpermissionset ARG4 (CLASS (PERM1)))
> >   (allow t4 self ARG4)
> > )
> > (call m4 (CLASS (PERM2)))
> >
> > It passed an anonymous classpermission into a macro where there
> > was a classpermissionset rule. Suprisingly, everything worked well
> > until it was time to destroy the AST. There is no way to distinguish
> > between the anonymous classpermission being passed in which needs
> > to be destroyed and the classpermission in the classpermissionset
> > rule which is destroyed when the classpermissionset rule is
> > destroyed. This led to CIL trying to destroy the classpermission
> > in the classpermissionset rule twice.
> >
> > To fix this, when resolving the classpermission name in the
> > classpermissionset rule, check if the datum returned is for
> > an anonymous classpermission (it has no name) and return an
> > error if it is.
> >
> > This fixes oss-fuzz issue 60670.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> This patch could use a review. I would like to get it in the upcoming rel=
ease.
> Jim
>

This patch has been merged.
Jim

> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index 33b9d321..49de8618 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -254,6 +254,12 @@ int cil_resolve_classpermissionset(struct cil_tree=
_node *current, struct cil_cla
> >                 goto exit;
> >         }
> >
> > +       if (!datum->fqn) {
> > +               cil_tree_log(current, CIL_ERR, "Anonymous classpermissi=
on used in a classpermissionset");
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +
> >         rc =3D cil_resolve_classperms_list(current, cps->classperms, ex=
tra_args);
> >         if (rc !=3D SEPOL_OK) {
> >                 goto exit;
> > --
> > 2.41.0
> >
