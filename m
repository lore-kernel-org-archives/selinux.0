Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6DC43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490CC217F5
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 13:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="hQNHTI9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfBRNBi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:01:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRNBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Feb 2019 08:01:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so8442614pgr.3
        for <selinux@vger.kernel.org>; Mon, 18 Feb 2019 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRXycP5aTQKBpzEw9V9ABdbf5znLht8zdPoj0XZMhlE=;
        b=hQNHTI9txmeShYx+nl0BwAMx3mzXfOIqLsXoWGk68ZXKt6KOaoJ0X8L+wm3vgtFKUA
         9oPKhzLXoVnBWUKEFWWhs/8+XY4FfnpA68Mfd0FYAc63f5EP1NT/tCeVu/C40GS0sP2B
         CyXDVgTR00Sie5vz60iVnYuDLzfPo06I/AOrduVMrDmaZ9rfgeErFRTC7Q7yDgVCPROK
         MljR/E5MDxEbAC1GSbWqYN+jPYUWb2/9leRNfTDppMDz4HoaEfM7qVn2Tcg5h4rfJGUZ
         u7Vu1BqoKrcIOtiPr1Wg94wn1XStSMO91uwN58TNkJjdvm8ev22z1Gebza9Xjf79os2z
         fQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRXycP5aTQKBpzEw9V9ABdbf5znLht8zdPoj0XZMhlE=;
        b=GA0IxCEi5DV1dE7SBKW/ierqIOSC7XxNODF4Tw8ApmCReaQ/HWp1g0o+4VZDv/41+T
         wyYTl0C6vrqCMYVM2zYAvQ7m24MmmjHQmGGjd81NsAlEGJa+F8eA+XwmJyotR3MfRdlc
         dzEoIWyGJNN2x4vKmPsgY8mL5JnS6sW3Tj5lVeZQ1Cz4XSwm9qKOxQUkSPBMe7Lym86E
         wYorniNZL/cjHOLZoj1maj1/6D3Lce/21zvU6S54q0sT9ECyw42owSbuprIkHtbSFchs
         RttmF1L2GnlY/hxp9nMJ06h9gWUqDS4HsPLWuyaSqwCDnPbwIStlzrnNgN3Y9mRRMKLm
         TuZg==
X-Gm-Message-State: AHQUAuZZVbjcgxXsUrYyE7R6+bJj4OOKaYt8rM1glQ2+05SP21JogLHF
        dz03JiUQnh7qMmVIsyWpQlGUxLqDkRw=
X-Google-Smtp-Source: AHgI3Iaqo9J51ewAyemXJ89QnFB16D/zwOk8CQje2B3YhJvJNtfZKDHrT3/KAQGRCNUUkLRmfMtqpQ==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr18617857pgb.56.1550494896655;
        Mon, 18 Feb 2019 05:01:36 -0800 (PST)
Received: from localhost ([2406:3003:2002:40c2:7952:f8f0:5b6c:6fa3])
        by smtp.gmail.com with ESMTPSA id 10sm25848691pfq.146.2019.02.18.05.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 05:01:35 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:01:34 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] python/sepolicy: drop python shebang from the module
Message-ID: <20190218130134.GA48250@baraddur.perfinion.com>
References: <20190217213650.25974-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217213650.25974-1-nicolas.iooss@m4x.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 17, 2019 at 10:36:49PM +0100, Nicolas Iooss wrote:
> The files in sepolicy's module directory are not supposed to used as
> executable files. The shebang line is therefore not needed.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

For both these patches:
Acked-by: Jason Zaman <jason@perfinion.com>
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
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 6f7294726be4..6aed31bddf1e 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python
> -
>  # Author: Dan Walsh <dwalsh@redhat.com>
>  # Author: Ryan Hallisey <rhallise@redhat.com>
>  # Author: Jason Zaman <perfinion@gentoo.org>
> diff --git a/python/sepolicy/sepolicy/booleans.py b/python/sepolicy/sepolicy/booleans.py
> index cf5f1ffc6469..ad07ab045d3e 100644
> --- a/python/sepolicy/sepolicy/booleans.py
> +++ b/python/sepolicy/sepolicy/booleans.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/communicate.py b/python/sepolicy/sepolicy/communicate.py
> index 299316e0bf27..374002204f84 100755
> --- a/python/sepolicy/sepolicy/communicate.py
> +++ b/python/sepolicy/sepolicy/communicate.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 5a2195b8033f..019e7836c597 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2007-2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index d4bf3b48e629..00fd7a11dab8 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2013 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 27c37bb8e1f8..583091ae18aa 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/python -Es
> -#
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index af18b6ffc12f..1d367962365a 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012-2013 Red Hat
>  # AUTHOR: Dan Walsh <dwalsh@redhat.com>
>  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
> diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepolicy/network.py
> index 115f6b8778d5..34267d929b0d 100755
> --- a/python/sepolicy/sepolicy/network.py
> +++ b/python/sepolicy/sepolicy/network.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2012 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/sepolicy/sepolicy/transition.py b/python/sepolicy/sepolicy/transition.py
> index 7dea80597dc1..6414a765d0fa 100755
> --- a/python/sepolicy/sepolicy/transition.py
> +++ b/python/sepolicy/sepolicy/transition.py
> @@ -1,4 +1,3 @@
> -#! /usr/bin/python -Es
>  # Copyright (C) 2011 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> -- 
> 2.20.1
> 
