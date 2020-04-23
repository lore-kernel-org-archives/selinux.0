Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF9C54FD0
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EFC2074F
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgDWOvx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:51:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:45957 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOvx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Apr 2020 10:51:53 -0400
IronPort-SDR: mFfim4ixyjTNpauoq+3yzZBJ9jHeT+GOVX34/U4zw2ljZyK3VEz/v1kzR7gh7A71LqLpmQlhUl
 20qlw0500qLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 07:51:53 -0700
IronPort-SDR: LqoLZriqlM/nAE/u5Cwq5eB70FSL9WIyibntNOBpYeXBsw7OaVAygKvArEIkh9kSUds/I7DIXH
 U8xLJfBF+Huw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="457524584"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2020 07:51:52 -0700
Received: from [10.249.228.14] (abudanko-mobl.ccr.corp.intel.com [10.249.228.14])
        by linux.intel.com (Postfix) with ESMTP id F29595802C9;
        Thu, 23 Apr 2020 07:51:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] perf docs: substitute CAP_SYS_ADMIN with
 CAP_PERFMON where needed
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <f1b48de9-e2b7-d20b-3686-3a15b73ef45c@linux.intel.com>
 <20200423132201.GB19437@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1f7e4ffa-6c46-3a27-7949-969586165aca@linux.intel.com>
Date:   Thu, 23 Apr 2020 17:51:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423132201.GB19437@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 23.04.2020 16:22, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 22, 2020 at 05:44:53PM +0300, Alexey Budankov escreveu:
>>
>> Substitute CAP_SYS_ADMIN with CAP_PERFMON in the docs where admin
>> is mentioned. CAP_SYS_ADMIN still works in keeping with user space
>> backward compatibility approach.
> 
> Same issue as with the previous patch, the documentation is for the
> tool, that may be used in older kernels, so we need to clarify that
> CAP_PERFMON requires updating libcap and the kernel, if that isn't
> possible, then CAP_SYS_ADMIN is needed.

Then it is just extending of single mentioning of "CAP_SYS_ADMIN" with
"CAP_PERFMON or CAP_SYS_ADMIN" where required.

Thanks,
Alexey
