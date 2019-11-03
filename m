Return-Path: <SRS0=TJdn=Y3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16BCA9EB0
	for <selinux@archiver.kernel.org>; Sun,  3 Nov 2019 20:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B58621744
	for <selinux@archiver.kernel.org>; Sun,  3 Nov 2019 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfKCU5n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:57:43 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54055 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfKCU5n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 3 Nov 2019 15:57:43 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 43ABF5646A6
        for <selinux@vger.kernel.org>; Sun,  3 Nov 2019 21:57:39 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id v24so7456621otp.5
        for <selinux@vger.kernel.org>; Sun, 03 Nov 2019 12:57:39 -0800 (PST)
X-Gm-Message-State: APjAAAXZ6UiiwR9Re8+iwh1I3cLaICw9FW38tXTxmHyq0Y//xbmiNS49
        Qjq98uPoIsPODcjPpF7FHkojp1fgF9DH4orJ488=
X-Google-Smtp-Source: APXvYqzFTjX727Ju6PAg7R+nuKOCE9zuWmYTRyY1NIsc2ep1xQZs0SqVPe0PxvDxs57n2iY+Hhhuoromm1MDB1xPxSM=
X-Received: by 2002:a05:6830:1e4c:: with SMTP id e12mr6425248otj.358.1572814658222;
 Sun, 03 Nov 2019 12:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20191102172812.22492-1-nicolas.iooss@m4x.org> <20191102211843.70b6037f@windsurf.home>
In-Reply-To: <20191102211843.70b6037f@windsurf.home>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 3 Nov 2019 21:57:27 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mXrusf-yANsoEhKGrySUJJHG3AkL3ND1uGx13yWwvMGg@mail.gmail.com>
Message-ID: <CAJfZ7=mXrusf-yANsoEhKGrySUJJHG3AkL3ND1uGx13yWwvMGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: compile Python bytecode when installing
 Python files
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov  3 21:57:39 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 2, 2019 at 9:18 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello Nicolas,
>
> On Sat,  2 Nov 2019 18:28:09 +0100
> Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> > When selinux module is imported from a Python script, the content of
> > __init__.py is compiled into bytecode and the result is saved into a
> > file if it is allowed. For example, when root runs with Python 3.7 a
> > script that uses "import selinux" on a system where SELinux is in
> > permissive mode, this file may be created:
> >
> >     /usr/lib/python3.7/site-packages/selinux/__pycache__/__init__.cpython-37.pyc
> >
> > Prevent this file from being dynamically created by creating it when
> > libselinux is installed, using "python -m compileall".
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> As far as I know, this not typically done by "setup.py install", and
> this is generally left to distributions.

Hello, this is done when a parameter such as "--optimize=1" is given
to "python setup.py install". Such a parameter is described in Arch
Linux packaging guidelines
(https://wiki.archlinux.org/index.php/Python_package_guidelines#distutils).
Nevertheless I agree it seems to be left to distributions whether to
bytecode-compile Python modules.

> In the context of Buildroot [1], we do the byte-compilation all at once
> at the very end of the build of all packages. Having individual
> packages do their own byte-compilation would be annoying.

What is the reference you are using for [1]? Why would this be
annoying? For example, do you use a non-standard way of generating the
bytecode which is not compatible with the one that would be generated
by the package itself?

> If you would like to have this byte-compilation done by the SELinux
> Makefile, could you make it optional (even if you decide to enable it
> by default) ?

My main motivation behind this patch is to remove lines such as this
one from Arch Linux's PKGBUILD:

/usr/bin/python3 -m compileall "${pkgdir}/$(/usr/bin/python3 -c
'import site; print(site.getsitepackages()[0])')"

(Example from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=selinux-python&id=dd87f7ae1d636a02bf404ed527a27022ee5d2ab3)
As every Makefile installing Python scripts has everything that is
needed to build this command line, it is much simpler for "make
install" to perform the bytecode-compilation directly instead.
Nevertheless, as there is an interest to keep bytecode-compilation out
of the "make && make install" process, I will rework my patches to
make it optional (so that Arch Linux and maybe other distributions can
invoke it, but not Buildroot).

Thanks,
Nicolas

