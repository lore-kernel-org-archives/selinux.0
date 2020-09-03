Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C0C43461
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6634820716
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HEz0FeEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICQLr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:11:47 -0400
Received: from mailomta18-sa.btinternet.com ([213.120.69.24]:12406 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgICQLp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 12:11:45 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200903161140.UEAR5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 3 Sep 2020 17:11:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599149500; 
        bh=tZb6DW+c+0LZQLUCQgdx35uKCxB0NfPEtpyKY9M/U7M=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=HEz0FeEo2KvqJVNuEGH6WL9+3Xte+9uRh9Y/US7va+mYYo/htfIPTrMwjEvHlRRtd/nho1xIBrNKrk6SDXWd9qmQCcmhUln7eao3vp2IIGRwFwGjHPDOIQePtaX+naJCgHX2WiSQrC8hcOoExHNWlCSSbEr9aphQGoEQvw+Mo2+KvU2A0O94Jur3WLd4QHZsDIC9SIDmstykHbu+NQ6uWz+omnnmjooholvw5VjrOp+9iKQxx9ILOAM9i+9mO1eRL9nrP4Oz7h2g3cf+kBB9lbhEYBJcpdi4WYtW5u1rvl9Um4CQV9W9kgCz4qB4NLRuj1sUYXN8W/tUZ7WUZXuYtQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.183.71.58]
X-OWM-Source-IP: 86.183.71.58 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudekfedrjedurdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeefrdejuddrheekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.71.58) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70F246206; Thu, 3 Sep 2020 17:11:40 +0100
Message-ID: <6702e7d809369332b73c6612a641115d360414ec.camel@btinternet.com>
Subject: Re: [PATCH 00/13] SELinux Notebook: Convert batch 2 to markdown
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Thu, 03 Sep 2020 17:11:32 +0100
In-Reply-To: <CAHC9VhSOsYOYGaqDW+ATR5O5hRGJLbWs0QExNemoK2HRamY0xg@mail.gmail.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
         <CAHC9VhSOsYOYGaqDW+ATR5O5hRGJLbWs0QExNemoK2HRamY0xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-09-03 at 10:52 -0400, Paul Moore wrote:
> On Wed, Sep 2, 2020 at 9:17 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Converted to Markdown or just tidy up formatting. Added TOC to aid
> > navigation where required.
> > No text changes.
> > 
> > Richard Haines (13):
> >   libselinux_functions: Convert to markdown
> >   mac: Tidy formatting
> >   modular_policy_statements: Convert to markdown
> >   network_statements: Convert to markdown
> >   network_support: Convert to markdown
> >   objects: Convert to markdown
> >   pam_login: Convert to markdown
> >   policy_config_statements: Convert to markdown
> >   policy_languages: Tidy up
> >   policy_store_config_files: Add TOC and tidy up formatting
> >   polyinstantiation: Convert to markdown
> >   rbac: Minor format fix
> >   role_statements: Convert to markdown
> > 
> >  src/libselinux_functions.md      | 2179 +++++++++++++++-----------
> > ----
> >  src/mac.md                       |   34 +-
> >  src/modular_policy_statements.md |  229 ++--
> >  src/network_statements.md        |  261 ++--
> >  src/network_support.md           |  270 ++--
> >  src/objects.md                   |  185 +--
> >  src/pam_login.md                 |  107 +-
> >  src/policy_config_statements.md  |   54 +-
> >  src/policy_languages.md          |   26 +-
> >  src/policy_store_config_files.md |  432 +++---
> >  src/polyinstantiation.md         |  108 +-
> >  src/rbac.md                      |    2 +-
> >  src/role_statements.md           |  443 +++---
> >  13 files changed, 2109 insertions(+), 2221 deletions(-)
> 
> All merged into the main branch.  Thanks again Richard, I know how
> tedious these conversion patches can be.
> 

Yes I know !!. I'll post the final batch early next week

