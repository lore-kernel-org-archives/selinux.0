Return-Path: <SRS0=rhON=D5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F4C388F7
	for <selinux@archiver.kernel.org>; Thu, 22 Oct 2020 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AEB24182
	for <selinux@archiver.kernel.org>; Thu, 22 Oct 2020 14:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="N1Zu5p5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444071AbgJVOLR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:11:17 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:24275 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439034AbgJVOLR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Oct 2020 10:11:17 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20201022141115.EVFY14484.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 22 Oct 2020 15:11:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1603375875; 
        bh=LA+WEGDhGMDfSghyVB8i7xaZxvPWSMmOuy3Ghgm0rbI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=N1Zu5p5d5NOtWGwswWirwfzg7IWLNO9YUWolPPdBA0+3WWOGY/pqQ/CCMdmnQloFnZmVnaKu08ZkNTXwK5QrHbUxKc+kIJLEjlc0k3whdvNQKVUmzGLR2ZzkuL2wUMq4S/INBnw6ePuCuTZGeaFTR3rXlZWAHreizgGaIw2k792MaFlSPx77ly1S5l8zn2X1jkpt88ekJN0L4q2LQx6gFvvrr207/w6+QrLISf82/EgoFXAaGDkTWq8V0U+fGCD3os+SB/nWe4mMWTRBNvywN8dv6lJKFv34pQSVz0hObmPZc01gcfmnmF3iR4uoT/VNcIXl0/eUp3oYQ+jFO6rDog==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C0CC17032696
X-Originating-IP: [109.158.127.77]
X-OWM-Source-IP: 109.158.127.77 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppedutdelrdduheekrdduvdejrdejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrjeejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.77) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC17032696; Thu, 22 Oct 2020 15:11:15 +0100
Message-ID: <e27493a79082271836c5fef11d494b052de83319.camel@btinternet.com>
Subject: Re: [PATCH 2/2] tests/sctp: set up a GRE tunnel to activate ASCONF
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Date:   Thu, 22 Oct 2020 15:11:14 +0100
In-Reply-To: <20201021214453.400811-3-omosnace@redhat.com>
References: <20201021214453.400811-1-omosnace@redhat.com>
         <20201021214453.400811-3-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-10-21 at 23:44 +0200, Ondrej Mosnacek wrote:
> Currently, the ASCONF tests will activate only if the test system has
> two global IPv4 addresses, otherwise they are just skipped. Most
> systems, including the VM in CI, don't fulfill this condition.
> 
> As it turns out, this second IPv4 address can be set up very easily
> by
> creating a GRE trunnel interface over loopback. So make the SCTP test
> create such interface so that the ASCONF tests can be always run.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/sctp/test | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> diff --git a/tests/sctp/test b/tests/sctp/test
> index eede42f..1170921 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -35,6 +35,12 @@ BEGIN {
>      else {
>          $test_count = 75;
>  
> +        # Set up a GRE tunnel over loopback to ensure we have enough
> addresses
> +        # for the ASCONF tests.
> +        system "ip link add mygre type gretap local 127.0.0.1 remote
> 127.0.0.1";
> +        system "ip addr add 10.123.123.123 dev mygre";
> +        system "ip link set mygre up";
> +
>          # asconf parameter tests require two local non-loopback
> addresses.
>          $ipaddress_list = `ip -o addr show up scope global`;
>          $test_asconf    = 0;
> @@ -909,4 +915,6 @@ if ($test_nft) {
>      system "nft -f $basedir/nftables-flush";
>  }
>  
> +system "ip link del mygre";
> +
>  exit;

