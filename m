Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F453AE18B
	for <selinux@vger.kernel.org>; Fri, 22 May 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456665; cv=pass; b=nhq+M44vzTpyIHKKim0R8JRqXW4TLl+8wCgGgReSezliih3qdmdlkWSDBZS3XwH7pyFAjrZT0x7/IXkEZn0136G4dJ/Uauk5Sfe+Q1Vd4vGrKwQkDm2sG3W1ze2yJFDoH/kF9x39GE5T4JVp3W4wMKQIAQIMGIWhHOa/vPGY1fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456665; c=relaxed/simple;
	bh=YuIFH4HQ1Rgp0Wk8QIh+vhWDgqyOEwJ3TzksBxHN1ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYGCglBD9ithKpA9qRiXxuPsfHKrqvcupI5ogKZ7mJ0Sdfy/3TnNkJsjidkIsF4vSWGhRwR2WAc82Yc22KAJqYUXU3EG27x1eOZ4ICy7PozmaLhJx0QNcUtRCc9iELJp8D/P4+jk9f/Mq4Fzb2mrje6EMA/4AjgPiiOZmrqABjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCQe7TVy; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCQe7TVy"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so54048911fa.1
        for <selinux@vger.kernel.org>; Fri, 22 May 2026 06:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779456661; cv=none;
        d=google.com; s=arc-20240605;
        b=NapVaRJsfgytFixzXf7Q7J9yDsWanc3U/zXunEjC7UqPWsL/ohv0XGiIEpPTM8YzC0
         PbHTgG7nHawy+ORWyppvcPMP5dOD2YGmIvnVtNeINH+zOgFoQrw9KyhSmONsQINtJCG5
         k3CCpDdNUtRBDfhfcgrXv4rORJCQSDotuhqd4Z2UN7Qn5LDpT2tQDvhSVrCNvemJTCU7
         WsA8XZGEMiQRdY5bz6J5j/RwBVds+bNfjQRJc9OJJlC4jH++SJcOoNK/Y9DiQj9Iz61/
         0snGuJTHCDrhEIsFGi9O+ztm27kvbO8EtjgJMkjEBdp4Y2JX6fbh/avl5wj4c/m+PP2r
         wE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/+9WYbBcfv3qFVTWKJFzyDz4m3csGRvQ/Rv2StmSXE=;
        fh=8+t9IPeQTqyGiWySCZ7zSKsVGC0IZExJx19zfd5jlQs=;
        b=eTIDwXy5BPm63Vj6drCerdXw3lRzP5yqteB/N7jf+TscZdtLAfxzjdkuCkx5KiAnO6
         n45pL+BXOHezpmlP/t12e1ozIRo+MO7dgL5yT+m++xvX1L2G51TFByxyEihJANWNmLCx
         8kK7cuhmryPzhRLFb0YUZI9RGuIuKPcIV9DTXIee9JvFdFH9PsQrVe25RX4OYgol/4sA
         Ul/MEdBYDZkC47zylNXKRKu5zy25S+k/IgbBUt4Jhm4MWyLb7hitDt9Cxg3ojzxX+Xk9
         +YY7beZ76bygHH/WkZN462V/VEZBBUvydBzpDRUddBs0wyeiO0uEJRO4dTcGvpuCduFH
         QojA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779456661; x=1780061461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/+9WYbBcfv3qFVTWKJFzyDz4m3csGRvQ/Rv2StmSXE=;
        b=PCQe7TVylwWtkh1gi7vMEEso+zQfE3K6M/J3txtQuSW62tjHJMT6qc1IzK3qdvfo9/
         SHxcEbHU06A4v9BzWR33Glgccx4RWwZ3XHYQkWcTpAZgODbLNUOkiET4WrhXDKTEFXE8
         rId+Xh5fIyKsKA8U/ppRbMFYpHnM/3jgPOJv/fbx+AlggmX6VArGPJDFGOSVGG8OMT2A
         a1z+JDCKH6yxri3lgQxSQqGoSkhVnqLRgun1YL93E0uhpwHtorLhwhDMbzgoEgonw/um
         HdKRr8JEwT+Xr0T50R3k60eLrrLfR6cuvzBTfEcpUaBodiChm6W8rzKH/eY3AzvcUN+I
         swUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456661; x=1780061461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/+9WYbBcfv3qFVTWKJFzyDz4m3csGRvQ/Rv2StmSXE=;
        b=tXzefTzmiq6wMUnRnfYuH3u3TnoWxtTinZ8c3Fnfzd6sGzfSmsrRvI6S4XNmy44mtD
         XU+osApgcQPGWCIDSVx8bRBEBCyTkD94TPANAbet2/mmMiqX1OczxtrmFzN1/e30Mzcw
         I+sxLrpMhDiFqEnp5WY27rCa0q6uXv95PGvNNPB1tF3jl7tA6XzTKWxmrIHUt5XDoRzw
         /oIFrkOdOLt0x4Ob34VW1bYOk/oYYUvWWTI+Ntc6sPJARo9kZY2Kv68B3V53yreTeBbg
         jlHeKi87F9lXaSg7USrTZXzA3xEZw9dWEKphH3OAM4R7V7/FyPxCqRKMXOErRLM1upKq
         CR3A==
X-Gm-Message-State: AOJu0YwBOUMI6p435COqxfkzoPYdiQmitZJT8unHp8mSQGm59e9Z+wAn
	U3G4Kyt1gr45ewmjwIfyAuQHLXF42BBV6sCppRTbWazZKp+aEP2YNWVMKz73vMSFhpMD9jJR3if
	GGwMN92wqtHXu9xkXzttqsbN62aZNn9sNjA==
X-Gm-Gg: Acq92OEJ0IxOC/aJBIq6kKjk1cYgqIpYcmN5Obh2/eAmjrTntxNXaODwiWmcjlIHuwX
	6JHArK9ns53DFRyfS9dQR/DgjO/PRS+tO1lcMhpDaKeV41Yw4zS9i/s8sGwZguKoKx1ct9IYnXS
	o3ABjV2NobxExbjTq+gzrubdvUAKtKSTyLYBtVlBaStMRCxVx5D/5lbo8CapJgypMSfqaKOmWBx
	lV6L0UQ3vkTSCYlZZ8tjMC6UZQIiPqpLFJwd6GuNt1GVd4kOR/1mbdurfoY7k+vKjBFxQgPpCQJ
	4g88
X-Received: by 2002:a05:651c:1ca:b0:38c:6b42:3d77 with SMTP id
 38308e7fff4ca-395d8bd343bmr12119591fa.2.1779456660783; Fri, 22 May 2026
 06:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com> <20260427195546.91395-3-jwcart2@gmail.com>
 <CA+zpnLf6Od_mM-T57zYjK9wQnO+hwpDZEqbc41jr0anK9Mgmtg@mail.gmail.com>
In-Reply-To: <CA+zpnLf6Od_mM-T57zYjK9wQnO+hwpDZEqbc41jr0anK9Mgmtg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 22 May 2026 09:30:49 -0400
X-Gm-Features: AVHnY4Jn830qa77JzdTLruCPf7kXxy_fDTSTFWQUpIZJIKEqkHDV_UOjuUuulro
Message-ID: <CAP+JOzT1BOkpwiF_B6kb18scQOL5Ys+Tm+pg4HMTNL8_ZN9Sfw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] secilc: Add program that checks CIL neverallow
 rules against a binary policy
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:00=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> On Tue, Apr 28, 2026 at 5:56=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Add the program secilcheck that takes a binary policy and one or
> > more CIL files and checks the binary policy against the neverallow
> > rules in the CIL policy.
> >
> > ex/
> > secilcheck policy.bin neverallows.cil
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  secilc/.gitignore       |   2 +
> >  secilc/Makefile         |  20 ++-
> >  secilc/secilcheck.8.xml |  81 +++++++++++
> >  secilc/secilcheck.c     | 301 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 402 insertions(+), 2 deletions(-)
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
> > index 00000000..004e6ccd
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
> > +      <refmiscinfo class=3D"date">27 April 2026</refmiscinfo>
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
> > index 00000000..874f6544
> > --- /dev/null
> > +++ b/secilc/secilcheck.c
> > @@ -0,0 +1,301 @@
> > +/*
> > + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
>
> Update the date? Is that the correct header here?

Since I work for the government, everything that I create is actually
in the public domain. We can contribute to code released under open
source licenses, but we can't create it.
Since this was derived from the secilc.c code, I just kept the
copyright notice. That is my usual practice.

I know there is a lot of duplicate code. One of my long-term todo
items is to pull out the common code from the various programs in the
secilc directory.

>
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
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <getopt.h>
> > +#include <fcntl.h>
> > +#include <sys/stat.h>
> > +#include <sys/mman.h>
>
> I had to add unistd.h for close(2) below.
>

ok, I will add that.

Thanks,
Jim

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
> > 2.53.0
> >
