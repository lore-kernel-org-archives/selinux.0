Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A5C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B820246C0
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2IjRCcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCATx0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:53:26 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41414 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCATx0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 14:53:26 -0500
Received: by mail-il1-f194.google.com with SMTP id q13so1302314ile.8
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HCmIwNuzUD6yP8iFrajY7XtXpRYXRvP6RjQs5H1FhEE=;
        b=d2IjRCcjuvyFyojaK+epEscxZM4skoGU0ARYCTwiiiBKxJ3JXwdn/w1sE83U8ha9sl
         K1Iqz+iwfgjueF7CDdn2dEZRPbHr5+usnKA2+9vDebi/sH74rS0671LuJ+BcIHpSP4ku
         JExcMZMoQ3KYQmPNuE337rL0EYoyFK6dm5zx68BsrqvGUFSgivhAn9lhsb3TUeSASVld
         VDuDLJPI3iSoYPAVKVz5ZGJdnqchI+ytSnP2l08Aojt1LsiWzkVYqDkhQahvXtyoaumX
         l51PGQO436XMhuWaHLwoYlPQ08O5sbfiiDM4/x/bCKOgMrHUT5QSfjnDHDcpWY8Dmw/o
         vUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HCmIwNuzUD6yP8iFrajY7XtXpRYXRvP6RjQs5H1FhEE=;
        b=G07NR7oC9c30odpc7zFKqz69i/jdOPrLO8Xr18EsXonu456YDW1WuPFCOYgjJ1IFsQ
         rokrbSisEBBQDn6Oer0g1YJHg4WgGJqyEqQfFpFkPto+/w6nB5P8+XHaHXn297/sHrAP
         mdhTbKFmqwxYpVp3llj6tXeZElErklh5zCOEUXHT/yatLvgAJHG1r0PIPYPdoDrNuXR8
         Ct8jRKR6+jD4sQTEnvCN7PgA/EjVJHlhXfcsBB1UqVApZpRdZ74wqy9ZIvUI3D/hM2Nt
         ekOBL41vrA+bIseyjUGypGLET6jhBYXnIeMr88y0wbImvjdn5I5B4y2DlZN/nzUN3MC1
         LMqg==
X-Gm-Message-State: APjAAAVO3bEJ/zruIMEd9CNf0ofdzHhWkf+LTJPGOmCwPuvxhk2nzgu+
        suLVTH1Gd+4pciblIsv5AhWZNi3iG0yPc1IQ9EZCSQ==
X-Google-Smtp-Source: APXvYqwSqfq9QXo3WnxLlOV0uP8tLUzAzWYILdzDMBqfQcwhNUbxb3yS5WWxHlTSPRjnb311iJwXYRLWjE6cubW7zo0=
X-Received: by 2002:a92:5cc7:: with SMTP id d68mr6672852ilg.163.1583092404924;
 Sun, 01 Mar 2020 11:53:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
In-Reply-To: <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 1 Mar 2020 13:53:14 -0600
Message-ID: <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 1, 2020 at 1:25 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > If libsepol is older than version 3.0, the required routine
> > sepol_policydb_optimize will not be present. Use pkg-config to get the
> > modversion and check that it is 3.0 or higher.
> >
> > This can manifest as a compilation issue:
> > direct_api.c: In function =E2=80=98semanage_direct_commit=E2=80=99:
> > direct_api.c:1466:13: error: implicit declaration of function =E2=80=98=
sepol_policydb_optimize=E2=80=99; did you mean =E2=80=98sepol_policydb_to_i=
mage=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >      retval =3D sepol_policydb_optimize(out);
> >
> > Which is not really clear on how to check.
>
> >From my point of view, this kind of dependency management is something
> that is more suited in a package management system than in a Makefile.
> It makes sense to check for libsepol version if there is some kind of
> optional features that gets enabled according to it (in a similar way
> as a --with-... statement in build systems using autoconf) or if there
> is a fall back to another compatible source code (and the Makefile
> would "route" the building process to the right .c file). But these
> reasons do not match what you are doing in this change.

Since we don't use autotools, selinux makefiles have to be smarter. We
already use
PKG_CONFIG to get various flags, which would normally be handled in a
configure script, which if we had autotools, would also be a place to check
dependency versions.

>
> Why do you need this patch, instead of stating in the package to use
> for libsemanage that it depends on libsepol>=3D3.0?

We should document that as well, but make software smarter, not people.
If we can provide a better error message, without a huge burden of
work or maintenance
I always vote to do it. In this case, it's pretty simple to do, since
we already have the infrastructure for
PKG_CONFIG in the Makefiles.

>
> Thanks,
> Nicolas
>
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsemanage/src/Makefile | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index f6780dc6048e..a329797fe1cc 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -65,6 +65,14 @@ SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir .=
/
> >
> >  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
> >
> > +sepol-version-check:
> > +       @v=3D$$($(PKG_CONFIG) --modversion libsepol); \
> > +       major=3D$$(echo "$$v" | cut -d"." -f 1-1); \
> > +       if [ "$$major" -lt 3 ]; then \
> > +               >&2 echo "libsepol is required to be version 3.0 or hig=
her, got: $$v"; \
> > +               exit 1; \
> > +       fi
> > +
> >  all: $(LIBA) $(LIBSO) $(LIBPC)
> >
> >  pywrap: all $(SWIGSO)
> > @@ -83,12 +91,12 @@ $(SWIGSO): $(SWIGLOBJ)
> >  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> >         $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RU=
BYLIBS)
> >
> > -$(LIBA): $(OBJS)
> > -       $(AR) rcs $@ $^
> > +$(LIBA): sepol-version-check $(OBJS)
> > +       $(AR) rcs $@ $(filter-out $<,$^)
> >         $(RANLIB) $@
> >
> > -$(LIBSO): $(LOBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -ls=
elinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.map,-z,def=
s
> > +$(LIBSO): sepol-version-check $(LOBJS)
> > +       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(filter-out $<,$^) -l=
sepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibse=
manage.map,-z,defs
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > @@ -163,4 +171,4 @@ distclean: clean
> >  indent:
> >         ../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[c=
h]))
> >
> > -.PHONY: all clean pywrap rubywrap swigify install install-pywrap insta=
ll-rubywrap distclean
> > +.PHONY: all clean pywrap rubywrap swigify install install-pywrap insta=
ll-rubywrap distclean sepol-version-check
> > --
> > 2.17.1
> >
>
