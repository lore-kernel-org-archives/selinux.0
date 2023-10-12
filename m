Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80EBC41513
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441897AbjJLRxH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441845AbjJLRxG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:53:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8CC9
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c17de836fbso16211521fa.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133183; x=1697737983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDTkgu3rfSEcv7OAjccI+HQIZOV91NYlP+OE1G4MEYM=;
        b=CVoabfDvEtItTvCuS11WvrMjA6Hd9+D1O7F+iYytgvDScMW9bnvAps3Wvj5kJA1Tl3
         u02bJr6l5nkzmHWTkEe/2HrhS0Ein0Ni33kaWDvgHqibwlcgNlZ5UToIBAm6MQU7XF+Y
         kiNdYT1YQ9IJ6OkNiVuGNdWyzJx7nxWK1CRVlmKJFWy4PjKNNWRYQC0p6THbzHu4aQ/b
         872x6hasnLkQdEUthBFuiOD2GgTAz9rkeK49SspZR02Oytp9w6ePWeoJnofHdSRbOc3Z
         FyJ6KuNWoOsOhOBxu6RHAGdfQ+BTZbSNSAu04L+78UsFk7C9DOy44o/bdhE0QlNSDrIw
         hjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133183; x=1697737983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDTkgu3rfSEcv7OAjccI+HQIZOV91NYlP+OE1G4MEYM=;
        b=oF3F/T7m0JYz9oGqJmkM/uMD3WNuv4sdo6UHipZhr3HuZ5ANTHTc926tuUC6Shz50s
         eilrS93aLTuTyzy96895lZ0YjAfV5XXC7zMd6ywK55gRLDzopSRvZECxwD2y/JnJg2to
         KV8dIPiuC0fCmgCKLSd7ldcwEHYwnJ0JIE7GE3G0i4sAPUh90I6NvhLK16V+LEVy8dcG
         lvxyBBWHXEp5L3DGs2SuG6+ve1hq1YejNMV9XjhaU0AiekE6Bg1Cgn8YJBT6BmE4LFKD
         JGDlabRdYfCn4UfGq3IoGxjBlMASLzlT/gzrwWyg5kFw6C2Ebe8mRJpP/u0L5xj1I/HG
         7e4A==
X-Gm-Message-State: AOJu0YwzBvbvjUaT0wYK5s7Wm1DeyOqeFz6wx3FELHt3sx1WN6M+n+bu
        PaIAoNX/kDM6lkzLBTUGOQAQIaqQNrOYQLWtUIcsXb6Kbak=
X-Google-Smtp-Source: AGHT+IFglygwty03CjY4QAQ6TrLy6azvMHw1TOZ0m2RkouWuXhDDd9cw+S2cbZhkVh1B36IhJcXKom55VywDW8O+oSM=
X-Received: by 2002:a2e:8250:0:b0:2ba:34d0:fa5f with SMTP id
 j16-20020a2e8250000000b002ba34d0fa5fmr19166381ljh.37.1697133182778; Thu, 12
 Oct 2023 10:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-4-cgzones@googlemail.com> <CAP+JOzQvz1C6JGuzU4TgKvbsieRuPV6W4NEZbgLCj4XVQ33vrQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQvz1C6JGuzU4TgKvbsieRuPV6W4NEZbgLCj4XVQ33vrQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:52:51 -0400
Message-ID: <CAP+JOzS3otU+AwzfFAe+O-wXRzMMVkN-xJ8qsR-b=g1FL1+gFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/27] libselinux: drop obsolete optimization flag
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
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The flag -fipa-pure-const is enabled by default in GCC at -O0 and above=
.
> >
> > The flag is not supported by Clang, which might result in issues if a
> > compilation database was created via GCC.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> > v2: add missing signed-off
> > ---
> >  libselinux/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index f9a1e5f5..b1620113 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -61,7 +61,7 @@ SRCS=3D $(filter-out $(GENERATED) audit2why.c, $(sort=
 $(wildcard *.c)))
> >  MAX_STACK_SIZE=3D32768
> >
> >  ifeq ($(COMPILER), gcc)
> > -EXTRA_CFLAGS =3D -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compa=
t -Wsync-nand \
> > +EXTRA_CFLAGS =3D -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
> >         -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=3D=
nfc -Wsuggest-attribute=3Dconst \
> >         -Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure -Wtra=
mpolines -Wjump-misses-init \
> >         -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst -U=
_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
> > --
> > 2.40.1
> >
