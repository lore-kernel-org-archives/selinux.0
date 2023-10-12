Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBECDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441896AbjJLRxY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441898AbjJLRxX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:53:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C91B8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-503065c4b25so1756915e87.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133201; x=1697738001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOj3pksH5PRhtnHYDgprgLWyBzZg5Oa5fW3f5Gqu8L0=;
        b=BV0d/9XVAU3IJlqH0EP7Z0RMh8pg3gVlXzbrtivVqxmeax7zc8u0bKqtX576iKoN8D
         Q9jlSvmJZMacVIO8nz6rQK5tYGkD9fM0g2n0wfKiP6pZukfNOkItlwoGIqI+piyqq/6Z
         zw65PBZ39zWmFh0oq043RN5/fqP/LHpHk4j9iBE47QMw0TZRoy5TP8/IQCREfxWhZ+mX
         4re5zwsAKuvN+uVbXlyswDMxbayYhInnIXyeP7yTXAxo+koCxt6BPjhig5O0LPqNG6Ev
         hZNw6wEGQkHgMCeiTq4/GMzj0+nERQpclTQWLE1/gH+FFNBz3r3upFvc8awz3N1Dwhlf
         PDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133201; x=1697738001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOj3pksH5PRhtnHYDgprgLWyBzZg5Oa5fW3f5Gqu8L0=;
        b=G9/77HK+bX2I7HMML+2J5L0ORwfDU8/6Ml2YcR8uEM9r+QLpPrl9dO5J+PzINk0c29
         uPmd+E7xXM4HYGgpkX+WU7kiI0m7Gnnoa670EsoI0a8W5E6euEEn2Tmc8Is198kOiVlm
         BUXOi/YFEenGuEoYmqUsaQYnFuffHiJHOUnSQJw2DIWnLQbmhjwtPq1w/k4FB6G9BMWW
         5PJLqFtLAOd8WJg5Uy3ksNVz5ijnEEHuMaEhAm7lmCCKVu1fNANeOnZ0ZtJ483p2AoxQ
         icGdLphIgYIZaWB4azJjXkcrA4HJYSdQnChOo9vB1IW2KOmJtFS1a3L5v2v9AwRSPfCk
         fmMw==
X-Gm-Message-State: AOJu0YxlJqHbFYQb5SmuBIdCnx2bWS8iDDVMGd8PXfeEU/svOsIhTXGQ
        jEcM5R7svWJz5iuUjF2CdR52FrhPqMQhy6y5Grp1Rwjo6jY=
X-Google-Smtp-Source: AGHT+IH5Z6FjiTtDyjmz0+qBL7k+ZGMr/lzyKI1CR28bnL9aoVss07L+rpIh4W22FR6NKYgLKPM7b9BjF/LuuizrXb0=
X-Received: by 2002:ac2:59cf:0:b0:505:783f:bc65 with SMTP id
 x15-20020ac259cf000000b00505783fbc65mr16211426lfn.66.1697133200653; Thu, 12
 Oct 2023 10:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-5-cgzones@googlemail.com> <CAP+JOzS_2HoqWcH1kcrz=6=AxO7-SrxgKGcVk5917KWumQE+8Q@mail.gmail.com>
In-Reply-To: <CAP+JOzS_2HoqWcH1kcrz=6=AxO7-SrxgKGcVk5917KWumQE+8Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:53:09 -0400
Message-ID: <CAP+JOzQTnKkFkB3mG6=q4hiyKx5d+pumqr7zm2f1x5hGH-oUCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/27] libselinux: drop unnecessary warning overrides
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 1:14=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Drop overrides of warning flags which are not triggered by any code.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index b1620113..20d79312 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -83,11 +83,10 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wform=
at-security -Winit-self -Wmissi
> >            -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -=
Wendif-labels -Wextra \
> >            -Wformat-extra-args -Wformat-zero-length -Wformat=3D2 -Wmult=
ichar \
> >            -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > -          -Wno-missing-field-initializers -Wno-sign-compare \
> > -          -Wno-format-nonliteral -Wframe-larger-than=3D$(MAX_STACK_SIZ=
E) \
> > +          -Wframe-larger-than=3D$(MAX_STACK_SIZE) \
> >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexcept=
ions \
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> > -          -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > +          -Werror -Wno-aggregate-return \
> >            $(EXTRA_CFLAGS)
> >
> >  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-=
z,defs,-z,relro
> > --
> > 2.40.1
> >
