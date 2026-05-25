Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A777083C
	for <selinux@vger.kernel.org>; Mon, 25 May 2026 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779669413; cv=pass; b=qJ4+BI2M6vIpYwkk2na9bcdsN8dXcRbt2UPqLWP6mY5nCCiKzSHhKdoTldanzk4hqCwVdQPuW1dMDX2C/m/HVt97nJfmbXzg6Gsgq7ur2A0OQkNQMnTM7BsHclGWPy9uCP/mvsQEjq9ouKO5CXOm1bKnR7HpVlWxG7daAqBSKtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779669413; c=relaxed/simple;
	bh=2qrgDN/bBMdQRg9l4KfM/gFB7cu1tJxDosamRpFzYqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuZ9BzeO8FfmA0Dz9hYkr9Cw3V1/kP2KUiNREMhts4fHxyrJv7hikRK/93PLGa36OWG4pbpYYuMhDVF4oWKlPUW0FOm31wMySyymQJnK5ucs8qgzA1WjcsAeoQUup5zE+gQbEblLAV03CUhDoY9/AgKfQt3N75gPs502fOkV8sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYlTHlfF; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYlTHlfF"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d6009380so2071cf.0
        for <selinux@vger.kernel.org>; Sun, 24 May 2026 17:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779669411; cv=none;
        d=google.com; s=arc-20240605;
        b=a/2nU/sHgeF3zvkka4K/nWI0zx1C21o+NnkCTben+zUWkgnL3EA+0Q615k80KT3mH9
         KIFDpzeFmrS5tq2/Po1V1dJnqxMtc0Fz0yrXCNMLBw2np0od4RV8r7oU6jkU+a94fdT4
         6OEmrBs6ANXzGCzwAH0yz1p+/OSVjLq0udFGMTwG94fN93AppIwet0h0AnV6boJOodPA
         nLKTMRTDXtmERqsyz7vtqRgLMgwNiu8tkyNo/9N8pD4Z6YwQNvkm9kTBAl629FCwKcu/
         53HbZ1ToksOdecKbTF7/4AmgGmH9XfgCO8yqhijgA9aoNC/kL5gzi0SYd/V805z5KYs0
         IPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nv3BfyoqNEGY/PdKeSr9wTOUCsbRUgR0jRxdNOgknjE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=TPwxis5Q8ERaJkhDh3V6YU1Rsr8vJkoYlEAARmNAvFYxiPUHonHhnLUxa2Ys874F7G
         V0cSWPBqnAaaZI0KRt7F2dDWD2mzxFmOGyRKIHtc5APdd3pmzI1CF+rwV6oqA85qb9wB
         KF7mlCzrmV1hR3HObmJ8w7RpnSLORZqTbGhIoh3yyivNUy9yg8V/kKoabseDmvB52dKg
         wr5EHJxXrxygOHbDWQ6CFscIevSzdyzVaUj5TXPdJQGQC3dBfJHYDWRJVoBgp4uIGU6K
         RMwB2J2qcgqJHaM2nEi889oD+cX0um2EPLEHcY6m7tkZQBky1xShQZ7Or8nOVJkb7I+W
         yyoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779669411; x=1780274211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv3BfyoqNEGY/PdKeSr9wTOUCsbRUgR0jRxdNOgknjE=;
        b=fYlTHlfFgPVxqH/BzssH4Ye3h0XonPeCwYtWTOat6Y5eZLxV4lTHl6asYdzsYtw5lg
         0wWnpNt/YvvDFp+qiZuemuBGuIcv9xzYhot+KtM6ONC0V97fDUhLWXYiWmfds+iNABpl
         JSdTGcUDh5/1h3j/iLkqvLXsEZOwWvueXSkr4fTmI+ypH5W2F9DmeogtlzrH+W76tRrX
         ueVsnc7/uhCJ6EMaLrUl5aot+yK+97M9Dk6JA2SwYGEK28HXQXTlTUULyUrPzmmHMPVE
         eYnJ4A27mDiEMGrqI6BLt/r9hzNuk9y6qXgA/TTZZ0/ZLAmq18cOBuGk01Qr+O5HeX8V
         aCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779669411; x=1780274211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nv3BfyoqNEGY/PdKeSr9wTOUCsbRUgR0jRxdNOgknjE=;
        b=blsn+eHlkJZED3vhHDHop7srBquHcpOo5Cwsu5HLlgDTVhqGF81Nd/F08YzxFRupA1
         Dw6GZuZWq4haN8K9DjAC7qaDYOZjHd21DjtZtl3KTruPPumG1JuPsaANbpwQrjbsy4mY
         e6lUkPnSnO95UNRWBg0FBmLVwGy3Dmpe1L2Em+KierGj2IJY7vmgg368Hr1pejEa/mM3
         FTNIQ7bzlgyXMwShIGyj3N2/wkM3MuefFUBJ1pgS36n2upJQMwBemsjigHzVvro63um+
         /tpOU8VxmVJRNVx7XzESQ14ml2tBDBejQQHpYxcDtrxIE/nmd1LgZTKIGG0ooNA4sdTs
         AIqw==
X-Gm-Message-State: AOJu0YyjX8emjw9j8shwIVOFdSKST11ivA7Wyh9vGe/CfgUJpiE3oLPH
	GH/hQosuAV4zPJ7obgrCd38GStDdaRffnxy5cKsurPhz+S+TuLf8BmUuqOoX+6nYkbijpJn0Nf+
	zjm3+J9PUkWrxtoYuRxf5xiijDJp6GBwN10xxRj0ZphldtBEjb1LNWi46
X-Gm-Gg: Acq92OETyWalLdPpt+CcjREOvyJ4M/3eqoSQWSua2d30gpeH8muzcqugga56mnZuus3
	rM3I5XQ2+nhiTOEcK+ic4D9Wah1YYX9PFCjg7gFipgkAphIWYSzV5S0LK/P995P3UEi4KTQVu+n
	R0I/yUIWL/qITrMwi0iXA/I3AETwYeffNIGZDxFRqUPdPQctiBJM2ZdgC8rqO4+pfV8L2jxyO4h
	LlQ61YM0Jm/5jDGsVkhxnOOiLPfR17SrN4jMahvsc2i116hr4lMfspaivWampKFvdoEI3Kw1n+K
	kJPfC9DItDr3qqPlI7DWek5jJHljPbjV8W/BZPCjBuUo2I7gKuK31lHbb8kymeZWpoXKJn9wPNS
	fBvL3UiCJOFWV
X-Received: by 2002:ac8:6a1a:0:b0:516:3b3c:1df2 with SMTP id
 d75a77b69052e-516e0dbbc51mr10440761cf.14.1779669410251; Sun, 24 May 2026
 17:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com> <20260427195546.91395-3-jwcart2@gmail.com>
 <CA+zpnLf6Od_mM-T57zYjK9wQnO+hwpDZEqbc41jr0anK9Mgmtg@mail.gmail.com> <CAP+JOzT1BOkpwiF_B6kb18scQOL5Ys+Tm+pg4HMTNL8_ZN9Sfw@mail.gmail.com>
In-Reply-To: <CAP+JOzT1BOkpwiF_B6kb18scQOL5Ys+Tm+pg4HMTNL8_ZN9Sfw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 25 May 2026 10:36:32 +1000
X-Gm-Features: AVHnY4LM0Mx9SZ-1OXQ059se0v-at7ouhDhKSsAsfkJaOvpEXrvSvbSfFhFyraY
Message-ID: <CA+zpnLcSQrhaR83D+4mchgLr=W3LucUnfZaYTy3e3mQwQOE69A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] secilc: Add program that checks CIL neverallow
 rules against a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:31=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, May 21, 2026 at 8:00=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > On Tue, Apr 28, 2026 at 5:56=E2=80=AFAM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > Add the program secilcheck that takes a binary policy and one or
> > > more CIL files and checks the binary policy against the neverallow
> > > rules in the CIL policy.
> > >
> > > ex/
> > > secilcheck policy.bin neverallows.cil
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >  secilc/.gitignore       |   2 +
> > >  secilc/Makefile         |  20 ++-
> > >  secilc/secilcheck.8.xml |  81 +++++++++++
> > >  secilc/secilcheck.c     | 301 ++++++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 402 insertions(+), 2 deletions(-)
> > >  create mode 100644 secilc/secilcheck.8.xml
> > >  create mode 100644 secilc/secilcheck.c
> > >
> > > diff --git a/secilc/.gitignore b/secilc/.gitignore
> > > index d2a3daf1..9a5f45e0 100644
> > > --- a/secilc/.gitignore
> > > +++ b/secilc/.gitignore
> > > @@ -4,6 +4,8 @@ secil2conf
> > >  secil2conf.8
> > >  secil2tree
> > >  secil2tree.8
> > > +secilcheck
> > > +secilcheck.8
> > >  policy.*
> > >  file_contexts
> > >  docs/html
> > > diff --git a/secilc/Makefile b/secilc/Makefile
> > > index ef7bc8cd..ebcc9d7c 100644
> > > --- a/secilc/Makefile
> > > +++ b/secilc/Makefile
> > > @@ -14,9 +14,14 @@ SECIL2TREE =3D secil2tree
> > >  SECIL2TREE_SRCS :=3D secil2tree.c
> > >  SECIL2TREE_OBJS :=3D $(patsubst %.c,%.o,$(SECIL2TREE_SRCS))
> > >
> > > +SECILCHECK =3D secilcheck
> > > +SECILCHECK_SRCS :=3D secilcheck.c
> > > +SECILCHECK_OBJS :=3D $(patsubst %.c,%.o,$(SECILCHECK_SRCS))
> > > +
> > >  SECILC_MANPAGE =3D secilc.8
> > >  SECIL2CONF_MANPAGE =3D secil2conf.8
> > >  SECIL2TREE_MANPAGE =3D secil2tree.8
> > > +SECILCHECK_MANPAGE =3D secilcheck.8
> > >  XMLTO =3D xmlto
> > >  DIFF =3D diff
> > >
> > > @@ -28,7 +33,7 @@ CFLAGS ?=3D -Wall -Wshadow -Wextra -Wundef -Wmissin=
g-format-attribute -Wcast-align
> > >  override CFLAGS +=3D -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> > >  override LDLIBS +=3D -lsepol
> > >
> > > -all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
> > > +all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) $(SECILCHECK) man
> > >
> > >  $(SECILC): $(SECILC_OBJS)
> > >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > > @@ -45,7 +50,10 @@ $(SECIL2CONF): $(SECIL2CONF_OBJS)
> > >  $(SECIL2TREE): $(SECIL2TREE_OBJS)
> > >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > >
> > > -man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
> > > +$(SECILCHECK): $(SECILCHECK_OBJS)
> > > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > > +
> > > +man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE) $=
(SECILCHECK_MANPAGE)
> > >
> > >  $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
> > >         $(XMLTO) man $(SECILC_MANPAGE).xml
> > > @@ -56,15 +64,20 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
> > >  $(SECIL2TREE_MANPAGE): $(SECIL2TREE_MANPAGE).xml
> > >         $(XMLTO) man $(SECIL2TREE_MANPAGE).xml
> > >
> > > +$(SECILCHECK_MANPAGE): $(SECILCHECK_MANPAGE).xml
> > > +       $(XMLTO) man $(SECILCHECK_MANPAGE).xml
> > > +
> > >  install: all man
> > >         -mkdir -p $(DESTDIR)$(BINDIR)
> > >         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> > >         install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
> > >         install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
> > >         install -m 755 $(SECIL2TREE) $(DESTDIR)$(BINDIR)
> > > +       install -m 755 $(SECILCHECK) $(DESTDIR)$(BINDIR)
> > >         install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> > >         install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> > >         install -m 644 $(SECIL2TREE_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> > > +       install -m 644 $(SECILCHECK_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> > >
> > >  doc:
> > >         $(MAKE) -C docs
> > > @@ -76,11 +89,14 @@ clean:
> > >         rm -f $(SECIL2CONF_OBJS)
> > >         rm -f $(SECIL2TREE)
> > >         rm -f $(SECIL2TREE_OBJS)
> > > +       rm -f $(SECILCHECK)
> > > +       rm -f $(SECILCHECK_OBJS)
> > >         rm -f policy.*
> > >         rm -f file_contexts
> > >         rm -f $(SECILC_MANPAGE)
> > >         rm -f $(SECIL2CONF_MANPAGE)
> > >         rm -f $(SECIL2TREE_MANPAGE)
> > > +       rm -f $(SECILCHECK_MANPAGE)
> > >         rm -f opt-actual.cil
> > >         rm -f opt-actual.bin
> > >         $(MAKE) -C docs clean
> > > diff --git a/secilc/secilcheck.8.xml b/secilc/secilcheck.8.xml
> > > new file mode 100644
> > > index 00000000..004e6ccd
> > > --- /dev/null
> > > +++ b/secilc/secilcheck.8.xml
> > > @@ -0,0 +1,81 @@
> > > +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > > +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> > > +               "http://www.oasis-open.org/docbook/xml/4.2/docbookx.d=
td">
> > > +
> > > +<refentry>
> > > +   <refentryinfo>
> > > +      <author>
> > > +         <firstname>James</firstname><surname>Carter</surname><contr=
ib></contrib>
> > > +      </author>
> > > +   </refentryinfo>
> > > +
> > > +   <refmeta>
> > > +      <refentrytitle>SECILCHECK</refentrytitle>
> > > +      <manvolnum>8</manvolnum>
> > > +      <refmiscinfo class=3D"date">27 April 2026</refmiscinfo>
> > > +      <refmiscinfo class=3D"source">secilcheck</refmiscinfo>
> > > +      <refmiscinfo class=3D"manual">Check binary policy file against=
 CIL neverallow files</refmiscinfo>
> > > +   </refmeta>
> > > +   <refnamediv id=3D"name">
> > > +      <refname>secilcheck</refname>
> > > +      <refpurpose>invoke the CIL neverallow checker</refpurpose>
> > > +   </refnamediv>
> > > +
> > > +   <refsynopsisdiv id=3D"synopsis">
> > > +      <cmdsynopsis>
> > > +        <command>secilcheck</command>
> > > +          <arg choice=3D"opt" rep=3D"repeat"><replaceable>OPTION</re=
placeable></arg>
> > > +          <arg choice=3D"plain"><replaceable>binary</replaceable></a=
rg>
> > > +          <arg choice=3D"plain" rep=3D"repeat"><replaceable>file</re=
placeable></arg>
> > > +      </cmdsynopsis>
> > > +   </refsynopsisdiv>
> > > +
> > > +   <refsect1 id=3D"description"><title>DESCRIPTION</title>
> > > +      <para><emphasis role=3D"italic">secilcheck</emphasis> invokes =
the CIL neverallow checker with specified <emphasis role=3D"italic">argumen=
t</emphasis>s.</para>
> > > +   </refsect1>
> > > +
> > > +   <refsect1 id=3D"options"><title>OPTIONS</title>
> > > +      <variablelist>
> > > +         <varlistentry>
> > > +            <term><option>-Q, --qualified-names</option></term>
> > > +            <listitem><para>Allow names containing dots (qualified n=
ames). Blocks, blockinherits, blockabstracts, and in-statements will not be=
 allowed.</para></listitem>
> > > +         </varlistentry>
> > > +
> > > +         <varlistentry>
> > > +            <term><option>-m, --multiple-decls</option></term>
> > > +            <listitem><para>Allow some statements to be re-declared.=
</para></listitem>
> > > +         </varlistentry>
> > > +
> > > +         <varlistentry>
> > > +            <term><option>-v, --verbose</option></term>
> > > +            <listitem><para>Increment verbosity level.</para></listi=
tem>
> > > +         </varlistentry>
> > > +
> > > +         <varlistentry>
> > > +            <term><option>-h, --help</option></term>
> > > +            <listitem><para>Display usage information.</para></listi=
tem>
> > > +         </varlistentry>
> > > +      </variablelist>
> > > +   </refsect1>
> > > +
> > > +   <refsect1 id=3D"see_also"><title>SEE ALSO</title>
> > > +      <para>
> > > +      <simplelist type=3D"inline">
> > > +         <member><citerefentry>
> > > +            <refentrytitle>secilc</refentrytitle>
> > > +            <manvolnum>8</manvolnum>
> > > +         </citerefentry></member>
> > > +         <member><citerefentry>
> > > +            <refentrytitle>secil2tree</refentrytitle>
> > > +            <manvolnum>8</manvolnum>
> > > +         </citerefentry></member>
> > > +         <member><citerefentry>
> > > +            <refentrytitle>secil2conf</refentrytitle>
> > > +            <manvolnum>8</manvolnum>
> > > +         </citerefentry></member>
> > > +      </simplelist>
> > > +      </para>
> > > +      <para>HTML documentation describing the CIL language statement=
s is available starting with <emphasis role=3D"italic">docs/html/index.html=
</emphasis>.</para>
> > > +      <para>PDF documentation describing the CIL language statements=
 is available at: <emphasis role=3D"italic">docs/pdf/CIL_Reference_Guide.pd=
f</emphasis>.</para>
> > > +   </refsect1>
> > > +</refentry>
> > > diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> > > new file mode 100644
> > > index 00000000..874f6544
> > > --- /dev/null
> > > +++ b/secilc/secilcheck.c
> > > @@ -0,0 +1,301 @@
> > > +/*
> > > + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
> >
> > Update the date? Is that the correct header here?
>
> Since I work for the government, everything that I create is actually
> in the public domain. We can contribute to code released under open
> source licenses, but we can't create it.
> Since this was derived from the secilc.c code, I just kept the
> copyright notice. That is my usual practice.
>
> I know there is a lot of duplicate code. One of my long-term todo
> items is to pull out the common code from the various programs in the
> secilc directory.
>

No worries. Thanks for sharing the context. I think the duplication is
fine for now.
