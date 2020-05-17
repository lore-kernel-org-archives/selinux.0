Return-Path: <SRS0=Vz70=67=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F2C433E0
	for <selinux@archiver.kernel.org>; Sun, 17 May 2020 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1F22065F
	for <selinux@archiver.kernel.org>; Sun, 17 May 2020 11:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="jjU/ubKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgEQLRd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 May 2020 07:17:33 -0400
Received: from mailomta12-re.btinternet.com ([213.120.69.105]:50247 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727845AbgEQLRd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 May 2020 07:17:33 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200517111730.NFJF8801.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 17 May 2020 12:17:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589714250; 
        bh=gfZYV8VpWn9poIcAD0maya4/9IKbNzWr8E/7oPa5dfA=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=jjU/ubKmkKC9aeNQTGM83BCxRn91PaQVMQgml0X++D7gsEzGSEsG9WviXEXE0MxfA1ujoT9AmShvYGvQMiV2HWiTV48axexGaFZDrlVty2vJUvxyeD0f1QAdXBDHf/2ScHtD4UO+jNMCFncuWknwBDgcwb0UOAvdN9ZiIZH68UF2hNMWon8yoqCMn+F1Kj6UD0BC9ZypOBhTRT6i7nh1Fy8q2rPisCQVPlWev/cAhSBiK+9TJRHZlFi5dNI3zgO+Rhlzi+1/sRKpiMM+LSt8ZKYOX1PoOJW/yEirSuubBvWrGwIZcq+oXwixfwVZXIoli/4kSVEe3Q5lxSOPPbbP5w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.183.71.52]
X-OWM-Source-IP: 86.183.71.52 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedruddtfedgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepfeeitedtteevieeuhfejhffhuefhieeivdegtdeutdfgtdeuhefgvdelffduvddunecuffhomhgrihhnpehsvghlihhnuhigphhrohhjvggtthdrohhrghdpvggughgvkhgvvghprdgtohhmnecukfhppeekiedrudekfedrjedurdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeefrdejuddrhedvpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophiffiesvggughgvkhgvvghprdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.71.52) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D10F55C8F; Sun, 17 May 2020 12:17:30 +0100
Message-ID: <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     selinux@vger.kernel.org
Date:   Sun, 17 May 2020 12:17:30 +0100
In-Reply-To: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-05-15 at 16:03 -0400, Peter Whittaker wrote:
> Folks, with whom I can verify whether there are errors on the SELinux
> Project Wiki?
You can contact me about any errors in the notebook or on wiki. I've
updated the wiki page and happy to correct any minor errors you find.
I've no plans to do major updates to the wiki as it is now history.

I update the notebook occasionally to keep track of changes for my own
reference, but currently have no plans to publish a new one. If you do
have comments I'm happy to take them onboard, however no guarantees to
publish.
 
> 
> Details: It looks like MCS information is missing from a few security
> contexts on https://selinuxproject.org/page/NB_SQL_9.3
> 
> The schema row has
> 
>    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s10'
> 
> which should likely be
> 
>    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s0:c10'
> 
> Likewise, the database row has
> 
>     context = 'unconfined_u:object_r:postgresql_db_t:s0'
> 
> but I'm unsure whether this should be as is or whether it should also
> have MCS info.
I think Stephen's reply covered the MCS query.

BTW the contexts match those in the tarball example, the testdb-
example.sql is correct, however the instructions in the README will not
work on version 11. If your interested I can send you an updated
README, however no plans to update online.

> 
> With whom can I verify this? (Not using PostgreSQL, just noticing
> errors as I crawl through my hardcopy of the handbook.)

> 
> Thanks!
> 
> P
> 
> Peter Whittaker
> EdgeKeep Inc.
> www.edgekeep.com
> +1 613 864 5337
> +1 613 864 KEEP

