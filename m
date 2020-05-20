Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED3C433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFEF20671
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 09:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXE7f/Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETJPy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 05:15:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25926 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgETJPy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 05:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589966153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP+ixVzaLw2MoB70ZGfykArQMhleRSrvShBKFfltehE=;
        b=BXE7f/Dx0Yg+96a1cUp9rlDjOnFgJKPUC56yJddnSFL5kIrgxUG0a1q+xC+i6Zh5B5udXb
        beSGExM90krL53l0WlhgDkqEg8MwZxBJRNaxP4YB4HzejpSPFdAM1XCHf/SpfU1iWAIJMf
        qBSritPeqtxZnFMBE4yMmmSE7pOMLdE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-fCwSq8jfOXCYVa9T8I0EbQ-1; Wed, 20 May 2020 05:15:48 -0400
X-MC-Unique: fCwSq8jfOXCYVa9T8I0EbQ-1
Received: by mail-oo1-f71.google.com with SMTP id p33so1397369ooi.11
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 02:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EP+ixVzaLw2MoB70ZGfykArQMhleRSrvShBKFfltehE=;
        b=uJZvokG1qhDNQ1SVYbD1QFBhiMMVAPuEL5rp9psgrRD9DD0HRrMaItjLhvhsoG2L7d
         3IFOTESestXas7dDiH9zbnP6kdxqtCgdyFfJSXAfkZy0u09xZr21sYxOaomU4nP5Npzf
         exnt0iwObGjc4FKJDJard1IatgS+AZTrx7Q3F3g0leQl9CRVlje//+ONz5pwrX1SGO3g
         MyQhcwnqtmnUX50dlqIFpFm5yyvhU93CWUn1+tRv6H0pVLdTaigWMSOOx/rnZuMbpA0w
         ABRTKfiDm4aa4JZmOcVHSqvb6RqbDUZL6Gy0FDdpeMPdxFyWZixavlaR8/TqxKynJBbG
         xT1g==
X-Gm-Message-State: AOAM531ebaFgG36GtOlePBCjocmj7OgdevCTpXCJ7jUbkWsFFZhjBvIY
        d9S2d3BxgQVWyi3hn91IOozXFbtKcFgYSs5qjJusj/9aWgyXNRIvLrTrxzgHv8R2saXrsUEh8UX
        6Fn9BaoyLmtKAEHKCYPoREROLEbi5HfLrFA==
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2657767ooo.58.1589966146289;
        Wed, 20 May 2020 02:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIy3EhHB6Bli+83EQbYYBuPXyChPUfp8NVCvBuI0vewTwOjSKjFE4BYbxzLr8JI9Czfm2AIIfVjoXG8pyytvQ=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2657752ooo.58.1589966145980;
 Wed, 20 May 2020 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200515145339.189099-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200515145339.189099-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 May 2020 11:15:34 +0200
Message-ID: <CAFqZXNu7VKQ+hNbV7qsEiUgJ4kVmR4dcDn78t3B8aC+F62NmbQ@mail.gmail.com>
Subject: Re: [PATCH V3] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 4:53 PM Richard Haines
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

Sorry for the delay in review... The function abstraction looks good,
but I spotted another thing that can be improved (see below).

>
>  README.md                        |  4 +-
>  tests/inet_socket/nftables-flush |  2 +
>  tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++
>  tests/inet_socket/test           | 99 ++++++++++++++++++++------------
>  tests/sctp/nftables-flush        |  2 +
>  tests/sctp/nftables-load         | 68 ++++++++++++++++++++++
>  tests/sctp/test                  | 87 +++++++++++++++++-----------
>  7 files changed, 265 insertions(+), 71 deletions(-)
>  create mode 100644 tests/inet_socket/nftables-flush
>  create mode 100644 tests/inet_socket/nftables-load
>  create mode 100644 tests/sctp/nftables-flush
>  create mode 100644 tests/sctp/nftables-load
[...]
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 47ce106..c2ad1ce 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -27,6 +27,19 @@ BEGIN {
>          $test_calipso_stream = 1;
>      }
>
> +    # Determine nftables version, must be >= 0.9.3 for secmark support
> +    # with kernel >= 4.20
> +    $test_nft = 0;
> +    $nft      = `nft -v`;
> +    $nft =~ s/\D//g;
> +    $kverminstream = "4.20";
> +
> +    $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $nft gt "092" and $rc > 0 ) {

I don't quite like this version parsing. What if there comes nftables
v0.10.1 one day? Then this would compare "0101" > "092", which would
fail the check, skipping the test unnecessarily. TIL that nft has this
nice '-c' option, which lets you check if commands are valid on your
system without actually running them. So I think we could replace both
the kernel and nft version checks with just:

$rc = system("nft -c -f nftables-load 2>/dev/null");
if ($rc == 0) {
...

> +        $test_count += 8;
> +        $test_nft = 1;
> +    }
> +
>      plan tests => $test_count;
>  }
>
[...]

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

