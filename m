Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CFCDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379647AbjJLRvu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379549AbjJLRvt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:51:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32BD8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:51:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50437c618b4so1598081e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133107; x=1697737907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV/VXt/O0GMwbTCqhm2FRGAjQMKFWQ1G0HGxXnMmCSA=;
        b=QDgo90jmWd2jhajYVlfITiZxYxOc6NaJPjHbTlVHrC/5s3VTvPWqLr7wm39W8Z6z5/
         Y0OJs2ucq+q+gwkhdJI36Kbi5HiWCdyMDu3vg0DXGZMVu7zx+4+K9GdjLjacPrh46kOe
         iHqIQ4A+GlcOgkA7vMMiS/LLuiNFMc+ap1V/M9+9ZijDvGLVr631Jyl2f3kl2ATOcFHs
         gs3sLmXfaODAZDxqVOZtrdNzNgeXmxrc84ivyQx0hJiyKAZihPlB9OT7UknuHuQsQeh4
         7+YOGsEaZor63uh5MnEjs9ERKUexeytckVpwnMENv+l8uCTEcqXLG+gybO4gxv/z3Fa5
         T6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133107; x=1697737907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV/VXt/O0GMwbTCqhm2FRGAjQMKFWQ1G0HGxXnMmCSA=;
        b=QOkV1QglB9OtlznjGbGv1JumX4RBhY2rwIUOpQII/UvT52y7vEhubHb+ek6hTwTAr0
         VwJb0sL1P1BzbCQnUxZR2cm+OZcGdtmDyRZiraMHX8XWIsMgBb3hgCWrFCu9s0EsO6vH
         +qKOfpfedKFDwb4OObLeWzj+lJ8Lm8sGPcw82XLrO1+vhj5np6R76CpLOgSzktXJF8K3
         o+hEAfX9F+UPBNbY7D57n/2UREyvAQsaVod2QaHSi/fozV2alA7bEliBrq6Tn2SdTI7r
         DeMQtYVaohJoEFeC2DJjXrtFYu2p5uBQcDKOUnJ1Spp1Txo4Fr3gl9PH2aQE7c6TP/sb
         oYwg==
X-Gm-Message-State: AOJu0YwM6ai0sPiDTIAny0C5XqsMOK8M96L+KIBeqCbm5Y/IthEfmh7r
        H2vh48EhOIPBrjYHcG4yJGZcTcRAFonkMlFB3Gka+cEo
X-Google-Smtp-Source: AGHT+IE7oNm1zG/JHJ3enTXRq8cGUto/E+a2Fh2PxcJjKH/6RCTZVW0sxMyhbeXblPdEWY+c4sy2x5cEjlqQGpbZcQg=
X-Received: by 2002:a05:6512:2082:b0:503:2561:adbc with SMTP id
 t2-20020a056512208200b005032561adbcmr18282783lfr.64.1697133106498; Thu, 12
 Oct 2023 10:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <260cd39c55ff2d13f5ac916b508f023bedecfce9.1692025627.git.mirai@makinata.eu>
 <CAP+JOzQPWZe45H8HrXZtOh9FLo37fSrZdLVxZeNJQ6v_ey_h-g@mail.gmail.com>
In-Reply-To: <CAP+JOzQPWZe45H8HrXZtOh9FLo37fSrZdLVxZeNJQ6v_ey_h-g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:51:35 -0400
Message-ID: <CAP+JOzTfrunQq9LHVK5fH2HVHA_RkiXXrHKPB2nHsBq2UHT50Q@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use versioned DocBook public identifier.
To:     Bruno Victal <mirai@makinata.eu>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 28, 2023 at 4:24=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 11:53=E2=80=AFAM Bruno Victal <mirai@makinata.eu>=
 wrote:
> >
> > Fix xml validation issues that often crop up since the XML catalogs
> > for DocBook often only contain versioned public identifiers.
> >
> > Signed-off-by: Bruno Victal <mirai@makinata.eu>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  secilc/secil2conf.8.xml | 2 +-
> >  secilc/secil2tree.8.xml | 2 +-
> >  secilc/secilc.8.xml     | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
> > index 33646f97..330b6a07 100644
> > --- a/secilc/secil2conf.8.xml
> > +++ b/secilc/secil2conf.8.xml
> > @@ -1,5 +1,5 @@
> >  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> > +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> >                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd=
">
> >
> >  <refentry>
> > diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
> > index e95a8947..d7bb177e 100644
> > --- a/secilc/secil2tree.8.xml
> > +++ b/secilc/secil2tree.8.xml
> > @@ -1,5 +1,5 @@
> >  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> > +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> >                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd=
">
> >
> >  <refentry>
> > diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
> > index e9a121e2..5c0680a8 100644
> > --- a/secilc/secilc.8.xml
> > +++ b/secilc/secilc.8.xml
> > @@ -1,5 +1,5 @@
> >  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> > +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> >                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd=
">
> >
> >  <refentry>
> >
> > base-commit: f6dc6acfa00707ce25c6357169111937f12512dd
> > --
> > 2.40.1
> >
