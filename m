Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FFC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 22:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28442147A
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBSWIB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:08:01 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37691 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfBSWIB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 17:08:01 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 87F26561266
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 23:07:56 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id b3so37033360otp.4
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 14:07:56 -0800 (PST)
X-Gm-Message-State: AHQUAuaebBoF1xqOqRTIMtEjEv37IbfdONxO9J+NlTmt6lsurzrqhPKE
        VsqKwgYCf/5AixDsLH49MVehL1iU6d8/kW0c18k=
X-Google-Smtp-Source: AHgI3IYZlsCOlTAnkmSL0+9tEZ/m/FsaDm6gg7zhWXogOhg66xxoXNBkpqP0kFoZYIJeY8MWLEBM38MNk4xmXXO/J30=
X-Received: by 2002:a9d:65c2:: with SMTP id z2mr2751977oth.301.1550614075368;
 Tue, 19 Feb 2019 14:07:55 -0800 (PST)
MIME-Version: 1.0
References: <pjdtvh5m8i4.fsf@redhat.com> <20190215160025.9810-1-plautrba@redhat.com>
 <20190215160025.9810-3-plautrba@redhat.com> <CAJfZ7=nsFTKC4upjKETSDC0bgmYCvQZg5tTte_KcTH8Kxe5ucA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nsFTKC4upjKETSDC0bgmYCvQZg5tTte_KcTH8Kxe5ucA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 19 Feb 2019 23:07:44 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==jGextEUUi=T7zGu6Zt4JcxKJE=K54+N2QMYGjeoXBXQ@mail.gmail.com>
Message-ID: <CAJfZ7==jGextEUUi=T7zGu6Zt4JcxKJE=K54+N2QMYGjeoXBXQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] python/semanage module: Fix handling of
 -a/-e/-d/-r options
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 19 23:07:57 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 17, 2019 at 9:42 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Feb 15, 2019 at 5:00 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Previous code traceback-ed when one of the mentioned option was used without
> > any argument as this state was not handled by the argument parser.
> >
> > action='store' stores arguments as a list while the original
> > action='store_const' used str therefore it's needed to convert list to str
> > before it's sent to moduleRecords class.
> >
> > Fixes:
> > ^_^ semanage module -a
> > Traceback (most recent call last):
> >   File "/usr/sbin/semanage", line 963, in <module>
> >     do_parser()
> >   File "/usr/sbin/semanage", line 942, in do_parser
> >     args.func(args)
> >   File "/usr/sbin/semanage", line 608, in handleModule
> >     OBJECT.add(args.module_name, args.priority)
> >   File "/usr/lib/python3.7/site-packages/seobject.py", line 402, in add
> >     if not os.path.exists(file):
> >   File "/usr/lib64/python3.7/genericpath.py", line 19, in exists
> >     os.stat(path)
> > TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> For the three patches: Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged. Thanks!

Nicolas

> > ---
> >  python/semanage/semanage | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 18191c13..d6d68248 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -609,14 +609,14 @@ def setupInterfaceParser(subparsers):
> >
> >  def handleModule(args):
> >      OBJECT = seobject.moduleRecords(args)
> > -    if args.action == "add":
> > -        OBJECT.add(args.module_name, args.priority)
> > -    if args.action == "enable":
> > -        OBJECT.set_enabled(args.module_name, True)
> > -    if args.action == "disable":
> > -        OBJECT.set_enabled(args.module_name, False)
> > -    if args.action == "remove":
> > -        OBJECT.delete(args.module_name, args.priority)
> > +    if args.action_add:
> > +        OBJECT.add(args.action_add[0], args.priority)
> > +    if args.action_enable:
> > +        OBJECT.set_enabled(" ".join(args.action_enable), True)
> > +    if args.action_disable:
> > +        OBJECT.set_enabled(" ".join(args.action_disable), False)
> > +    if args.action_remove:
> > +        OBJECT.delete(" ".join(args.action_remove), args.priority)
> >      if args.action == "deleteall":
> >          OBJECT.deleteall()
> >      if args.action == "list":
> > @@ -635,14 +635,13 @@ def setupModuleParser(subparsers):
> >      parser_add_priority(moduleParser, "module")
> >
> >      mgroup = moduleParser.add_mutually_exclusive_group(required=True)
> > -    parser_add_add(mgroup, "module")
> >      parser_add_list(mgroup, "module")
> >      parser_add_extract(mgroup, "module")
> >      parser_add_deleteall(mgroup, "module")
> > -    mgroup.add_argument('-r', '--remove', dest='action', action='store_const', const='remove', help=_("Remove a module"))
> > -    mgroup.add_argument('-d', '--disable', dest='action', action='store_const', const='disable', help=_("Disable a module"))
> > -    mgroup.add_argument('-e', '--enable', dest='action', action='store_const', const='enable', help=_("Enable a module"))
> > -    moduleParser.add_argument('module_name', nargs='?', default=None, help=_('Name of the module to act on'))
> > +    mgroup.add_argument('-a', '--add', dest='action_add', action='store', nargs=1, metavar='module_name', help=_("Add a module"))
> > +    mgroup.add_argument('-r', '--remove', dest='action_remove', action='store', nargs='+', metavar='module_name', help=_("Remove a module"))
> > +    mgroup.add_argument('-d', '--disable', dest='action_disable', action='store', nargs='+', metavar='module_name', help=_("Disable a module"))
> > +    mgroup.add_argument('-e', '--enable', dest='action_enable', action='store', nargs='+', metavar='module_name', help=_("Enable a module"))
> >      moduleParser.set_defaults(func=handleModule)
> >
> >
> > --
> > 2.20.1
> >

