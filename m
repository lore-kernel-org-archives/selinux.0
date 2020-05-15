Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0105C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B0920657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqhJZ1KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEONZk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:25:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589549138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gw1Ewsuvc2VoHUXAGEXM1Bw5DXr/lUfgSDQ0Zmu2EcA=;
        b=BqhJZ1KY9y7rBBSfMnROG75BeNFKIdAMCVxwlXvg/C5Is4dtEgBUH2ATf9A9TwTEjbqkmw
        NwBgbfDm1iNjTK/32dpqbxroJFAZHEZiOSFAvCssa7+/e4/GWefsN2VE4iIncizOuu+i2I
        ZGciaeO/jQjLo8mfqObtb6atQJc5UrM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-GrrdhtyvPbGl-I5IalglwA-1; Fri, 15 May 2020 09:25:34 -0400
X-MC-Unique: GrrdhtyvPbGl-I5IalglwA-1
Received: by mail-oi1-f199.google.com with SMTP id b1so1250943oib.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 06:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gw1Ewsuvc2VoHUXAGEXM1Bw5DXr/lUfgSDQ0Zmu2EcA=;
        b=IzlJSVl3FSxC7cNZ5asozwRBVsWATuBsbA1+yMkhQY1xp41bzckcjeIy/yu0tXiXmJ
         g6xeT/hBSmv/h9SbbJEw2mnZQYxXj+2ql+EBoyb5haXbQl11wkbQr98g48R+vsATruAQ
         rSYKavtSxXvH2gg338Kn8EndHeOK+1kmACUjYwqKiPUnKfMzOqYWgZJUeTZii/KdSITE
         uwEpRTjPo+PdtVppSKsuw1KkO56wZIzwNP975bopgY7Nf4PH6iezombtx6GuFlX8GY0K
         VLTEGh0o9ZDHfm1i18RTry4FkMi+rsG7yTOVsN1/e7R1Zq0ZYYRThXr11JNnrdoAzJSh
         +VMw==
X-Gm-Message-State: AOAM532oZ8qB17IQDZXAG8GgmSiQboniu2bpFOWK/ITepcWOpjzM3mTF
        SivQV82WmMYBNU4MslEznbA/vbTx3NAR8lncEE6TYxjg/Ld94E7RhkUoE8LShFLeG33ZDDiCaDd
        +pxFNO3zhdK9KwOTls8bwjw1/cZyFDr3xYg==
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2513185ooo.58.1589549132708;
        Fri, 15 May 2020 06:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZK1wtq9kUwLFFnavcP9B10MxXuRXIqr3oxbiOUaZPjqWjpFCVxQ0d/Pt8Fms8zGGlB/ini1mRuXaZuV12fDU=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2513165ooo.58.1589549132372;
 Fri, 15 May 2020 06:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200515131014.7852-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200515131014.7852-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 15:25:21 +0200
Message-ID: <CAFqZXNt12x0iNQGdzeZr-Hv1CT-tBq42xyv1rh3L=EqK9SbAcQ@mail.gmail.com>
Subject: Re: [PATCH V2] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 3:10 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Support secmark tests that require nftables version 9.3 or greater and
> kernel 4.20 or greater.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Use common tests for iptables/nftables
>
>  README.md                        |   4 +-
>  tests/inet_socket/nftables-flush |   2 +
>  tests/inet_socket/nftables-load  |  74 +++++++++++++++++++++
>  tests/inet_socket/test           | 108 ++++++++++++++++++++-----------
>  tests/sctp/nftables-flush        |   2 +
>  tests/sctp/nftables-load         |  68 +++++++++++++++++++
>  tests/sctp/test                  |  96 +++++++++++++++++----------
>  7 files changed, 281 insertions(+), 73 deletions(-)
>  create mode 100644 tests/inet_socket/nftables-flush
>  create mode 100644 tests/inet_socket/nftables-load
>  create mode 100644 tests/sctp/nftables-flush
>  create mode 100644 tests/sctp/nftables-load
>
[...]
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 47ce106..ce9bd7f 100755
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
> +        $test_count += 8;
> +        $test_nft = 1;
> +    }
> +
>      plan tests => $test_count;
>  }
>
> @@ -348,63 +361,82 @@ if ($test_ipsec) {
>      system "/bin/sh $basedir/ipsec-flush";
>  }
>
> -# Load iptables (IPv4 & IPv6) configuration.
> -system "/bin/sh $basedir/iptables-load";
> +#
> +################## Test iptables/nftables configuration ######################
> +#
> +$test_msg = "Testing iptables (IPv4/IPv6).\n";
> +$cmd      = "/bin/sh";
> +$table    = "iptables";
> +$i        = 0;
> +$loop     = 1;
> +
> +if ($test_nft) {
> +    $loop = 2;
> +}
>
> -# Start the stream server.
> -$pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
> +while ( $i < $loop ) {
> +    print "$test_msg";
> +    system "$cmd $basedir/$table-load";

Ugh, that is ugly... Why not just do something like:

sub test_tables {
    # run the tests...
}
[...]
print "Testing iptables (IPv4/IPv6).\n";
system "/bin/sh $basedir/iptables-load";
test_tables();
system "/bin/sh $basedir/iptables-flush";

print "Testing nftables (IPv4/IPv6).\n";
system "nft -f $basedir/nftables-load";
test_tables();
system "nft -f $basedir/nftables-flush";
[...]

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

