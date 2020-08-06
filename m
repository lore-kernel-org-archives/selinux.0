Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E8C433E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15C4206B5
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WYn5z/pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgHFKIZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:08:25 -0400
Received: from mailomta24-re.btinternet.com ([213.120.69.117]:33420 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729309AbgHFKIB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 06:08:01 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200806100758.PIAW4701.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 6 Aug 2020 11:07:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596708478; 
        bh=cOGNyTk/HkqyrfMVR7zM7oiR75nBf0ER+y9pdaa+8R0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WYn5z/pJN1emCj/O32VdRip7nWe27apEOsIzOzIlaGOsHIq864DnFocMZ08XDo1ImB4BZqp972MrihD/s8N8EHzoi95WaFHAwo0Zb/vbOFtdA6lal4LtcMhgAWSxzIwsOv9J4/VN9dtHQqv0rijJf0l3iuMY3kQgYxV7IHrcPUpukLpiuwybBS0H1jxIGzLa6cqSQZs3YrvhE5y+Mf0wguYC0n4zay7v9otryc4xAuybHROKS6ZvSAgdL9Qi6bwdbdhduUcTDKFIKNLjHJDKOQjjFC2lVMIkJQ9uc/fpZ+k+ywHcGulQ4sj+LkJ57MI7jmsfDoqZMQuT9cJKHtfDgw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.147.13.204]
X-OWM-Source-IP: 86.147.13.204 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudegjedrudefrddvtdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrudefrddvtdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.147.13.204) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC0A94C10F; Thu, 6 Aug 2020 11:07:58 +0100
Message-ID: <14cc38f023a913d7be8d452c63e6bb3ee8916422.camel@btinternet.com>
Subject: Re: [RFC,selinux-notebook PATCH 05/18] xperm_rules: fully convert
 to markdown
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Thu, 06 Aug 2020 11:07:46 +0100
In-Reply-To: <CAHC9VhR5ik=yk5Oo=n_B3JhKyJuBVaSa5rUNsPdHMtH78b83mw@mail.gmail.com>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
         <159650482872.8961.7516871249534865160.stgit@sifl>
         <837e782ff80f69e8e4d44bc49ff2ced54b0aef2c.camel@btinternet.com>
         <CAHC9VhR5ik=yk5Oo=n_B3JhKyJuBVaSa5rUNsPdHMtH78b83mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-08-05 at 22:34 -0400, Paul Moore wrote:
> On Tue, Aug 4, 2020 at 12:14 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:
> 
> ...
> 
> > > +*rule_name*
> > > +
> > > +The applicable *allowxperm*, *dontauditxperm*, *auditallowxperm*
> > > +or *neverallowxperm* rule keyword.
> > > +
> > > +*source_type*
> > > +
> > > +One or more source / target *type*, *typealias* or *attribute*
> > > identifiers.
> > > +Multiple entries consist of a space separated list enclosed in
> > > braces \'{}\'.
> > > +Entries can be excluded from the list by using the negative
> > > operator
> > > \'-\'.
> > > +
> > > +*target_type*
> > > +
> > > +The target_type can have the *self* keyword instead of *type*,
> > > *typealias* or
> > > +*attribute* identifiers. This means that the *target_type* is
> > > the
> > > same as the
> > > +*source_type*.
> > > +
> > > +*class*
> > > +
> > > +One or more object classes. Multiple entries consist of a space
> > > separated list
> > > +enclosed in braces \'{}\'.
> > 
> > I've had a rethink on this and wonder if it would be clearer if the
> > descriptions were a bullet list:
> > 
> > *class*
> > 
> > - One or more object classes. Multiple ...
> 
> Ooops.  I forgot about this comment in my inbox when I merged the
> patchset; although I guess even if we go with the bulleted list
> having
> the table in markdown first should make this easier.
> 
> I guess we could give it a try and see how it looks?  My only concern
> is that sometimes a list with only one item can look a bit "off".  Or
> an I misunderstanding what you are proposing?

I've posted the SE Android section as an RFC patch that converts HTML
tables to lists. See what you think.

I sent the Reference Policy updates yesterday but it never made it to
the list as I didn't realise it was over 100K, still I guess you had
your copy.

> 

