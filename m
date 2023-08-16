Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E112C41513
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjHPRlb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbjHPRlK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:41:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF42710
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:41:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so103077561fa.1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207663; x=1692812463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fukqSx29IXRqaxnZaIdodrQQ+YfLU6ymVKN7W8vamj4=;
        b=XtlMjnVxIaRAnSkzV1idwUk0trEodmlVJ7+uXKBn/JR/6+QVZK12iUzj5kjlz4LQpH
         Ttg8fULzvRV4p4tLJlTFo691iHhi2aHwvXw7naZdngqru1f8K8kw8VFEq4DOf8/zI8VT
         ZwIhJ7kvq/+9QwEeyYqSOPgGSuiicjfWT4b6Fo14R4FN0DP0uORxunIF2NH4G2c26ccV
         aS+ix/NLDUb2a1nWJ3Jdy6uFM641d1iD+I81syN6PwmZakiGGRjujHxH8KmlzQn3DSaC
         pJLrXtjiWwVnOpSxR4r2Z/+mQcUQ/2bbt3/SMJ+HdMvA1wQvK5ywQvDI/cc5yuuxIdWy
         DODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207663; x=1692812463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fukqSx29IXRqaxnZaIdodrQQ+YfLU6ymVKN7W8vamj4=;
        b=bWK03N6qC+SkEmGA1Y7xC6T83pYfBcpj3WIOV2RVqjpF/UUfb2UY0NuU5jTE/y5lQa
         0Tkr89K4TH4lUgrXL3Zk3H3ihcGFqYD82ALdn9DsjFokJMESnYrLXdu5hJQCYmkjpGvQ
         MWesRnGWwdcfInohpqAULg7PplKYMsPBRW05MK1P87wjvilC0Bz8D+VHWroXwzy+sK7W
         01Dlrf8cIhjLfVAeb08BRIMkwWJ6rpaAnxu+uQ91mKala9AkXaOG3rI1npczuGQnqW1H
         VbZGfScrewXY/UUwI+n1884RDQzHR3f5sS1kkpfftD19i6vK+HXMuO91fuFeucSs/BKC
         X3BA==
X-Gm-Message-State: AOJu0YxHR+eAVNFgroVFW4iDs0XMVMape1wTjo8N8Ivxy3Hd0c1kHep4
        V5CSJfjrxJnsABtmy2WBhSRCHt4Avg+JNdcx8a1WNoCn
X-Google-Smtp-Source: AGHT+IF26xBS0Bf45gB5eGUqgLjnm4x5GL3rGfHMfgiZdtjUqop+NBL91kjzF30fxj1r0OvihMmHWGTB2X3Msl412Cg=
X-Received: by 2002:a2e:3c18:0:b0:2bb:7b85:2a01 with SMTP id
 j24-20020a2e3c18000000b002bb7b852a01mr2187372lja.31.1692207662786; Wed, 16
 Aug 2023 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814142516.505390-1-jwcart2@gmail.com> <87pm3obv5w.fsf@redhat.com>
In-Reply-To: <87pm3obv5w.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 13:40:51 -0400
Message-ID: <CAP+JOzTaEAkO0-zb9tZU47bbHpGzO8y7eLRPy2Yi+=J_AOtygg@mail.gmail.com>
Subject: Re: [PATCH] Do not automatically install Russian translations
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 15, 2023 at 3:51=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Since they are being removed, there will be nothing to install.
> >
> > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> Thanks!
>
>
> > ---
> >  checkpolicy/Makefile                     | 2 +-
> >  gui/Makefile                             | 2 +-
> >  libselinux/man/Makefile                  | 2 +-
> >  libsemanage/man/Makefile                 | 2 +-
> >  libsepol/man/Makefile                    | 2 +-
> >  mcstrans/man/Makefile                    | 2 +-
> >  policycoreutils/load_policy/Makefile     | 2 +-
> >  policycoreutils/man/Makefile             | 2 +-
> >  policycoreutils/newrole/Makefile         | 2 +-
> >  policycoreutils/run_init/Makefile        | 2 +-
> >  policycoreutils/scripts/Makefile         | 2 +-
> >  policycoreutils/secon/Makefile           | 2 +-
> >  policycoreutils/semodule/Makefile        | 2 +-
> >  policycoreutils/sestatus/Makefile        | 2 +-
> >  policycoreutils/setfiles/Makefile        | 2 +-
> >  policycoreutils/setsebool/Makefile       | 2 +-
> >  python/audit2allow/Makefile              | 2 +-
> >  python/chcat/Makefile                    | 2 +-
> >  python/semanage/Makefile                 | 2 +-
> >  python/sepolicy/Makefile                 | 2 +-
> >  restorecond/Makefile                     | 2 +-
> >  sandbox/Makefile                         | 2 +-
> >  semodule-utils/semodule_expand/Makefile  | 2 +-
> >  semodule-utils/semodule_link/Makefile    | 2 +-
> >  semodule-utils/semodule_package/Makefile | 2 +-
> >  25 files changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index f9e1fc7c..c37e0310 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -1,7 +1,7 @@
> >  #
> >  # Makefile for building the checkpolicy program
> >  #
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/gui/Makefile b/gui/Makefile
> > index 4035fb21..b29610d4 100644
> > --- a/gui/Makefile
> > +++ b/gui/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  SHAREDIR ?=3D $(PREFIX)/share/system-config-selinux
> > diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> > index 4b3626d2..fdc0825f 100644
> > --- a/libselinux/man/Makefile
> > +++ b/libselinux/man/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX       ?=3D /usr
> >  MANDIR ?=3D  $(PREFIX)/share/man
> >  MAN3SUBDIR ?=3D man3
> > diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
> > index f626447d..5e21a65e 100644
> > --- a/libsemanage/man/Makefile
> > +++ b/libsemanage/man/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  MANDIR ?=3D  $(PREFIX)/share/man
> >  MAN3SUBDIR ?=3D man3
> > diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
> > index f54e478d..0b410c19 100644
> > --- a/libsepol/man/Makefile
> > +++ b/libsepol/man/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  MANDIR ?=3D  $(PREFIX)/share/man
> >  MAN3SUBDIR ?=3D man3
> > diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
> > index 71713818..895a592d 100644
> > --- a/mcstrans/man/Makefile
> > +++ b/mcstrans/man/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  MANDIR ?=3D  $(PREFIX)/share/man
> >  MAN5SUBDIR ?=3D man5
> > diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/loa=
d_policy/Makefile
> > index c1ba805b..ad80d500 100644
> > --- a/policycoreutils/load_policy/Makefile
> > +++ b/policycoreutils/load_policy/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefil=
e
> > index 94bbf586..a4539f24 100644
> > --- a/policycoreutils/man/Makefile
> > +++ b/policycoreutils/man/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  MANDIR ?=3D $(PREFIX)/share/man
> >  MAN5DIR ?=3D $(MANDIR)/man5
> > diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole=
/Makefile
> > index b3ccf671..4b8145d3 100644
> > --- a/policycoreutils/newrole/Makefile
> > +++ b/policycoreutils/newrole/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_in=
it/Makefile
> > index e86364a4..619ebc1d 100644
> > --- a/policycoreutils/run_init/Makefile
> > +++ b/policycoreutils/run_init/Makefile
> > @@ -1,6 +1,6 @@
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts=
/Makefile
> > index 75e75b80..6d8196c6 100644
> > --- a/policycoreutils/scripts/Makefile
> > +++ b/policycoreutils/scripts/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Mak=
efile
> > index 576a6203..440503a1 100644
> > --- a/policycoreutils/secon/Makefile
> > +++ b/policycoreutils/secon/Makefile
> > @@ -1,5 +1,5 @@
> >  # secon tool - command-line context
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodu=
le/Makefile
> > index 73801e48..9fbf99d6 100644
> > --- a/policycoreutils/semodule/Makefile
> > +++ b/policycoreutils/semodule/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestat=
us/Makefile
> > index 3dbb792b..aebf050c 100644
> > --- a/policycoreutils/sestatus/Makefile
> > +++ b/policycoreutils/sestatus/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  SBINDIR ?=3D $(PREFIX)/sbin
> > diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfil=
es/Makefile
> > index d7670a8f..84ffb08b 100644
> > --- a/policycoreutils/setfiles/Makefile
> > +++ b/policycoreutils/setfiles/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D /sbin
> >  MANDIR =3D $(PREFIX)/share/man
> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setse=
bool/Makefile
> > index c1440c1c..fc5b4ff6 100644
> > --- a/policycoreutils/setsebool/Makefile
> > +++ b/policycoreutils/setsebool/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> > index 76bf4e37..fb04b8bd 100644
> > --- a/python/audit2allow/Makefile
> > +++ b/python/audit2allow/Makefile
> > @@ -2,7 +2,7 @@ PYTHON ?=3D python3
> >  SECILC ?=3D secilc
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> > index e4873bf4..7b3ee17f 100644
> > --- a/python/chcat/Makefile
> > +++ b/python/chcat/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > index b53ee33d..628d135a 100644
> > --- a/python/semanage/Makefile
> > +++ b/python/semanage/Makefile
> > @@ -1,7 +1,7 @@
> >  PYTHON ?=3D python3
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index 4e9e93d0..1a26cfdc 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -1,7 +1,7 @@
> >  PYTHON ?=3D python3
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/restorecond/Makefile b/restorecond/Makefile
> > index 8e9a5ef1..1ddfcc92 100644
> > --- a/restorecond/Makefile
> > +++ b/restorecond/Makefile
> > @@ -1,7 +1,7 @@
> >  PKG_CONFIG ?=3D pkg-config
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> > diff --git a/sandbox/Makefile b/sandbox/Makefile
> > index 84cb5a39..360a8bc5 100644
> > --- a/sandbox/Makefile
> > +++ b/sandbox/Makefile
> > @@ -1,7 +1,7 @@
> >  PYTHON ?=3D python3
> >
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  SYSCONFDIR ?=3D /etc/sysconfig
> >  BINDIR ?=3D $(PREFIX)/bin
> > diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/s=
emodule_expand/Makefile
> > index e63dcff2..ad776b15 100644
> > --- a/semodule-utils/semodule_expand/Makefile
> > +++ b/semodule-utils/semodule_expand/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/sem=
odule_link/Makefile
> > index c5cf69cd..936d161c 100644
> > --- a/semodule-utils/semodule_link/Makefile
> > +++ b/semodule-utils/semodule_link/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/=
semodule_package/Makefile
> > index 680ab836..6a289f73 100644
> > --- a/semodule-utils/semodule_package/Makefile
> > +++ b/semodule-utils/semodule_package/Makefile
> > @@ -1,5 +1,5 @@
> >  # Installation directories.
> > -LINGUAS ?=3D ru
> > +LINGUAS ?=3D
> >  PREFIX ?=3D /usr
> >  BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> > --
> > 2.41.0
>
