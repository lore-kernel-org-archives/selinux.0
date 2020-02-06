Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DAC33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B6621775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgBFSDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:03:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:38928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBFSDo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 6 Feb 2020 13:03:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 10:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="236053402"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2020 10:03:42 -0800
Received: from [10.251.88.4] (abudanko-mobl.ccr.corp.intel.com [10.251.88.4])
        by linux.intel.com (Postfix) with ESMTP id 1AA19580698;
        Thu,  6 Feb 2020 10:03:32 -0800 (PST)
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
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
        Thomas Gleixner <tglx@linutronix.de>,
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
References: <0548c832-7f4b-dc4c-8883-3f2b6d351a08@linux.intel.com>
 <9b77124b-675d-5ac7-3741-edec575bd425@linux.intel.com>
 <64cab472-806e-38c4-fb26-0ffbee485367@tycho.nsa.gov>
 <05297eff-8e14-ccdf-55a4-870c64516de8@linux.intel.com>
 <CAADnVQK-JzK-GUk4KOozn4c1xr=7TiCpB9Fi0QDC9nE6iVn8iQ@mail.gmail.com>
 <537bdb28-c9e4-f44f-d665-25250065a6bb@linux.intel.com>
 <63d9700f-231d-7973-5307-3e56a48c54cb@linux.intel.com>
 <d7213569-9578-7201-6106-f5ebc95bd6be@tycho.nsa.gov>
 <ac0dbab7-de47-ee34-bb88-4c43d3538b7d@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2b608e26-354b-3df9-aea9-58e56dc0c5e5@linux.intel.com>
Date:   Thu, 6 Feb 2020 21:03:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <ac0dbab7-de47-ee34-bb88-4c43d3538b7d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 22.01.2020 17:25, Alexey Budankov wrote:
> 
> On 22.01.2020 17:07, Stephen Smalley wrote:
>> On 1/22/20 5:45 AM, Alexey Budankov wrote:
>>>
>>> On 21.01.2020 21:27, Alexey Budankov wrote:
>>>>
>>>> On 21.01.2020 20:55, Alexei Starovoitov wrote:
>>>>> On Tue, Jan 21, 2020 at 9:31 AM Alexey Budankov
>>>>> <alexey.budankov@linux.intel.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 21.01.2020 17:43, Stephen Smalley wrote:
>>>>>>> On 1/20/20 6:23 AM, Alexey Budankov wrote:
>>>>>>>>
>>>>>>>> Introduce CAP_PERFMON capability designed to secure system performance
>>>>>>>> monitoring and observability operations so that CAP_PERFMON would assist
>>>>>>>> CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
>>>>>>>> and other performance monitoring and observability subsystems.
>>>>>>>>
>>>>>>>> CAP_PERFMON intends to harden system security and integrity during system
>>>>>>>> performance monitoring and observability operations by decreasing attack
>>>>>>>> surface that is available to a CAP_SYS_ADMIN privileged process [1].
>>>>>>>> Providing access to system performance monitoring and observability
>>>>>>>> operations under CAP_PERFMON capability singly, without the rest of
>>>>>>>> CAP_SYS_ADMIN credentials, excludes chances to misuse the credentials and
>>>>>>>> makes operation more secure.
>>>>>>>>
>>>>>>>> CAP_PERFMON intends to take over CAP_SYS_ADMIN credentials related to
>>>>>>>> system performance monitoring and observability operations and balance
>>>>>>>> amount of CAP_SYS_ADMIN credentials following the recommendations in the
>>>>>>>> capabilities man page [1] for CAP_SYS_ADMIN: "Note: this capability is
>>>>>>>> overloaded; see Notes to kernel developers, below."
>>>>>>>>
>>>>>>>> Although the software running under CAP_PERFMON can not ensure avoidance
>>>>>>>> of related hardware issues, the software can still mitigate these issues
>>>>>>>> following the official embargoed hardware issues mitigation procedure [2].
>>>>>>>> The bugs in the software itself could be fixed following the standard
>>>>>>>> kernel development process [3] to maintain and harden security of system
>>>>>>>> performance monitoring and observability operations.
>>>>>>>>
>>>>>>>> [1] http://man7.org/linux/man-pages/man7/capabilities.7.html
>>>>>>>> [2] https://www.kernel.org/doc/html/latest/process/embargoed-hardware-issues.html
>>>>>>>> [3] https://www.kernel.org/doc/html/latest/admin-guide/security-bugs.html
<SNIP>
>>>>>>>>
>>>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>>>
>>>>>>> Why _noaudit()?  Normally only used when a permission failure is non-fatal to the operation.  Otherwise, we want the audit message.
>>>
>>> So far so good, I suggest using the simplest version for v6:
>>>
>>> static inline bool perfmon_capable(void)
>>> {
>>>     return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
>>> }
>>>
>>> It keeps the implementation simple and readable. The implementation is more
>>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>>> privileged process.
>>>
>>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>>> based approach to use perf_event_open system call.
>>
>> I can live with that.  We just need to document that when you see both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process, try only allowing CAP_PERFMON first and see if that resolves the issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus CAP_DAC_OVERRIDE.
> 
> perf security [1] document can be updated, at least, to align and document 
> this audit logging specifics.

And I plan to update the document right after this patch set is accepted.
Feel free to let me know of the places in the kernel docs that also
require update w.r.t CAP_PERFMON extension.

~Alexey

> 
> ~Alexey
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> 
