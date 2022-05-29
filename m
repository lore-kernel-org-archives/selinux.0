Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CD1C433EF
	for <selinux@archiver.kernel.org>; Sun, 29 May 2022 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiE2WtG convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 May 2022 18:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE2WtF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 May 2022 18:49:05 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116E66AC4
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:49:03 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6BD70564841
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 00:49:00 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id gd1so1199652pjb.2
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:49:00 -0700 (PDT)
X-Gm-Message-State: AOAM530HS9yp2fnHgZeeAGncUxX49wkn96NAwPxJU3R31S/F5Zm/GTvE
        nP2KJOBAxudZ69+urDpcQrlu46k7246pJozWVUY=
X-Google-Smtp-Source: ABdhPJyzaIepXGJ46NhUpjbBVGErUhXmVUmykYLIRDh9bH5yOLNxceukglR3auC5uYuSJreEU/n4XH8TppSPvT0wvOk=
X-Received: by 2002:a17:903:2308:b0:163:ad36:900c with SMTP id
 d8-20020a170903230800b00163ad36900cmr9405446plh.100.1653864539103; Sun, 29
 May 2022 15:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220520130004.9096-1-cgzones@googlemail.com>
In-Reply-To: <20220520130004.9096-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 30 May 2022 00:48:47 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mjPwViS6umaq=BPF1=bDHZZfSwGwMq=-Ajtj2RoLcLUA@mail.gmail.com>
Message-ID: <CAJfZ7=mjPwViS6umaq=BPF1=bDHZZfSwGwMq=-Ajtj2RoLcLUA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: always include and link with DESTDIR
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon May 30 00:49:01 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 20, 2022 at 3:00 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> The top level Makefile adds, if the environment variable DESTDIR is
> defined, the according include and link directory to CFLAGS and LDFLAGS
> to build all userspace tools against dependencies from this repository
> and not the system.
> If CFLAGS or LDFLAGS are specified by the user, e.g.
>
>     DESTDIR=~/destdir CFLAGS=-Dfoo LDFLAGS=-Lbar make install
>
> use the override directive to force adding DESTDIR paths to the user
> specified CFLAGS or LDFLAGS.
>
> Note that
>
>     DESTDIR=~/destdir make CFLAGS=-Dfoo LDFLAGS=-Lbar install
>
> does not work, since in sub-directories the internal make options take
> precedence over the overridden environment variables in the top
> Makefile.

Hello,

>From my understanding of the documentation of "override"
(https://www.gnu.org/software/make/manual/html_node/Override-Directive.html)
it only matters when setting variables which come from the command
line, not from the environment. On my system (Arch Linux with "GNU
Make 4.3"), your first command works fine. To really be sure I
understood things correctly, I added a target into the main Makefile:

testenv:
    @echo Root Makefile: CFLAGS=$(CFLAGS)
    (cd libsepol && $(MAKE) $@)

... and added similar commands to libsepol/Makefile and
libsepol/src/Makefile. Without override, "DESTDIR=/tmp/destdir
CFLAGS=-Dfoo make testenv" displays:

Root Makefile: CFLAGS=-Dfoo -I/tmp/destdir/usr/include
libsepol Makefile: CFLAGS=-Dfoo -I/tmp/destdir/usr/include
libsepol/src Makefile: CFLAGS=-Dfoo -I/tmp/destdir/usr/include -I.
-I../include -D_GNU_SOURCE -I../cil/include -DHAVE_REALLOCARRAY

... which shows that the Makefile works as expected. Adding "override"
does not change this output. It only changes it with
"DESTDIR=/tmp/destdir make CFLAGS=-Dfoo testenv":

Root Makefile: CFLAGS=-Dfoo -I/tmp/destdir/usr/include
libsepol Makefile: CFLAGS=-Dfoo
libsepol/src Makefile: CFLAGS=-Dfoo -I. -I../include -D_GNU_SOURCE
-I../cil/include -DHAVE_REALLOCARRAY

Your patch makes the first output have " -I/tmp/destdir/usr/include"
but not the other lines, because $(MAKEFLAGS) contains "CFLAGS=-Dfoo"
(as documented on
https://www.gnu.org/software/make/manual/html_node/Variables_002fRecursion.html
). So using CFLAGS in command-line argument does not work and making
it work would require removing CFLAGS and LDFLAGS from MAKEFLAGS,
which seems fragile.

Therefore, I did not manage to reproduce the issue that your patch was
fixing and I did not understand why using "override" helped. You could
be using a specific kind of make which behaves differently as mine.
Could you please provide some way to reproduce the issue you were
experiencing (that "DESTDIR=~/destdir CFLAGS=-Dfoo LDFLAGS=-Lbar make
install" did not work on your system)?

Thanks,
Nicolas

> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2ffba8e9..e05e924b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -29,8 +29,8 @@ ifneq ($(DESTDIR),)
>         LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
>         LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>
> -       CFLAGS += -I$(DESTDIR)$(PREFIX)/include
> -       LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
> +       override CFLAGS += -I$(DESTDIR)$(PREFIX)/include
> +       override LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
>         export CFLAGS
>         export LDFLAGS
>         export LIBSEPOLA
> --
> 2.36.1
>

