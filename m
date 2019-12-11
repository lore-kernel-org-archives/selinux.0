Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD58C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 20:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F225A2173E
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLKUgt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:36:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:40267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKUgt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 11 Dec 2019 15:36:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 12:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="210845460"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2019 12:36:48 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7EAA2300FF1; Wed, 11 Dec 2019 12:36:48 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:36:48 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
Message-ID: <20191211203648.GA862919@tassilo.jf.intel.com>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
 <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
 <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
 <16e9e399-2ebf-261f-eee5-cf9ace2a82b9@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e9e399-2ebf-261f-eee5-cf9ace2a82b9@schaufler-ca.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> > In this circumstances CAP_SYS_PERFMON looks like smart balanced advancement that
> > trade-offs between perf_events subsystem extensions, required level of control
> > and configurability of perf_events, existing users adoption effort, and it brings
> > security hardening benefits of decreasing attack surface for the existing users
> > and use cases.
> 
> I'm not 100% opposed to CAP_SYS_PERFMON. I am 100% opposed to new capabilities
> that have a single use. Surely there are other CAP_SYS_ADMIN users that [cs]ould
> be converted to CAP_SYS_PERFMON as well. If there is a class of system performance
> privileged operations, say a dozen or so, you may have a viable argument.

perf events is not a single use. It has a bazillion of sub functionalities,
including hardware tracing, software tracing, pmu counters, software counters,
uncore counters, break points and various other stuff in its PMU drivers.

See it more as a whole quite heterogenous driver subsystem.

I guess CAP_SYS_PERFMON is not a good name because perf is much more
than just Perfmon. Perhaps call it CAP_SYS_PERF_EVENTS

-Andi
