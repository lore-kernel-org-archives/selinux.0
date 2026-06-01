Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465C36CE04
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314018; cv=pass; b=ILp+RTpU6riRKHPp5pyYXceyUBUQ6GiNIutOAIwGm8tOAAf4JQL2tAT0D6hxAyxCuKqGOl1ZIBxSvs5NCBLfTgjj7BboGz7DodA+G0JLSEEVqrT0MkxXSmMgM/jeEKz2sQZ9wQUlwwHEJ9nbUnt5TDrVNAQy3dkG/g8NL/NTnuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314018; c=relaxed/simple;
	bh=3Th1CP4IGsOAp04jFyTE3bK1caPOGoQtEpJjaeZ+MIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJs+LhG930GJPT9LlZsX6+RGk7hJ/TwNgsX6GtUGP3vXEIuJOyrjfj5H1yuzirnAiqPVsq4/vh/xBnqTMAlMwbhFpPGCFtrnMsbeFR6SZA9hSPIPuQ+AWhQ3mX/ZRIDpmk0mdMtOaVQpiN5uTZjGAxTd3Jlc1OIwFr6P1vUxhmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izr/00a1; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izr/00a1"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso1317788a12.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 04:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780314016; cv=none;
        d=google.com; s=arc-20240605;
        b=j+tOksUerCEcmUUlaNPaN6cr1Kl0XQMLKE2O7tD/4qzoNw8CzS8LRIji5jkp2DGU9n
         gXzYpixX3QQ2Ez8iQV6X9hk7117BmbJFd++Q43T2+lg4QGurLExZZMlXQ2VSDzWk0vtI
         aashzOFtH9Kjh+9LALSYiGkl7o69mbA8mWjEVYshtjwP7LKvGszbQJt8i51gKdE56cgY
         KPOpj/kM5tDceClbjypf/B2JK8AeIEXR2FlQJnJ7vdlQoyAtIiJt5phxC1+Tp7wnohMf
         p1bl5Ija6GNtYBM6jSrANikS+8h41MKCtOOG+xJJzGZSnOnW8fbN0hxAo14kuanRqhHm
         /KDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u107uVjg73SVFGhwoyflfz835sucwVPYXZhJAi5VGnQ=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=U/Vr4U0GH9AQexa6Nr0sYLYtbB7I/1j295qFfdFc8SD4y2YlnaG2/Uc85fekKah4RY
         iS0mC/+OvSq1C1/GBRaWYl7llyPryCDF/Lq7o4qnPFBtCx7JPIIbZ8saTUy44Zc74eIq
         w2hZrRnWQ3kmUenijIBkS687Ff4UqX95MXMJlZVCwQv6Vd1PSigzhwPH3kMldg9uA2id
         YzL3nP+y51O564i9EinYpMd2IC6NmZDme51tQ+BiDE5zPQ+hqdHmRXS2bARHcQ1TVNJu
         tbRKmbasD6gbwUZWS/A3yCJIn4OFgxeJdLpRzKy4LjxtKFUZhtNdvkgESwiDnDg8QMoo
         0M5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314016; x=1780918816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u107uVjg73SVFGhwoyflfz835sucwVPYXZhJAi5VGnQ=;
        b=Izr/00a1LxOOYXioM4wHoRKJFiJWZjciKN7qd/EW636HDIkBfgxiqJ1HjO/gymU4JL
         C0UZy0NpZboHDZD0lJtnKQJgC76ntqV8JYLKj+orBf++q2L5vs79sd6JeE6lT1jX3Dcn
         0Nu5l2HA7hx9I6pi1RguYs+VCG1rBFh3wnGP2W2djBYkaLgA3gnCpD2j62fLZBwPczY3
         UZwNX+79AEsoXJozU0g71X5rWzAwQfaUpdMGrjXDuBzbg2I3yWR1EWYUlA9dJBhfCmRu
         3uM9qTMl0WGcfjIUMBY4j8T0N4mmEoHBJ924UuqRvbfeJn835wNlhrT3yuHtBtrvtI3w
         NOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314016; x=1780918816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u107uVjg73SVFGhwoyflfz835sucwVPYXZhJAi5VGnQ=;
        b=AqhFsVdDVEVE3j28NsKnDTUrZJWJpI8k7smOE1twJQokT8HW1RMyqEuQG/xIehgE/w
         K5WG9IVk2UIrLuoPkk4M7oz/yZaT1KR8H1JT+9WpEDQ9XAQIUO0v+pP4p7FUdvmzcTok
         gWVDmQtNIoKzcxkvhwXAMEPKXJfFssMKLNJTVTore5RgOVJP9o5IxwNVIeBylYKywWuC
         cVpLXg800gMX0pZ8mvP5U17PeyCB+TysboUiXXmXVcdbR8cCSfCMb6dup5Hoq78iiqGe
         qULUVs4hZbkcMqJOKPqQBCe7SK4BBrhYkw0RsJaXr6zAgU/RqHxLw+vM5FwD1JwQn2Am
         jb0w==
X-Gm-Message-State: AOJu0YyRE4yE5ScBmLaA7VKIYCqCpoTdUDuR3VS3P5xP26bGm2g9OhS/
	rKp3ov8e59h7AOyAbXVrfM2ewpG9VxAAU/g3eaR60Vv1Ahs53MnyES1VC/1K5vTiHY8xDF7ZVp1
	8QvUDkQTamER1oDia4onPx5JwHe8qJz8=
X-Gm-Gg: Acq92OG7K1GBaTgoMz3lSi/GGATY9T0DjYHpZUKBpV/4LLdgkZVr41QNijFcFpIF7gs
	u1aQq0//t6pQjBNaQs/Ev/2JRryhg6quKRB0vutvGQZNHRz69uPHWIXyeyp6Zpg5tIAQ3dthDG3
	1q84ykVN1p1CVYCMpJGP0eerM+/IgEAqA8y1k0TCbZmAn8jS77r7NGZeoinmIvJm0GNbv6l2PqZ
	LQ2+6ynEqInav1iaGkcZJs2z6LgG7cstdnQa4EGbXr83gZzKnt9XcukhXvXNCrJx19WS7jLu3nP
	1oJjZNatpxnKMD9HCQ==
X-Received: by 2002:a05:6a20:6f03:b0:3aa:f5a5:1c37 with SMTP id
 adf61e73a8af0-3b427c40f81mr12169544637.11.1780314015863; Mon, 01 Jun 2026
 04:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529200244.65895-1-jwcart2@gmail.com> <20260529200244.65895-3-jwcart2@gmail.com>
In-Reply-To: <20260529200244.65895-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 1 Jun 2026 07:40:03 -0400
X-Gm-Features: AVHnY4IjP2Aiq0X_UbjIH831KGKMYLX9CR1YP7At2RdkJt7pHHTMa3FQ_mfuGbY
Message-ID: <CAEjxPJ7gcqf+0UWmVcdcweXBduMU3ujTnD4fEoT-SPutwbeUUw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] secilc: Add program that checks CIL neverallows
 against a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:24=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the program secilcheck that takes a binary policy and one or
> more CIL files and checks for violations in the binary policy using
> the neverallow and neverallowx rules from the CIL policy.
>
> ex/
> secilcheck policy.bin neverallows.cil
>
> The CIL neverallow and neverallowx rules must only use types, classes,
> and permissions that are declared in the binary policy.
>
> This is planned on being used in Android to validate policies from
> partners against the standard AOSP assertions as part of the
> Compatibility Test Suite.
>
> Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This series appears to break the secilc tests:
from https://github.com/stephensmalley/selinux/actions/runs/26752368177/job=
/78843360133
make[1]: Entering directory '/home/runner/work/selinux/selinux/secilc'
./secilc test/policy.cil
./secilc -c 35 -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
checkpolicy -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
diff test/opt-expected.cil opt-actual.cil
2,3d1
< (class cl01 (p01a p01b p11a p11b))
< (classorder (cl01))
5a4,5
> (class cl01 (p01a p01b p11a p11b))
> (classorder (cl01))
12,14d11
< (typeattribute at01)
< (typeattribute at02)
< (boolean b01 false)
22a20,21
> (typeattribute at01)
> (typeattribute at02)
32a32
> (boolean b01 false)
make[1]: *** [Makefile:45: test] Error 1
make[1]: Leaving directory '/home/runner/work/selinux/selinux/secilc'
make: *** [Makefile:40: test] Error 1
Error: Process completed with exit code 2.

> ---
> v2: Added more explanation to the commit msg
>     Added the header unistd.h
>
>  secilc/.gitignore       |   2 +
>  secilc/Makefile         |  20 ++-
>  secilc/secilcheck.8.xml |  81 +++++++++++
>  secilc/secilcheck.c     | 302 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 403 insertions(+), 2 deletions(-)
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
> index 00000000..279322a5
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
> +      <refmiscinfo class=3D"date">29 May 2026</refmiscinfo>
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
> index 00000000..194f4943
> --- /dev/null
> +++ b/secilc/secilcheck.c
> @@ -0,0 +1,302 @@
> +/*
> + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
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
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
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
> 2.54.0
>
>
