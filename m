Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20957C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98D12175B
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGVqc convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 7 Feb 2019 16:46:32 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50965 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGVqc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:46:32 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9DAC9561213
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:46:26 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id s5so2495803oth.7
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:46:26 -0800 (PST)
X-Gm-Message-State: AHQUAubNsrInCsb4twRnojVeWnqkQcg95t1AgQCRQppt7LJWFa7AJ7Es
        1o2peBLPGl4oWYa7qx+q+EIsCpcBzWH0zUCYYWk=
X-Google-Smtp-Source: AHgI3IblYT5jr3c7du1CKAbtgv7L61twlb4PCf+5wr3VdqO2hoOc/OPa5zFqp3JzQUmNZ8kE8ipdEtnNRB/mVNpLpY4=
X-Received: by 2002:aca:4155:: with SMTP id o82mr146847oia.172.1549575985440;
 Thu, 07 Feb 2019 13:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20190206194325.24875-1-plautrba@redhat.com>
In-Reply-To: <20190206194325.24875-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:46:14 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mdSxSVTNBNbuD0SWp_yMC6O0Gsf12Wh2b3JM0abx3VEQ@mail.gmail.com>
Message-ID: <CAJfZ7=mdSxSVTNBNbuD0SWp_yMC6O0Gsf12Wh2b3JM0abx3VEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/semanage module: Fix handling of -a/-e/-d/-r options
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:46:27 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 8:43 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Previous code traceback-ed when one of the mentioned option was used without
> any argument as this state was not handled by the argument parser.
>
> action='store' stores arguments as a list while the original
> action='store_const' used str therefore the particular interfaces in
> moduleRecords are changed to be compatible with both.
>
> Fixes:
> ^_^ semanage module -a
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 963, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 942, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 608, in handleModule
>     OBJECT.add(args.module_name, args.priority)
>   File "/usr/lib/python3.7/site-packages/seobject.py", line 402, in add
>     if not os.path.exists(file):
>   File "/usr/lib64/python3.7/genericpath.py", line 19, in exists
>     os.stat(path)
> TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Nice bug :) Nevertheless "if type(module) == str" troubles me because
I except a function to only accept one kind of arguments (either a
list of strings or a string, but not both). Moreover this is
Python3-only code and semanage's shebang does not specify a Python
version (the Python2-equivalent code would have been "if
isinstance(module, basestring)").

I would prefer if the new code looked like this (that I have not tested):

    def set_enabled(self, modules, enable):
        for item_modules in modules:
            for m in item_modules.split():
                # ...

Moreover the "file = file[0]" in moduleRecords.add() looks strange
without a context, which is in handleModule(). I would prefer if this
operation occurred in semanage, where it is clear that args.action_add
always has a single item (because « action='store', nargs=1 »):

    if args.action_add:
        OBJECT.add(args.action_add[0], args.priority)

Nicolas

PS: As setools is now Python3-only and seobject.py requires it, it
seems to be a good time to update the shebang to "#!/usr/bin/python3
-Es".

> ---
>  python/semanage/semanage    | 25 ++++++++++++-------------
>  python/semanage/seobject.py | 10 ++++++++--
>  2 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 6afeac14..9b737fa8 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -609,14 +609,14 @@ def setupInterfaceParser(subparsers):
>
>  def handleModule(args):
>      OBJECT = seobject.moduleRecords(args)
> -    if args.action == "add":
> -        OBJECT.add(args.module_name, args.priority)
> -    if args.action == "enable":
> -        OBJECT.set_enabled(args.module_name, True)
> -    if args.action == "disable":
> -        OBJECT.set_enabled(args.module_name, False)
> -    if args.action == "remove":
> -        OBJECT.delete(args.module_name, args.priority)
> +    if args.action_add:
> +        OBJECT.add(args.action_add, args.priority)
> +    if args.action_enable:
> +        OBJECT.set_enabled(args.action_enable, True)
> +    if args.action_disable:
> +        OBJECT.set_enabled(args.action_disable, False)
> +    if args.action_remove:
> +        OBJECT.delete(args.action_remove, args.priority)
>      if args.action == "deleteall":
>          OBJECT.deleteall()
>      if args.action == "list":
> @@ -635,14 +635,13 @@ def setupModuleParser(subparsers):
>      parser_add_priority(moduleParser, "module")
>
>      mgroup = moduleParser.add_mutually_exclusive_group(required=True)
> -    parser_add_add(mgroup, "module")
>      parser_add_list(mgroup, "module")
>      parser_add_extract(mgroup, "module")
>      parser_add_deleteall(mgroup, "module")
> -    mgroup.add_argument('-r', '--remove', dest='action', action='store_const', const='remove', help=_("Remove a module"))
> -    mgroup.add_argument('-d', '--disable', dest='action', action='store_const', const='disable', help=_("Disable a module"))
> -    mgroup.add_argument('-e', '--enable', dest='action', action='store_const', const='enable', help=_("Enable a module"))
> -    moduleParser.add_argument('module_name', nargs='?', default=None, help=_('Name of the module to act on'))
> +    mgroup.add_argument('-a', '--add', dest='action_add', action='store', nargs=1, metavar='module_name', help=_("Add a module"))
> +    mgroup.add_argument('-r', '--remove', dest='action_remove', action='store', nargs='+', metavar='module_name', help=_("Remove a module"))
> +    mgroup.add_argument('-d', '--disable', dest='action_disable', action='store', nargs='+', metavar='module_name', help=_("Disable a module"))
> +    mgroup.add_argument('-e', '--enable', dest='action_enable', action='store', nargs='+', metavar='module_name', help=_("Enable a module"))
>      moduleParser.set_defaults(func=handleModule)
>
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 556d3ba5..cd2d3457 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -401,6 +401,8 @@ class moduleRecords(semanageRecords):
>              print("%-25s %-9s %-5s %s" % (t[0], t[2], t[3], disabled))
>
>      def add(self, file, priority):
> +        if type(file) == list:
> +            file = file[0]
>          if not os.path.exists(file):
>              raise ValueError(_("Module does not exist: %s ") % file)
>
> @@ -413,7 +415,9 @@ class moduleRecords(semanageRecords):
>              self.commit()
>
>      def set_enabled(self, module, enable):
> -        for m in module.split():
> +        if type(module) == str:
> +            module = module.split()
> +        for m in module:
>              rc, key = semanage_module_key_create(self.sh)
>              if rc < 0:
>                  raise ValueError(_("Could not create module key"))
> @@ -435,7 +439,9 @@ class moduleRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Invalid priority %d (needs to be between 1 and 999)") % priority)
>
> -        for m in module.split():
> +        if type(module) == str:
> +            module = module.split()
> +        for m in module:
>              rc = semanage_module_remove(self.sh, m)
>              if rc < 0 and rc != -2:
>                  raise ValueError(_("Could not remove module %s (remove failed)") % m)
> --
> 2.20.1
>

