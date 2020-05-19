Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A7C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFF0207FB
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="QpZ4HmAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgESNup (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 09:50:45 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:11215 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbgESNup (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 09:50:45 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200519135040.PYMM4065.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 19 May 2020 14:50:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589896240; 
        bh=EVLCjFvTVTfPAVGtdxfMMJ5BeK8DS1hnn8lhGz23YMQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=QpZ4HmANDoAsU3pRT9TmT1hBew1ap6wfeNlwEBAVsedrpX4IjRfjVKQkjxkoNy5o2BtcWZkJU/pk41kVmzxQoUKvUvlQhhtyRfXoUYfYLsjilAyUuuR+fBBlPr8LmzI2ZjL7HLJo0RTbWRMfRUM8HF+68vjhZ7CNigEgBQJEwyMAFVa7OMzqHtY3F/F7ckMCbs4WiVFpNLAVriZQDMglK6TmeICNhQfFWSegZwcV3whtyBCpk6c5sxkCuJ67E+xVGFArGrWxyJv9fmSt56F7c0+Ir01Hh2cl99XaQ76nq2rxcCvxEYI2Xo5peOlex3F0tcCk540iqF8udeweUQqeMA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.155.32.188]
X-OWM-Source-IP: 109.155.32.188 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepuddtledrudehhedrfedvrddukeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudekkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeophiffiesvggughgvkhgvvghprdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
        ohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.188) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A290C118A7EC6; Tue, 19 May 2020 14:50:40 +0100
Message-ID: <60438e5b407320275932f60bc10936b75c9280aa.camel@btinternet.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Date:   Tue, 19 May 2020 14:50:40 +0100
In-Reply-To: <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
         <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
         <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 2020-05-17 at 17:59 -0400, Paul Moore wrote:
> On Sun, May 17, 2020 at 7:17 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > I update the notebook occasionally to keep track of changes for my
> > own
> > reference, but currently have no plans to publish a new one. If you
> > do
> > have comments I'm happy to take them onboard, however no guarantees
> > to
> > publish.
> 
> I just wanted to say thank you once again for all your work on the
> notebook, it's a great resource!
Glad it's useful

> 
> I understand not wanting to go through the process of generating new
> editions of the notebook, but is the source material posted somewhere
> online so that people who wanted an updated copy could access it?
The source is not available anywhere that I know of (I did send it to a
few people who wanted to translate it but never heard from them again
!!!). I edit it with LibreOffice Writer as an odt document. It converts
to pdf okay, but epub looks real crap.

I guess I could post it somewhere, would you like to host it on your
site ??.

It needs cleaning up as I've scribbled all over it so will take a few
weeks.
> 

