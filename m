Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3BC352A2
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F9B21775
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGNjX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:39:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:44098 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgBGNjW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Feb 2020 08:39:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 05:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,413,1574150400"; 
   d="scan'208";a="220798400"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2020 05:39:21 -0800
Received: from [10.125.252.178] (abudanko-mobl.ccr.corp.intel.com [10.125.252.178])
        by linux.intel.com (Postfix) with ESMTP id 7EB57580458;
        Fri,  7 Feb 2020 05:39:13 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
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
Organization: Intel Corp.
Message-ID: <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
Date:   Fri, 7 Feb 2020 16:39:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <875zgizkyk.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 07.02.2020 14:38, Thomas Gleixner wrote:
> Alexey Budankov <alexey.budankov@linux.intel.com> writes:
>> On 22.01.2020 17:25, Alexey Budankov wrote:
>>> On 22.01.2020 17:07, Stephen Smalley wrote:
>>>>> It keeps the implementation simple and readable. The implementation is more
>>>>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>>>>> privileged process.
>>>>>
>>>>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>>>>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>>>>> based approach to use perf_event_open system call.
>>>>
>>>> I can live with that.  We just need to document that when you see
>>>> both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process,
>>>> try only allowing CAP_PERFMON first and see if that resolves the
>>>> issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus
>>>> CAP_DAC_OVERRIDE.
>>>
>>> perf security [1] document can be updated, at least, to align and document 
>>> this audit logging specifics.
>>
>> And I plan to update the document right after this patch set is accepted.
>> Feel free to let me know of the places in the kernel docs that also
>> require update w.r.t CAP_PERFMON extension.
> 
> The documentation update wants be part of the patch set and not planned
> to be done _after_ the patch set is merged.

Well, accepted. It is going to make patches #11 and beyond.

Thanks,
Alexey

> 
> Thanks,
> 
>         tglx
> 
