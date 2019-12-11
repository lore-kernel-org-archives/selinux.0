Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E9C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25BE208C3
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 11:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLKLMl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:12:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:22038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfLKLMl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 11 Dec 2019 06:12:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 02:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="215736932"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2019 02:52:20 -0800
Received: from [10.125.252.248] (abudanko-mobl.ccr.corp.intel.com [10.125.252.248])
        by linux.intel.com (Postfix) with ESMTP id 143BF580297;
        Wed, 11 Dec 2019 02:52:16 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        elena.reshetova@intel.com,
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
Organization: Intel Corp.
Message-ID: <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
Date:   Wed, 11 Dec 2019 13:52:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 05.12.2019 20:33, Casey Schaufler wrote:
> On 12/5/2019 9:05 AM, Alexey Budankov wrote:
>> Hello Casey,
>>  
>> On 05.12.2019 19:49, Casey Schaufler wrote:
>>> On 12/5/2019 8:15 AM, Alexey Budankov wrote:
>>>> Currently access to perf_events functionality [1] beyond the scope permitted
>>>> by perf_event_paranoid [1] kernel setting is allowed to a privileged process
>>>> [2] with CAP_SYS_ADMIN capability enabled in the process effective set [3].
>>>>
>>>> This patch set introduces CAP_SYS_PERFMON capability devoted to secure performance
>>>> monitoring activity so that CAP_SYS_PERFMON would assist CAP_SYS_ADMIN in its
>>>> governing role for perf_events based performance monitoring of a system.
>>>>
>>>> CAP_SYS_PERFMON aims to harden system security and integrity when monitoring
>>>> performance using perf_events subsystem by processes and Perf privileged users
>>>> [2], thus decreasing attack surface that is available to CAP_SYS_ADMIN
>>>> privileged processes [3].
>>> Are there use cases where you would need CAP_SYS_PERFMON where you
>>> would not also need CAP_SYS_ADMIN? If you separate a new capability
>> Actually, there are. Perf tool that has record, stat and top modes could run with
>> CAP_SYS_PERFMON capability as mentioned below and provide system wide performance
>> data. Currently for that to work the tool needs to be granted with CAP_SYS_ADMIN.
> 
> The question isn't whether the tool could use the capability, it's whether
> the tool would also need CAP_SYS_ADMIN to be useful. Are there existing
> tools that could stop using CAP_SYS_ADMIN in favor of CAP_SYS_PERFMON?
> My bet is that any tool that does performance monitoring is going to need
> CAP_SYS_ADMIN for other reasons.
> 
>>
>>> from CAP_SYS_ADMIN but always have to use CAP_SYS_ADMIN in conjunction
>>> with the new capability it is all rather pointless.
>>>
>>> The scope you've defined for this CAP_SYS_PERFMON is very small.
>>> Is there a larger set of privilege checks that might be applicable
>>> for it?
>> CAP_SYS_PERFMON could be applied broadly, though, this patch set enables record
>> and stat mode use cases for system wide performance monitoring in kernel and
>> user modes.
> 
> The granularity of capabilities is something we have to watch
> very carefully. Sure, CAP_SYS_ADMIN covers a lot of things, but
> if we broke it up "properly" we'd have hundreds of capabilities.

Fully agree and this broader discussion is really helpful to come up with
properly balanced solution.

> If you want control that finely we have SELinux.

Undoubtedly, SELinux is the powerful, mature, whole level of functionality that
could provide benefits not only for perf_events subsystem. However perf_events
is built around capabilities to provide access control to its functionality,
thus perf_events would require considerable rework prior it could be controlled
thru SELinux. Then the adoption could also require changes to the installed
infrastructure just for the sake of adopting alternative access control mechanism.

On the other hand there are currently already existing users and use cases that
are built around the CAP_SYS_ADMIN based access control, and Perf tool, which is
the native Linux kernel observability and performance profiling tool, provides
means to operate in restricted multiuser environments(HPC clusters, cloud and 
virtual environments) for groups of unprivileged users under admins control [1].

In this circumstances CAP_SYS_PERFMON looks like smart balanced advancement that
trade-offs between perf_events subsystem extensions, required level of control
and configurability of perf_events, existing users adoption effort, and it brings
security hardening benefits of decreasing attack surface for the existing users
and use cases.

Well, yes, it is really good that Linux nowadays provides a handful of various
security assuring mechanisms but proper balance is what usually makes valuable
features happen and its users happy and moves forward. 

Gratefully,
Alexey

[1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
