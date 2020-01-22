Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1087C33CB8
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923A22467F
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 14:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAVO0O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:26:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:7295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgAVO0O (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Jan 2020 09:26:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 06:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="259481099"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2020 06:25:20 -0800
Received: from [10.252.5.6] (unknown [10.252.5.6])
        by linux.intel.com (Postfix) with ESMTP id C8A54580100;
        Wed, 22 Jan 2020 06:25:10 -0800 (PST)
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ac0dbab7-de47-ee34-bb88-4c43d3538b7d@linux.intel.com>
Date:   Wed, 22 Jan 2020 17:25:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d7213569-9578-7201-6106-f5ebc95bd6be@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 22.01.2020 17:07, Stephen Smalley wrote:
> On 1/22/20 5:45 AM, Alexey Budankov wrote:
>>
>> On 21.01.2020 21:27, Alexey Budankov wrote:
>>>
>>> On 21.01.2020 20:55, Alexei Starovoitov wrote:
>>>> On Tue, Jan 21, 2020 at 9:31 AM Alexey Budankov
>>>> <alexey.budankov@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>> On 21.01.2020 17:43, Stephen Smalley wrote:
>>>>>> On 1/20/20 6:23 AM, Alexey Budankov wrote:
>>>>>>>
>>>>>>> Introduce CAP_PERFMON capability designed to secure system performance
>>>>>>> monitoring and observability operations so that CAP_PERFMON would assist
>>>>>>> CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
>>>>>>> and other performance monitoring and observability subsystems.
>>>>>>>
>>>>>>> CAP_PERFMON intends to harden system security and integrity during system
>>>>>>> performance monitoring and observability operations by decreasing attack
>>>>>>> surface that is available to a CAP_SYS_ADMIN privileged process [1].
>>>>>>> Providing access to system performance monitoring and observability
>>>>>>> operations under CAP_PERFMON capability singly, without the rest of
>>>>>>> CAP_SYS_ADMIN credentials, excludes chances to misuse the credentials and
>>>>>>> makes operation more secure.
>>>>>>>
>>>>>>> CAP_PERFMON intends to take over CAP_SYS_ADMIN credentials related to
>>>>>>> system performance monitoring and observability operations and balance
>>>>>>> amount of CAP_SYS_ADMIN credentials following the recommendations in the
>>>>>>> capabilities man page [1] for CAP_SYS_ADMIN: "Note: this capability is
>>>>>>> overloaded; see Notes to kernel developers, below."
>>>>>>>
>>>>>>> Although the software running under CAP_PERFMON can not ensure avoidance
>>>>>>> of related hardware issues, the software can still mitigate these issues
>>>>>>> following the official embargoed hardware issues mitigation procedure [2].
>>>>>>> The bugs in the software itself could be fixed following the standard
>>>>>>> kernel development process [3] to maintain and harden security of system
>>>>>>> performance monitoring and observability operations.
>>>>>>>
>>>>>>> [1] http://man7.org/linux/man-pages/man7/capabilities.7.html
>>>>>>> [2] https://www.kernel.org/doc/html/latest/process/embargoed-hardware-issues.html
>>>>>>> [3] https://www.kernel.org/doc/html/latest/admin-guide/security-bugs.html
>>>>>>>
>>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>>> ---
>>>>>>>    include/linux/capability.h          | 12 ++++++++++++
>>>>>>>    include/uapi/linux/capability.h     |  8 +++++++-
>>>>>>>    security/selinux/include/classmap.h |  4 ++--
>>>>>>>    3 files changed, 21 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>>>>>>> index ecce0f43c73a..8784969d91e1 100644
>>>>>>> --- a/include/linux/capability.h
>>>>>>> +++ b/include/linux/capability.h
>>>>>>> @@ -251,6 +251,18 @@ extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct
>>>>>>>    extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
>>>>>>>    extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
>>>>>>>    extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
>>>>>>> +static inline bool perfmon_capable(void)
>>>>>>> +{
>>>>>>> +    struct user_namespace *ns = &init_user_ns;
>>>>>>> +
>>>>>>> +    if (ns_capable_noaudit(ns, CAP_PERFMON))
>>>>>>> +        return ns_capable(ns, CAP_PERFMON);
>>>>>>> +
>>>>>>> +    if (ns_capable_noaudit(ns, CAP_SYS_ADMIN))
>>>>>>> +        return ns_capable(ns, CAP_SYS_ADMIN);
>>>>>>> +
>>>>>>> +    return false;
>>>>>>> +}
>>>>>>
>>>>>> Why _noaudit()?  Normally only used when a permission failure is non-fatal to the operation.  Otherwise, we want the audit message.
>>
>> So far so good, I suggest using the simplest version for v6:
>>
>> static inline bool perfmon_capable(void)
>> {
>>     return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
>> }
>>
>> It keeps the implementation simple and readable. The implementation is more
>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>> privileged process.
>>
>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>> based approach to use perf_event_open system call.
> 
> I can live with that.  We just need to document that when you see both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process, try only allowing CAP_PERFMON first and see if that resolves the issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus CAP_DAC_OVERRIDE.

perf security [1] document can be updated, at least, to align and document 
this audit logging specifics.

~Alexey

[1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
