Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECFBC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8220657
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="YTI2I259"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgENPF3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 11:05:29 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:34008 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgENPF3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 11:05:29 -0400
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20200514150525.DMXF4342.sa-prd-fep-049.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 14 May 2020 16:05:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589468725; 
        bh=Hb4RGAhEvd3aDq4D23eDh02Yl06UevKEcmFCeHPeCi0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=YTI2I259hgY8gEHQw7Cs/YeyUbUtMsFseDe8yaVyAfRvW1yqccEJpr6172v/TZexgm13HttHeDvu5RiA38AZst6zcqYq99VAoDvaKJaLsmRz5QpOlcv0uoQBnP7gjkkIpnLAspR9f0Or+yCeXZRUQa0PoyM3nsmrZpSmyD9fgU7uaWoUnTafn6gZXllMb5r085rJByx3ORXQfjDg+Ks7sA8bouuf9aHPypb2J5w7YGmnVmd9TX6avRIqc9OtK9E57K3995Dss4ORu5/c1r6qQFtA63GCxHecPxm2EDyke8W4bDHnIof/wHAYFKTxofW5iGY2QNSQwGkk2B0WVDiDsQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.156.13.4]
X-OWM-Source-IP: 86.156.13.4 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrleeigdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudehiedrudefrdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehiedrudefrdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.156.13.4) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A254B10A338AB; Thu, 14 May 2020 16:05:25 +0100
Message-ID: <8ca78b86cad476f6748f58df5bb41a3d5c017d3f.camel@btinternet.com>
Subject: Re: [PATCH] selinux-testsuite: Add nftables to inet_socket and sctp
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Thu, 14 May 2020 16:05:24 +0100
In-Reply-To: <CAFqZXNvZvXYZpJNLAK=iuW5+ouwjQWHWbh_Jy2_dqbHbBN8VCA@mail.gmail.com>
References: <20200510132620.39873-1-richard_c_haines@btinternet.com>
         <CAFqZXNvZvXYZpJNLAK=iuW5+ouwjQWHWbh_Jy2_dqbHbBN8VCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-05-14 at 11:50 +0200, Ondrej Mosnacek wrote:
> Hi,
> 
> On Sun, May 10, 2020 at 3:26 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Support secmark tests that require nftables version 9.3 or greater
> > and
> > kernel 4.20 or greater.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  README.md                        |  4 +-
> >  tests/inet_socket/nftables-flush |  2 +
> >  tests/inet_socket/nftables-load  | 74
> > ++++++++++++++++++++++++++++++++
> >  tests/inet_socket/test           | 72
> > +++++++++++++++++++++++++++++++
> >  tests/sctp/nftables-flush        |  2 +
> >  tests/sctp/nftables-load         | 68
> > +++++++++++++++++++++++++++++
> >  tests/sctp/test                  | 74
> > ++++++++++++++++++++++++++++++++
> >  7 files changed, 295 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/inet_socket/nftables-flush
> >  create mode 100644 tests/inet_socket/nftables-load
> >  create mode 100644 tests/sctp/nftables-flush
> >  create mode 100644 tests/sctp/nftables-load
> 
> Thanks, this seems to work fine on Fedora 32 and even on RHEL-8
> (after
> adjusting the kernel version check). However, I have some style
> suggestions (see below).
> 
> [...]
> > diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> > index 47ce106..b551961 100755
> > --- a/tests/inet_socket/test
> > +++ b/tests/inet_socket/test
> [...]
> > @@ -406,6 +419,65 @@ server_end($pid);
> >  # Flush iptables configuration.
> >  system "/bin/sh $basedir/iptables-flush";
> > 
> > +# Load nftables (IPv4 & IPv6) configuration.
> > +if ($test_nft) {
> > +    system "nft -f $basedir/nftables-load";
> > +
> > +    # Start the stream server.
> > +    $pid = server_start( "-t test_inet_server_t", "-n stream
> > 65535" );
> > +
> > +    # Verify that authorized client can communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream
> > 127.0.0.1 65535";
> > +    ok( $result eq 0 );
> > +
> > +    # Verify that unauthorized client cannot communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer
> > stream 127.0.0.1 65535 2>&1";
> > +    ok( $result >> 8 eq 5 );
> > +
> > +    # Verify that authorized client can communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream
> > ::1 65535";
> > +    ok( $result eq 0 );
> > +
> > +    # Verify that unauthorized client cannot communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer
> > stream ::1 65535 2>&1";
> > +    ok( $result >> 8 eq 5 );
> > +
> > +    # Kill the server.
> > +    server_end($pid);
> > +
> > +    # Start the dgram server.
> > +    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535"
> > );
> > +
> > +    # Verify that authorized client can communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_client_t $basedir/client -e nopeer dgram
> > 127.0.0.1 65535";
> > +    ok( $result eq 0 );
> > +
> > +    # Verify that unauthorized client cannot communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer
> > dgram 127.0.0.1 65535 2>&1";
> > +    ok( $result >> 8 eq 8 );
> > +
> > +    # Verify that authorized client can communicate with the
> > server.
> > +    $result = system
> > +      "runcon -t test_inet_client_t $basedir/client -e nopeer
> > dgram ::1 65535";
> > +    ok( $result eq 0 );
> > +
> > +    # Verify that unauthorized client cannot communicate with the
> > server.
> > +    $result = system
> > +"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer
> > dgram ::1 65535 2>&1";
> > +    ok( $result >> 8 eq 8 );
> > +
> > +    # Kill the server.
> > +    server_end($pid);
> > +
> > +    system "nft -f $basedir/nftables-flush";
> > +}
> 
> It seems that this block of tests is the same for both iptables and
> nftables... could you extract it into a single shared function? I
> think you were reluctant to do that because then you can't tell from
> the line number in the test output which test has failed (iptables or
> nftables), but I don't think it's worth the duplication here. AFAIK,
> in case 2+ "ok()" calls are done from the same line, the test failure
> report includes the number of the call that failed, so it should be
> pretty easy to tell which variant has failed. Anyway, I would expect
> that in 90% of cases either both calls pass or both fail.
> 

I'll rework this to be like the nfs_filesystem test that had 28 tests x
2 with a minor change in each cycle.

> > +
> >  if ($test_calipso_stream) {
> > 
> >      # Load NetLabel configuration for CALIPSO/IPv6 labeling over
> > loopback.
> [...]
> > diff --git a/tests/sctp/test b/tests/sctp/test
> > index 6631da4..afd28a1 100755
> > --- a/tests/sctp/test
> > +++ b/tests/sctp/test
> [...]
> > @@ -809,4 +819,68 @@ server_end($pid);
> > 
> >  system "/bin/sh $basedir/iptables-flush";
> > 
> > +#
> > +##################### Test nftables configuration
> > ############################
> > +#
> > +if ($test_nft) {
> > +    print "# Testing nftables (IPv4/IPv6).\n";
> > +    system "nft -f $basedir/nftables-load";
> > +
> > +    # Start the stream server.
> > +    $pid = server_start( "-t test_sctp_server_t",
> > +        "sctp_server", "$v -n stream 1035" );
> > +
> > + # Verify that authorized client can communicate with the server
> > STREAM->STREAM.
> > +    $result = system
> > +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer
> > stream 127.0.0.1 1035";
> > +    ok( $result eq 0 );
> > +
> > +# Verify that a client without peer { recv } permission cannot
> > communicate with the server STREAM->STREAM.
> > +    $result = system
> > +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v
> > -e nopeer stream 127.0.0.1 1035 2>&1";
> > +    ok( $result >> 8 eq 6 );
> > +
> > + # Verify that authorized client can communicate with the server
> > STREAM->STREAM.
> > +    $result = system
> > +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer
> > stream ::1 1035";
> > +    ok( $result eq 0 );
> > +
> > +# Verify that a client without peer { recv } permission cannot
> > communicate with the server STREAM->STREAM.
> > +    $result = system
> > +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v
> > -e nopeer stream ::1 1035 2>&1";
> > +    ok( $result >> 8 eq 6 );
> > +
> > +    # Kill the stream server.
> > +    server_end($pid);
> > +
> > +    # Start the seq server.
> > +    $pid =
> > +      server_start( "-t test_sctp_server_t", "sctp_server", "$v -n
> > seq 1035" );
> > +
> > +    # Verify that authorized client can communicate with the
> > server SEQ->SEQ.
> > +    $result = system
> > +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer
> > seq 127.0.0.1 1035";
> > +    ok( $result eq 0 );
> > +
> > +# Verify that a client without peer { recv } permission cannot
> > communicate with the server SEQ->SEQ.
> > +    $result = system
> > +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v
> > -e nopeer seq 127.0.0.1 1035 2>&1";
> > +    ok( $result >> 8 eq 6 );
> > +
> > +    # Verify that authorized client can communicate with the
> > server SEQ->SEQ.
> > +    $result = system
> > +"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer
> > seq ::1 1035";
> > +    ok( $result eq 0 );
> > +
> > +# Verify that a client without peer { recv } permission cannot
> > communicate with the server SEQ->SEQ.
> > +    $result = system
> > +"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v
> > -e nopeer seq ::1 1035 2>&1";
> > +    ok( $result >> 8 eq 6 );
> > +
> > +    # Kill the seq server.
> > +    server_end($pid);
> 
> Same comment as above.
> 
> > +
> > +    system "nft -f $basedir/nftables-flush";
> > +}
> > +
> >  exit;
> > --
> > 2.25.3
> > 

