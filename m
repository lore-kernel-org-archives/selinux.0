Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F0C54FCB
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C2620700
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDZNCi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:02:38 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41134 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNCh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 09:02:37 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 667D6564970
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 15:02:34 +0200 (CEST)
Received: by mail-ot1-f48.google.com with SMTP id z17so21342288oto.4
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 06:02:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuZjsrtmNliTYcF61ajssbMzHsA69Y1CWdrvTupnVBt0xVLkPQJQ
        DaCGWPyT3F7NQMr3Go6JF/1T/+8K0m7o0pJb1D0=
X-Google-Smtp-Source: APiQypJmP93yE6hLkDAH0dE17Fcyp/s5bgJTl039pbY/Jr+AW/wQDH4PzxJNdCQqENDOflFQZj/KhEnbsQ3nHR68vmI=
X-Received: by 2002:a9d:bca:: with SMTP id 68mr13869704oth.96.1587906153256;
 Sun, 26 Apr 2020 06:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRe25+PkmjaM8GcFZzFgDM5F3S65rfR5LuCBkangOtjGw@mail.gmail.com>
 <20200423185449.223595-1-plautrba@redhat.com> <CAHC9VhQdgvihTJPLPAzZ7O0QPTtLehdGn18vs19+mOGTG_ev3g@mail.gmail.com>
In-Reply-To: <CAHC9VhQdgvihTJPLPAzZ7O0QPTtLehdGn18vs19+mOGTG_ev3g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Apr 2020 15:02:22 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mz0=QT_OdZHg_eZwOqS=7KZPBB1q=16Qsav7gZSoV97A@mail.gmail.com>
Message-ID: <CAJfZ7=mz0=QT_OdZHg_eZwOqS=7KZPBB1q=16Qsav7gZSoV97A@mail.gmail.com>
Subject: Re: [PATCH v2] Convert README to README.md
To:     Paul Moore <paul@paul-moore.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 26 15:02:34 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 23, 2020 at 9:29 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Apr 23, 2020 at 2:55 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > It should make the document readable for github users.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/225
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >
> > - Fixed indentation in yum command
> >
> >  README    | 25 -------------------------
> >  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+), 25 deletions(-)
> >  delete mode 100644 README
> >  create mode 100644 README.md
>
> Thanks Petr.  For whatever it's worth, here is my ACK.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks :) I will improve the README a little bit more (adding a
Travis-CI badge, listing Debian build dependencies, adding
"install-rubywrap"...) and send a patch to be applied on top of this
one.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Nicolas

>
> > diff --git a/README b/README
> > deleted file mode 100644
> > index e4423ca23b58..000000000000
> > --- a/README
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -Please submit all bug reports and patches to selinux@vger.kernel.org.
> > -Subscribe by sending "subscribe selinux" in the body of an email
> > -to majordomo@vger.kernel.org.
> > -
> > -Build dependencies on Fedora:
> > -yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
> > -
> > -To build and install everything under a private directory, run:
> > -make DESTDIR=~/obj install install-pywrap
> > -
> > -To install as the default system libraries and binaries
> > -(overwriting any previously installed ones - dangerous!),
> > -on x86_64, run:
> > -make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> > -or on x86 (32-bit), run:
> > -make install install-pywrap relabel
> > -
> > -This may render your system unusable if the upstream SELinux userspace
> > -lacks library functions or other dependencies relied upon by your
> > -distribution.  If it breaks, you get to keep both pieces.
> > -
> > -To install libsepol on macOS (mainly for policy analysis):
> > -cd libsepol; make PREFIX=/usr/local install
> > -
> > -This requires GNU coreutils (brew install coreutils).
> > diff --git a/README.md b/README.md
> > new file mode 100644
> > index 000000000000..974280f9d14f
> > --- /dev/null
> > +++ b/README.md
> > @@ -0,0 +1,41 @@
> > +SELinux Userspace
> > +=================
> > +
> > +Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> > +
> > +Subscribe by sending "subscribe selinux" in the body of an email
> > +to <majordomo@vger.kernel.org>.
> > +
> > +Installation
> > +------------
> > +
> > +Build dependencies on Fedora:
> > +
> > +    yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
> > +
> > +
> > +To build and install everything under a private directory, run:
> > +
> > +    make DESTDIR=~/obj install install-pywrap
> > +
> > +To install as the default system libraries and binaries
> > +(overwriting any previously installed ones - dangerous!),
> > +on x86_64, run:
> > +
> > +    make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> > +
> > +or on x86 (32-bit), run:
> > +
> > +    make install install-pywrap relabel
> > +
> > +This may render your system unusable if the upstream SELinux userspace
> > +lacks library functions or other dependencies relied upon by your
> > +distribution.  If it breaks, you get to keep both pieces.
> > +
> > +To install libsepol on macOS (mainly for policy analysis):
> > +
> > +    cd libsepol; make PREFIX=/usr/local install
> > +
> > +This requires GNU coreutils:
> > +
> > +    brew install coreutils
> > --
> > 2.26.0
> >
>
>
> --
> paul moore
> www.paul-moore.com

