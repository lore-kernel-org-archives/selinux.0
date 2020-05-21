Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA86C433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB30204EC
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2ERtGO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEUKAW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 06:00:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726405AbgEUKAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 06:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590055220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IP4tCFJJIZGzmUwOvRfURNEJWABhw2MJCY4xF5pB6kc=;
        b=X2ERtGO+ijbHDteAh1Izn187Tfp/CKi3B4mQQ7S/AWbrgMsWzsRzyjhjl2CMzuW4HxAo+W
        SZAyqM70YFv9DDzJuKBecQkbqe0OKoj0MhMFNnRli9iZ1fUnK3upVE0vLSY0wScQltLTOL
        /Kk9n20mnMK0pO7d+fNLTGOaW5dyeTk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-dH3ulpLHPIitpRjsOT9shg-1; Thu, 21 May 2020 06:00:15 -0400
X-MC-Unique: dH3ulpLHPIitpRjsOT9shg-1
Received: by mail-oo1-f71.google.com with SMTP id l21so3139896oos.22
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 03:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IP4tCFJJIZGzmUwOvRfURNEJWABhw2MJCY4xF5pB6kc=;
        b=exyL41s6XsvIaTw1Vr+rO5N+/tB2e+YhFtlrxUEymAG8nukNCEg2PBQ2Mp5narQfZF
         vBk7Nj8GahHic1LIOaL44U6dviXscwUwxl367ya3rUgBkribAS/YhVi8hpBhE01fIehG
         BpxffO0X5WuoT4SpzrJf/aIF5X/ntpbJEo7LawW/pNOVahnN9fp9kM2Fq+NQ20cRlrz0
         +oT0/UnbMQ9ktFKcWfzMBz6VkapM2+HoODv+wUmXflNchLD/o2xR2uNy6f9n94Xfrebe
         ZEDQxqBzNHvvocE6b9sGFD7I6sWVqbiD380ebQJZrPG5SsW5ytG+aSc+e1A8MHZOGSOx
         V8Zg==
X-Gm-Message-State: AOAM533bmLWVaZM0ivIF6cGDXXKB3Mq9k/IIKOSAL/mGgwJGmV6cOilw
        0F30QOPg3d40Kd/7PYSW4B5GjpI0vJZTsKfcDMpAyfY4XDmM5neapE6VZJz56oPa1DhdK8982qP
        TdgbZa2arDl939nGzc+NPRwjPJpiuiKTR1g==
X-Received: by 2002:a4a:909a:: with SMTP id j26mr6669272oog.21.1590055214153;
        Thu, 21 May 2020 03:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTiMcjAHYF4KnMk4CVmZyxOL2O6DVrwCJXCTNSqHUoTtOlTRQFb5hb3qUQ1XqcC6OAHIS/QLyttDPZmEaj13A=
X-Received: by 2002:a4a:909a:: with SMTP id j26mr6669258oog.21.1590055213819;
 Thu, 21 May 2020 03:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200520122546.30442-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200520122546.30442-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 May 2020 12:00:02 +0200
Message-ID: <CAFqZXNt9f21xXUnu3ek4cihcx1zCkMs5a72XRxcEAO+=bDPFWg@mail.gmail.com>
Subject: Re: [PATCH V4] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 2:25 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Support secmark tests that require nftables version 9.3 or greater and
> kernel 4.20 or greater.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Use common tests for iptables/nftables
> V3 Change:
> Use function
> V4 Changes:
> Add nftables to README for Debian
> Use nft -c to determine if SECMARK supported
>
>  README.md                        |  7 ++-
>  tests/inet_socket/nftables-flush |  2 +
>  tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++
>  tests/inet_socket/test           | 99 ++++++++++++++++++++------------
>  tests/sctp/nftables-flush        |  2 +
>  tests/sctp/nftables-load         | 68 ++++++++++++++++++++++
>  tests/sctp/test                  | 90 ++++++++++++++++++-----------
>  7 files changed, 270 insertions(+), 72 deletions(-)
>  create mode 100644 tests/inet_socket/nftables-flush
>  create mode 100644 tests/inet_socket/nftables-load
>  create mode 100644 tests/sctp/nftables-flush
>  create mode 100644 tests/sctp/nftables-load
[...]
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 47ce106..6c82719 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -27,6 +27,19 @@ BEGIN {
>          $test_calipso_stream = 1;
>      }
>
> +    # Determine if nftables has secmark support and kernel >= 4.20
> +    $test_nft = 0;
> +
> +    $rc = system("nft -c -f $basedir/nftables-load 2>/dev/null");
> +    if ( $rc == 0 ) {
> +        $kverminstream = "4.20";
> +        $rc            = `$basedir/../kvercmp $kvercur $kverminstream`;
> +        if ( $rc > 0 ) {
> +            $test_count += 8;
> +            $test_nft = 1;
> +        }
> +    }
> +
>      plan tests => $test_count;
>  }

Sorry for bothering you again, but I believe we can drop the kernel
version check here as well (as I said in the previous reply). When I
strace the nft -c -f ... command, I can see it actually sending
netlink messages to the kernel, so it should be able to transparently
detect missing kernel support as well. I just tried it on a RHEL-7 box
with nftables v0.9.4 compiled from source and the command failed with
many errors so I think that confirms it. I'd like us to avoid
hard-coded kernel version checks (they may be unreliable on kernels
with backports) when there is an easy way to detect support directly.

Thanks,

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

