Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B093C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386BD214AF
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfLKRAO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:00:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:62027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLKRAO (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 11 Dec 2019 12:00:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="220497269"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2019 09:00:13 -0800
Received: from [10.252.11.55] (abudanko-mobl.ccr.corp.intel.com [10.252.11.55])
        by linux.intel.com (Postfix) with ESMTP id 43A9358043C;
        Wed, 11 Dec 2019 09:00:09 -0800 (PST)
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
 <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
 <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
 <20191211152435.GN2827@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <72d0dabb-ebd1-f071-6167-1fa935c0a09c@linux.intel.com>
Date:   Wed, 11 Dec 2019 20:00:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211152435.GN2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 11.12.2019 18:24, Peter Zijlstra wrote:
> On Wed, Dec 11, 2019 at 01:52:15PM +0300, Alexey Budankov wrote:
>> Undoubtedly, SELinux is the powerful, mature, whole level of functionality that
>> could provide benefits not only for perf_events subsystem. However perf_events
>> is built around capabilities to provide access control to its functionality,
>> thus perf_events would require considerable rework prior it could be controlled
>> thru SELinux. 
> 
> You mean this:
> 
>   da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> ?

Yes, I do.

This feature greatly adds up into MAC access control [1], [2] for perf_events,
additionally to already existing DAC [3]. However, there is still the whole
other part of MAC story on the user space side.

Fortunately MAC and DAC access control mechanisms designed in the way they are
naturally layered and coexist in the system so I don't see any contradiction
in advancing either mechanism to meet the demand of possible diverse use cases.

There is no much rationale in providing favor to one or the other mechanism
because together they constitute complete integrity of security access control
and configurability for diverse use cases of perf_events.

> 
>> Then the adoption could also require changes to the installed
>> infrastructure just for the sake of adopting alternative access control mechanism.
> 
> This is still very much true.

It is just enough to imaging some HPC cluster or Cloud lab with
several hundreds of nodes to be upgraded.

Thanks,
Alexey

[1] https://en.wikipedia.org/wiki/Security-Enhanced_Linux
[2] https://en.wikipedia.org/wiki/Mandatory_access_control
[3] https://en.wikipedia.org/wiki/Discretionary_access_control
