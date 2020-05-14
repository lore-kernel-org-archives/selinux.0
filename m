Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40390C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCE520671
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 09:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxQ1oY/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENJul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 05:50:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725878AbgENJul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 05:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589449838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bg9Qj0SP/bnO1YMjxeqCdDOoEq/m6f4/LZub8oP/K5g=;
        b=JxQ1oY/Oq1qSkhLmkVvslh2PyplCEvKepxCW48DeIsVWNPqjmvOq+7W/RmZns4ezeWn84t
        L/BR4u/hQcbL/EVi1gytFI511WirDIB6sBp0pumxQTfAro7uWI2P+jhf12HzdFfi8ABzdo
        +mgOgrs4Rb13jDREEqPOnqp87UDSapQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WwHxzK66M_Sr8H8WyNCstQ-1; Thu, 14 May 2020 05:50:34 -0400
X-MC-Unique: WwHxzK66M_Sr8H8WyNCstQ-1
Received: by mail-ot1-f70.google.com with SMTP id v1so1052806ote.13
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 02:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg9Qj0SP/bnO1YMjxeqCdDOoEq/m6f4/LZub8oP/K5g=;
        b=Uo+Sq23mxuzflUlmTKOBpFzUo5DzbFTaO/2rNXg7Ax5cK97sUjC7B07FfFFStVBfnV
         rPRFvTkKjtdrZ5aOB3ovPi94bnKHdmZVtEnG09Ldj04YYTt5JqRBaec6OFb3tAQ/wmEK
         +4VfNA4/98I53XUHEcvxjWaFu2IJ4+5DKkXMNqCWxAi2lvEGAk2C3FC/MRoVzRfFP6/n
         /Q3wfMlGHvCMTNraxiAXlXu/NOFLJPnaYuHr/iMsAvdkn6e+XcrfACP/Icp8gyHPjDno
         Jovp2/1+pzn3SjaqsSr8Q05fyIV9+JqdPb9BC+QcouUaHHWbli0qcg5qJga4wHwvfntL
         cDmg==
X-Gm-Message-State: AOAM532jhORn4fm1NhjVK1/oKG5MJpBs24/N1O4aJlu5l5WTIGPtegHj
        Mqs/J1Eg1fzrmP41wSsPzllUBwbEQDbvJxQesloNuy12REyiA2S9e4Z/jHOzyl74DejHBvPC1Gq
        cnCm6HMqzeciR+r4qCNbHyxz0jh19sUnGHw==
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr2890603oth.66.1589449833215;
        Thu, 14 May 2020 02:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtXR842Ilqcf7tVvcoGtiKEq8iT7K9//ugDgh37ZDfZzUZ4Qoei8TIMqew6bEZQiA9npFbjA7sEmp0uTN3SH8=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr2890585oth.66.1589449832851;
 Thu, 14 May 2020 02:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200510132620.39873-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200510132620.39873-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 May 2020 11:50:21 +0200
Message-ID: <CAFqZXNvZvXYZpJNLAK=iuW5+ouwjQWHWbh_Jy2_dqbHbBN8VCA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add nftables to inet_socket and sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Sun, May 10, 2020 at 3:26 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Support secmark tests that require nftables version 9.3 or greater and
> kernel 4.20 or greater.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  README.md                        |  4 +-
>  tests/inet_socket/nftables-flush |  2 +
>  tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++++++++++
>  tests/inet_socket/test           | 72 +++++++++++++++++++++++++++++++
>  tests/sctp/nftables-flush        |  2 +
>  tests/sctp/nftables-load         | 68 +++++++++++++++++++++++++++++
>  tests/sctp/test                  | 74 ++++++++++++++++++++++++++++++++
>  7 files changed, 295 insertions(+), 1 deletion(-)
>  create mode 100644 tests/inet_socket/nftables-flush
>  create mode 100644 tests/inet_socket/nftables-load
>  create mode 100644 tests/sctp/nftables-flush
>  create mode 100644 tests/sctp/nftables-load

Thanks, this seems to work fine on Fedora 32 and even on RHEL-8 (after
adjusting the kernel version check). However, I have some style
suggestions (see below).

>
[...]
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 47ce106..b551961 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
[...]
> @@ -406,6 +419,65 @@ server_end($pid);
>  # Flush iptables configuration.
>  system "/bin/sh $basedir/iptables-flush";
>
> +# Load nftables (IPv4 & IPv6) configuration.
> +if ($test_nft) {
> +    system "nft -f $basedir/nftables-load";
> +
> +    # Start the stream server.
> +    $pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
> +
> +    # Verify that authorized client can communicate with the server.
> +    $result = system
> +"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535";
> +    ok( $result eq 0 );
> +
> +    # Verify that unauthorized client cannot communicate with the server.
> +    $result = system
> +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
> +    ok( $result >> 8 eq 5 );
> +
> +    # Verify that authorized client can communicate with the server.
> +    $result = system
> +"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
> +    ok( $result eq 0 );
> +
> +    # Verify that unauthorized client cannot communicate with the server.
> +    $result = system
> +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
> +    ok( $result >> 8 eq 5 );
> +
> +    # Kill the server.
> +    server_end($pid);
> +
> +    # Start the dgram server.
> +    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
> +
> +    # Verify that authorized client can communicate with the server.
> +    $result = system
> +"runcon -t test_inet_client_t $basedir/client -e nopeer dgram 127.0.0.1 65535";
> +    ok( $result eq 0 );
> +
> +    # Verify that unauthorized client cannot communicate with the server.
> +    $result = system
> +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
> +    ok( $result >> 8 eq 8 );
> +
> +    # Verify that authorized client can communicate with the server.
> +    $result = system
> +      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
> +    ok( $result eq 0 );
> +
> +    # Verify that unauthorized client cannot communicate with the server.
> +    $result = system
> +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
> +    ok( $result >> 8 eq 8 );
> +
> +    # Kill the server.
> +    server_end($pid);
> +
> +    system "nft -f $basedir/nftables-flush";
> +}

It seems that this block of tests is the same for both iptables and
nftables... could you extract it into a single shared function? I
think you were reluctant to do that because then you can't tell from
the line number in the test output which test has failed (iptables or
nftables), but I don't think it's worth the duplication here. AFAIK,
in case 2+ "ok()" calls are done from the same line, the test failure
report includes the number of the call that failed, so it should be
pretty easy to tell which variant has failed. Anyway, I would expect
that in 90% of cases either both calls pass or both fail.

> +
>  if ($test_calipso_stream) {
>
>      # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
[...]
> diff --git a/tests/sctp/test b/tests/sctp/test
> index 6631da4..afd28a1 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
[...]
> @@ -809,4 +819,68 @@ server_end($pid);
>
>  system "/bin/sh $basedir/iptables-flush";
>
> +#
> +##################### Test nftables configuration ############################
> +#
> +if ($test_nft) {
> +    print "# Testing nftables (IPv4/IPv6).\n";
> +    system "nft -f $basedir/nftables-load";
> +
> +    # Start the stream server.
> +    $pid = server_start( "-t test_sctp_server_t",
> +        "sctp_server", "$v -n stream 1035" );
> +
> + # Verify that authorized client can communicate with the server STREAM->STREAM.
> +    $result = system
> +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035";
> +    ok( $result eq 0 );
> +
> +# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
> +    $result = system
> +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
> +    ok( $result >> 8 eq 6 );
> +
> + # Verify that authorized client can communicate with the server STREAM->STREAM.
> +    $result = system
> +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
> +    ok( $result eq 0 );
> +
> +# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
> +    $result = system
> +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
> +    ok( $result >> 8 eq 6 );
> +
> +    # Kill the stream server.
> +    server_end($pid);
> +
> +    # Start the seq server.
> +    $pid =
> +      server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
> +
> +    # Verify that authorized client can communicate with the server SEQ->SEQ.
> +    $result = system
> +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035";
> +    ok( $result eq 0 );
> +
> +# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
> +    $result = system
> +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
> +    ok( $result >> 8 eq 6 );
> +
> +    # Verify that authorized client can communicate with the server SEQ->SEQ.
> +    $result = system
> +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
> +    ok( $result eq 0 );
> +
> +# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
> +    $result = system
> +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
> +    ok( $result >> 8 eq 6 );
> +
> +    # Kill the seq server.
> +    server_end($pid);

Same comment as above.

> +
> +    system "nft -f $basedir/nftables-flush";
> +}
> +
>  exit;
> --
> 2.25.3
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

