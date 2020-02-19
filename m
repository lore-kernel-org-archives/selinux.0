Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7938C34022
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52C21D56
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 07:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBSHyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:54:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:6491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBSHyp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Feb 2020 02:54:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 23:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="436148633"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2020 23:54:42 -0800
Received: from [10.125.252.130] (abudanko-mobl.ccr.corp.intel.com [10.125.252.130])
        by linux.intel.com (Postfix) with ESMTP id 40E9A580270;
        Tue, 18 Feb 2020 23:54:36 -0800 (PST)
Subject: Re: [PATCH v7 01/12] capabilities: introduce CAP_PERFMON to kernel
 and user space
To:     James Morris <jmorris@namei.org>
Cc:     Serge Hallyn <serge@hallyn.com>,
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
References: <c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com>
 <f56fbb5c-1477-44d5-7346-85a1ca0869dc@linux.intel.com>
 <alpine.LRH.2.21.2002190621180.10165@namei.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4664bbc7-e4ef-5d6e-7f71-96e5567fcf60@linux.intel.com>
Date:   Wed, 19 Feb 2020 10:54:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2002190621180.10165@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 18.02.2020 22:21, James Morris wrote:
> On Mon, 17 Feb 2020, Alexey Budankov wrote:
> 
>>
>> Introduce CAP_PERFMON capability designed to secure system performance
>> monitoring and observability operations so that CAP_PERFMON would assist
>> CAP_SYS_ADMIN capability in its governing role for performance
>> monitoring and observability subsystems.
> 
> 
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Thanks James! 
I appreciate your involvement and collaboration 
w.r.t to the whole patch set.

Gratefully,
Alexey
