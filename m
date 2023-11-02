Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B19C4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 13:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjKBNuz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 09:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjKBNuy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 09:50:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22E12E
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 06:50:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c320a821c4so782156b3a.2
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933050; x=1699537850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ykkywYL793k4+cXMN2hn8M7sGb/pdkzkqLV9IRK/s=;
        b=fvl69WLTUYZVzPJqCDui/EHOYXRXJE3LZJvUthBLBbPmTKYKTLOl5lcMASwkhwDPoO
         cFpFZIEtUnXpUO+VWX/wUy+lPfyICKZAflOPn1Q2e7qHoDQ2Wh+rEWjnu4l2Forf1NZe
         9RFPbG921e5zxjni7eGuTKJtuR8wd4uhmHI+RctM79rzKh11SEqzlM4T1ZFG6hQWxry4
         7OXq6lqD8YHasp9ERZuP3YRpQqDsdzf6tguWJzEXnDhPcAuW3rz5uzKuK/Z9K3wtepu2
         B2yVI2oqaJ40lDEboFpBzvFjo77vcixou6F0FBONc/iEBLYx2hD/zNbzJfofMvXCeY1r
         GvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933050; x=1699537850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1ykkywYL793k4+cXMN2hn8M7sGb/pdkzkqLV9IRK/s=;
        b=OE724kcrbPo0lYrxPI2KUxU4bArWT0I1kUW3o0QMKNG/OT+i4MRtoixEO0BRGhLZhf
         TXk2D0POmgOK/H5niJmO0ssUJww1XC1T9JzzamXPbZRuu9LN7wUvtAB0ZdzsM/+zui+M
         X94b7vVC3rmBif1dRhhp6xV0wreAj/9jM5S9I5hPF4E3elDdA76hQM9Tr+/JLavdU/Nv
         6DlzhWEbCNThVZP4b2L7FJhL6qzOUfNDezNWY4wVSipqWAIiPuUN7VmKkR+4CdfFqGnz
         8SOliM1r+rFRWJFcm3IFmuYhA49547xBtKSvqIEPkCrLdiuqL0gJ4Y97QM47oJmylh7t
         rpgg==
X-Gm-Message-State: AOJu0YywFEi35OBqKUAtV9sUbXYZ1Czeoz+4tOjWT6TVnDQZslg2rjGB
        3xHSswNkpidQtFr2SHeyLWJxsaVCwc2+Hy/WFwo=
X-Google-Smtp-Source: AGHT+IEx9Iyxe2Z3s1SDB+kCEDcMtJjOVpqxWbb88uRxioSLq4Jn6+oSCecTQ9Aw2K5lmsWqknzNp/gzn4u1G+dsBaw=
X-Received: by 2002:a05:6a00:22d6:b0:68b:c562:da65 with SMTP id
 f22-20020a056a0022d600b0068bc562da65mr16439155pfj.26.1698933049744; Thu, 02
 Nov 2023 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-18-cgzones@googlemail.com> <CAP+JOzRLxX_Wg=EzihUQgTOaLBpxzWADjYPLJ+LtreN7BPtpFg@mail.gmail.com>
 <CAEjxPJ6ewvJB0vAWfUCPKLhP6hGkwS12LAf8quBs_cRDgNXiXQ@mail.gmail.com> <CAJ2a_DcJ0zRF7WSG3G0jczU2ygC_up0aJeorV9cg0TqJK8V-Ew@mail.gmail.com>
In-Reply-To: <CAJ2a_DcJ0zRF7WSG3G0jczU2ygC_up0aJeorV9cg0TqJK8V-Ew@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 2 Nov 2023 09:50:38 -0400
Message-ID: <CAEjxPJ5YXx5U+AG4oLW+ZhxMuRnbEyv6HY2bK1-R-S=TWhVb0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/27] libselinux: remove SELABEL_OPT_SUBSET
 support from selabel_file(5)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 10 Oct 2023 at 20:45, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Oct 10, 2023 at 1:08=E2=80=AFPM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > The selabel_file(5) option SELABEL_OPT_SUBSET has been deprecated i=
n
> > > > commit 26e05da0fc2d ("libselinux: matchpathcon/selabel_file: Fix ma=
n
> > > > pages.") for version 2.5.
> > > >
> > > > Drop the support to easy refactoring the selabel_file related code.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  libselinux/include/selinux/label.h    |  2 +-
> > > >  libselinux/include/selinux/selinux.h  |  6 +++++-
> > > >  libselinux/src/Makefile               |  4 ++++
> > > >  libselinux/src/label_file.c           | 19 ++++++++-----------
> > > >  libselinux/src/label_file.h           | 13 ++-----------
> > > >  libselinux/src/matchpathcon.c         |  4 +---
> > > >  libselinux/utils/matchpathcon.c       | 11 ++---------
> > > >  libselinux/utils/sefcontext_compile.c |  3 +--
> > > >  8 files changed, 24 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/libselinux/include/selinux/label.h b/libselinux/includ=
e/selinux/label.h
> > > > index ce189a3a..6cb2d782 100644
> > > > --- a/libselinux/include/selinux/label.h
> > > > +++ b/libselinux/include/selinux/label.h
> > > > @@ -50,7 +50,7 @@ struct selabel_handle;
> > > >  #define SELABEL_OPT_BASEONLY   2
> > > >  /* specify an alternate path to use when loading backend data */
> > > >  #define SELABEL_OPT_PATH       3
> > > > -/* select a subset of the search space as an optimization (file ba=
ckend) */
> > > > +/* Unsupported since v3.6: select a subset of the search space as =
an optimization (file backend) */
> > > >  #define SELABEL_OPT_SUBSET     4
> > > >  /* require a hash calculation on spec files */
> > > >  #define SELABEL_OPT_DIGEST     5
> > > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/incl=
ude/selinux/selinux.h
> > > > index a0948853..3b23cb50 100644
> > > > --- a/libselinux/include/selinux/selinux.h
> > > > +++ b/libselinux/include/selinux/selinux.h
> > > > @@ -484,7 +484,11 @@ extern int matchpathcon_init(const char *path)
> > > >
> > > >  /* Same as matchpathcon_init, but only load entries with
> > > >     regexes that have stems that are prefixes of 'prefix'. */
> > > > -extern int matchpathcon_init_prefix(const char *path, const char *=
prefix);
> > > > +extern int matchpathcon_init_prefix(const char *path, const char *=
prefix)
> > > > +#ifdef __GNUC__
> > > > +   __attribute__ ((deprecated("Use selabel_open with backend SELAB=
EL_CTX_FILE")))
> > > > +#endif
> > > > +;
> > > >
> > > >  /* Free the memory allocated by matchpathcon_init. */
> > > >  extern void matchpathcon_fini(void)
> > > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > index ac656257..15d224e1 100644
> > > > --- a/libselinux/src/Makefile
> > > > +++ b/libselinux/src/Makefile
> > > > @@ -144,6 +144,10 @@ ifeq ($(DISABLE_X11),y)
> > > >  SRCS:=3D $(filter-out label_x.c, $(SRCS))
> > > >  endif
> > > >
> > > > +# ignore usage of matchpathcon_init_prefix(3)
> > > > +matchpathcon.o:  CFLAGS +=3D -Wno-deprecated -Wno-deprecated-decla=
rations
> > > > +matchpathcon.lo: CFLAGS +=3D -Wno-deprecated -Wno-deprecated-decla=
rations
> > > > +
> > >
> > > "-Wno-deprecated" means do not warn about deprecated features and
> > > seems to be about deprecated c++ features. I don't think we need it
> > > here.
> > >
> > > Everything else looks ok to me as long as no distro is depending on
> > > this deprecated option.
> >
> > Removing an option flag defined in the public API of libselinux would
> > be an API and ABI break, requiring a major version change. Not worth
> > it IMHO.
>
> No function or macro from the public header, and no exported symbol in
> the shared library is removed or changed, so it's not an API or ABI
> break.

Fair point - my apologies.

> It is an behavior change since a lookup of /etc/shadow with the prefix
> of /usr will now return a result, and not ENOENT.

That still seems like a reason to keep it to me, or if not, to change
the .so version to reflect the compatibility break.
Others are free to disagree.

> It seems the flag was introduced as a performance optimization, which
> should no longer be necessary by the followup rewrite.
> I could try to continue to support to the flag however.
