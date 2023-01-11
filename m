Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6EC678D5
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjAKPxy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjAKPxv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:53:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89CC77D
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so26061376ejc.10
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ+3SnxuAhYG6CM321I498pARz0+TiaostSc2uu8WD4=;
        b=Lr1dOFJAzH/j/QIzqthsP+YJ0jlf/nIBTyXm09yXZpsbWj7STpyP124fB7iNx7i+5b
         lpHnMRWq90VQWx96qpw4FQbfyWpxl5wJufCiDV7/ebtzTL186kuKG5n2EYrLZu2Yofhl
         Po9JWVCW84fFtaSiV+zaL+IHuncFxMGMclKK9+zcCjp4msNQsPyK995ryI1KHhxfYrkC
         NaKaDKhK8wuvEIHLENoe5zDUKAxmuFNFCEqli9NB92M/n36q6Whg+AMsi8sX5yLIGHsw
         f+QTvk5uozXk3C6IXhcpO3E/FA1jOGUX/1nEohQYxZEYUBvoqRHk2v0/CLOyEU2qr92T
         GqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ+3SnxuAhYG6CM321I498pARz0+TiaostSc2uu8WD4=;
        b=rlJVti8mzO+/2caRIKqdEKViSCPjaByGxyhj3MHP7FPbqRO8KCJf83YUoB1me1o1Zh
         cxLa1BoSGHQrUJ/a51b4t7NquvB7z92zQjBwEZyfl4XKX0XNQ/y4h/oqtNX7n6rkbZMM
         h8R+UxBSGAmlVWkRQO4FDEZOwUXqe5RyPBFNQo7xLchnedEJ5Cpak6AQQmJQUyd1WAwR
         YMygefce1c+XqDAfa5yFUsMCzdAlQrqpu4wp4Mz+AB4lird3YFi5U2bCSoRbRkYWO1Ew
         yvPu9LGGFpjIqlBK8b4sWpmdZgw7PtBpSfInSJSB9Jyo5xcCQzDQo+hoz1uLl0wn1wg7
         yw0g==
X-Gm-Message-State: AFqh2kraObIycIuRIir6R1XxMYHNLKu9WADd/uXbgdV8U7elG+f8BfsI
        shREEcIwIymvTN6bOth3nqYSegaq8Wzcr4Fu9Ec=
X-Google-Smtp-Source: AMrXdXsDj0Q8RZQM656PfPsTobivQv3/U2NvAcDY5xob3UUf5Bg7/mycPLiLKy35tRSB4mzsdFBBJc39HDKn9LbqveA=
X-Received: by 2002:a17:906:1481:b0:84d:1760:3981 with SMTP id
 x1-20020a170906148100b0084d17603981mr2362865ejc.705.1673452428869; Wed, 11
 Jan 2023 07:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20230105171340.18444-1-cgzones@googlemail.com> <CAP+JOzR5n9Goku3R9bMyk9466cBCDomVyv-nQFkE0Gfctv=tCw@mail.gmail.com>
In-Reply-To: <CAP+JOzR5n9Goku3R9bMyk9466cBCDomVyv-nQFkE0Gfctv=tCw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:53:37 -0500
Message-ID: <CAP+JOzTWEMa_-F6XsFpkyu9L5KetP-wBEiDV3KnYtxn3Yb4CvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: do not write empty class definitions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 10, 2023 at 10:27 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jan 5, 2023 at 12:27 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not write class definitions for classes without any permission and
> > any inherited common class.  The classes are already declared in
> > write_class_decl_rules_to_conf().  Skipping those empty definitions,
> > which are equal to the corresponding class declarations, will enable to
> > parse the generated policy conf file with checkpolicy, as checkpolicy
> > does not accept class declarations after initial sid declarations.
> >
> > This will enable simple round-trip tests with checkpolicy.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_conf.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 63dffd9b..73b72b5d 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -591,16 +591,21 @@ static int write_class_and_common_rules_to_conf(F=
ILE *out, struct policydb *pdb)
> >                 class =3D pdb->class_val_to_struct[i];
> >                 if (!class) continue;
> >                 name =3D pdb->p_class_val_to_name[i];
> > -               sepol_printf(out, "class %s", name);
> > -               if (class->comkey) {
> > -                       sepol_printf(out, " inherits %s", class->comkey=
);
> > -               }
> >                 perms =3D class_or_common_perms_to_str(&class->permissi=
ons);
> > -               if (perms) {
> > -                       sepol_printf(out, " { %s }", perms);
> > -                       free(perms);
> > +               /* Do not write empty classes, their declaration was al=
reedy
> > +                * printed in write_class_decl_rules_to_conf() */
> > +               if (perms || class->comkey) {
> > +                       sepol_printf(out, "class %s", name);
> > +                       if (class->comkey) {
> > +                               sepol_printf(out, " inherits %s", class=
->comkey);
> > +                       }
> > +
> > +                       if (perms) {
> > +                               sepol_printf(out, " { %s }", perms);
> > +                               free(perms);
> > +                       }
> > +                       sepol_printf(out, "\n");
> >                 }
> > -               sepol_printf(out, "\n");
> >         }
> >
> >  exit:
> > --
> > 2.39.0
> >
