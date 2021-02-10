Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6732C433E6
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83AC64E87
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhBJPDB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:03:01 -0500
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:51193 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231876AbhBJPCb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 10:02:31 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20210210150142.WPYR29410.sa-prd-fep-040.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 10 Feb 2021 15:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1612969302; 
        bh=9xWE1mrG7nb7GG8bN9GqYrT4OYT93VzCoxP2sLAd8lM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=TSdOVDd/nvPnK899Y/3/TLFjJEH8uZtEqzdPsN4W0xYxskY2JZv8fB+qQ9i8PcZxiInhVa/EnB6/L9hVqa+k/0cmrz5zNxfPiteUsr+HHTekm+gRKT5J0rNqYX2+3fATU+2ZF7lS3mmwcP7xiQ8baeK6/iNuun4sQcEf89oAOZNDPKtFtt+V6Ny2cYsjccfgYRRyHb1iIpdiOsjH49+K51HSMTNLOvgIaTab5sUvhHE433WB/hZKBaRoEUAwXVuXdHZoJ+dEMSmBtEKte1afWPsOimAOB7FXpaJcqFIF4apdtu9sJfBynd1L3/cER1wp2j2GqS1pNDxgeAVGaajNlg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED99EC9267B6D52
X-Originating-IP: [86.184.36.196]
X-OWM-Source-IP: 86.184.36.196 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudekgedrfeeirdduleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudekgedrfeeirdduleeipdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhk
        vghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.184.36.196) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED99EC9267B6D52; Wed, 10 Feb 2021 15:01:41 +0000
Message-ID: <960f300d47abf038355dfb48fb5f56fbaa4b62f0.camel@btinternet.com>
Subject: Re: [PATCH] selinux-notebook: Add new section for Embedded Systems
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        paul@paul-moore.com
Date:   Wed, 10 Feb 2021 15:01:35 +0000
In-Reply-To: <ypjl1rdpqgy8.fsf@defensec.nl>
References: <20210125112409.6956-1-richard_c_haines@btinternet.com>
         <ypjl1rdpqgy8.fsf@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2021-02-09 at 18:38 +0100, Dominick Grift wrote:
> Richard Haines <richard_c_haines@btinternet.com> writes:
> 
> > Add a new section and supporting examples for embedded systems.
> 
> Looks good. Thanks
> 
> I will probably submit a patch once this one is committed that
> expands a
> little on the OpenWrt scenario.

This patch has already been commited by Paul on 27th Jan. This
particular email was sent on the 25th Jan but got lost so I resent.
Looks like this one only took 14 days to finally get delivered.

