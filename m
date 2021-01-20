Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B4FC433E0
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8E622573
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 12:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbhATMVm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:21:42 -0500
Received: from mailomta5-sa.btinternet.com ([213.120.69.11]:35116 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732101AbhATLz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 06:55:56 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20210120115512.BRPL28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 20 Jan 2021 11:55:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1611143712; 
        bh=c2vRwTO7GTdmLt0+uT9Q3hJULeYILhdBxVMsWq97xUY=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=fy5mafaZNNkhUeOBj08qL2/GEA9YuDcODprqd0J3JBJJ7zDyCUiVpH248sZOpA4HlqvCm69kl13z7818sYatK2L6MaSV0KUEJpLVy8nwn1Gk0emlK/uw/YQd6buz+0gptsv6I1LQV+5a5uhm7aSy1W2G5tZT0iiJvogwFmMZV3UY3pW6SQo+V/MRCQ2wT3QhLuLsxX7dcbmlhdZQzTTHHPDbcGcDLZwN+UnCs8CxCUd7MourJsp3wpI/xE0famAd8cBgecsWuIT88abMYIT5VdflOzlvt4gO23N/kldyzHJ9eVR/sTSm8z7w321JKiiNBWhpE5gSbz0lHQtfT0r7rQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9AFBE23A4C332
X-Originating-IP: [109.158.127.42]
X-OWM-Source-IP: 109.158.127.42 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepteetveegheevieeifeekvdeiheejvedtieelfffffeevleeijeevvdejvdduudegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtledrudehkedruddvjedrgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedutdelrdduheekrdduvdejrdegvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlheqpdhrtghpthhtohepoehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
        gheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.158.127.42) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE23A4C332; Wed, 20 Jan 2021 11:55:11 +0000
Message-ID: <8776cbb2687a09ed5b4e5b3cf0c50ade6c018fa6.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] selinux-notebook: Add new section for Embedded
 Systems
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Date:   Wed, 20 Jan 2021 11:55:02 +0000
In-Reply-To: <ypjleeihm5e0.fsf@defensec.nl>
References: <20210119105747.9680-1-richard_c_haines@btinternet.com>
         <20210119105747.9680-2-richard_c_haines@btinternet.com>
         <ypjleeihm5e0.fsf@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2021-01-19 at 14:18 +0100, Dominick Grift wrote:
> Richard Haines <richard_c_haines@btinternet.com> writes:
> 
> > Add a new section and supporting examples for embedded systems.
> 
> Nice initiative, thanks. Looks pretty solid for a first iteration.
> 
> I wrote a document for OpenWrt here [1]. Basically the instructions
> needed
> to assemble OpenWrt from modules applicable to a particular system,
> but also how
> to build on top of it, or now to just fork it so that you can use it
> as
> a base for your own policy.
> 
> [1] 
> https://github.com/doverride/openwrt-selinux-policy/blob/master/README.md
> 
> I am currently pretty happy with the results so far (its a work in
> progress, and there are known loose ends)
> 
> One of the differences compared with android is that SELinux is not
> tightly integrated in OpenWrt, and so most of the tough aspects are
> addressed in policy
> rather than adding selinux-awareness all over. SELinux in OpenWrt is
> therefore
> fairly self-contained and considering the challenges fairly robust.
> 

Thanks, I've worked these comments into the next version.


