Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104FC10F01
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC759217F5
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfBRNBi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:01:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfBRNBi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 18 Feb 2019 08:01:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D99FF2976C;
        Mon, 18 Feb 2019 13:01:37 +0000 (UTC)
Received: from workstation (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7D5104811D;
        Mon, 18 Feb 2019 13:01:36 +0000 (UTC)
References: <20190217213650.25974-1-nicolas.iooss@m4x.org> <20190217213650.25974-2-nicolas.iooss@m4x.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] python: always use python3 in the shebang of programs using setools
In-reply-to: <20190217213650.25974-2-nicolas.iooss@m4x.org>
Date:   Mon, 18 Feb 2019 14:01:35 +0100
Message-ID: <pjdpnrpmes0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 18 Feb 2019 13:01:37 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> setools 4.2.0 dropped support for Python 2. On systems where
> /usr/bin/python is Python 2, several tools are now broken 
> because of
> this. Update the shebang of these tools to /usr/bin/python3.
>
> For future reference, as semanage/seobject.py, sepolicy and 
> sepolgen
> import setools, every program that uses one of these modules 
> need to be
> run with Python 3. The following programs do not use any of 
> these
> modules so their shebangs have not been modified:
>
>     dbus/selinux_server.py
>     libsemanage/utils/semanage_migrate_store
>     mcstrans/share/util/mlscolor-test
>     mcstrans/share/util/mlstrans-test
>     sandbox/start
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  gui/polgengui.py                  | 2 +-
>  gui/system-config-selinux.py      | 2 +-
>  python/audit2allow/audit2allow    | 2 +-
>  python/audit2allow/sepolgen-ifgen | 2 +-
>  python/chcat/chcat                | 2 +-
>  python/sepolicy/sepolicy.py       | 2 +-
>  sandbox/sandbox                   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index 1601dbef0e8d..b1cc99372434 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  #
>  # polgengui.py - GUI for SELinux Config tool in 
>  system-config-selinux
>  #
> diff --git a/gui/system-config-selinux.py 
> b/gui/system-config-selinux.py
> index ce7c74b1333c..c42301b626fc 100644
> --- a/gui/system-config-selinux.py
> +++ b/gui/system-config-selinux.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  #
>  # system-config-selinux.py - GUI for SELinux Config tool in 
>  system-config-selinux
>  #
> diff --git a/python/audit2allow/audit2allow 
> b/python/audit2allow/audit2allow
> index 18fe0a531d02..09b06f664bc4 100644
> --- a/python/audit2allow/audit2allow
> +++ b/python/audit2allow/audit2allow
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
>  # Authors: Dan Walsh <dwalsh@redhat.com>
>  #
> diff --git a/python/audit2allow/sepolgen-ifgen 
> b/python/audit2allow/sepolgen-ifgen
> index c482f227193f..be2d093be597 100644
> --- a/python/audit2allow/sepolgen-ifgen
> +++ b/python/audit2allow/sepolgen-ifgen
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  #
>  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
>  #
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index 5bef0073b7a4..ba398684376d 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  # Copyright (C) 2005 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy.py 
> b/python/sepolicy/sepolicy.py
> index 8cc7e8cc5c1c..1934cd8620b0 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  # Copyright (C) 2012 Red Hat
>  # AUTHOR: Dan Walsh <dwalsh@redhat.com>
>  # see file 'COPYING' for use and warranty information
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index c07a1d812a13..1dec07acdcb8 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  # Authors: Dan Walsh <dwalsh@redhat.com>
>  # Authors: Thomas Liu <tliu@fedoraproject.org>
>  # Authors: Josh Cogliati

