Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2575C2BB1D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E02074F
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="oqS9E5ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgCKVJd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:09:33 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:33491 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729202AbgCKVJc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 17:09:32 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200311210929.HYXG23502.sa-prd-fep-048.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 11 Mar 2020 21:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583960969; 
        bh=GIBLv6M8kFVn9KOWRi0WjOoF/PpK7dUl51nnon1Y8bc=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=oqS9E5lycCtvS4mtVanmYUSbuHvyJFD2VUNGvts19wYpEmtHw/d93XpfAwkjo2kaqLetiNHwIX3I50oJ/PN/suDwxUaNq4w93pqrzbnJ2ZwTJ/rGLyE8HDgBNoUlnd25NNY1AcjPvBqVTXhVzUy9Vh1Uaguf+9rgEPKY+fpvQAwjwqg+vEPp1EibnLyTeOdCuZVVn9j+vAgjwqt4BUMEhSHm4N9MxlPpCV8mDFBO6QglOh07zrKAB8Aqu4+3Vefwzoh5UabK6Mi1d1WXnkpVNR0ht0395TbK5NSWw0h2ZntPVHd50SWAnfEVXwnvaYkG47ia9sljGzXmmOT2SrFPrQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.153.63.157]
X-OWM-Source-IP: 81.153.63.157 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvfedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkedurdduheefrdeifedrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdeifedrudehjedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.63.157) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A27DB05774D90; Wed, 11 Mar 2020 21:09:29 +0000
Message-ID: <0246f7121c3c18731273b3812f068ee1bcdb96a3.camel@btinternet.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Wed, 11 Mar 2020 21:09:28 +0000
In-Reply-To: <CAEjxPJ54UEMrNU+NBKtJoffB_gyErFbzsLrHj3EbVRMmA+EWmQ@mail.gmail.com>
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
         <CAEjxPJ4USNdqFY40vPnviLPHSZR22Tpq0y1L+LauJenKXRw6HA@mail.gmail.com>
         <5b317d8b29fbf7d56238a136254b53b042becf96.camel@btinternet.com>
         <CAEjxPJ54UEMrNU+NBKtJoffB_gyErFbzsLrHj3EbVRMmA+EWmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-03-11 at 14:02 -0400, Stephen Smalley wrote:
> On Wed, Mar 11, 2020 at 1:52 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Wed, 2020-03-11 at 10:55 -0400, Stephen Smalley wrote:
> > > On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > I've revamped the nfs.sh to handle tests that require specific
> > > > mount
> > > > options, these plus many more are now in tests/nfs_filesystem.
> > > > This
> > > > only
> > > > gets run by nfs.sh.
> > > 
> > > I don't really understand why you moved tests that could only be
> > > run
> > > from nfs.sh out of it into
> > > tests/nfs_filesystem?
> > 
> > I only moved them as it seemed more in keeping with the testsuite.
> > Would you prefer them in the shell script ? I don't mind either
> > way.
> 
> Previously they weren't dependent on the test policy (weren't running
> in any test domain
> or using any test types) and were only testing NFS labeling behavior.
> I think you switched
> them over to running in test domains and on test files/directories.
> If we stay with the former,
> then keeping them in nfs.sh makes more sense.  If we choose the
> latter, then moving them as
> you have done makes more sense.  Not sure about the tradeoffs here.

I'll leave as is for now and see how it goes.
> 
> One thing to double check is that if you move them and there is a
> failure, is that failure reported
> properly and propagated up to the shell script in a way that causes
> the entire test to fail.  Might be
> but I haven't confirmed it.

It does now. I've fixed all the highlighted problems now. Will send new
patch set tomorrow. Thanks for feedback.

