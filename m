Return-Path: <SRS0=e4om=ZB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF9C43331
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BAF21882
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKIPzZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:55:25 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:40366 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfKIPzZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 9 Nov 2019 10:55:25 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9A1F9564904
        for <selinux@vger.kernel.org>; Sat,  9 Nov 2019 16:55:20 +0100 (CET)
Received: by mail-oi1-f175.google.com with SMTP id v138so7938926oif.6
        for <selinux@vger.kernel.org>; Sat, 09 Nov 2019 07:55:20 -0800 (PST)
X-Gm-Message-State: APjAAAX/CGSU45U7pOk2b6gvoGANIkU/uSY4HMhoUN+iUIdk9eu0Qdoo
        TAFk01JoXD5g9jkZB8TxI+iyV2BCLCMuQbPvEbU=
X-Google-Smtp-Source: APXvYqwZdSduRtzw+Tk/XlfYoNWAcYUH7AfkKxuPxb1hHx6tpg+LM4n1E6LnO6zL3liSd+uX/a1p+RG6OKEhJl6u3U8=
X-Received: by 2002:aca:5709:: with SMTP id l9mr15598095oib.163.1573314919505;
 Sat, 09 Nov 2019 07:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20191102172812.22492-1-nicolas.iooss@m4x.org> <20191102211843.70b6037f@windsurf.home>
 <CAJfZ7=mXrusf-yANsoEhKGrySUJJHG3AkL3ND1uGx13yWwvMGg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mXrusf-yANsoEhKGrySUJJHG3AkL3ND1uGx13yWwvMGg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 9 Nov 2019 16:55:07 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kihH_zrWHdYcR8qf9w9C_VSjcs4ShxUE1XeQv_VRG0eg@mail.gmail.com>
Message-ID: <CAJfZ7=kihH_zrWHdYcR8qf9w9C_VSjcs4ShxUE1XeQv_VRG0eg@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: compile Python bytecode when installing
 Python files
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov  9 16:55:21 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 3, 2019 at 9:57 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sat, Nov 2, 2019 at 9:18 PM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> >
> > Hello Nicolas,
> >
> > On Sat,  2 Nov 2019 18:28:09 +0100
> > Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > > When selinux module is imported from a Python script, the content of
> > > __init__.py is compiled into bytecode and the result is saved into a
> > > file if it is allowed. For example, when root runs with Python 3.7 a
> > > script that uses "import selinux" on a system where SELinux is in
> > > permissive mode, this file may be created:
> > >
> > >     /usr/lib/python3.7/site-packages/selinux/__pycache__/__init__.cpython-37.pyc
> > >
> > > Prevent this file from being dynamically created by creating it when
> > > libselinux is installed, using "python -m compileall".
> > >
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > As far as I know, this not typically done by "setup.py install", and
> > this is generally left to distributions.
>
> Hello, this is done when a parameter such as "--optimize=1" is given
> to "python setup.py install". Such a parameter is described in Arch
> Linux packaging guidelines
> (https://wiki.archlinux.org/index.php/Python_package_guidelines#distutils).
> Nevertheless I agree it seems to be left to distributions whether to
> bytecode-compile Python modules.

I have spent some time working on these patches, and it appears that
the base assumption of "this not typically done by setup.py install"
is not true on my system (Arch Linux with Python 3.7): setup.py *DOES*
compile bytecode into .pyc files. What the distribution I'm using does
when packaging is giving a parameter such as --optimize=1 in order to
create .opt-1.pyc files too. Currently, python/sepolicy/Makefile
already uses setup.py (cf.
https://github.com/SELinuxProject/selinux/blob/selinux-python-3.0-rc1/python/sepolicy/Makefile#L30),
so .pyc files are already generated in some Makefiles of the project.

Could you please confirm that "setup.py install" does not compile
Python scripts into bytecode on your system? This test can be achieved
for example by cloning https://github.com/SELinuxProject/selinux,
running "make -C python/sepolicy DESTDIR=/tmp/selinux install" and
searching for .pyc files in /tmp/selinux.

If "setup.py install" produces .pyc files on every system, from my
point of view there are several alternatives that can be considered:

1. Keep the current behavior by default and introduce a COMPILE_PY
boolean variable in Makefiles that produces both .pyc and .opt-1.pyc
files in Makefiles that do not use setup.py.
2. Generate .pyc files everywhere (what my patches do), and introduce
a OPTIMIZE_PY boolean variable in Makefiles that is used to trigger
the compilation to .opt-1.pyc files.
3. Mix 2 and 3 by introducing both COMPILE_PY and OPTIMIZE_PY.
4. Find a way for "setup.py install" not to produce such files in
python/sepolicy/Makefile and do as 1 or 3.

(A 5th option would be to compile both .pyc and .opt-1.pyc files
without introducing new variables, but this would go against what
appears to be a legitimate user request)

My personal preference here would be either 1. or 2. Would one of
these options suits Buildroot maintainers better?

Thanks,
Nicolas

