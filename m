Return-Path: <SRS0=TNfp=Z4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC05DC2BD09
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F53924673
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VibVxwRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLFNpN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:45:13 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:24348 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfLFNpN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Dec 2019 08:45:13 -0500
X-EEMSG-check-017: 58025474|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,284,1571702400"; 
   d="scan'208";a="58025474"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Dec 2019 13:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575639911; x=1607175911;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=onjZb9Wfg/ljAWES5Sxmh7frufiA79iYJjG3KdL+Cyw=;
  b=VibVxwRNIL5giSfe6+bOwiJbLgo/RK734b/6ejmaBrOiaO8vuslQ1urW
   77+4EEHM5xIGrlwCxz7KR3oZPEEhvTEmx5FcQh55r7t0o6Q8SxAWjaY6v
   j6GBNxVwtugyACZip7d9UmZhcJsZUiG1s5LoGLysECfUFruNUp8dTqGYM
   /hiLU8g8hPNZjJJMMvGBhbtGnhrm2d0laOKezpGVOEZB/LUPjjZjj0CgQ
   mjup8RPXo9vfjcwp+uYS4WYA9D7F7fYW6TD+aWGmb37UiqX71LQygoSyU
   +JVkwygRjsqUoRKpcenKEbjChMeru5a9JSR5jAm4zdylYC73JeyPao0+K
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,284,1571702400"; 
   d="scan'208";a="36424786"
IronPort-PHdr: =?us-ascii?q?9a23=3ATXvHyRFMuvNpXOPeYPNITp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76psS7bnLW6fgltlLVR4KTs6sC17ON9fmwAiddvd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu8oYjIdtKqs8xQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4pUBascIPL3QULxrMbXDgI9MwCtxubnD9J91pkAVm6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvgi4v7uimQ5mVkHcqa1w5Qac2q4Eep7LE?=
 =?us-ascii?q?WZe3Xsns0NHnsNvgo7VObqkkGNUSZPZ3auWKIx/jM7B5yoDYfNWICgm7OB3C?=
 =?us-ascii?q?C8Hp1ZYmBJFEqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU5Qh2g+qtA/7zbpnM+?=
 =?us-ascii?q?XV9zYGtZLsytd1/ffflRIs+jxuCcSSzWWNQ3tznmMSSD88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVFNJS5/NNVgc3Lp3cwPJgC9D0RA3Bes2FSFG8QtWpGTsxVM4+w8cSY0?=
 =?us-ascii?q?ZhHNWvlgjD0DC3A78RkryEGJ80/7nf33fvPcZ9zWjJ1K07g1khWMtPOnWshr?=
 =?us-ascii?q?Rj+AjLG47Jj0KZmr6wdasAwS7A73mDzWWQs0FCSgJwUrvKXWoZZkTIqdT1/E?=
 =?us-ascii?q?TCT6WhCb4/KAtO1daCKrdWat3ulVhGRvDjOMrEbGK3gWiwBg2FxryLbIrtdG?=
 =?us-ascii?q?Ud2DvSBFIYnAAU+HbVfTQ5Ux+ovmaWKTtpD1+nN1vl7O1WsHqmSgoxyAaQYg?=
 =?us-ascii?q?tq0L/jqTAPgvnJcO8exrIJvm8arjxwGFusl4bNB8GouxtqfKIaZ8g0plhAyz?=
 =?us-ascii?q?SK5ERGIpW8IvU61RYleANtsharjk4mBw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D8AAAVW+pd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEK4kDhmYGgRIliWmRRAkBAQEBAQEBAQE3AQGEQAKCOTgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJuAQUjFUEQCxgCAiYCAlcGDQYCAQGCX?=
 =?us-ascii?q?z+CUyWtK4EyhU+DOoFIgQ4ojDF5gQeBEScMA4JdPodZgl4Ej2SHDUaXE4I4g?=
 =?us-ascii?q?jmTGwYbmiaqfiKBWCsIAhgIIQ+DJ1ARFIxxAReOQSMDMJFoAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Dec 2019 13:44:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB6DihK9111652;
        Fri, 6 Dec 2019 08:44:44 -0500
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191122093306.17335-1-jeffv@google.com>
 <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
 <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
 <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
 <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov>
 <CAHC9VhREL17FH0XOUkvegY4yGeQu5p1qLdWEdnwvPw1W+bLfRA@mail.gmail.com>
 <CAHC9VhQOb5skqQofnrESFuAqfRE1+xq9OD48JcYzq77v0XJsog@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4257992a-e4d8-eff4-3421-61da3376d930@tycho.nsa.gov>
Date:   Fri, 6 Dec 2019 08:45:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQOb5skqQofnrESFuAqfRE1+xq9OD48JcYzq77v0XJsog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/5/19 7:50 PM, Paul Moore wrote:
> On Thu, Dec 5, 2019 at 1:14 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Dec 5, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 12/5/19 12:41 PM, Paul Moore wrote:
>>>> Hmm.  I haven't done any debugging yet, but the BPF tests are failing
>>>> (they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):
> 
> ...
> 
>>> They all pass for me (with your next-queue branch, using the
>>> selinux-testsuite defconfig fragment merged with the Fedora config).
>>
>> Oh goodie, I'm special :/
>>
>> FWIW, my current test kernel is the next-queue branch rebased on top
>> of Linus' current tree, using the latest config from the secnext
>> kernel builds (Fedora Rawhide + stuff for the test suite).
>>
>>> The error above doesn't look SELinux-related; it looks like your kernel
>>> is rejecting the trivial bpf program used in the test code as being
>>> invalid for some reason.
>>
>> That's where I'm at as well, I'm building an instrumented kernel right
>> now to try and track down the source.  I'm sure it is something silly
>> like a messed up kernel config or something, but I'd like to
>> understand *why*.
> 
> I traced the "./bpf_test -p" failure down to a BTF check in the BPF
> verifier, there is a comment in that code block which helpfully reads:
> "Either gcc or pahole or kernel are broken.".
> 
>   :/
> 
> The relevant commit is 8580ac9404f6 ("bpf: Process in-kernel BTF"),
> and it appears to be new for v5.5; it isn't present in selinux/next or
> selinux/next-queue.  Recompiling with CONFIG_DEBUG_INFO_BTF disabled
> does allow "./bpf_test -p" to succeed, but I hit other BPF test
> failures further along.  For reasons I don't understand, the secnext
> kernel builds (which should have this code, and have
> CONFIG_DEBUG_INFO_BTF enabled) are not hitting this problem, but that
> may be due to differences in the build tools on the two systems
> (although they *should* be the same).
> 
> Given that we haven't hit -rc1 yet, and everyone else's builds are
> working just fine, I'm going to leave this alone for now.  Whatever
> the problems may be, they definitely don't appear to be SELinux
> related.

I re-based next-queue on top of -linus, enabled CONFIG_DEBUG_INFO_BTF, 
rebuilt and booted new kernel, did a git clean -fdx in the 
selinux-testsuite directory, and built/ran the testsuite; bpf tests 
still passed for me.  This was on F31.

