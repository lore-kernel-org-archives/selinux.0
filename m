Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F2C352A4
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 11:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9699B20720
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 11:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBGLjJ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 7 Feb 2020 06:39:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGLjI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 06:39:08 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j01xc-000288-1g; Fri, 07 Feb 2020 12:38:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7CCA5100375; Fri,  7 Feb 2020 11:38:11 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula\@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen\@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi\@intel.com" <rodrigo.vivi@intel.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
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
        "linux-security-module\@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux\@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-parisc\@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users\@vger.kernel.org" 
        <linux-perf-users@vger.kernel.org>, oprofile-list@lists.sf.net,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel and user space
In-Reply-To: <2b608e26-354b-3df9-aea9-58e56dc0c5e5@linux.intel.com>
Date:   Fri, 07 Feb 2020 11:38:11 +0000
Message-ID: <875zgizkyk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Alexey Budankov <alexey.budankov@linux.intel.com> writes:
> On 22.01.2020 17:25, Alexey Budankov wrote:
>> On 22.01.2020 17:07, Stephen Smalley wrote:
>>>> It keeps the implementation simple and readable. The implementation is more
>>>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>>>> privileged process.
>>>>
>>>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>>>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>>>> based approach to use perf_event_open system call.
>>>
>>> I can live with that.  We just need to document that when you see
>>> both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process,
>>> try only allowing CAP_PERFMON first and see if that resolves the
>>> issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus
>>> CAP_DAC_OVERRIDE.
>> 
>> perf security [1] document can be updated, at least, to align and document 
>> this audit logging specifics.
>
> And I plan to update the document right after this patch set is accepted.
> Feel free to let me know of the places in the kernel docs that also
> require update w.r.t CAP_PERFMON extension.

The documentation update wants be part of the patch set and not planned
to be done _after_ the patch set is merged.

Thanks,

        tglx
