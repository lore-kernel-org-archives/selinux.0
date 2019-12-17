Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C5C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A4C20716
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 09:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLQJp3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:45:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:31364 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQJp2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 17 Dec 2019 04:45:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 01:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="217719255"
Received: from gorris-mobl2.ger.corp.intel.com (HELO [10.249.34.224]) ([10.249.34.224])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 01:45:20 -0800
Subject: Re: [Intel-gfx] [PATCH v3 4/7] drm/i915/perf: open access for
 CAP_SYS_PERFMON privileged process
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     songliubraving@fb.com, Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        intel-gfx@lists.freedesktop.org,
        Igor Lubashev <ilubashe@akamai.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <b175f283-d256-e37e-f447-6ba4ab4f3d3a@linux.intel.com>
 <bc5b2a0d-a185-91b6-5deb-a4b6e1dc3d3e@linux.intel.com>
From:   Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <503ad40c-d94e-df1d-1541-730c002ad3b7@intel.com>
Date:   Tue, 17 Dec 2019 11:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <bc5b2a0d-a185-91b6-5deb-a4b6e1dc3d3e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 16/12/2019 22:03, Alexey Budankov wrote:
> Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged processes.
> For backward compatibility reasons access to i915_perf subsystem remains open
> for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
> i915_perf monitoring is discouraged with respect to CAP_SYS_PERFMON capability.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>


Assuming people are fine with this new cap, I like this idea of a 
lighter privilege for i915-perf.


-Lionel


