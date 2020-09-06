Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A651C433E2
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28A0206B5
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="oVpqak6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIFN75 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Sep 2020 09:59:57 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:14737 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgIFN74 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Sep 2020 09:59:56 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200906135930.IIWI5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 6 Sep 2020 14:59:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599400770; 
        bh=IABhlc2bldc8f7OCKKHpYC7ppBiRBGa3NN/wv7Hhqr0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=oVpqak6JbuUVI6dQdyV82E1NpZWw3VzjAKnWE39d+aC9/rxFz/7nKuGV//27omI5tAA5jLDSVNh1OK3fu6U2DH5L/2jqveuwYcQ5Tw8gooSOwnnRFqqwxL5ygbwqBksnprG/IZJbykLl+uXADbYUXG7ve6zjM+6owRKmtrlFuwwUeAfuijV7jjeWXjj1evll6ZdBc6WHwBcwwvJDGlSrARDdbhxfyO7hQzxdgrgRY3zfjH30AB7yfv91aNpJxi6NUgnFsxLLaQdVUl2DomgN5yOK+L+hOQWNYcJYROPRHljlPzddWdPPdWw0VaFxyka/mtRGRJ20KIV/EEc5HqhOlA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.155.130.182]
X-OWM-Source-IP: 109.155.130.182 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudegjedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvedtjedtgfdtvddtjeeitdfhfeetvdetieelfefgjeetfefghfekvdelgfevheetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtledrudehhedrudeftddrudekvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudekvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegtghiiohhnvghssehgohhoghhlvghmrghilhdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.182) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B6610F94249D; Sun, 6 Sep 2020 14:59:30 +0100
Message-ID: <7f1d72fc03daf42f7977248379cd02aa663cc076.camel@btinternet.com>
Subject: Re: [RFC PATCH] xperm_rules: add two notes
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Date:   Sun, 06 Sep 2020 14:59:22 +0100
In-Reply-To: <20200904161834.7677-1-cgzones@googlemail.com>
References: <20200904161834.7677-1-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-09-04 at 18:18 +0200, Christian Göttsche wrote:
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> I *hope* the note number 4 is actually correct!?

It is correct as noted in [1]. checkpolicy allows 0x1234ABCD and just
uses ABCD whereas CIL only allows 0xABCD.

[1] 
https://lore.kernel.org/selinux/1495656704.3489.4.camel@tycho.nsa.gov/

> 
>  src/xperm_rules.md | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/xperm_rules.md b/src/xperm_rules.md
> index 7f8744b..1e1dfff 100644
> --- a/src/xperm_rules.md
> +++ b/src/xperm_rules.md
> @@ -1,6 +1,6 @@
>  # Extended Access Vector Rules
>  
> -There are three extended AV rules implemented from Policy version 30
> +There are four extended AV rules implemented from Policy version 30

Yes I think they all came under policy 30. It's just that
neverallowxperm was added a few months later.


>  with the target platform 'selinux' that expand the permission sets
> from
>  a fixed 32 bits to permission sets in 256 bit increments:
> *allowxperm*,
>  *dontauditxperm*, *auditallowxperm* and *neverallowxperm*.
> @@ -127,6 +127,12 @@ Notes:
>      class/permission is required.
>  3.  To deny all ioctl requests for a specific source/target/class
> the
>      *xperm_set* should be set to *0* or *0x0*.
> +4.  From the 32-bit ioctl request parameter value only the least
> significant
> +    16 bits are used. Thus *0x8927*, *0x00008927* and *0xabcd8927*
> +    are the same extended permission.
> +5.  To decode a numeric ioctl request parameter into the
> corresponding
> +    textual identifier see
> +    <
> https://www.kernel.org/doc/html/latest/userspace-api/ioctl/ioctl-decoding.html
> >
>  
>  <!-- %CUTHERE% -->
>  

