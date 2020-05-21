Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE9C433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8730F206F6
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 10:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="XY26ri09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEUK4w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 06:56:52 -0400
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:49465 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727864AbgEUK4v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 06:56:51 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200521105648.BOBE4003.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 21 May 2020 11:56:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1590058608; 
        bh=7OAt1udcKjdYrv7zjyoa8UJBVkIB7D39OZPsbAt8xeU=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=XY26ri09HS489ftadeAIWMpxvHKigdDn9kBkzJAZZlPrG+PrW1DK3CrllZz+mDUJ6puBnf3mxfx0WS9UavN1/d7Al9oQkTKUOuFtogwIAnSsfPUft8tCKcaWufWz7pa3vNhiHrdVv8HPDX9B2PuyO436W+zQqLaNqstWKm0/uX1EPgUaMxM5SDACQeVeMHnseqabdbUPxVVUftDqBtkEMQ0wDq+Mtt1vpJ4LuCwRqr6knYYyqCaYZszi5/HpKEYoH1C4ThQvYkY9h+2nAl02kRAClRpuik1zm1a4ErLKsSEI8O18GGogCzXrjX8eFzChhED85LKI2+/AHnCM1YgvEw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.148.83.78]
X-OWM-Source-IP: 109.148.83.78 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudduuddgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepuddtledrudegkedrkeefrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudegkedrkeefrdejkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.148.83.78) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A15B611B04913; Thu, 21 May 2020 11:56:48 +0100
Message-ID: <c0f03bf125c7d7518e1e8a3b341bdd2342e03808.camel@btinternet.com>
Subject: Re: [PATCH V4] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Thu, 21 May 2020 11:56:47 +0100
In-Reply-To: <CAFqZXNt9f21xXUnu3ek4cihcx1zCkMs5a72XRxcEAO+=bDPFWg@mail.gmail.com>
References: <20200520122546.30442-1-richard_c_haines@btinternet.com>
         <CAFqZXNt9f21xXUnu3ek4cihcx1zCkMs5a72XRxcEAO+=bDPFWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-05-21 at 12:00 +0200, Ondrej Mosnacek wrote:
> On Wed, May 20, 2020 at 2:25 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Support secmark tests that require nftables version 9.3 or greater
> > and
> > kernel 4.20 or greater.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change:
> > Use common tests for iptables/nftables
> > V3 Change:
> > Use function
> > V4 Changes:
> > Add nftables to README for Debian
> > Use nft -c to determine if SECMARK supported
> > 
> >  README.md                        |  7 ++-
> >  tests/inet_socket/nftables-flush |  2 +
> >  tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++
> >  tests/inet_socket/test           | 99 ++++++++++++++++++++------
> > ------
> >  tests/sctp/nftables-flush        |  2 +
> >  tests/sctp/nftables-load         | 68 ++++++++++++++++++++++
> >  tests/sctp/test                  | 90 ++++++++++++++++++--------
> > ---
> >  7 files changed, 270 insertions(+), 72 deletions(-)
> >  create mode 100644 tests/inet_socket/nftables-flush
> >  create mode 100644 tests/inet_socket/nftables-load
> >  create mode 100644 tests/sctp/nftables-flush
> >  create mode 100644 tests/sctp/nftables-load
> [...]
> > diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> > index 47ce106..6c82719 100755
> > --- a/tests/inet_socket/test
> > +++ b/tests/inet_socket/test
> > @@ -27,6 +27,19 @@ BEGIN {
> >          $test_calipso_stream = 1;
> >      }
> > 
> > +    # Determine if nftables has secmark support and kernel >= 4.20
> > +    $test_nft = 0;
> > +
> > +    $rc = system("nft -c -f $basedir/nftables-load 2>/dev/null");
> > +    if ( $rc == 0 ) {
> > +        $kverminstream = "4.20";
> > +        $rc            = `$basedir/../kvercmp $kvercur
> > $kverminstream`;
> > +        if ( $rc > 0 ) {
> > +            $test_count += 8;
> > +            $test_nft = 1;
> > +        }
> > +    }
> > +
> >      plan tests => $test_count;
> >  }
> 
> Sorry for bothering you again, but I believe we can drop the kernel
> version check here as well (as I said in the previous reply). When I
> strace the nft -c -f ... command, I can see it actually sending
> netlink messages to the kernel, so it should be able to transparently
> detect missing kernel support as well. I just tried it on a RHEL-7
> box
> with nftables v0.9.4 compiled from source and the command failed with
> many errors so I think that confirms it. I'd like us to avoid
> hard-coded kernel version checks (they may be unreliable on kernels
> with backports) when there is an easy way to detect support directly.
> 

No problem, I should read, digest and take note etc. !!!!

> Thanks,
> 

