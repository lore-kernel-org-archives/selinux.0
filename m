Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7CC4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 17:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKARaF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjKARaE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 13:30:04 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413211F
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 10:29:58 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b6043d0b82so2945592241.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698859797; x=1699464597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8KhEnFh+4GyL4LygBWgC7QG5lttLm7jt4Q1BzN19hA=;
        b=ZWIBPTEJ69qIX5Mwb2WnrxrPOl2lYm5xXJXGXuvGTEmPz9Ju5spPH3uBZY9ElfkjUL
         yihGaUYO6YeQo/twjc+k+EVHQ8gjsDigXkVWWtZSD3gfrmklLGsLEGirID+iGuf9ZBMO
         5ZrKYfdn0VtbzHQjZIQ13COVYH9Wh+2C1KhDWHe1VXOPEvjOkm1EsPZ5JQp5o22oTU9k
         uczci6aqVYYpf3lgUoo5yDjuGIaNPdN+4m78hS83Lysrm0PgxpSfpJ/820hlagXbtNTb
         7EkRH14Z2Vzh1jsAJKvHxm3/Z8UVsHvYo6dSx463cxiEwnFnIbuNjNKyL1CezgmiaNfm
         Eaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859797; x=1699464597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8KhEnFh+4GyL4LygBWgC7QG5lttLm7jt4Q1BzN19hA=;
        b=qSqTH2mUIUO8GJFlSMzzkRXMhwTIaH38CGlu++aX8ycp5drDCMV3EeX3v7/CHlg4Ht
         p9VLbHjWiBn/2q0iLpXIZ6JXrj+LYDpioSfe+1DNTOpVw9JblQKYpjbT6snUR+ZxcAkv
         fzA2bV7BRwgfee4KG+KFSil3doCpaCRw303ifVfR1IHffuULcz4lJykf5fds4btFgcKL
         IQAhaHptk65+hUdE4W7lcDesaYgpPIrn8QwNQWn0QLtxdzJoL/j9qjvhuwP+Cbrg68xB
         AYjyIBQe3We9Vg9TiNRJkoyBUwBuyOkUQcpSuNkpCCF8sSaIFl8jaXfDKGR975FhOiOM
         uWww==
X-Gm-Message-State: AOJu0Yx9LCvAmQ3XMB8SAs30tcIqNnCI0Lr7QdcozJsYHhORMMp0ssGm
        CFmdJi92pXnlQzaQA/eUAlkxoryWft4J6MO2oRNGPTNh
X-Google-Smtp-Source: AGHT+IEtHNEhzrnnKKA1cJc9xVWhO/yGOKNI3StAtjxBAtoiUS2JyyiXAQOmqHJYSvqaodTlXhmMHydXr5ihMjZaSB8=
X-Received: by 2002:a67:ac09:0:b0:457:6cf4:6fa2 with SMTP id
 v9-20020a67ac09000000b004576cf46fa2mr16628322vse.4.1698859797457; Wed, 01 Nov
 2023 10:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-18-cgzones@googlemail.com> <CAP+JOzRLxX_Wg=EzihUQgTOaLBpxzWADjYPLJ+LtreN7BPtpFg@mail.gmail.com>
 <CAEjxPJ6ewvJB0vAWfUCPKLhP6hGkwS12LAf8quBs_cRDgNXiXQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6ewvJB0vAWfUCPKLhP6hGkwS12LAf8quBs_cRDgNXiXQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 1 Nov 2023 18:29:46 +0100
Message-ID: <CAJ2a_DcJ0zRF7WSG3G0jczU2ygC_up0aJeorV9cg0TqJK8V-Ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/27] libselinux: remove SELABEL_OPT_SUBSET
 support from selabel_file(5)
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 10 Oct 2023 at 20:45, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 10, 2023 at 1:08=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > The selabel_file(5) option SELABEL_OPT_SUBSET has been deprecated in
> > > commit 26e05da0fc2d ("libselinux: matchpathcon/selabel_file: Fix man
> > > pages.") for version 2.5.
> > >
> > > Drop the support to easy refactoring the selabel_file related code.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/include/selinux/label.h    |  2 +-
> > >  libselinux/include/selinux/selinux.h  |  6 +++++-
> > >  libselinux/src/Makefile               |  4 ++++
> > >  libselinux/src/label_file.c           | 19 ++++++++-----------
> > >  libselinux/src/label_file.h           | 13 ++-----------
> > >  libselinux/src/matchpathcon.c         |  4 +---
> > >  libselinux/utils/matchpathcon.c       | 11 ++---------
> > >  libselinux/utils/sefcontext_compile.c |  3 +--
> > >  8 files changed, 24 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/=
selinux/label.h
> > > index ce189a3a..6cb2d782 100644
> > > --- a/libselinux/include/selinux/label.h
> > > +++ b/libselinux/include/selinux/label.h
> > > @@ -50,7 +50,7 @@ struct selabel_handle;
> > >  #define SELABEL_OPT_BASEONLY   2
> > >  /* specify an alternate path to use when loading backend data */
> > >  #define SELABEL_OPT_PATH       3
> > > -/* select a subset of the search space as an optimization (file back=
end) */
> > > +/* Unsupported since v3.6: select a subset of the search space as an=
 optimization (file backend) */
> > >  #define SELABEL_OPT_SUBSET     4
> > >  /* require a hash calculation on spec files */
> > >  #define SELABEL_OPT_DIGEST     5
> > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/includ=
e/selinux/selinux.h
> > > index a0948853..3b23cb50 100644
> > > --- a/libselinux/include/selinux/selinux.h
> > > +++ b/libselinux/include/selinux/selinux.h
> > > @@ -484,7 +484,11 @@ extern int matchpathcon_init(const char *path)
> > >
> > >  /* Same as matchpathcon_init, but only load entries with
> > >     regexes that have stems that are prefixes of 'prefix'. */
> > > -extern int matchpathcon_init_prefix(const char *path, const char *pr=
efix);
> > > +extern int matchpathcon_init_prefix(const char *path, const char *pr=
efix)
> > > +#ifdef __GNUC__
> > > +   __attribute__ ((deprecated("Use selabel_open with backend SELABEL=
_CTX_FILE")))
> > > +#endif
> > > +;
> > >
> > >  /* Free the memory allocated by matchpathcon_init. */
> > >  extern void matchpathcon_fini(void)
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index ac656257..15d224e1 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -144,6 +144,10 @@ ifeq ($(DISABLE_X11),y)
> > >  SRCS:=3D $(filter-out label_x.c, $(SRCS))
> > >  endif
> > >
> > > +# ignore usage of matchpathcon_init_prefix(3)
> > > +matchpathcon.o:  CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declara=
tions
> > > +matchpathcon.lo: CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declara=
tions
> > > +
> >
> > "-Wno-deprecated" means do not warn about deprecated features and
> > seems to be about deprecated c++ features. I don't think we need it
> > here.
> >
> > Everything else looks ok to me as long as no distro is depending on
> > this deprecated option.
>
> Removing an option flag defined in the public API of libselinux would
> be an API and ABI break, requiring a major version change. Not worth
> it IMHO.

No function or macro from the public header, and no exported symbol in
the shared library is removed or changed, so it's not an API or ABI
break.
It is an behavior change since a lookup of /etc/shadow with the prefix
of /usr will now return a result, and not ENOENT.
It seems the flag was introduced as a performance optimization, which
should no longer be necessary by the followup rewrite.
I could try to continue to support to the flag however.
