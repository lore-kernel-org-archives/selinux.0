Return-Path: <SRS0=hQaX=ZU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D6C432C0
	for <selinux@archiver.kernel.org>; Thu, 28 Nov 2019 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABC9215A5
	for <selinux@archiver.kernel.org>; Thu, 28 Nov 2019 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="P5SoTcA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK1Mx4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:53:56 -0500
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:13536 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfK1Mxz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Nov 2019 07:53:55 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20191128125352.LAEU8432.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 28 Nov 2019 12:53:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1574945632; 
        bh=EspOsOgQcRMH66ym6vS8OXAaQPNdOGfDC5PVlvcC5sI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=P5SoTcA+gmUqlWPXOiC+Gw2umD9tCC550woxeG9DMC2kuG2/MJZLunBmXfJ18XDOG8C93VjD+bFV6vIOfC9EsK4wYS86wKx9/y2mhl+0LtLSnb9av5uP9XGGSgqzfS2K9MMO2rmeKF/vC+Y8YUMSIoKhjmWEk1H8utWXzNmAHfRPaES+og3pdpAfPrcpGCrBg82nR1TOjAQmsRcqmD8ygzVYZsB39fNwevykF7UIWLmQt28j88OKpP62PHuFuVlE2zXI/NjiFheSRRvrnkCfK9bzvFYR31GQY+jmgtERnnfy/FN7J35TBRGCohcEqOerEc/jqMFsBZroxmUismHquw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.134]
X-OWM-Source-IP: 86.134.6.134 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrudefgeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudefgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.134) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DCFE7EF02164B4D; Thu, 28 Nov 2019 12:53:52 +0000
Message-ID: <2f41698ed14a640481fcc82476cd9c725e3d17e6.camel@btinternet.com>
Subject: Re: [RFC PATCH] selinux-testsuite: Add TUN/TAP driver tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Thu, 28 Nov 2019 12:53:51 +0000
In-Reply-To: <41aca6c1-7284-0226-3f20-6eb15f437c48@tycho.nsa.gov>
References: <20191127094702.3418-1-richard_c_haines@btinternet.com>
         <41aca6c1-7284-0226-3f20-6eb15f437c48@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-11-27 at 09:59 -0500, Stephen Smalley wrote:
> On 11/27/19 4:47 AM, Richard Haines wrote:
> > Test TUN/TAP tun_socket permissions.
> > 
> > I've made this an RFC patch as TAP supports adding BPF prog file
> > descriptors, therefore I've added a simple test that just checks
> > that it
> > works. However, there does not seem to be a requirement to test any
> > additional SELinux functionality that the basic BPF tests do not
> > already cover. Any views !!!
> 
> That seems reasonable to me.  Generally our focus is on ensuring
> test 
> coverage of the LSM/SELinux hooks and SELinux kernel APIs, so
> anything 
> that is already covered by an existing test doesn't need to be
> repeated. 
>   In the case of tun/tap, likely only the tun_socket checks
> themselves 
> are unique to these tests.

I'll remove the BPF check and send an update.

> 
> I would prioritize on 1) ensuring that we have test coverage of new 
> security hooks, new functionality within existing hooks, or new
> SELinux 
> kernel APIs as they get added to the kernel, e.g. the perf
> permission 
> checks (github issue #71), the socketpair peer labeling support
> (#63), 
> etc, and then 2) gradually expanding our test coverage of existing 
> security hooks and kernel APIs to ensure that future kernels do not 
> regress, e.g. it would have been nice to have had explicit tests for 
> context mounts as per issue #20 to ensure that we didn't regress
> during 
> the vfs new mount API overhaul (we happen to exercise context mounts
> as 
> part of overlay testing and as part of binderfs testing but not as a 
> separate test, not in a comprehensive way, and not for anything
> other 
> than overlay mounts), and likewise for many of the tests identified
> as 
> open github issues.

I'll have a go at the perf checks next as I guess it will make it to
5.5 unlike the keys-acl (that I did tests for). I also have the simple
'watch_key' test that I'll send once in 5.5 (if it makes it).

> 
> I haven't looked too closely at this yet, but I did have one minor 
> comment on your test policy below.

I'll change this (I try to avoid interfaces in tests as you need to
lookup what they really contain and it may be more than you want, plus
just plain allow rules are much clearer (but that's just me))
> 
> <snip>
> > diff --git a/policy/test_tap_bpf.te b/policy/test_tap_bpf.te
> > new file mode 100644
> > index 0000000..f921a5a
> > --- /dev/null
> > +++ b/policy/test_tap_bpf.te
> > @@ -0,0 +1,30 @@
> > +#
> > +########### Test TAP/BPF - 'tun_socket' #################
> > +#
> > +attribute tapbpfdomain;
> > +
> > +# For CONFIG_TUN=m
> > +kernel_request_load_module(tapbpfdomain)
> > +
> > +gen_require(`
> > +	type tun_tap_device_t;
> > +')
> 
> Any time you find yourself needing a require, look to see if there is
> a 
> refpolicy interface you could use instead that would provide that 
> require and the necessary rules.  In this case, I think you could
> have 
> used corenet_rw_tun_tap_dev().

