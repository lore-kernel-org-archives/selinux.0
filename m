Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A9C56201
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A522076B
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 12:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="L9Hm33d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbgKXM0a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:26:30 -0500
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:43954 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729172AbgKXM03 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Nov 2020 07:26:29 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20201124122626.JJON15135.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 24 Nov 2020 12:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1606220786; 
        bh=bLxqdJzzB8rUKQ1RprUf9JPNAnPt75dOiOmunolJq5E=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=L9Hm33d8tMbbG6xPWyJ1XCFH+O4OnukcglLGvfkX1aA4SY2vWFrqOnFqDhPIG8Ufv1gif1A6jgphd12yTmlHTJdJPfGgnlR9rZ0niWVYA+6+tE7PcdRO6ibwJiUJYZG2OZxsGuf+GGT6aAbgU2afUpsN2tOdmSeK5WACWPS+/4R0VoNDODkjc6+yaQBWkX0hjfDNcbwau0gX+qFJaPm15VV/33WcF5zADjt3JQFyx6/J6VLmtx1IwaPmTvtgyF86kc2G50RXJrD9QYXqB9ztiTLRwrm2OkhCbpXGhiu6SS5XcS+bV/8LLe5KA5VHPgVX34uniQbVpi1cqe0ux1eTkg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED99EC91BE79267
X-Originating-IP: [86.183.97.227]
X-OWM-Source-IP: 86.183.97.227 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevtdejtdfgtddvtdejiedthfeftedvteeileefgfejteefgffhkedvlefgveehteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudekfedrleejrddvvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudekfedrleejrddvvdejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.183.97.227) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED99EC91BE79267; Tue, 24 Nov 2020 12:26:26 +0000
Message-ID: <71112670492a57f244225d200c121f25e267fa44.camel@btinternet.com>
Subject: Re: [PATCH] mls_mcs.md: Convert section to markdown
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Tue, 24 Nov 2020 12:26:19 +0000
In-Reply-To: <CAHC9VhTzkCiaRXXO9ZwPNyG59c-uJx=jW5qYPqwfv9jeVPxcGQ@mail.gmail.com>
References: <20201120113807.11605-1-richard_c_haines@btinternet.com>
         <CAHC9VhTzkCiaRXXO9ZwPNyG59c-uJx=jW5qYPqwfv9jeVPxcGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-11-23 at 18:06 -0500, Paul Moore wrote:
> On Fri, Nov 20, 2020 at 6:38 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > Add a TOC to aid navigation and converted to markdown.
> > 
> > Reworked a table that required rewording some text.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > RFC Change: Updated MLS/MCS text to reflect [1] comments.
> > 
> > All Notebook sections should now be in markdown.
> > 
> > [1] 
> > https://lore.kernel.org/selinux/80e38828-1473-5bc5-1b23-067cd242125a@gmail.com/
> > 
> >  src/mls_mcs.md | 411 ++++++++++++++++++++++++---------------------
> > ----
> >  1 file changed, 204 insertions(+), 207 deletions(-)
> 
> Merged, thanks Richard.
> 
> There are a few other small outstanding patches that I'm going to
> look
> at now, but what does everyone think: time for a new GH release of
> the
> notebook?
> 

Seems reasonable now all in markdown. I did notice a couple of HTML
<br's in title.md and the notebook-examples README.md files. Not sure
if worth removing ??.


