Return-Path: <SRS0=M2Pn=QY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45802C43381
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C20E2173C
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBQUlt convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 15:41:49 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:57356 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBQUlt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 15:41:49 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D1B075605F7
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 21:41:44 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id z19so25084079otm.2
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 12:41:44 -0800 (PST)
X-Gm-Message-State: AHQUAua+Z2HZIfv1mJmBgsEYAOO9NMxPcwq9O4DkWnC8BsY99yqt9C2W
        ZEl8Ov9HIYBj+ysmxE1iCOtn6hd2MSwlN7HtRVY=
X-Google-Smtp-Source: AHgI3IYtOgTWU84Bm9ebHVeV4y3VB9ZlxpMybN8PY/tdwPOeaSe+32x6YRKYOrt7clH6W1Xc8yYlsdv9i3BPBY/IqTE=
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr6393000ota.278.1550436103638;
 Sun, 17 Feb 2019 12:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20190206194325.24875-1-plautrba@redhat.com> <CAJfZ7=mdSxSVTNBNbuD0SWp_yMC6O0Gsf12Wh2b3JM0abx3VEQ@mail.gmail.com>
 <pjdtvh5m8i4.fsf@redhat.com>
In-Reply-To: <pjdtvh5m8i4.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 17 Feb 2019 21:41:32 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kMA6fKDq=cWD1Tjz5wZLd9gvqnN5FTKh=mMiPZLG70Qg@mail.gmail.com>
Message-ID: <CAJfZ7=kMA6fKDq=cWD1Tjz5wZLd9gvqnN5FTKh=mMiPZLG70Qg@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/semanage module: Fix handling of -a/-e/-d/-r options
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 17 21:41:45 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 3:28 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > On Wed, Feb 6, 2019 at 8:43 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Previous code traceback-ed when one of the mentioned option was used without
> >> any argument as this state was not handled by the argument parser.
> >>
> >> action='store' stores arguments as a list while the original
> >> action='store_const' used str therefore the particular interfaces in
> >> moduleRecords are changed to be compatible with both.
> >>
> >> Fixes:
> >> ^_^ semanage module -a
> >> Traceback (most recent call last):
> >>   File "/usr/sbin/semanage", line 963, in <module>
> >>     do_parser()
> >>   File "/usr/sbin/semanage", line 942, in do_parser
> >>     args.func(args)
> >>   File "/usr/sbin/semanage", line 608, in handleModule
> >>     OBJECT.add(args.module_name, args.priority)
> >>   File "/usr/lib/python3.7/site-packages/seobject.py", line 402, in add
> >>     if not os.path.exists(file):
> >>   File "/usr/lib64/python3.7/genericpath.py", line 19, in exists
> >>     os.stat(path)
> >> TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType
> >>
> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >
> > Nice bug :) Nevertheless "if type(module) == str" troubles me because
> > I except a function to only accept one kind of arguments (either a
> > list of strings or a string, but not both).
>
> The idea was to have backward compatible code. Originally, semanage used
> to send a string, while the new code sends a list. I didn't want to
> break 3rd party and I wanted to avoid converting of the list from
> action_enable to string and the converting it back to list in
> moduleRecords.set_enabled()
>
>
> > Moreover this is
> > Python3-only code and semanage's shebang does not specify a Python
> > version (the Python2-equivalent code would have been "if
> > isinstance(module, basestring)").
>
> Works for me:
>
> > python2
> Python 2.7.15 (default, Feb  2 2019, 16:04:51)
> [GCC 9.0.1 20190129 (Red Hat 9.0.1-0.2)] on linux2
> Type "help", "copyright", "credits" or "license" for more information.
> >>> type("name")
> <type 'str'>
> >>> type(["name"])
> <type 'list'>
> >>> type("name") == str
> True
> >>> type(["name"]) == str
> False
>
>
> https://docs.python.org/2/library/functions.html#type

I had unicode strings in mind:

python2
>>> type(u'abc')
<type 'unicode'>
>>> type(u'abc') == str
False
>>> isinstance(u'abc', basestring)
True

Nevertheless, it seems that argparse does not introduce unicode
strings when UTF-8 characters are provided as command-line parameters,
so your code worked.

> >
> > I would prefer if the new code looked like this (that I have not tested):
> >
> >     def set_enabled(self, modules, enable):
> >         for item_modules in modules:
> >             for m in item_modules.split():
> >                 # ...
>
> Or just convert action_enable to string before it's sent to
> moduleRecords.set_enabled():
>
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -612,9 +612,9 @@ def handleModule(args):
>      if args.action_add:
>          OBJECT.add(args.action_add, args.priority)
>      if args.action_enable:
> -        OBJECT.set_enabled(args.action_enable, True)
> +        OBJECT.set_enabled(args.action_enable.join(" "), True)
>      if args.action_disable:
> -        OBJECT.set_enabled(args.action_disable, False)
> +        OBJECT.set_enabled(args.action_disable.join(" "), False)
>      if args.action_remove:
>          OBJECT.delete(args.action_remove, args.priority)

Indeed. I like it better, thanks!

> > Moreover the "file = file[0]" in moduleRecords.add() looks strange
> > without a context, which is in handleModule(). I would prefer if this
> > operation occurred in semanage, where it is clear that args.action_add
> > always has a single item (because « action='store', nargs=1 »):
> >
> >     if args.action_add:
> >         OBJECT.add(args.action_add[0], args.priority)
>
> Good idea.
>
> >
> > Nicolas
> >
> > PS: As setools is now Python3-only and seobject.py requires it, it
> > seems to be a good time to update the shebang to "#!/usr/bin/python3
> > -Es".
>
> seobject.py is just a module which is not supposed to be entry point.
> The shebang does not make sense here and should be removed.
>
> But I'd change at least semanage and chcat as they both directly imports
> seobject.
>
> Or rather change the whole project to python3 by default.

I agree with changing all the shebangs in the project to python3 (as
python/sepolicy/sepolicy/__init__.py also imports setools, there are
more tools that are broken with a Python3-only setools and a Python2
"python" binary).

Nicolas

