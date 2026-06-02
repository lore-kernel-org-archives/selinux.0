Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF718DB2A
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423867; cv=pass; b=g9wbxGu5ZofN4LeSk8ntZtI7aKNx93eIEsHcD43jYtrGIyz5BgBa4T1SgWoBHGjeS5EA5ty9deefQyDDeIkzIJ1Koam/BCu5Vly1Lk8PIrOO++AppMXENbII88dbvsfUAyMwlyMsKhsIc+Gw8o3V6uRYOhiLCo+ZyByOrP29kkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423867; c=relaxed/simple;
	bh=RAffDagROH0pxNI6tRcbHOwwQoKBrWRqjfvCCpC46KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdQdciGjtFExs1E2aeJ7pKCmt8ezfivZ6A7/1talICtNNpsXysRLhCqOUg+/C0Zw1J9HcQELYT6KqWkC5JUPYPO8EF1d1AAIpmMBTQF1vXvFzcSICk9WwwKaHZTYd2WJFlNc+oru8cIqy4XzVK0FWiRSmjtnKUCRDa4il6X3WyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU7HYq04; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU7HYq04"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84230ab8857so1493131b3a.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780423865; cv=none;
        d=google.com; s=arc-20240605;
        b=a+5P2CBmjq+8uoVpK77DBeYhp9S5IvBFe/mLCbWCaqIiRef6nQTSlxyRgFHnbhGYCN
         A/STMCFuQH/ulaDbU2brhyjbduBkWmH4CVOR1c7On1QdAaJXCpGw23kxZc/+wYLV+jht
         KORfQy8ANCGainGEFuE6lR0TkEJqo8EggbVC5wF2gloZ8Tqj807Z6iRP9TWmkZnPoIEL
         bBn47t0lLXTjEVi2lj/IvsiNlQOBgSAXjgRjiDlXhAHchnV3jYD3oUDxwJGQQelaiFqg
         YJUvSlZe7O6wWae/WmNdKJTfN5KynPtng/u6S8ln53YIYKDujdPafwvATzHE+vXb9UR7
         Nm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7GeVdX9VgtJIIse2SzMFrVpFNYx9J/xl82658OnleA=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=K1X3glq/BiVqJkh1FlneZ37mC3xLqlAmFsrA4hqWlVrXET3+1qJLSIOmQsJt5AFANp
         ZwKE5HA9jQDMDkH1j4GxgOAiYQjW0xXOU4UXrwRF+Zb+yRWcHsjGy5KN2hw5k+MEwMyX
         4LYGkA059LOgdBrMVc6V00SKYWgD29b2W1at4ySeaZqp5f+6t1zp+Umer3KcaK/WGW99
         RBoKkXpWmzNZni75H3lGFGFcaXWbNKwwRrtU7B2Seb0C5EvW03QmCA+73N3Yw7dxtAkG
         bK+TQ3PKZ+MYOwGsaTPMxF2LfRRj6QaAcnhy34PaOfSVx1p3nn/ujPjd7KCx3nFgF7VS
         kU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780423865; x=1781028665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7GeVdX9VgtJIIse2SzMFrVpFNYx9J/xl82658OnleA=;
        b=gU7HYq04liWPtI0wwaW+dVci3Lf82DPQ7biI5JmeavTx2jOoRIUnL2m0ImMWn6GXRz
         UkJRMWLZGmyujfJn7gCI7i3GpKJFAiXi7yjmp33AfveerGY7oEg2zLPq+/BLUv0mYzvp
         9dThwyPOlbSIXh7ckUZrs0mmY7ejPGsbeGqWb6rIKNCqZX8VPkLIyO4/Xla7YwPTRdAJ
         gY7EQEJGzGgi0v8sR3EwqimGu6o5x81oOeJj/Ovyr2ZMfUpYOPckiQRoWdVo/tsASJgz
         I50NqlGeMzwEyWffnd2qGIaq8PpI5UE8GTXz3ncyMSv/8rEXOH5tsbFQ1cUmlGTzTgpd
         Ps2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780423865; x=1781028665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7GeVdX9VgtJIIse2SzMFrVpFNYx9J/xl82658OnleA=;
        b=TtouTx3zk2Q3iQdRge9Zz0fWSdZUKsSmx7jXEYqLzajYewcswLdgPdH6vBfI/8WbiY
         n0AcoKu8O8qwSO2FMSLYq74HBZX6fMML7hb2/AFiVRgOn7RTexoP1rIVbP81AG9Belgb
         9xPpV20KWOxysDDINtvvy7evA8JWNkWFdjBAj4agYk+ELl56KI6GUg9sAxp6osFyGNh/
         kEFVTe6K0CcXNaqEl+lMT5tKdI6M+E8nnigFrQg7JXnkJk6C7LtNknD03549GExZzz2L
         1q8s6Bol5SmMkMIfZlpP1N0pb+RE20kq/DD9pE/fViiyznqnRMiL4lY8R8pt9+kgzG28
         8Fsg==
X-Gm-Message-State: AOJu0YwwKo9749VedOPibwO6ZRTMVh6RarrzBL7YkRo5qlmBMy7bkVc+
	Qbp7zNShCqRc4gk2aDf6TZ7G+v8EU1u3f8pbvjPVL+g7l8+RzEu4Wc8ssqBR5RCeljODBFHkFMt
	PW3kyrGOeNYBWA70JIs2oTA0JuK5cnOY=
X-Gm-Gg: Acq92OHQu+j+Sn1+hVoLTxauDHnQIBDs26psZnZ4sOWAYKXbKW3BUuYu5akzmmScf5/
	Rsq/zs1EVypEO+RC0n5OtVHKCPtxh7SHQWHB0/1dYzE7KwLRppjz4NBzHOq6qPexjCZETuOD/5I
	LkmY3jYpl00Pmum0XpokA6fmqcp3vOFA/bguGVoik7RFlK7MooVLdnpvjuYog5Vzo2LINnLH+bG
	p3o6HVcDePmM8c8upyW1qff225Iaz4yvXguGIs1PA25n6Nrz3vQAVPQez6HKxWbMzfLYlbENHZ+
	9IsolhsNOnO/CddJbQ==
X-Received: by 2002:a05:6a00:3cd4:b0:842:50fd:4c01 with SMTP id
 d2e1a72fcca58-84284f4ef95mr9263b3a.50.1780423864810; Tue, 02 Jun 2026
 11:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com> <20260602153309.157348-3-jwcart2@gmail.com>
In-Reply-To: <20260602153309.157348-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:10:53 -0400
X-Gm-Features: AVHnY4IXFl_VwWgwJrOMcCv5q2yhrL8d-bHaBkR8axCO2SqMKIlui09oDhgCkxE
Message-ID: <CAEjxPJ7NyYz8fXbiEGdhBMPcckRTk6OuzS+fsPNO_W=SuZCYWg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] secilc: Add program that checks CIL neverallows
 against a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
