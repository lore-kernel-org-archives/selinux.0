Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58B7C54FD0
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4F2074F
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDWOti (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:49:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:43187 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOti (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Apr 2020 10:49:38 -0400
IronPort-SDR: 7qxIBEgG3WEPfdjusavt1enZ89VFXYhLTAyKlGKf0PlgAZjk9zJsT3llULEZYrmmaAEU8lLUa2
 KqW6nVg9tqcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 07:49:37 -0700
IronPort-SDR: MtXdHNMsGlrXrs09Toa9jfSEyfxSQh0dM37YM4Jo6MWNlglMEHwyr9qkNbc1GzIUDncM04qQga
 /kf0UqA05Nfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="366022929"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2020 07:49:36 -0700
Received: from [10.249.228.14] (abudanko-mobl.ccr.corp.intel.com [10.249.228.14])
        by linux.intel.com (Postfix) with ESMTP id 028015802C9;
        Thu, 23 Apr 2020 07:49:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] perf trace: substitute CAP_SYS_ADMIN with
 CAP_PERFMON in error message
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
 <450d035a-c192-10e5-1c28-664ccae3e46e@linux.intel.com>
 <20200423132052.GA19437@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a775fef2-6d86-d43a-3a46-5b2d129c77dc@linux.intel.com>
Date:   Thu, 23 Apr 2020 17:49:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423132052.GA19437@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 23.04.2020 16:20, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 22, 2020 at 05:44:02PM +0300, Alexey Budankov escreveu:
>>
>> Update error message to mention CAP_PERFMON only. CAP_SYS_ADMIN still
>> works in keeping with user space backward compatibility approach.
> 
> This will confuse users that build the latest perf to use in older
> systems where CAP_PERFMON isn't available, probably we need to, in these
> cases, check for the existence of CAP_PERFMON to provide a better
> warning message, something like:
> 
>   You need CAP_ADMIN or update your kernel and libcap to one that supports
>   CAP_PERFMON.
> 
> For systems without CAP_PERFMON, while mentioning only CAP_PERFMON for
> systems where it is present, right?

Right, but this ideal implementation requires more effort, so staying with
two caps in the message and letting users decide which one to use looks like
a good balance already. 

Thanks,
Alexey
