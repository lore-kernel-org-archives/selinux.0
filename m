Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114EC43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B166217F5
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBRNBP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:01:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfBRNBP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 18 Feb 2019 08:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEC27C0E012A;
        Mon, 18 Feb 2019 13:01:13 +0000 (UTC)
Received: from workstation (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A34B65D70A;
        Mon, 18 Feb 2019 13:01:12 +0000 (UTC)
References: <20190217213650.25974-1-nicolas.iooss@m4x.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] python/sepolicy: drop python shebang from the module
In-reply-to: <20190217213650.25974-1-nicolas.iooss@m4x.org>
Date:   Mon, 18 Feb 2019 14:01:11 +0100
Message-ID: <pjdr2c5meso.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Feb 2019 13:01:14 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> The files in sepolicy's module directory are not supposed to 
> used as
> executable files. The shebang line is therefore not needed.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  python/sepolicy/sepolicy/__init__.py    | 2 --
>  python/sepolicy/sepolicy/booleans.py    | 1 -
>  python/sepolicy/sepolicy/communicate.py | 1 -
>  python/sepolicy/sepolicy/generate.py    | 2 --
>  python/sepolicy/sepolicy/gui.py         | 2 --
>  python/sepolicy/sepolicy/interface.py   | 2 --
>  python/sepolicy/sepolicy/manpage.py     | 1 -
>  python/sepolicy/sepolicy/network.py     | 1 -
>  python/sepolicy/sepolicy/transition.py  | 1 -
>  9 files changed, 13 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py 
> b/python/sepolicy/sepolicy/__init__.py
> index 6f7294726be4..6aed31bddf1e 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python
> -
>  # Author: Dan Walsh <dwalsh@redhat.com>
>  # Author: Ryan Hallisey <rhallise@redhat.com>
>  # Author: Jason Zaman <perfinion@gentoo.org>
> diff --git a/python/sepolicy/sepolicy/booleans.py 
> b/python/sepolicy/sepolicy/booleans.py
> index cf5f1ffc6469..ad07ab045d3e 100644
> --- a/python/sepolicy/sepolicy/booleans.py
> +++ b/python/sepolicy/sepolicy/booleans.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/communicate.py 
> b/python/sepolicy/sepolicy/communicate.py
> index 299316e0bf27..374002204f84 100755
> --- a/python/sepolicy/sepolicy/communicate.py
> +++ b/python/sepolicy/sepolicy/communicate.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/generate.py 
> b/python/sepolicy/sepolicy/generate.py
> index 5a2195b8033f..019e7836c597 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2007-2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/gui.py 
> b/python/sepolicy/sepolicy/gui.py
> index d4bf3b48e629..00fd7a11dab8 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2013 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/interface.py 
> b/python/sepolicy/sepolicy/interface.py
> index 27c37bb8e1f8..583091ae18aa 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/manpage.py 
> b/python/sepolicy/sepolicy/manpage.py
> index af18b6ffc12f..1d367962365a 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012-2013 Red Hat
>  # AUTHOR: Dan Walsh <dwalsh@redhat.com>
>  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
> diff --git a/python/sepolicy/sepolicy/network.py 
> b/python/sepolicy/sepolicy/network.py
> index 115f6b8778d5..34267d929b0d 100755
> --- a/python/sepolicy/sepolicy/network.py
> +++ b/python/sepolicy/sepolicy/network.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/transition.py 
> b/python/sepolicy/sepolicy/transition.py
> index 7dea80597dc1..6414a765d0fa 100755
> --- a/python/sepolicy/sepolicy/transition.py
> +++ b/python/sepolicy/sepolicy/transition.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2011 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #

