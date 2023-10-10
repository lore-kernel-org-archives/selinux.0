Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E7FCD8CAF
	for <selinux@archiver.kernel.org>; Tue, 10 Oct 2023 18:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJJSp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Oct 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSp2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Oct 2023 14:45:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1F94
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 11:45:26 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4fc2ce697so4287656a34.0
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963525; x=1697568325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcDdi7SNWan3y9hrUxdK7YqPhjdS18hBb88yx347NRk=;
        b=AAlvmfxlHi6T4pLnu8M7dGwYp7rbdgz2lYwEDjVacU3ds0/DBrfNQ845a+8PNxEQ2A
         bVK0CMRv3O8BjPhKNF+7fiUlp26jIaUvefr3+ZtxJBqK8wv+sD5YTNxRDa38444pNX3B
         2aKxzPu/gAJMK2emDePYsqTiEKSDZjUAt+rWoMZ7giAwpaIXBinlHMGAmPL6DhrRwcXq
         K2ZxX11O77FrTX2M1wgTaVQbCDYJKs1RIDbYNHBB10itcsuNmhVbT2P7zjJmFPWYo1bl
         cGHORCIZE6NhAgBqaNL94L/ppw6On3Az7umyv3R22rX/bpjO7+4fwoQOU4cogoGNMq7v
         cq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963525; x=1697568325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcDdi7SNWan3y9hrUxdK7YqPhjdS18hBb88yx347NRk=;
        b=h4ta4uRvkMZ2pjq1dpKLmUNtsby5uJP8a69/KsozLnzvT9TiUq/cgYP0zseBjQuwFe
         5l+qXYRfno05oWjnGaWXfogpctvlnK8b1uozxP63Tw1w7U8Ml3BB3NYK9wD+ufhqnKKl
         EvwwdJx/NDbgXu429U5DJ376HM58M+6HSqCGOvThzK1fUQd84QWXFioS8FCkOwc/hpjV
         eHr0JDmodYAdmptFBllAjcYjpHaTcVb8fOo7XDXVoE6w1iQuWnIEjUNyscCSIwZxTCfv
         IJ9+Q7Fn2E6MaUt5A3/rOxbo2CyDE2hvD2WJjfcTd0d80qOwBqY4TMflR/UgcqMU59LE
         CWSw==
X-Gm-Message-State: AOJu0YywzQhjz8G+udghEki4JzTRMTHlqOUI4fHvNxQ6JVjb7x2BnbqZ
        1+ucYcZ0u+QQSsQVnsmZimvHtvrrskn7zRnE5uChAdkP
X-Google-Smtp-Source: AGHT+IHgw3Kks8pjWRX/wU66j019uuyD7yW16HF545k+pg8E1RyQGgMEu58qqr/ed0+1giWf6YYomqOPcZOEB2kHSTU=
X-Received: by 2002:a9d:684b:0:b0:6bc:b6a6:24f4 with SMTP id
 c11-20020a9d684b000000b006bcb6a624f4mr20357919oto.34.1696963525708; Tue, 10
 Oct 2023 11:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-18-cgzones@googlemail.com> <CAP+JOzRLxX_Wg=EzihUQgTOaLBpxzWADjYPLJ+LtreN7BPtpFg@mail.gmail.com>
In-Reply-To: <CAP+JOzRLxX_Wg=EzihUQgTOaLBpxzWADjYPLJ+LtreN7BPtpFg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Oct 2023 14:45:14 -0400
Message-ID: <CAEjxPJ6ewvJB0vAWfUCPKLhP6hGkwS12LAf8quBs_cRDgNXiXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/27] libselinux: remove SELABEL_OPT_SUBSET
 support from selabel_file(5)
To:     James Carter <jwcart2@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 10, 2023 at 1:08=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The selabel_file(5) option SELABEL_OPT_SUBSET has been deprecated in
> > commit 26e05da0fc2d ("libselinux: matchpathcon/selabel_file: Fix man
> > pages.") for version 2.5.
> >
> > Drop the support to easy refactoring the selabel_file related code.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/include/selinux/label.h    |  2 +-
> >  libselinux/include/selinux/selinux.h  |  6 +++++-
> >  libselinux/src/Makefile               |  4 ++++
> >  libselinux/src/label_file.c           | 19 ++++++++-----------
> >  libselinux/src/label_file.h           | 13 ++-----------
> >  libselinux/src/matchpathcon.c         |  4 +---
> >  libselinux/utils/matchpathcon.c       | 11 ++---------
> >  libselinux/utils/sefcontext_compile.c |  3 +--
> >  8 files changed, 24 insertions(+), 38 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/se=
linux/label.h
> > index ce189a3a..6cb2d782 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -50,7 +50,7 @@ struct selabel_handle;
> >  #define SELABEL_OPT_BASEONLY   2
> >  /* specify an alternate path to use when loading backend data */
> >  #define SELABEL_OPT_PATH       3
> > -/* select a subset of the search space as an optimization (file backen=
d) */
> > +/* Unsupported since v3.6: select a subset of the search space as an o=
ptimization (file backend) */
> >  #define SELABEL_OPT_SUBSET     4
> >  /* require a hash calculation on spec files */
> >  #define SELABEL_OPT_DIGEST     5
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index a0948853..3b23cb50 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -484,7 +484,11 @@ extern int matchpathcon_init(const char *path)
> >
> >  /* Same as matchpathcon_init, but only load entries with
> >     regexes that have stems that are prefixes of 'prefix'. */
> > -extern int matchpathcon_init_prefix(const char *path, const char *pref=
ix);
> > +extern int matchpathcon_init_prefix(const char *path, const char *pref=
ix)
> > +#ifdef __GNUC__
> > +   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_C=
TX_FILE")))
> > +#endif
> > +;
> >
> >  /* Free the memory allocated by matchpathcon_init. */
> >  extern void matchpathcon_fini(void)
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index ac656257..15d224e1 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -144,6 +144,10 @@ ifeq ($(DISABLE_X11),y)
> >  SRCS:=3D $(filter-out label_x.c, $(SRCS))
> >  endif
> >
> > +# ignore usage of matchpathcon_init_prefix(3)
> > +matchpathcon.o:  CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declarati=
ons
> > +matchpathcon.lo: CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declarati=
ons
> > +
>
> "-Wno-deprecated" means do not warn about deprecated features and
> seems to be about deprecated c++ features. I don't think we need it
> here.
>
> Everything else looks ok to me as long as no distro is depending on
> this deprecated option.

Removing an option flag defined in the public API of libselinux would
be an API and ABI break, requiring a major version change. Not worth
it IMHO.
