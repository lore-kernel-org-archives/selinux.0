Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB9C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1E21D56
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgBRTYz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:24:55 -0500
Received: from namei.org ([65.99.196.166]:46644 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgBRTYz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 18 Feb 2020 14:24:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01IJO3sT013441;
        Tue, 18 Feb 2020 19:24:03 GMT
Date:   Wed, 19 Feb 2020 06:24:03 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        oprofile-list@lists.sf.net,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v7 04/12] perf tool: extend Perf tool with CAP_PERFMON
 capability support
In-Reply-To: <5f961a07-36d0-d8f4-1895-6cfc38bcb81e@linux.intel.com>
Message-ID: <alpine.LRH.2.21.2002190623450.10165@namei.org>
References: <c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com> <5f961a07-36d0-d8f4-1895-6cfc38bcb81e@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 17 Feb 2020, Alexey Budankov wrote:

> 
> Extend error messages to mention CAP_PERFMON capability as an option
> to substitute CAP_SYS_ADMIN capability for secure system performance
> monitoring and observability. Make perf_event_paranoid_check() and
> __cmd_ftrace() to be aware of CAP_PERFMON capability.
> 
> CAP_PERFMON implements the principal of least privilege for performance
> monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39
> principle of least privilege: A security design principle that states
> that a process or program be granted only those privileges (e.g.,
> capabilities) necessary to accomplish its legitimate function, and only
> for the time that such privileges are actually required)
> 
> For backward compatibility reasons access to perf_events subsystem
> remains open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN
> usage for secure perf_events monitoring is discouraged with respect to
> CAP_PERFMON capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

