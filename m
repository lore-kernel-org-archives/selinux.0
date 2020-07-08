Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBDC433E0
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFEA206DF
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="YnW65uqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgGHPKB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:10:01 -0400
Received: from mailomta22-re.btinternet.com ([213.120.69.115]:58624 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgGHPJ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 11:09:59 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200708150957.IQJM13627.re-prd-fep-042.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 8 Jul 2020 16:09:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594220997; 
        bh=XPwoOMbcCB6+K2G/ZIpeSjLTDAb/uI69Iq90VvoM5BM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=YnW65uqVFCB/WKo2XeyAHoCsPVD4mDclKLGgcWcnT/82c8/e2oq/n3q8jdIlYbmi5R8DHhoFAXDuJCRhC5N5jZebNN0f/UOkZKRIq7tG+hmdvuvmhNQjWhYLVIyeOViiLLe+gniUKST00dToRMxbAVMtH5eaDqBGXp1fiInbMD+L4RSI5UzURvp275XeA5MyfI2IkHsdCM4spf4Xo/LMtNkRE7+RsXVgl2q33Vw6Dne2j1aw8FZZC1EjVnN9bFpsSgWd4rdu6JIAleTImE2+mrP0L1KeTb6HV5saWP8gO90d8T0SRi+WjizsHNDAx0zSffYz+Joi81UPegjQhDKqJg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.148.83.76]
X-OWM-Source-IP: 109.148.83.76 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepteetveegheevieeifeekvdeiheejvedtieelfffffeevleeijeevvdejvdduudegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtledrudegkedrkeefrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehnfhhsqdgtlhhivghnthdpihhnvghtpedutdelrddugeekrdekfedrjeeipdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from nfs-client (109.148.83.76) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C74D05DA1BFB; Wed, 8 Jul 2020 16:09:57 +0100
Message-ID: <84b9f79f814d4a482cf3309e50a1aaffad755be0.camel@btinternet.com>
Subject: Re: ANN: The SELinux Notebook in markdown on GitHub
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:33 +0100
In-Reply-To: <CAHC9VhTuDrgzeh9mXgkW98psssUCwy5i7_=Kx6hOyinfLjcd0w@mail.gmail.com>
References: <CAHC9VhTuDrgzeh9mXgkW98psssUCwy5i7_=Kx6hOyinfLjcd0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-07-07 at 16:55 -0400, Paul Moore wrote:
> If you've followed the SELinux developers mailing list for a while,
> you've surely heard of The SELinux Notebook.  For those of you that
> haven't, The SELinux Notebook is an effort by Richard Haines to
> document all the different aspects of SELinux from the kernel up
> through policy.  It's an impressive piece of work, spanning ~345
> pages
> in the current edition.
> 
> Richard has always made The SELinux Notebook freely available, but
> with the latest edition Richard has converted the entire document to
> markdown and it is now available on GitHub at the link below:
> 
> * https://github.com/SELinuxProject/selinux-notebook
> 
> Richard has decided that he enjoys life enough without a GitHub
> account, so I've posted it on his behalf and with his approval.
> Needless to say, this is a significant gift to the SELinux community,
> and we all own Richard our thanks.
> 
> I've made a few tweaks to the original import from Richard, but these
> have mostly been limited to boilerplate, organization, and some
> build/formatting fixes so that we could generate a reasonable PDF for
> this initial "release".  The latest edition (release?) can be found
> at
> the link below:

Paul - Thanks for getting this into shape and adding to GitHub. The PDF
now looks good

> 
> * 
> https://github.com/SELinuxProject/selinux-notebook/releases/tag/20200707
> 
> It is my hope that we can treat this as a living document, keeping it
> current so that it stays relevant and useful.  Those who wish to help
> and contribute to the effort can do so via patches to the SELinux
> mailing list or via GitHub PRs.  The CONTRIBUTING.md file in the
> repository has more information.
> 
> Thank you Richard!
> 

