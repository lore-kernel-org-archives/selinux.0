Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB881C432C0
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C222071C
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mMQAStza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKVQSk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:18:40 -0500
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:20196 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbfKVQSk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 11:18:40 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20191122161836.VJLH30084.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 22 Nov 2019 16:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1574439516; 
        bh=SVJQLrWHGw2jom/v+sBEqEqXkedEsNARnVbmDl+l+kE=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=mMQAStzaKHi+/Lb6WnBSLQkmUgpYxDZi0aDHeDnbXDgezehuEqdgKVr8ZtMTyoD2klPVpumFiP68zNuzWQq3+TgFKYjs/ZsXcYWfzgDrmJZguJNeiLLzAbheV03AnAF/qY2/vS0jBUQAAPrUDmcn4nsQ6DDIb38v0vNPz4jy4hEmqMLYNomBja7JxEozflOts9yq/Q6X79BDN3yWX59i5y/mmlgio/HOK4MZeNy2tPWrHLxMl5kG5XojoKtYKzyYvK/d74vj1eLhlqDHj6eWqTPy24O1NRUrSk//u7tDWR0+YoHi0J11ZZL7SYDw3q4XtHfX34/5Vt9rbjdiuX7lpQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.7.51]
X-OWM-Source-IP: 86.134.7.51 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddquddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekiedrudefgedrjedrhedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdejrdehuddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
        gheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.7.51) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D834EE50BE1AD7B; Fri, 22 Nov 2019 16:18:36 +0000
Message-ID: <7735c6c82adc9c1b8e3ff9ee195e4efaf530e480.camel@btinternet.com>
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Fri, 22 Nov 2019 16:18:35 +0000
In-Reply-To: <CAHC9VhS3jdaCH+jdmTG=Qk+r_zBuaNdWtFKnQ=ntQL-PpDqjPA@mail.gmail.com>
References: <20191119113845.89951-1-richard_c_haines@btinternet.com>
         <CAFqZXNtdWNSma6Y55bPcRvJinCe=F4YNwuciDAhhdgr95ef0Dg@mail.gmail.com>
         <CAFqZXNtZ8TVWP=6Rsp81u5NOHsvgc0Xr2yMtATTv2R-u5YmOhw@mail.gmail.com>
         <57736f19-2b1b-aa1f-39ea-19f5c837ad9a@tycho.nsa.gov>
         <CAHC9VhS3jdaCH+jdmTG=Qk+r_zBuaNdWtFKnQ=ntQL-PpDqjPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-11-22 at 08:39 -0500, Paul Moore wrote:
> On Fri, Nov 22, 2019 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On 11/22/19 5:40 AM, Ondrej Mosnacek wrote:
> > > When trying this on RHEL-7, I realized there is a missing kernel
> > > version check here (module_load kernel support was introduced in
> > > v4.7
> > > [1]):
> > > 
> > > ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > > ...
> > > endif
> > > 
> > > It is quite a corner case to have a policy that supports
> > > module_load
> > > and a kernel that does not, but there is at least one distro that
> > > hits
> > > it, so I think it's worth it to add the explicit check.
> > > 
> > > Stephen/Paul, is it trivial enough to add when merging the patch
> > > or
> > > should Richard repost it?
> > > 
> > > [1] 
> > > https://github.com/torvalds/linux/commit/61d612ea731e57dc510472fb746b55cdc017f371
> > 
> > Alternatively, you could exclude it on RHEL7 by adding it to the
> > filter-out line under ifeq ($(DISTRO),RHEL7).  Regardless, it is
> > entirely up to you as to whether you want to fix it up on merge
> > yourself
> > or request a re-spin.
> 
> Yes, each project and maintainer handle this differently.  I
> personally try to have the original submitter make the change(s)
> whenever possible (assuming they are not merge related); I do this
> for
> a few reasons: 1) it is their name on the code, and I don't want to
> cause them problems by others mistaking my changes for the submitters
> changes (aside, this is why I try to mark my edits in the commit
> metadata) 2) changes made during the merge don't go through the
> normal
> mailing list review 3) the mailing list feedback loop is a Very Good
> Thing in my opinion and we should do what we can to keep it going.
> 
> That said, there are cases where the change is mindlessly trivial
> (e.g. misspellings, nonconformant whitespace, etc.) and I don't have
> a
> problem making that edit.  I'll also consider making larger changes
> if
> I know the original submitter to be unreliable and we want/need to
> get
> the commit into the tree soon.

I'll submit a new patch with:
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)

Richard
> 

