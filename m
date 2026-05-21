Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1B3C2B9B
	for <selinux@vger.kernel.org>; Fri, 22 May 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408012; cv=pass; b=eFPkyk+qbZgTVRRSb6aMfwofYZh6r+QP4Xcruq2asijfs3xVLaKM2m4dWLwqKYhs4Nn3pPBgjSBL0ksCqx4DAixmgi1lf41Wh6O1J9R01qoHx/635BaiH4/gaa5KV/8QZNGq4YNi0HyKJi2rH8bmaa576pUVh6hYm9e2ZEfZ1Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408012; c=relaxed/simple;
	bh=bgdWJYZzEDEO0+OQNOkQW9VSSBY0Dj2FxVNaaLDhEJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/RkTJYCKrs3e9rT66a9HEB6U3eAX4nXFUNjCA00MKK9974qKHbYbmI99pPYj13s886grDys6mgMpejpY6be/49fA1e56xQUQJqOO8AqgUotRiCtAcCsBIWE7Z14xBI8tl87BSZ9Aai1TlXj+AWS5xXVl3Duu0hXQfBW6BedTBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXIGW5Fh; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXIGW5Fh"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516d1ddcdf4so2641cf.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 17:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779408009; cv=none;
        d=google.com; s=arc-20240605;
        b=W+vhWzTLjEgAGz3cFEIu80QCtoD2gczMh6nQQ2V5juYf/mSA+mwq2NNdWaDNXpab57
         IOTWnHGYQnF2L0fxr1i3Iy8R4XlxRAmkq4tHXiBhfFn917+89sKgiYZ7e+IIpiCNm/3d
         WEM6KC/SzHNYDJptLEPGCyiO9Qx7Z9U+bq1DaWeebW4ohWOOgH5fblFEUiJcTB1lihfe
         nvwYw19x0fGfWNn+fdV9lWcRIUehNzWghC8blg/dVxrd1LO5/MvuhUOXHAv6JBjpLvs9
         QintW6d+06JObCfPcOeNLXkiNOaQ308+NFkCNB/kZFT8yjdczr8nDmAB1w5EMNIeX6Rk
         BSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gB5uBIWdGjEUaSE3vAwyq2WMdPq2JzbHmC4OcXQzphc=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=DxLyFYU40lceK4SXXnbcMf0Y9KxEh0o/N3ZZTm399GHOZv5YfjaPaQNHeytfgMs28b
         8PxxLdJwiIY8uVCphAQhRjsqWBMU50laxEAO2kQP1jjpVksA4yACTT43TabYU4+Iljqm
         OTYVOoYOosrjFUJ5vrPuV9uxV0m0JtljsGZ8cQPq3JC/p8Tk0Nhp7cFOylyFEa8PiW7m
         WEcNJ0V7QQhKrHeV+gH+UV9HWihwqusl3dQDbQPkng/J8xNqBN6/swZ4eMjuB9guUZ8t
         8D8McLHGi3FaxsAz4eiQZGHlnqpQbn/coNvcVCA3ANUDOZibyjaJn49Maft4jNPYF4KN
         AOlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779408009; x=1780012809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB5uBIWdGjEUaSE3vAwyq2WMdPq2JzbHmC4OcXQzphc=;
        b=NXIGW5FhQwptE7M9SnD5+52Mcz9a+QCxNQ6lkKd3bHjPZ9/1K6WpS1+GiONTVn1pbo
         uAjvENxRRWk2a3lSvLMOmobXDDR41cSF3nZDpb7nRbkYFbRtCtSrduSS1NMHDVsoPRUq
         K1yp1yPJNDkCRNnz2f+mrkO+TzMtjCSC3a0hGIdKKVgv4j7VU22xfgxsLb2os73N1Oyk
         c3wUmdnEBJyhDVd/qc6wo16khoWZsG0S/1lmM8n8dj3SZ1x21xZNwIK6vZMWgyCtxQgh
         Z6YaQoj+vYnHjxatN1CBXIBttFbyEsxf6cKjC2WukZR1bi41LV1krEIewss3Pa0TBl1D
         8Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779408009; x=1780012809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gB5uBIWdGjEUaSE3vAwyq2WMdPq2JzbHmC4OcXQzphc=;
        b=SNCU6F43QResNPBLCdmC4FOp13xerxGpdLRVb9rfeU00uN+IhJkqg1QmvpomDwzOmx
         fF8xdre6X72od2RRbWlOuHTcj8BZO6vbyX7i15WmBx4h9hfIfxOwslzVSXxKHbutprFa
         feRGa8cyKc1dZfzWs99RFo8DmUTXnYymxjYPPjphX3JPIrC6hJjfdYZ4DuO5hqZh7+jJ
         MbxHal9FRuKn4VXxv5tkm6zyuvGAOmzIxZJYv6dhQqUowrLo8SdN+WteuEl4GDEIyrqc
         gUKZP0gRzM78aloO5xZLs5dYNmMWTW+7A6iAe+jpeSssrLa3A5bhhmjaPJC4TOM2BPKQ
         Xtug==
X-Gm-Message-State: AOJu0YyItygaIqRRQn/MUxS2NOKKeSlFxguPiis8ow/aa1AC/iqSLdQu
	0rMhK+LFKmegYUxXXaUo4oGof3P2rI93AWXCsCKAaEEbYlz8WX8camwCPF0FBter43XUliTzRgx
	uCtGKBco+QO1TsCad3xcXcfiCOaw3P1u+/bA/Z73f
X-Gm-Gg: Acq92OERuFxkdmtFAKgTVErntD1pkZ3owtNkVmHxI9OY+3TmoBm5x/CNOh1UduGViyW
	RThZIYMOPu9qwML2DbvvjsK/L8H2QgJgJLoDz9u6NpvfFW+Hh9387XjyJLJlRokCJhFfAWZntjJ
	FNhNgo31CXcFD2IHCvZyISqx9iqI5F8whzUBaeqDZDm+aWpOlERcESRCUtP5U0L6JVve7u86yx6
	0U6TBL76Zzz0KCk67KSg2eNM5W2JA3lEVsoJtAOan6gvbOR4ZdMmbjJsKgwkAtuVH5ERwJkisG4
	PAlt6/9ytPIRqX9+377eivFHw8w17EMjI1D1Hwfg/S/YXKbGRdYu55hVbGOHAvqx439RrGmZ1Mf
	rJg==
X-Received: by 2002:ac8:7d46:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-516d7c18b07mr489351cf.9.1779408005892; Thu, 21 May 2026
 17:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com> <20260427195546.91395-3-jwcart2@gmail.com>
In-Reply-To: <20260427195546.91395-3-jwcart2@gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 22 May 2026 09:59:48 +1000
X-Gm-Features: AVHnY4JJDaNc4LsjkhgmcxIYdD_xbViUMPcxUMdkUu97JYMK_XOKv5wvTli6u4s
Message-ID: <CA+zpnLf6Od_mM-T57zYjK9wQnO+hwpDZEqbc41jr0anK9Mgmtg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] secilc: Add program that checks CIL neverallow
 rules against a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 5:56=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the program secilcheck that takes a binary policy and one or
> more CIL files and checks the binary policy against the neverallow
> rules in the CIL policy.
>
> ex/
> secilcheck policy.bin neverallows.cil
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  secilc/.gitignore       |   2 +
>  secilc/Makefile         |  20 ++-
>  secilc/secilcheck.8.xml |  81 +++++++++++
>  secilc/secilcheck.c     | 301 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 402 insertions(+), 2 deletions(-)
>  create mode 100644 secilc/secilcheck.8.xml
>  create mode 100644 secilc/secilcheck.c
>
> diff --git a/secilc/.gitignore b/secilc/.gitignore
> index d2a3daf1..9a5f45e0 100644
> --- a/secilc/.gitignore
> +++ b/secilc/.gitignore
> @@ -4,6 +4,8 @@ secil2conf
>  secil2conf.8
>  secil2tree
>  secil2tree.8
> +secilcheck
> +secilcheck.8
>  policy.*
>  file_contexts
>  docs/html
> diff --git a/secilc/Makefile b/secilc/Makefile
> index ef7bc8cd..ebcc9d7c 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -14,9 +14,14 @@ SECIL2TREE =3D secil2tree
>  SECIL2TREE_SRCS :=3D secil2tree.c
>  SECIL2TREE_OBJS :=3D $(patsubst %.c,%.o,$(SECIL2TREE_SRCS))
>
> +SECILCHECK =3D secilcheck
> +SECILCHECK_SRCS :=3D secilcheck.c
> +SECILCHECK_OBJS :=3D $(patsubst %.c,%.o,$(SECILCHECK_SRCS))
> +
>  SECILC_MANPAGE =3D secilc.8
>  SECIL2CONF_MANPAGE =3D secil2conf.8
>  SECIL2TREE_MANPAGE =3D secil2tree.8
> +SECILCHECK_MANPAGE =3D secilcheck.8
>  XMLTO =3D xmlto
>  DIFF =3D diff
>
> @@ -28,7 +33,7 @@ CFLAGS ?=3D -Wall -Wshadow -Wextra -Wundef -Wmissing-fo=
rmat-attribute -Wcast-align
>  override CFLAGS +=3D -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
>  override LDLIBS +=3D -lsepol
>
> -all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
> +all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) $(SECILCHECK) man
>
>  $(SECILC): $(SECILC_OBJS)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> @@ -45,7 +50,10 @@ $(SECIL2CONF): $(SECIL2CONF_OBJS)
>  $(SECIL2TREE): $(SECIL2TREE_OBJS)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
> -man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
> +$(SECILCHECK): $(SECILCHECK_OBJS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +
> +man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE) $(SEC=
ILCHECK_MANPAGE)
>
>  $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
>         $(XMLTO) man $(SECILC_MANPAGE).xml
> @@ -56,15 +64,20 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
>  $(SECIL2TREE_MANPAGE): $(SECIL2TREE_MANPAGE).xml
>         $(XMLTO) man $(SECIL2TREE_MANPAGE).xml
>
> +$(SECILCHECK_MANPAGE): $(SECILCHECK_MANPAGE).xml
> +       $(XMLTO) man $(SECILCHECK_MANPAGE).xml
> +
>  install: all man
>         -mkdir -p $(DESTDIR)$(BINDIR)
>         -mkdir -p $(DESTDIR)$(MANDIR)/man8
>         install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
>         install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
>         install -m 755 $(SECIL2TREE) $(DESTDIR)$(BINDIR)
> +       install -m 755 $(SECILCHECK) $(DESTDIR)$(BINDIR)
>         install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
>         install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
>         install -m 644 $(SECIL2TREE_MANPAGE) $(DESTDIR)$(MANDIR)/man8
> +       install -m 644 $(SECILCHECK_MANPAGE) $(DESTDIR)$(MANDIR)/man8
>
>  doc:
>         $(MAKE) -C docs
> @@ -76,11 +89,14 @@ clean:
>         rm -f $(SECIL2CONF_OBJS)
>         rm -f $(SECIL2TREE)
>         rm -f $(SECIL2TREE_OBJS)
> +       rm -f $(SECILCHECK)
> +       rm -f $(SECILCHECK_OBJS)
>         rm -f policy.*
>         rm -f file_contexts
>         rm -f $(SECILC_MANPAGE)
>         rm -f $(SECIL2CONF_MANPAGE)
>         rm -f $(SECIL2TREE_MANPAGE)
> +       rm -f $(SECILCHECK_MANPAGE)
>         rm -f opt-actual.cil
>         rm -f opt-actual.bin
>         $(MAKE) -C docs clean
> diff --git a/secilc/secilcheck.8.xml b/secilc/secilcheck.8.xml
> new file mode 100644
> index 00000000..004e6ccd
> --- /dev/null
> +++ b/secilc/secilcheck.8.xml
> @@ -0,0 +1,81 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> +               "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
> +
> +<refentry>
> +   <refentryinfo>
> +      <author>
> +         <firstname>James</firstname><surname>Carter</surname><contrib><=
/contrib>
> +      </author>
> +   </refentryinfo>
> +
> +   <refmeta>
> +      <refentrytitle>SECILCHECK</refentrytitle>
> +      <manvolnum>8</manvolnum>
> +      <refmiscinfo class=3D"date">27 April 2026</refmiscinfo>
> +      <refmiscinfo class=3D"source">secilcheck</refmiscinfo>
> +      <refmiscinfo class=3D"manual">Check binary policy file against CIL=
 neverallow files</refmiscinfo>
> +   </refmeta>
> +   <refnamediv id=3D"name">
> +      <refname>secilcheck</refname>
> +      <refpurpose>invoke the CIL neverallow checker</refpurpose>
> +   </refnamediv>
> +
> +   <refsynopsisdiv id=3D"synopsis">
> +      <cmdsynopsis>
> +        <command>secilcheck</command>
> +          <arg choice=3D"opt" rep=3D"repeat"><replaceable>OPTION</replac=
eable></arg>
> +          <arg choice=3D"plain"><replaceable>binary</replaceable></arg>
> +          <arg choice=3D"plain" rep=3D"repeat"><replaceable>file</replac=
eable></arg>
> +      </cmdsynopsis>
> +   </refsynopsisdiv>
> +
> +   <refsect1 id=3D"description"><title>DESCRIPTION</title>
> +      <para><emphasis role=3D"italic">secilcheck</emphasis> invokes the =
CIL neverallow checker with specified <emphasis role=3D"italic">argument</e=
mphasis>s.</para>
> +   </refsect1>
> +
> +   <refsect1 id=3D"options"><title>OPTIONS</title>
> +      <variablelist>
> +         <varlistentry>
> +            <term><option>-Q, --qualified-names</option></term>
> +            <listitem><para>Allow names containing dots (qualified names=
). Blocks, blockinherits, blockabstracts, and in-statements will not be all=
owed.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-m, --multiple-decls</option></term>
> +            <listitem><para>Allow some statements to be re-declared.</pa=
ra></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-v, --verbose</option></term>
> +            <listitem><para>Increment verbosity level.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-h, --help</option></term>
> +            <listitem><para>Display usage information.</para></listitem>
> +         </varlistentry>
> +      </variablelist>
> +   </refsect1>
> +
> +   <refsect1 id=3D"see_also"><title>SEE ALSO</title>
> +      <para>
> +      <simplelist type=3D"inline">
> +         <member><citerefentry>
> +            <refentrytitle>secilc</refentrytitle>
> +            <manvolnum>8</manvolnum>
> +         </citerefentry></member>
> +         <member><citerefentry>
> +            <refentrytitle>secil2tree</refentrytitle>
> +            <manvolnum>8</manvolnum>
> +         </citerefentry></member>
> +         <member><citerefentry>
> +            <refentrytitle>secil2conf</refentrytitle>
> +            <manvolnum>8</manvolnum>
> +         </citerefentry></member>
> +      </simplelist>
> +      </para>
> +      <para>HTML documentation describing the CIL language statements is=
 available starting with <emphasis role=3D"italic">docs/html/index.html</em=
phasis>.</para>
> +      <para>PDF documentation describing the CIL language statements is =
available at: <emphasis role=3D"italic">docs/pdf/CIL_Reference_Guide.pdf</e=
mphasis>.</para>
> +   </refsect1>
> +</refentry>
> diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> new file mode 100644
> index 00000000..874f6544
> --- /dev/null
> +++ b/secilc/secilcheck.c
> @@ -0,0 +1,301 @@
> +/*
> + * Copyright 2011 Tresys Technology, LLC. All rights reserved.

Update the date? Is that the correct header here?

> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions ar=
e met:
> + *
> + *    1. Redistributions of source code must retain the above copyright =
notice,
> + *       this list of conditions and the following disclaimer.
> + *
> + *    2. Redistributions in binary form must reproduce the above copyrig=
ht notice,
> + *       this list of conditions and the following disclaimer in the doc=
umentation
> + *       and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY=
 EXPRESS
> + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WAR=
RANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. =
IN NO
> + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY =
DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (I=
NCLUDING,
> + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS=
 OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY=
 THEORY OF
> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING =
NEGLIGENCE
> + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVE=
N IF
> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * The views and conclusions contained in the software and documentation=
 are those
> + * of the authors and should not be interpreted as representing official=
 policies,
> + * either expressed or implied, of Tresys Technology, LLC.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>

I had to add unistd.h for close(2) below.

> +
> +#ifdef ANDROID
> +#include <cil/cil.h>
> +#else
> +#include <sepol/cil/cil.h>
> +#endif
> +#include <sepol/policydb.h>
> +#include <sepol/kernel_to_cil.h>
> +
> +static int get_binary_policy_db(const char *filename, sepol_policydb_t *=
pdb)
> +{
> +       int fd;
> +       struct stat sb;
> +       void *map =3D NULL;
> +       sepol_policy_file_t *pf =3D NULL;
> +       int rc =3D SEPOL_ERR;
> +
> +       /* Read binary policy */
> +       fd =3D open(filename, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "Could not open file: %s\n", filename);
> +               goto exit;
> +       }
> +       if (fstat(fd, &sb) < 0) {
> +               fprintf(stderr, "Could not stat file: %s\n", filename);
> +               goto exit;
> +       }
> +       map =3D mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVAT=
E, fd, 0);
> +       if (map =3D=3D MAP_FAILED) {
> +               fprintf(stderr, "Could not map file: %s\n", filename);
> +               goto exit;
> +       }
> +
> +       if (sepol_policy_file_create(&pf) < 0) {
> +               fprintf(stderr, "Out of memory");
> +               goto exit;
> +       }
> +       sepol_policy_file_set_mem(pf, map, sb.st_size);
> +
> +       if (sepol_policydb_read(pdb, pf) < 0) {
> +               fprintf(stderr,"Error reading binary policy: %s\n", filen=
ame);
> +               sepol_policydb_free(pdb);
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
> +       rc =3D SEPOL_OK;
> +
> +exit:
> +       if (fd >=3D 0)
> +               close(fd);
> +       if (map)
> +               munmap(map, sb.st_size);
> +       sepol_policy_file_free(pf);
> +       return rc;
> +}
> +
> +static int add_decls_to_cil(const char *filename, sepol_policydb_t *pdb,=
 struct cil_db *db)
> +{
> +       FILE *cfp =3D NULL;
> +       char *cptr =3D NULL;
> +       size_t csize;
> +       int rc =3D SEPOL_ERR;
> +
> +       cfp =3D open_memstream(&cptr, &csize);
> +       if (!cfp) {
> +               fprintf(stderr, "Failed to open dynamic memory buffer str=
eam\n");
> +               goto exit;
> +       }
> +
> +       if (sepol_kernel_policydb_decls_to_cil(cfp, &pdb->p) < 0) {
> +               fprintf(stderr, "Failed to convert binary policy to CIL\n=
");
> +               goto exit;
> +       }
> +
> +       if (fflush(cfp) < 0) {
> +               fprintf(stderr, "Failed to flush CIL memory buffer stream=
\n");
> +               goto exit;
> +       }
> +
> +       /* Add to CIL db */
> +       if (cil_add_file(db, filename, cptr, csize) < 0) {
> +               fprintf(stderr, "Failed to add binary policy file: %s\n",=
 filename);
> +               goto exit;
> +       }
> +
> +       rc =3D 0;
> +
> +exit:
> +       if (cfp)
> +               fclose(cfp);
> +       if (cptr)
> +               free(cptr);
> +       return rc;
> +}
> +
> +static int add_cil_file(const char *filename, struct cil_db *cdb)
> +{
> +       FILE *file;
> +       struct stat filedata;
> +       char *buffer =3D NULL;
> +       size_t file_size;
> +       int rc =3D -1;
> +
> +       file =3D fopen(filename, "r");
> +       if (!file) {
> +               fprintf(stderr, "Could not open file: %s\n", filename);
> +               goto exit;
> +       }
> +       if (stat(filename, &filedata) < 0) {
> +               fprintf(stderr, "Could not stat file: %s\n", filename);
> +               goto exit;
> +       }
> +       file_size =3D filedata.st_size;
> +
> +       if (!file_size) {
> +               fclose(file);
> +               rc =3D 0;
> +               goto exit;
> +       }
> +
> +       buffer =3D malloc(file_size);
> +       if (!buffer) {
> +               fprintf(stderr, "Out of memory\n");
> +               goto exit;
> +       }
> +
> +       if (fread(buffer, file_size, 1, file) !=3D 1) {
> +               fprintf(stderr, "Failure reading file: %s\n", filename);
> +               goto exit;
> +       }
> +
> +       if (cil_add_file(cdb, filename, buffer, file_size) < 0) {
> +               fprintf(stderr, "Failure adding %s\n", filename);
> +               goto exit;
> +       }
> +
> +       rc =3D 0;
> +
> +exit:
> +       if (file)
> +               fclose(file);
> +       if (buffer)
> +               free(buffer);
> +       return rc;
> +}
> +
> +static __attribute__((__noreturn__)) void usage(const char *prog)
> +{
> +       printf("Usage: %s [OPTION]... BIN_POLICY CIL_NEVERALLOW_FILE1...\=
n", prog);
> +       printf("\n");
> +       printf("Options:\n");
> +       printf("  -Q, --qualified-names          Allow names containing d=
ots (qualified names).\n");
> +       printf("                                 Blocks, blockinherits, b=
lockabstracts, and\n");
> +       printf("                                 in-statements will not b=
e allowed.\n");
> +       printf("  -m, --multiple-decls           allow some statements to=
 be re-declared\n");
> +       printf("  -v, --verbose                  increment verbosity leve=
l\n");
> +       printf("  -h, --help                     display usage informatio=
n\n");
> +       exit(1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int rc =3D SEPOL_ERR;
> +       sepol_policydb_t *pdb =3D NULL;
> +       int violation =3D 0;
> +       struct cil_db *db =3D NULL;
> +       int multiple_decls =3D 0;
> +       int qualified_names =3D 0;
> +       int opt_char;
> +       int opt_index =3D 0;
> +       enum cil_log_level log_level =3D CIL_ERR;
> +       static struct option long_opts[] =3D {
> +               {"help", no_argument, 0, 'h'},
> +               {"verbose", no_argument, 0, 'v'},
> +               {"multiple-decls", no_argument, 0, 'm'},
> +               {"qualified-names", no_argument, 0, 'Q'},
> +               {0, 0, 0, 0}
> +       };
> +
> +       while (1) {
> +               opt_char =3D getopt_long(argc, argv, "hvQm", long_opts, &=
opt_index);
> +               if (opt_char =3D=3D -1) {
> +                       break;
> +               }
> +               switch (opt_char) {
> +                       case 'v':
> +                               log_level++;
> +                               break;
> +                       case 'm':
> +                               multiple_decls =3D 1;
> +                               break;
> +                       case 'Q':
> +                               qualified_names =3D 1;
> +                               break;
> +                       case 'h':
> +                               usage(argv[0]);
> +                       case '?':
> +                               break;
> +                       default:
> +                                       fprintf(stderr, "Unsupported opti=
on: %s\n", optarg);
> +                               usage(argv[0]);
> +               }
> +       }
> +
> +       if (argc < optind + 2) {
> +               fprintf(stderr, "Not enough files specified\n");
> +               usage(argv[0]);
> +       }
> +
> +       cil_set_log_level(log_level);
> +
> +       cil_db_init(&db);
> +       cil_set_multiple_decls(db, multiple_decls);
> +       cil_set_qualified_names(db, qualified_names);
> +
> +       if (sepol_policydb_create(&pdb) < 0) {
> +               fprintf(stderr, "Out of memory\n");
> +               goto exit;
> +       }
> +       if (get_binary_policy_db(argv[optind], pdb) < 0) {
> +               fprintf(stderr, "Failed to get binary policy db\n");
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +       if (add_decls_to_cil(argv[optind], pdb, db) < 0) {
> +               fprintf(stderr, "Failed to convert decls to CIL\n");
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +       optind++;
> +
> +       do {
> +               if (add_cil_file(argv[optind], db) < 0) {
> +                       fprintf(stderr, "Failed to add cil file to CIL fi=
les\n");
> +                       rc =3D SEPOL_ERR;
> +                       goto exit;
> +               }
> +               optind++;
> +       } while (optind < argc);
> +
> +       rc =3D cil_compile(db);
> +       if (rc !=3D SEPOL_OK) {
> +               fprintf(stderr, "Failed to compile cildb: %d\n", rc);
> +               goto exit;
> +       }
> +
> +       rc =3D cil_check_neverallows_against_pdb(db, &pdb->p, &violation)=
;
> +       if (rc !=3D SEPOL_OK) {
> +               fprintf(stderr, "Failed to complete neverallow checking\n=
");
> +               goto exit;
> +       }
> +       if (violation =3D=3D 1) {
> +               fprintf(stderr, "There was a neverallow violation\n");
> +               rc =3D SEPOL_ERR;
> +       }
> +
> +       rc =3D SEPOL_OK;
> +
> +exit:
> +       cil_db_destroy(&db);
> +       sepol_policydb_free(pdb);
> +       return rc;
> +}
> --
> 2.53.0
>
