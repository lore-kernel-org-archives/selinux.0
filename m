Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FEC433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02430214F1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="lfytIDPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgHXPXp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:23:45 -0400
Received: from mailomta27-sa.btinternet.com ([213.120.69.33]:38149 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgHXPR5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:17:57 -0400
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200824151738.JHMD19995.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 24 Aug 2020 16:17:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598282258; 
        bh=7rSFIGghP6hLdJBG0+K/6W5jxwVHa0RGHgYQdFNIA40=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=lfytIDPp6Via7Pdc3Ieuu1mRBj4gSZ7dg88ifiKgQwz6bTBj/N5foeOF9pz8Fe7l69b/rWR3WFMDZIdK4/2C5tu1EOGHZ/Vh6262rqJ3VQDeWgRaKKxQtfHuyGzWUIObKeOOPC4xC7NYjaRFi3jSDdvXN2303LfHJ8RU+TEPD32YcdOujgcXM3KJSEy7wPix0FSsq/cZuDSxDq3Mz0VMpYcjXDzsrn3wrRmCOjPfhlYjkNUGqTRBkiO3KhBIRzDd29rvfD3MgONp3jmxtiLLp54CmsyOj2truRu9ecBTYz6Vj2A7vcX49lcwNLrDIHN4gUIt+HRClX3UTiLrxQi79A==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.183.114.82]
X-OWM-Source-IP: 86.183.114.82 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddukedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepkeeirddukeefrdduudegrdekvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeefrdduudegrdekvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.114.82) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AA6E0D38C978; Mon, 24 Aug 2020 16:17:38 +0100
Message-ID: <4588336e487610f41187718629369aeadbd651d3.camel@btinternet.com>
Subject: Re: [PATCH] selinux-notebook: Convert terminology.md to markdown
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:17:29 +0100
In-Reply-To: <CAHC9VhTP+A3mGO_1nVz4Q-WtEBNubAGO_gysR7L-_OOqFRazZw@mail.gmail.com>
References: <20200809162212.193739-1-richard_c_haines@btinternet.com>
         <CAHC9VhTP+A3mGO_1nVz4Q-WtEBNubAGO_gysR7L-_OOqFRazZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-08-24 at 09:40 -0400, Paul Moore wrote:
> On Sun, Aug 9, 2020 at 12:22 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  src/terminology.md | 349 +++++++++++++++++++++++++++++++--------
> > ------
> >  1 file changed, 243 insertions(+), 106 deletions(-)
> 
> Merged.
> 
> I wasn't sure how I was going to like the changes to the
> abbreviations
> table, but I think it still looks okay and it's more consistent with
> the rest of the doc.  Thanks Richard.
> 

Just to let you all know that I've converted the remaining sections to
markdown. I'll send the updates in small batches (A-Z) over the next
week or so.

