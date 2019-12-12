Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EE5C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A043E214D8
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IigjLaZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfLLOYQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:24:16 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:44541 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfLLOYQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 09:24:16 -0500
X-EEMSG-check-017: 60315571|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="60315571"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 14:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576160654; x=1607696654;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Y3KYuYPbH0nMd0X+aWlXgx9w/IYsU1vilpXJMJ8W4mE=;
  b=IigjLaZQZAZjc1fCSxA30ziMU9TSAr9mKZNh520/QOIQEehrxs/mnEaq
   utbR4gPHtXy88EVOOPiayZFagx+QRfSXkI/gJ/uMiZQd7cKC0b0u/VhP4
   1P5iXMpJfNGAyZfJB7WJuzYK8ykjmBAgcyf3/FX+wdgk2QLVehFWktNjL
   k2nFUP03p0knupbi/UHxZ6RS3muzct5XQiyGH51/l18U/+1JsnnRZxxOM
   5qj63dPvtKuwKozjFL7/ndGC/ay65KniSV6FQpe3/WjBCVdwPF8iMtrrX
   vdt/E8xqZTL8mW0W+c9yA5bLZpGVWHJ7MVJWfEk42fokPqOBNSwHwQkMm
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36661636"
IronPort-PHdr: =?us-ascii?q?9a23=3Ax74tdRNwzTVyse/Qi5Ml6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/T8pcbcNUDSrc9gkEXOFd2Cra4d0KyP4v+rBzVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjVtMQajopvJrsswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDrR+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhF6JJXEbwBJPPzWknstN3XFBM5Mgq0w/r5B9V5zI8RRWWPAq?=
 =?us-ascii?q?qBOqPIrVCI/v4vI/WLZIINpDnyMeMl6ODujHIigl8SYamp0oEKaHC2GvRpPV?=
 =?us-ascii?q?+ZbWPwjdgbC2sFog0+TOnygl2YTTFTf2qyX7475jwjEo2mCZnMR4+zj72Bxi?=
 =?us-ascii?q?u0BYBWaX1cBVCKEnfocJuEVuwIaCKTJM9hjzMFWaKgS48nyRGhqgv6x6B7Ie?=
 =?us-ascii?q?rT/y0SrYjj28Rt5+3PiREy8iR5D9yD3GGRUW50hGIJSiQ33KB5r0x90E2M3r?=
 =?us-ascii?q?VmjPNCCNNf/fRJUh01NZTE1ex1F8jyWh7dfteOUFupWMmpATQvQd8qwN8BfV?=
 =?us-ascii?q?x9G9O8gRDHxSaqBKUVl7OTDpwu7q3cx2TxJ9p6y3ve0akhjl8mQsRINWC9nK?=
 =?us-ascii?q?5w6RXcB47TnEWFjaqlaaMc3CvV/meZ0WWOpF1YUBJ3UajdX3AfYU/Wrc/j6U?=
 =?us-ascii?q?7ZVb+hF6koMgtbxs6eMKdFdtrpjVBeTvf5JNvee36xm3u3BRuQ2LyMaJTle2?=
 =?us-ascii?q?MH0ynHEkgLjRsT/XaYOggiASehvXjRASdvFVLpf0Pj7+1+pGmnQU8zygGAd1?=
 =?us-ascii?q?dh2Kat+h4JmfycTOse0agAuCg/pDR7BlC90M/IBNqavQZhZ6VcYdIm4FdH1m?=
 =?us-ascii?q?LZtgp9M4ekL6BjgF4ebgt2s1nv1xVxFoVPj8wqoGk2wwp1LKKSyElBeC+A3Z?=
 =?us-ascii?q?DsJr3XLXH//BK1ZK7Q3FHe0M2b+qgI6PQ/pFXjuB+mGlA+/HVg1tlfy2Gc6Y?=
 =?us-ascii?q?nSDAoOTZLxVV469xtkqL7EeSky+4TU1XpvMaSvrjDC28gpBOwgyhahYtdfNb?=
 =?us-ascii?q?mIFAjoE80VH8KuMvAlm0C1bhIYO+Bf7LA7P9m8ePuA2a6kJuBgkSmpjWRA54?=
 =?us-ascii?q?B93UaM+DRmRuHU2JYFxumS3hGbWDfkkFehrsf3lJhCZT4IG2q/ySjlBJNXZq?=
 =?us-ascii?q?19ZosLCnmhI9exxtpgg57hQXlY9ESsB1kews+mZQKSb0Dh3Q1XzUkXpX2nmS?=
 =?us-ascii?q?2lzz17ij0ptbSQ0zDTw+T4dRoHJm5KSHBnjVfrPIe0ktQaU1azYgg3mxuq+1?=
 =?us-ascii?q?z6y7JYpKthNWnTR1lHfyzsI2FlSKuwuaKIY9RT55MwrSVXTOO8bEiBSrHjpx?=
 =?us-ascii?q?sa0iXjH3ZRxT0gaTGqtYv2nwZghGKeMnlztnzZdt90xRvF49zcX/FR1CIcRC?=
 =?us-ascii?q?ZkkTnXGkS8P96x8NWQlpfDtP2+Vm24Wp1Qbybr14WAuzW/5WBxHx2/kO68ms?=
 =?us-ascii?q?f9HQg5zyD7zd9qWjvMrBrmZYnrzau6O/p9fkZ0HF/899Z6GoZmn4srmp4Qw3?=
 =?us-ascii?q?caiYuO8HoHi2jzNdFb2KL4bHYXWTELxNvV6hD/2EJ/NnKJ2575VnKFz8tjYt?=
 =?us-ascii?q?m6ZXkW2jg878BRE6qU6qZLnS5rrVq5tw7RZuJ9njhOgccpvVccj+BBmw4gwy?=
 =?us-ascii?q?PVVrkRNU1ZOzH80RWO89266q5QYTDrOZO5z0dv1euqDLifrAVRQj6tcZ45ED?=
 =?us-ascii?q?5Y9c5/OU/C1HDpr4rtPtLXaIRAmAeTlkL7k+VNKJ833sEPjC5jNHO16WYp0M?=
 =?us-ascii?q?YnnBdu2te8p4HBJGJzqvHqSiVEPyH4MptAsgrmirxTy4PPgtGi?=
X-IPAS-Result: =?us-ascii?q?A2DNAABqTPJd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoFvBYFtIBKELYkDhmoGBoE3gQGIaJFGCQEBAQEBAQEBATcBAYFMgnQCg?=
 =?us-ascii?q?i44EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxUtFBALDgoCAiYCAlcGA?=
 =?us-ascii?q?QwIAQEXgkg/glMlrV6BMoVPgyyBSIEOKIlPgmN5gQeBEScPgig1PoQigzeCX?=
 =?us-ascii?q?gSPcYYxYUaXJoI6gjyTNwYbmkEtjh6cTiI+gRorCAIYCCEPgj9pTxEUkCwXF?=
 =?us-ascii?q?Y4sIwOOFIJBAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 14:24:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCENi1U043831;
        Thu, 12 Dec 2019 09:23:45 -0500
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
 <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
 <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
 <16e9e399-2ebf-261f-eee5-cf9ace2a82b9@schaufler-ca.com>
 <20191211203648.GA862919@tassilo.jf.intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d2095e4a-261b-b561-2a2c-cf00fd416503@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 09:24:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211203648.GA862919@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/19 3:36 PM, Andi Kleen wrote:
>>> In this circumstances CAP_SYS_PERFMON looks like smart balanced advancement that
>>> trade-offs between perf_events subsystem extensions, required level of control
>>> and configurability of perf_events, existing users adoption effort, and it brings
>>> security hardening benefits of decreasing attack surface for the existing users
>>> and use cases.
>>
>> I'm not 100% opposed to CAP_SYS_PERFMON. I am 100% opposed to new capabilities
>> that have a single use. Surely there are other CAP_SYS_ADMIN users that [cs]ould
>> be converted to CAP_SYS_PERFMON as well. If there is a class of system performance
>> privileged operations, say a dozen or so, you may have a viable argument.
> 
> perf events is not a single use. It has a bazillion of sub functionalities,
> including hardware tracing, software tracing, pmu counters, software counters,
> uncore counters, break points and various other stuff in its PMU drivers.
> 
> See it more as a whole quite heterogenous driver subsystem.
> 
> I guess CAP_SYS_PERFMON is not a good name because perf is much more
> than just Perfmon. Perhaps call it CAP_SYS_PERF_EVENTS

That seems misleading since it isn't being checked for all perf_events 
operations IIUC (CAP_SYS_ADMIN is still required for some?) and it is 
even more specialized than CAP_SYS_PERFMON, making it less likely that 
we could ever use this capability as a check for other kernel 
performance monitoring facilities beyond perf_events.

I'm not as opposed to fine-grained capabilities as Casey is but I do 
recognize that there are a limited number of available bits (although we 
do have a fair number of unused ones currently given the extension to 
64-bits) and that it would be easy to consume them all if we allocated 
one for every kernel feature.  That said, this might be a sufficiently 
important use case to justify it.

Obviously I'd encourage you to consider leveraging SELinux as well but I 
understand that you are looking for a solution that doesn't depend on a 
distro using a particular LSM or a particular policy.  I will note that 
SELinux doesn't suffer from the limited bits problem because one can 
always define a new SELinux security class with its own access vector 
permissions bitmap, as has been done for the recently added LSM/SELinux 
perf_event hooks.

I don't know who actually gets to decide when/if a new capability is 
allocated.  Maybe Serge and/or James as capabilities and LSM maintainers.

I have no objections to these patches from a SELinux POV.
