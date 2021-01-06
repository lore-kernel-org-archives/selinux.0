Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0FC433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B323106
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 07:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAFHii (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:38:38 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39008 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbhAFHii (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 02:38:38 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EFD29564F11
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 08:37:55 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id j20so2237527otq.5
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 23:37:55 -0800 (PST)
X-Gm-Message-State: AOAM532AK/31l/tOKTZO2KLnREv8/biBpkpFghFNEMDDaWQIbqrvIPaS
        3OgGRYDNns/TK11gOZu4Q0lxTXpsisRyp+an1ZY=
X-Google-Smtp-Source: ABdhPJzV7//uGXbg0H03xImi9b5ZYgvJO7q1QkcxCwrYrZJvBrbCiu8bWGqu/ZRLRFRr8YrsI/pP8R3nZxXYnWHQQXI=
X-Received: by 2002:a05:6830:188:: with SMTP id q8mr2369741ota.96.1609918674696;
 Tue, 05 Jan 2021 23:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210105160021.160108-1-vmojzis@redhat.com>
In-Reply-To: <20210105160021.160108-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Jan 2021 08:37:43 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==efgpSLs-U81UEp-0ven0mr3WZMLpP1+1XC8a-ww0uSg@mail.gmail.com>
Message-ID: <CAJfZ7==efgpSLs-U81UEp-0ven0mr3WZMLpP1+1XC8a-ww0uSg@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: empty stdout before exiting on BrokenPipeError
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 08:37:56 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 5, 2021 at 5:03 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Empty stdout buffer before exiting when BrokenPipeError is
> encountered. Otherwise python will flush the bufer during exit, which
> may trigger the exception again.
> https://docs.python.org/3/library/signal.html#note-on-sigpipe
>
> Fixes:
>    #semanage fcontext -l | egrep -q -e '^/home'
>    BrokenPipeError: [Errno 32] Broken pipe
>    Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
>    BrokenPipeError: [Errno 32] Broken pipe
>
> Note that the error above only appears occasionally (usually only the
> first line is printed).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/semanage | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index b2fabea6..ce15983b 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -27,6 +27,7 @@ import traceback
>  import argparse
>  import seobject
>  import sys
> +import os

Hello,
It would be nicer if the imports were imported in alphabetical order
(also moving "import traceback" after "import sys"). But there also is
an "import re" in the middle of the file, and while at it the
Python2-compatibility layer in the gettext things could be dropped...
so this should be done in other patches anyway. No need to change this
patch.

>  PROGNAME = "policycoreutils"
>  try:
>      import gettext
> @@ -945,6 +946,13 @@ def do_parser():
>          args = commandParser.parse_args(make_args(sys.argv))
>          args.func(args)
>          sys.exit(0)
> +    except BrokenPipeError as e:
> +        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
> +        # Python flushes standard streams on exit; redirect remaining output
> +        # to devnull to avoid another BrokenPipeError at shutdown
> +        devnull = os.open(os.devnull, os.O_WRONLY)
> +        os.dup2(devnull, sys.stdout.fileno())
> +        sys.exit(1)
>      except IOError as e:
>          sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
>          sys.exit(1)
> --
> 2.29.2

Doing open(os.devnull) + dup2 seems strange, but as this is precisely
what is documented in the official Python documentation that you
linked in the commit description, I am fine with this.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

