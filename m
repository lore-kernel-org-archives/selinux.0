Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9CDC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94B20748
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WDhHhPVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgAPND3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:03:29 -0500
Received: from mailomta14-sa.btinternet.com ([213.120.69.20]:31751 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgAPND3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 08:03:29 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200116130327.CHQS8432.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 16 Jan 2020 13:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579179807; 
        bh=hSilISzTjZsLVHusRA2wwQ0P7fkfeW478rFTAcnlvic=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WDhHhPVZE6CWqncrA8A08bRX8SQIeMlFGTdQffptmRC3AsLghxzo1PK+eGdL9LmFr56kir0B3jfZOO1dnFLsWBZddF7FMvlex6fR8Ok2MaBca5y+p+rDZ6Pbio1EuPwMGz/SKNXKaMElRYGtaCd04YpXG0z+uBy/+tH17D6J/wDWh0IauNhw88rLIP5Ku9bC6Y24SqzUiGtU6qvt7on1C1iKJEztlcKkKnEs2p0x0aOI5abj10lxYbT7ipl/N1EinI26Zmxl7w+tN7Kdyzl1xLHzCRWlwzcgeUDLhsrOpaznA/EAnC6wXAXXegXX72SN5qBXehf2cJM5r+AJEQ7lJQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.91]
X-OWM-Source-IP: 86.134.6.91 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlqddutddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrledunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdeluddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.91) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DC137950C5EE4F5; Thu, 16 Jan 2020 13:03:26 +0000
Message-ID: <84627a0c4895105a5ebb9ecd113c0ba872edba00.camel@btinternet.com>
Subject: Re: [PATCH V5 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Thu, 16 Jan 2020 13:03:26 +0000
In-Reply-To: <CAFqZXNsqYzaaOSAuZ=1z3vrgvW8cJ0LKufEpvPdNqmrhXW5yhw@mail.gmail.com>
References: <20200114144426.355523-1-richard_c_haines@btinternet.com>
         <20200114144426.355523-2-richard_c_haines@btinternet.com>
         <4c43a27d-6af6-4be0-611a-9564d898ff06@tycho.nsa.gov>
         <CAFqZXNsqYzaaOSAuZ=1z3vrgvW8cJ0LKufEpvPdNqmrhXW5yhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-16 at 10:00 +0100, Ondrej Mosnacek wrote:
> On Wed, Jan 15, 2020 at 10:09 PM Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On 1/14/20 9:44 AM, Richard Haines wrote:
> > > Test filesystem permissions, setfscreatecon(3), file { quotaon }
> > > and
> > > changing file context via non and name-based type_transition
> > > rules.
> > > 
> > >  From kernels 5.5 filesystem { watch } is also tested.
> > > 
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > 
> > This looks good to me and passes travis-ci and testing on Fedora.
> > Ondrej, how does it fare on RHEL?
> 
> Thanks for asking! Unfortunately the policy fails to build on RHEL-6
> due to lack of support for filename-based transitions... That part of
> the test needs to be somehow conditioned on $(MOD_POL_VERS) >= 11 and
> $(POL_VERS) >= 25. After I removed the two filetrans rules, only the
> expected two subtests failed, so the rest seems to be fine.
> 

Okay I'll fix this.

I'm also reworking the policy to make some of the contexts a bit more
sensible. Also trying to differentiate between these in the audit log
for denials:

hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
type: test_filesystem_inode_relabel_no_associate_t
hooks.c may_create() FILESYSTEM__ASSOCIATE
type: test_filesystem_may_create_no_associate_t
hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
type: test_filesystem_inode_setxattr_no_associate_t

hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
type: test_filesystem_no_inode_no_relabelfrom_t
hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
type: test_filesystem_sb_relabel_no_relabelfrom_t


