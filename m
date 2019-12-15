Return-Path: <SRS0=eXnu=2F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4509C43603
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 11:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FA522B48
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 11:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfLOLxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Dec 2019 06:53:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:55004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfLOLxn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 15 Dec 2019 06:53:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 03:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,317,1571727600"; 
   d="scan'208";a="416159519"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Dec 2019 03:53:41 -0800
Received: from [10.251.95.214] (abudanko-mobl.ccr.corp.intel.com [10.251.95.214])
        by linux.intel.com (Postfix) with ESMTP id 1FB7658044E;
        Sun, 15 Dec 2019 03:53:36 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <d2095e4a-261b-b561-2a2c-cf00fd416503@tycho.nsa.gov>
Organization: Intel Corp.
Message-ID: <533d0954-25ce-9df0-6324-3ff00d1ee042@linux.intel.com>
Date:   Sun, 15 Dec 2019 14:53:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d2095e4a-261b-b561-2a2c-cf00fd416503@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 12.12.2019 17:24, Stephen Smalley wrote:
> On 12/11/19 3:36 PM, Andi Kleen wrote:
>>>> In this circumstances CAP_SYS_PERFMON looks like smart balanced advancement that
>>>> trade-offs between perf_events subsystem extensions, required level of control
>>>> and configurability of perf_events, existing users adoption effort, and it brings
>>>> security hardening benefits of decreasing attack surface for the existing users
>>>> and use cases.
>>>
>>> I'm not 100% opposed to CAP_SYS_PERFMON. I am 100% opposed to new capabilities
>>> that have a single use. Surely there are other CAP_SYS_ADMIN users that [cs]ould
>>> be converted to CAP_SYS_PERFMON as well. If there is a class of system performance
>>> privileged operations, say a dozen or so, you may have a viable argument.
>>
>> perf events is not a single use. It has a bazillion of sub functionalities,
>> including hardware tracing, software tracing, pmu counters, software counters,
>> uncore counters, break points and various other stuff in its PMU drivers.
>>
>> See it more as a whole quite heterogenous driver subsystem.
>>
>> I guess CAP_SYS_PERFMON is not a good name because perf is much more
>> than just Perfmon. Perhaps call it CAP_SYS_PERF_EVENTS
> 
> That seems misleading since it isn't being checked for all perf_events operations IIUC (CAP_SYS_ADMIN is still required for some?) and it is even more specialized than CAP_SYS_PERFMON, making it less likely that we could ever use this capability as a check for other kernel performance monitoring facilities beyond perf_events.
> 
> I'm not as opposed to fine-grained capabilities as Casey is but I do recognize that there are a limited number of available bits (although we do have a fair number of unused ones currently given the extension to 64-bits) and that it would be easy to consume them all if we allocated one for every kernel feature.  That said, this might be a sufficiently important use case to justify it.
> 
> Obviously I'd encourage you to consider leveraging SELinux as well but I understand that you are looking for a solution that doesn't depend on a distro using a particular LSM or a particular policy.  I will note that SELinux doesn't suffer from the limited bits problem because one can always define a new SELinux security class with its own access vector permissions bitmap, as has been done for the recently added LSM/SELinux perf_event hooks.
> 
> I don't know who actually gets to decide when/if a new capability is allocated.  Maybe Serge and/or James as capabilities and LSM maintainers.
> 
> I have no objections to these patches from a SELinux POV.

Stephen, thanks for meaningful input!

~Alexey
