Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577402459EA
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424559; cv=pass; b=F4lce44K2ZXA/Ev3hMfApZBQ/F2PV2n+qiKSzDSkjewp5YcZwWOYSHa1yAb2EaKYlYtHBEnlqpMD0TiBuSOhnMhi1IDmzpYwmSpl7N46uicGoAEJGP45tv7miWwfi4ODU4kD2ZWVqXfBrLwNcuZxksx8WKFbzXcZ+ScdGmZHNhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424559; c=relaxed/simple;
	bh=mo3WG3AjLDjhAkBKHFgzJCnYOKsG3fBDhLdVBOx5rFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdY5Ve7LOd/rCUYV9yKlKSXlI4HIwyBck8JGbLDiDJNFmVvKxrASZuFv1oIayAdzzDQgxnFqTLmkn4ZCddYUOsEKzgDHUTZaHzQoMr2fcdJLoYEqnsz2fjvELBazlDZTvampROT1IBXns0m0uSXBp+c5YwEBcFIDiJqtKAps1yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdPZuRtX; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdPZuRtX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso19882525ad.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424557; cv=none;
        d=google.com; s=arc-20240605;
        b=E7/gkGvxvNuVpf0NTGXV6/gR4GhNZpFwj7UCGVYYde46rPZnKZg+iWGRTHqZzyOAJ8
         Tk25uckhDnk6Z4vlsOzXzsqsLbBwmxUiDVl62aGCxVHU8N/zl6lSgQ15+u5gLREykshu
         tApbFmdOJ/8JDFaEoqHDx0aVwy9gOm9c9MfhseU7pUAfifmEjzfQGx1ra5FTfSRTZ8C5
         DMeLuM98iqOjdJFjoS5dkBZNqO1PlZ3mBYfKw7DYv/pe0+H5g1GZ6oHjbPfAyyhS8tA6
         nJCuLGNd7tHEdKcYFBaYHhDSL8fcDXnlNyWO8ODhGqkdCLkKwdDKJxAZDBgzg31uRnf5
         oDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnhcfmLZ83YzmSgrx5I2dJbVdq2SbyAD60ZUTcS+ZTs=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=I49m1DJKR9VbWiPeZhl8jHhPKYqDrFGLJ6GL3uOMsk7yRmXBHt4eg9yK6PNIfP95ih
         bZtltUTtj/ktKVoup7HFMWOkt22wnhLLwkHCibnBCZlrDFYzds7D/HOsOapxiGt4DEX4
         DNI3ACpREE19nZwN+SgbrdonAyU4BS4cp5ACscAj3aEw16DD7oxMlDLrDdMw9KoW0v1l
         z931cEF120nOCrLe43Xc7RbrMeNh/yy3AbMd1ymYo2FVcUdpyl1a/CnJsmzMNVpo7Ctb
         C9mIBzE0vw6atlH/VapqR2EwISxBOaaYrRt7KSksCjeWUc2pbWA6kgV5+300jKkH2O8f
         Oirw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780424557; x=1781029357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnhcfmLZ83YzmSgrx5I2dJbVdq2SbyAD60ZUTcS+ZTs=;
        b=QdPZuRtXfaZhsNE44DHujxKn5GDd++6FqWdmJy8GxAGtIiqpHLkdDIfY64NzBzcDDh
         WRdmb022oma2IDIgQ2NQmbY4Q0TFykzX2pgFtLjZ1MesyktSCqzL20jBHCKc91eph5Qs
         sZnGHP45OygPHQiUZxUQtsvMlsC7TUSDni7DAZDpI83jTVrdtva6rd14yIB+8+mh7zM2
         6m5WwMB0tX806Da24u14zq8IJ2390IztcX4ksYcVZK2Eex3JkSnAsI3UfGuPNeKJHPoR
         vRn4GrOLeQtwGv5ODtVFKVzoe8Lw+aC2fnJ/llsx+HWr3t2KYICAXqrvfH4KeohS9DnS
         9ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424557; x=1781029357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnhcfmLZ83YzmSgrx5I2dJbVdq2SbyAD60ZUTcS+ZTs=;
        b=D12Yme9Uh4LYvyaJnh+PqRBxtSwmRp9fjd7Do5qc7IsHUBIrnTqcc6G8/bvQ+h61dZ
         /2UpOHtBAbER4RdHqhKYiNIJbGRb2t/2f9k3uqG0QbkD9mtbHi4qzKV1wk9/1vbZ7rFj
         tUeIYpk2idDn7tQ7iZ4+E+DYIa6Opav6DvaiNAXr1rz7T6B6CUtRvWCxLBB59+JUPOj7
         uL/FW+Wvqmo+V7y9S3AvfWMXqCOV6lpG2452m7kxm8BbQIar2VX2d4EhPczD3RsOtc3h
         HvBuFhnFEiDqbu46WnKVjwe/uBWWjN88yF/G9stk8JU1UTljmeJ7HfEcl2QwATe1TRgZ
         NaXw==
X-Gm-Message-State: AOJu0YwD4TkG1xERpR9iO7tINU+xK6bI/nbXAxVadftyAYN498Fbe/gL
	ss85T3N9M5mDZ2emzk8AUEXDUzxnzpUtPYqCtILpHQ5uGvakruOvfBlJsBA98SnD9sgkmDVpZP0
	wDX+j5TbCHiZffzsAnkyyE3Au5BbbgV8fOw==
X-Gm-Gg: Acq92OH+2iDnK6Cy113Q7PcKOLeRN6/KcEQhij+RxeF/IigGBXvyT40IFAuxSAKa85W
	eCXyzI7mWHGNjEwdjJDpORRFMbod+pISInIYrOKqvlhoybSwDXopy4bUKZi5iwq6w/dUz1XbYe8
	b/ALRY4JZ4MAoWMlbMn0F+lqGUEhLCU7rqqUIlcjzuUD6nyerp9JjlhWknUQ2MOtZeG+LLUbgKu
	m8iMvNTVCJWso2mB8CtHf6Yi4e2Gqq/H79yDm+NM+FDY21CeGJt0AG6FilGIziAF1Z9VETQuRvd
	fwir4VmVQLyAukI+pA==
X-Received: by 2002:a17:902:f610:b0:2c0:c389:d99c with SMTP id
 d9443c01a7336-2c0c389dd89mr143801485ad.15.1780424556400; Tue, 02 Jun 2026
 11:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com> <20260602153309.157348-3-jwcart2@gmail.com>
 <CAEjxPJ7NyYz8fXbiEGdhBMPcckRTk6OuzS+fsPNO_W=SuZCYWg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7NyYz8fXbiEGdhBMPcckRTk6OuzS+fsPNO_W=SuZCYWg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:22:25 -0400
X-Gm-Features: AVHnY4JtaA2JWPGKtPS3-BpFenL4vITWRZntHBtXlMDxnBBXdh5Be_iTdDNVDno
Message-ID: <CAEjxPJ68-SUdABNeRsX1GZXv_scQFSGJWY2YZDU5bTa4B-ZCXA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] secilc: Add program that checks CIL neverallows
 against a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 2:10=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 2, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Add the program secilcheck that takes a binary policy and one or
> > more CIL files and checks for violations in the binary policy using
> > the neverallow and neverallowx rules from the CIL policy.
> >
> > ex/
> > secilcheck policy.bin neverallows.cil
> >
> > The CIL neverallow and neverallowx rules must only use types, classes,
> > and permissions that are declared in the binary policy.
> >
> > This is planned on being used in Android to validate policies from
> > partners against the standard AOSP assertions as part of the
> > Compatibility Test Suite.
> >
> > Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

All three merged.

>
> > ---
> > v2: Added more explanation to the commit msg
> >     Added the header unistd.h
> >
> >  secilc/.gitignore       |   2 +
> >  secilc/Makefile         |  20 ++-
> >  secilc/secilcheck.8.xml |  81 +++++++++++
> >  secilc/secilcheck.c     | 302 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 403 insertions(+), 2 deletions(-)
> >  create mode 100644 secilc/secilcheck.8.xml
> >  create mode 100644 secilc/secilcheck.c
> >
> > diff --git a/secilc/.gitignore b/secilc/.gitignore
> > index d2a3daf1..9a5f45e0 100644
> > --- a/secilc/.gitignore
> > +++ b/secilc/.gitignore
> > @@ -4,6 +4,8 @@ secil2conf
> >  secil2conf.8
> >  secil2tree
> >  secil2tree.8
> > +secilcheck
> > +secilcheck.8
> >  policy.*
> >  file_contexts
> >  docs/html
> > diff --git a/secilc/Makefile b/secilc/Makefile
> > index ef7bc8cd..ebcc9d7c 100644
> > --- a/secilc/Makefile
> > +++ b/secilc/Makefile
> > @@ -14,9 +14,14 @@ SECIL2TREE =3D secil2tree
> >  SECIL2TREE_SRCS :=3D secil2tree.c
> >  SECIL2TREE_OBJS :=3D $(patsubst %.c,%.o,$(SECIL2TREE_SRCS))
> >
> > +SECILCHECK =3D secilcheck
> > +SECILCHECK_SRCS :=3D secilcheck.c
> > +SECILCHECK_OBJS :=3D $(patsubst %.c,%.o,$(SECILCHECK_SRCS))
> > +
> >  SECILC_MANPAGE =3D secilc.8
> >  SECIL2CONF_MANPAGE =3D secil2conf.8
> >  SECIL2TREE_MANPAGE =3D secil2tree.8
> > +SECILCHECK_MANPAGE =3D secilcheck.8
> >  XMLTO =3D xmlto
> >  DIFF =3D diff
> >
> > @@ -28,7 +33,7 @@ CFLAGS ?=3D -Wall -Wshadow -Wextra -Wundef -Wmissing-=
format-attribute -Wcast-align
> >  override CFLAGS +=3D -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> >  override LDLIBS +=3D -lsepol
> >
> > -all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
> > +all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) $(SECILCHECK) man
> >
> >  $(SECILC): $(SECILC_OBJS)
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > @@ -45,7 +50,10 @@ $(SECIL2CONF): $(SECIL2CONF_OBJS)
> >  $(SECIL2TREE): $(SECIL2TREE_OBJS)
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> > -man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
> > +$(SECILCHECK): $(SECILCHECK_OBJS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > +
> > +man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE) $(S=
ECILCHECK_MANPAGE)
> >
> >  $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
> >         $(XMLTO) man $(SECILC_MANPAGE).xml
> > @@ -56,15 +64,20 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
> >  $(SECIL2TREE_MANPAGE): $(SECIL2TREE_MANPAGE).xml
> >         $(XMLTO) man $(SECIL2TREE_MANPAGE).xml
> >
> > +$(SECILCHECK_MANPAGE): $(SECILCHECK_MANPAGE).xml
> > +       $(XMLTO) man $(SECILCHECK_MANPAGE).xml
> > +
> >  install: all man
> >         -mkdir -p $(DESTDIR)$(BINDIR)
> >         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> >         install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
> >         install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
> >         install -m 755 $(SECIL2TREE) $(DESTDIR)$(BINDIR)
> > +       install -m 755 $(SECILCHECK) $(DESTDIR)$(BINDIR)
> >         install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> >         install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> >         install -m 644 $(SECIL2TREE_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> > +       install -m 644 $(SECILCHECK_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> >
> >  doc:
> >         $(MAKE) -C docs
> > @@ -76,11 +89,14 @@ clean:
> >         rm -f $(SECIL2CONF_OBJS)
> >         rm -f $(SECIL2TREE)
> >         rm -f $(SECIL2TREE_OBJS)
> > +       rm -f $(SECILCHECK)
> > +       rm -f $(SECILCHECK_OBJS)
> >         rm -f policy.*
> >         rm -f file_contexts
> >         rm -f $(SECILC_MANPAGE)
> >         rm -f $(SECIL2CONF_MANPAGE)
> >         rm -f $(SECIL2TREE_MANPAGE)
> > +       rm -f $(SECILCHECK_MANPAGE)
> >         rm -f opt-actual.cil
> >         rm -f opt-actual.bin
> >         $(MAKE) -C docs clean
> > diff --git a/secilc/secilcheck.8.xml b/secilc/secilcheck.8.xml
> > new file mode 100644
> > index 00000000..279322a5
> > --- /dev/null
> > +++ b/secilc/secilcheck.8.xml
> > @@ -0,0 +1,81 @@
> > +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> > +               "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd=
">
> > +
> > +<refentry>
> > +   <refentryinfo>
> > +      <author>
> > +         <firstname>James</firstname><surname>Carter</surname><contrib=
></contrib>
> > +      </author>
> > +   </refentryinfo>
> > +
> > +   <refmeta>
> > +      <refentrytitle>SECILCHECK</refentrytitle>
> > +      <manvolnum>8</manvolnum>
> > +      <refmiscinfo class=3D"date">29 May 2026</refmiscinfo>
> > +      <refmiscinfo class=3D"source">secilcheck</refmiscinfo>
> > +      <refmiscinfo class=3D"manual">Check binary policy file against C=
IL neverallow files</refmiscinfo>
> > +   </refmeta>
> > +   <refnamediv id=3D"name">
> > +      <refname>secilcheck</refname>
> > +      <refpurpose>invoke the CIL neverallow checker</refpurpose>
> > +   </refnamediv>
> > +
> > +   <refsynopsisdiv id=3D"synopsis">
> > +      <cmdsynopsis>
> > +        <command>secilcheck</command>
> > +          <arg choice=3D"opt" rep=3D"repeat"><replaceable>OPTION</repl=
aceable></arg>
> > +          <arg choice=3D"plain"><replaceable>binary</replaceable></arg=
>
> > +          <arg choice=3D"plain" rep=3D"repeat"><replaceable>file</repl=
aceable></arg>
> > +      </cmdsynopsis>
> > +   </refsynopsisdiv>
> > +
> > +   <refsect1 id=3D"description"><title>DESCRIPTION</title>
> > +      <para><emphasis role=3D"italic">secilcheck</emphasis> invokes th=
e CIL neverallow checker with specified <emphasis role=3D"italic">argument<=
/emphasis>s.</para>
> > +   </refsect1>
> > +
> > +   <refsect1 id=3D"options"><title>OPTIONS</title>
> > +      <variablelist>
> > +         <varlistentry>
> > +            <term><option>-Q, --qualified-names</option></term>
> > +            <listitem><para>Allow names containing dots (qualified nam=
es). Blocks, blockinherits, blockabstracts, and in-statements will not be a=
llowed.</para></listitem>
> > +         </varlistentry>
> > +
> > +         <varlistentry>
> > +            <term><option>-m, --multiple-decls</option></term>
> > +            <listitem><para>Allow some statements to be re-declared.</=
para></listitem>
> > +         </varlistentry>
> > +
> > +         <varlistentry>
> > +            <term><option>-v, --verbose</option></term>
> > +            <listitem><para>Increment verbosity level.</para></listite=
m>
> > +         </varlistentry>
> > +
> > +         <varlistentry>
> > +            <term><option>-h, --help</option></term>
> > +            <listitem><para>Display usage information.</para></listite=
m>
> > +         </varlistentry>
> > +      </variablelist>
> > +   </refsect1>
> > +
> > +   <refsect1 id=3D"see_also"><title>SEE ALSO</title>
> > +      <para>
> > +      <simplelist type=3D"inline">
> > +         <member><citerefentry>
> > +            <refentrytitle>secilc</refentrytitle>
> > +            <manvolnum>8</manvolnum>
> > +         </citerefentry></member>
> > +         <member><citerefentry>
> > +            <refentrytitle>secil2tree</refentrytitle>
> > +            <manvolnum>8</manvolnum>
> > +         </citerefentry></member>
> > +         <member><citerefentry>
> > +            <refentrytitle>secil2conf</refentrytitle>
> > +            <manvolnum>8</manvolnum>
> > +         </citerefentry></member>
> > +      </simplelist>
> > +      </para>
> > +      <para>HTML documentation describing the CIL language statements =
is available starting with <emphasis role=3D"italic">docs/html/index.html</=
emphasis>.</para>
> > +      <para>PDF documentation describing the CIL language statements i=
s available at: <emphasis role=3D"italic">docs/pdf/CIL_Reference_Guide.pdf<=
/emphasis>.</para>
> > +   </refsect1>
> > +</refentry>
> > diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> > new file mode 100644
> > index 00000000..194f4943
> > --- /dev/null
> > +++ b/secilc/secilcheck.c
> > @@ -0,0 +1,302 @@
> > +/*
> > + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions =
are met:
> > + *
> > + *    1. Redistributions of source code must retain the above copyrigh=
t notice,
> > + *       this list of conditions and the following disclaimer.
> > + *
> > + *    2. Redistributions in binary form must reproduce the above copyr=
ight notice,
> > + *       this list of conditions and the following disclaimer in the d=
ocumentation
> > + *       and/or other materials provided with the distribution.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND A=
NY EXPRESS
> > + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED W=
ARRANTIES OF
> > + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED=
. IN NO
> > + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR AN=
Y DIRECT,
> > + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING,
> > + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LO=
SS OF USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY THEORY OF
> > + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDIN=
G NEGLIGENCE
> > + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, E=
VEN IF
> > + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *
> > + * The views and conclusions contained in the software and documentati=
on are those
> > + * of the authors and should not be interpreted as representing offici=
al policies,
> > + * either expressed or implied, of Tresys Technology, LLC.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <getopt.h>
> > +#include <fcntl.h>
> > +#include <sys/stat.h>
> > +#include <sys/mman.h>
> > +
> > +#ifdef ANDROID
> > +#include <cil/cil.h>
> > +#else
> > +#include <sepol/cil/cil.h>
> > +#endif
> > +#include <sepol/policydb.h>
> > +#include <sepol/kernel_to_cil.h>
> > +
> > +static int get_binary_policy_db(const char *filename, sepol_policydb_t=
 *pdb)
> > +{
> > +       int fd;
> > +       struct stat sb;
> > +       void *map =3D NULL;
> > +       sepol_policy_file_t *pf =3D NULL;
> > +       int rc =3D SEPOL_ERR;
> > +
> > +       /* Read binary policy */
> > +       fd =3D open(filename, O_RDONLY);
> > +       if (fd < 0) {
> > +               fprintf(stderr, "Could not open file: %s\n", filename);
> > +               goto exit;
> > +       }
> > +       if (fstat(fd, &sb) < 0) {
> > +               fprintf(stderr, "Could not stat file: %s\n", filename);
> > +               goto exit;
> > +       }
> > +       map =3D mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIV=
ATE, fd, 0);
> > +       if (map =3D=3D MAP_FAILED) {
> > +               fprintf(stderr, "Could not map file: %s\n", filename);
> > +               goto exit;
> > +       }
> > +
> > +       if (sepol_policy_file_create(&pf) < 0) {
> > +               fprintf(stderr, "Out of memory");
> > +               goto exit;
> > +       }
> > +       sepol_policy_file_set_mem(pf, map, sb.st_size);
> > +
> > +       if (sepol_policydb_read(pdb, pf) < 0) {
> > +               fprintf(stderr,"Error reading binary policy: %s\n", fil=
ename);
> > +               sepol_policydb_free(pdb);
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D SEPOL_OK;
> > +
> > +exit:
> > +       if (fd >=3D 0)
> > +               close(fd);
> > +       if (map)
> > +               munmap(map, sb.st_size);
> > +       sepol_policy_file_free(pf);
> > +       return rc;
> > +}
> > +
> > +static int add_decls_to_cil(const char *filename, sepol_policydb_t *pd=
b, struct cil_db *db)
> > +{
> > +       FILE *cfp =3D NULL;
> > +       char *cptr =3D NULL;
> > +       size_t csize;
> > +       int rc =3D SEPOL_ERR;
> > +
> > +       cfp =3D open_memstream(&cptr, &csize);
> > +       if (!cfp) {
> > +               fprintf(stderr, "Failed to open dynamic memory buffer s=
tream\n");
> > +               goto exit;
> > +       }
> > +
> > +       if (sepol_kernel_policydb_decls_to_cil(cfp, &pdb->p) < 0) {
> > +               fprintf(stderr, "Failed to convert binary policy to CIL=
\n");
> > +               goto exit;
> > +       }
> > +
> > +       if (fflush(cfp) < 0) {
> > +               fprintf(stderr, "Failed to flush CIL memory buffer stre=
am\n");
> > +               goto exit;
> > +       }
> > +
> > +       /* Add to CIL db */
> > +       if (cil_add_file(db, filename, cptr, csize) < 0) {
> > +               fprintf(stderr, "Failed to add binary policy file: %s\n=
", filename);
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D 0;
> > +
> > +exit:
> > +       if (cfp)
> > +               fclose(cfp);
> > +       if (cptr)
> > +               free(cptr);
> > +       return rc;
> > +}
> > +
> > +static int add_cil_file(const char *filename, struct cil_db *cdb)
> > +{
> > +       FILE *file;
> > +       struct stat filedata;
> > +       char *buffer =3D NULL;
> > +       size_t file_size;
> > +       int rc =3D -1;
> > +
> > +       file =3D fopen(filename, "r");
> > +       if (!file) {
> > +               fprintf(stderr, "Could not open file: %s\n", filename);
> > +               goto exit;
> > +       }
> > +       if (stat(filename, &filedata) < 0) {
> > +               fprintf(stderr, "Could not stat file: %s\n", filename);
> > +               goto exit;
> > +       }
> > +       file_size =3D filedata.st_size;
> > +
> > +       if (!file_size) {
> > +               fclose(file);
> > +               rc =3D 0;
> > +               goto exit;
> > +       }
> > +
> > +       buffer =3D malloc(file_size);
> > +       if (!buffer) {
> > +               fprintf(stderr, "Out of memory\n");
> > +               goto exit;
> > +       }
> > +
> > +       if (fread(buffer, file_size, 1, file) !=3D 1) {
> > +               fprintf(stderr, "Failure reading file: %s\n", filename)=
;
> > +               goto exit;
> > +       }
> > +
> > +       if (cil_add_file(cdb, filename, buffer, file_size) < 0) {
> > +               fprintf(stderr, "Failure adding %s\n", filename);
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D 0;
> > +
> > +exit:
> > +       if (file)
> > +               fclose(file);
> > +       if (buffer)
> > +               free(buffer);
> > +       return rc;
> > +}
> > +
> > +static __attribute__((__noreturn__)) void usage(const char *prog)
> > +{
> > +       printf("Usage: %s [OPTION]... BIN_POLICY CIL_NEVERALLOW_FILE1..=
.\n", prog);
> > +       printf("\n");
> > +       printf("Options:\n");
> > +       printf("  -Q, --qualified-names          Allow names containing=
 dots (qualified names).\n");
> > +       printf("                                 Blocks, blockinherits,=
 blockabstracts, and\n");
> > +       printf("                                 in-statements will not=
 be allowed.\n");
> > +       printf("  -m, --multiple-decls           allow some statements =
to be re-declared\n");
> > +       printf("  -v, --verbose                  increment verbosity le=
vel\n");
> > +       printf("  -h, --help                     display usage informat=
ion\n");
> > +       exit(1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       int rc =3D SEPOL_ERR;
> > +       sepol_policydb_t *pdb =3D NULL;
> > +       int violation =3D 0;
> > +       struct cil_db *db =3D NULL;
> > +       int multiple_decls =3D 0;
> > +       int qualified_names =3D 0;
> > +       int opt_char;
> > +       int opt_index =3D 0;
> > +       enum cil_log_level log_level =3D CIL_ERR;
> > +       static struct option long_opts[] =3D {
> > +               {"help", no_argument, 0, 'h'},
> > +               {"verbose", no_argument, 0, 'v'},
> > +               {"multiple-decls", no_argument, 0, 'm'},
> > +               {"qualified-names", no_argument, 0, 'Q'},
> > +               {0, 0, 0, 0}
> > +       };
> > +
> > +       while (1) {
> > +               opt_char =3D getopt_long(argc, argv, "hvQm", long_opts,=
 &opt_index);
> > +               if (opt_char =3D=3D -1) {
> > +                       break;
> > +               }
> > +               switch (opt_char) {
> > +                       case 'v':
> > +                               log_level++;
> > +                               break;
> > +                       case 'm':
> > +                               multiple_decls =3D 1;
> > +                               break;
> > +                       case 'Q':
> > +                               qualified_names =3D 1;
> > +                               break;
> > +                       case 'h':
> > +                               usage(argv[0]);
> > +                       case '?':
> > +                               break;
> > +                       default:
> > +                                       fprintf(stderr, "Unsupported op=
tion: %s\n", optarg);
> > +                               usage(argv[0]);
> > +               }
> > +       }
> > +
> > +       if (argc < optind + 2) {
> > +               fprintf(stderr, "Not enough files specified\n");
> > +               usage(argv[0]);
> > +       }
> > +
> > +       cil_set_log_level(log_level);
> > +
> > +       cil_db_init(&db);
> > +       cil_set_multiple_decls(db, multiple_decls);
> > +       cil_set_qualified_names(db, qualified_names);
> > +
> > +       if (sepol_policydb_create(&pdb) < 0) {
> > +               fprintf(stderr, "Out of memory\n");
> > +               goto exit;
> > +       }
> > +       if (get_binary_policy_db(argv[optind], pdb) < 0) {
> > +               fprintf(stderr, "Failed to get binary policy db\n");
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +       if (add_decls_to_cil(argv[optind], pdb, db) < 0) {
> > +               fprintf(stderr, "Failed to convert decls to CIL\n");
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +       optind++;
> > +
> > +       do {
> > +               if (add_cil_file(argv[optind], db) < 0) {
> > +                       fprintf(stderr, "Failed to add cil file to CIL =
files\n");
> > +                       rc =3D SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +               optind++;
> > +       } while (optind < argc);
> > +
> > +       rc =3D cil_compile(db);
> > +       if (rc !=3D SEPOL_OK) {
> > +               fprintf(stderr, "Failed to compile cildb: %d\n", rc);
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D cil_check_neverallows_against_pdb(db, &pdb->p, &violatio=
n);
> > +       if (rc !=3D SEPOL_OK) {
> > +               fprintf(stderr, "Failed to complete neverallow checking=
\n");
> > +               goto exit;
> > +       }
> > +       if (violation =3D=3D 1) {
> > +               fprintf(stderr, "There was a neverallow violation\n");
> > +               rc =3D SEPOL_ERR;
> > +       }
> > +
> > +       rc =3D SEPOL_OK;
> > +
> > +exit:
> > +       cil_db_destroy(&db);
> > +       sepol_policydb_free(pdb);
> > +       return rc;
> > +}
> > --
> > 2.54.0
> >
