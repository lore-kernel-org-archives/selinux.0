Return-Path: <SRS0=8r5V=ZZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F9C432C0
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921B0206E4
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="OYDSYOHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCQAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:00:35 -0500
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:49401 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfLCQAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Dec 2019 11:00:35 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20191203160032.QJRV8099.re-prd-fep-047.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 3 Dec 2019 16:00:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1575388832; 
        bh=WyrlERNun4rcJ5k+wG3sxVKijbSDyXmOPd1k3nuf66U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=OYDSYOHFEBD/DRMEs9Va/bSlUC8vSF0bPzDhFHYjgxXdTdz+0ZQlkj3CznERE7wAyFbN4c9j7lQk8td1yhS5LRVOgtJxISgjR7CzIcz+S5UQUbkrbkV7kTZt7/1WXPkbAMKPEnenx0jnHMuP9t0BQMEQaXm6lDzDBZSDivQDAu4SHPDhhxmjt3IrFCurZJjam9MxeY8I+zZU85Yyr4b2B2P2pcdyFyjni6//4nZVKrBxyKk5n2STbR8NOtMy5Snaiwrx1BuWbXzOkFwFe3ahWXVVQ8qOMaXk6ULylvZQt/YSHVvScKGR5KSwRv1kbEEI65Lb0hg462zzdVyL4qlN0g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.146]
X-OWM-Source-IP: 31.49.58.146 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehkedrudegieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehkedrudegiedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.146) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D834EE50DC47F5D; Tue, 3 Dec 2019 16:00:32 +0000
Message-ID: <048b2ebe62b56bb3497eec0cb99f9e13a91c29d9.camel@btinternet.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Add perf_event tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Tue, 03 Dec 2019 16:00:31 +0000
In-Reply-To: <a715e047-7973-2847-96c4-5f26cd29adb2@tycho.nsa.gov>
References: <20191201145238.265621-1-richard_c_haines@btinternet.com>
         <20191201145238.265621-2-richard_c_haines@btinternet.com>
         <a715e047-7973-2847-96c4-5f26cd29adb2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2019-12-03 at 10:15 -0500, Stephen Smalley wrote:
> On 12/1/19 9:52 AM, Richard Haines wrote:
> > Test perf_event permissions.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
> > new file mode 100644
> > index 0000000..8b612bc
> > --- /dev/null
> > +++ b/policy/test_perf_event.te
> <snip>
> > +neverallow test_perf_no_admin_t self:capability { sys_admin };
> 
> I don't particularly object to this, but I wanted to note that these 
> neverallows are not being checked by default (expand-check=0 in 
> /etc/selinux/semanage.conf) and in fact, if one were to enable 
> expand-check, it would not be possible to insert the test policy
> module 
> without triggering some neverallow and/or typebounds failures
> because 
> the test policy intentionally violates such invariants at points.
> 
> Even the base Fedora policy doesn't appear to pass neverallow
> checking 
> at present; if you enable expand-check=1 in
> /etc/selinux/semanage.conf 
> and semodule -B, it fails (at least for me).
> 
> So your neverallow rules in the test policy are at best
> documentation.

Yes I was just using them as comments as the policy Makefile just stops
if expand-check=1.

I'll comment them out as I need to send a new version. I found that if
I set /proc/sys/kernel/perf_event_paranoid to < 2 then the 'Deny
capability { sys_admin }' test fails. I therefore now test the value
and bypass that test if < 2



