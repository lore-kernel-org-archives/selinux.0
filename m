Return-Path: <SRS0=zFQt=PM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920AC43387
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F021872
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfADU4c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADU4c (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17311C058CA9;
        Fri,  4 Jan 2019 20:56:32 +0000 (UTC)
Received: from workstation (ovpn-204-69.brq.redhat.com [10.40.204.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 051CD19C7C;
        Fri,  4 Jan 2019 20:56:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [large PATCH on GitHub] python/sepolgen: upgrade ply to release 3.11
References: <CAJfZ7=kwP5YkjSQssxLR9--uZgfa3MgyM7m4Dv9_Z34cac3HTQ@mail.gmail.com>
Date:   Fri, 04 Jan 2019 21:56:26 +0100
In-Reply-To: <CAJfZ7=kwP5YkjSQssxLR9--uZgfa3MgyM7m4Dv9_Z34cac3HTQ@mail.gmail.com>
        (Nicolas Iooss's message of "Fri, 21 Dec 2018 21:53:42 +0100")
Message-ID: <pjdmuogta4l.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 04 Jan 2019 20:56:32 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Hi,
> I tried to send a large patch to the mailing list but it did not seem
> to work. Therefore I opened
> https://github.com/SELinuxProject/selinux/pull/117 and send now a
> smaller version below.
> Cheers,
> Nicolas

I've ran several tests on this and since everything worked for me, I've
merged it. Thanks!


> ----------------
>
> PLY (Python Lex-Yacc) 3.11 has been released in February 2018:
> - http://www.dabeaz.com/ply/index.html
> - https://github.com/dabeaz/ply/releases/tag/3.11
>
> Copy lex.py and yacc.py from this new release.
>
> This fixes the following warning from "make test":
>
>     python run-tests.py
>     ../src/./sepolgen/lex.py:634: DeprecationWarning: Using or importing
>     the ABCs from 'collections' instead of from 'collections.abc' is
>     deprecated, and in 3.8 it will stop working
>      if isinstance(t, collections.Callable):
>
> (Python 3.3 moved collections.Callable to collections.abc.Callable)
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/sepolgen/src/sepolgen/lex.py  | 1298 ++++---
>  python/sepolgen/src/sepolgen/yacc.py | 4930 ++++++++++++++++----------
>  scripts/run-flake8                   |    4 +-
>  3 files changed, 3872 insertions(+), 2360 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/lex.py
> b/python/sepolgen/src/sepolgen/lex.py
> index c13acef0507a..f95bcdbf1bb5 100644
> --- a/python/sepolgen/src/sepolgen/lex.py
> +++ b/python/sepolgen/src/sepolgen/lex.py
> [Diff available on https://github.com/SELinuxProject/selinux/pull/117/files ]
>
> diff --git a/python/sepolgen/src/sepolgen/yacc.py
> b/python/sepolgen/src/sepolgen/yacc.py
> index afef174849f2..88188a1e8ead 100644
> --- a/python/sepolgen/src/sepolgen/yacc.py
> +++ b/python/sepolgen/src/sepolgen/yacc.py
> [Diff available on https://github.com/SELinuxProject/selinux/pull/117/files ]
>
> diff --git a/scripts/run-flake8 b/scripts/run-flake8
> index 207edd20dd89..6ad029fa6852 100755
> --- a/scripts/run-flake8
> +++ b/scripts/run-flake8
> @@ -17,10 +17,8 @@ IGNORE_LIST="$IGNORE_LIST,E101" # indentation
> contains mixed spaces and tabs
>  IGNORE_LIST="$IGNORE_LIST,E711" # comparison to None should be 'if
> cond is not None:'
>  IGNORE_LIST="$IGNORE_LIST,E712" # comparison to False should be 'if
> cond is False:' or 'if not cond:'
>  IGNORE_LIST="$IGNORE_LIST,E722" # do not use bare 'except'
> -IGNORE_LIST="$IGNORE_LIST,E999" # TabError: inconsistent use of tabs
> and spaces in indentation
>
>  IGNORE_LIST="$IGNORE_LIST,F401" # module imported but unused
> -IGNORE_LIST="$IGNORE_LIST,F812" # list comprehension redefines 'f',
> in lex.py and yacc.py
>  IGNORE_LIST="$IGNORE_LIST,F841" # local variable '...' is assigned to
> but never used
>
>
> @@ -75,4 +73,4 @@ IGNORE_LIST="$IGNORE_LIST,F405" # '...' may be
> undefined, or defined from star i
>  IGNORE_LIST="$IGNORE_LIST,F811" # redefinition of unused ...
>
>
> -exec flake8 --max-line-length=120
> --builtins='_,unicode,lextab,parsetab' --ignore=",$IGNORE_LIST" "$@"
> +exec flake8 --max-line-length=120 --builtins='_,basestring,unicode'
> --ignore=",$IGNORE_LIST" "$@"
> --
