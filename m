Return-Path: <SRS0=5MQ6=4I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF399C11D09
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A105124670
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 13:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgBTNFj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:05:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:57895 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgBTNFj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Feb 2020 08:05:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 05:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="283399590"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2020 05:05:21 -0800
Received: from [10.125.252.166] (abudanko-mobl.ccr.corp.intel.com [10.125.252.166])
        by linux.intel.com (Postfix) with ESMTP id 253CC580472;
        Thu, 20 Feb 2020 05:05:12 -0800 (PST)
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robert Richter <rric@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        oprofile-list@lists.sf.net, Andy Lutomirski <luto@amacapital.net>
References: <875zgizkyk.fsf@nanos.tec.linutronix.de>
 <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
Organization: Intel Corp.
Message-ID: <95aa57e6-4d78-39df-386c-a98734f19777@linux.intel.com>
Date:   Thu, 20 Feb 2020 16:05:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 07.02.2020 16:39, Alexey Budankov wrote:
> 
> On 07.02.2020 14:38, Thomas Gleixner wrote:
>> Alexey Budankov <alexey.budankov@linux.intel.com> writes:
>>> On 22.01.2020 17:25, Alexey Budankov wrote:
>>>> On 22.01.2020 17:07, Stephen Smalley wrote:
>>>>>> It keeps the implementation simple and readable. The implementation is more
>>>>>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>>>>>> privileged process.
>>>>>>
>>>>>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>>>>>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>>>>>> based approach to use perf_event_open system call.
>>>>>
>>>>> I can live with that.  We just need to document that when you see
>>>>> both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process,
>>>>> try only allowing CAP_PERFMON first and see if that resolves the
>>>>> issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus
>>>>> CAP_DAC_OVERRIDE.
>>>>
>>>> perf security [1] document can be updated, at least, to align and document 
>>>> this audit logging specifics.
>>>
>>> And I plan to update the document right after this patch set is accepted.
>>> Feel free to let me know of the places in the kernel docs that also
>>> require update w.r.t CAP_PERFMON extension.
>>
>> The documentation update wants be part of the patch set and not planned
>> to be done _after_ the patch set is merged.
> 
> Well, accepted. It is going to make patches #11 and beyond.

Patches #11 and #12 of v7 [1] contain information on CAP_PERFMON intention and usage.
Patch for man-pages [2] extends perf_event_open.2 documentation.

Thanks,
Alexey

---
[1] https://lore.kernel.org/lkml/c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com/
[2] https://lore.kernel.org/lkml/18d1083d-efe5-f5f8-c531-d142c0e5c1a8@linux.intel.com/

