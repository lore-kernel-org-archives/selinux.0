Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6131C433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 16:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F2D20758
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 16:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgERQu0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 12:50:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:60500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgERQu0 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 18 May 2020 12:50:26 -0400
IronPort-SDR: RZpLFjnY4CF4vMfRF6x7TFa7Q03Vg439eJhOAmWT03yDGZPXQ6MKN+0li1Jz3mQHGrQpW5Kj4d
 rIwfpMkMAaTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:50:25 -0700
IronPort-SDR: yDZWrORbas6Bbf4P2PnX4MI8kWYYm/LATS1XSpSx+GN75BymvQatXfWkkJ0b6XUvND943g8Zad
 odhH+TmIUu6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="253111534"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2020 09:50:24 -0700
Received: from [10.249.230.167] (abudanko-mobl.ccr.corp.intel.com [10.249.230.167])
        by linux.intel.com (Postfix) with ESMTP id 3F9BF580100;
        Mon, 18 May 2020 09:50:22 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] perf docs: introduce security.txt file to document
 related issues
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
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <290ded0a-c422-3749-5180-918fed1ee30f@linux.intel.com>
 <20200518155936.GG24211@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1f6eb4c7-dec1-355c-024e-8405f4ef7f3e@linux.intel.com>
Date:   Mon, 18 May 2020 19:50:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518155936.GG24211@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 18.05.2020 18:59, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 30, 2020 at 10:16:34AM +0300, Alexey Budankov escreveu:
>>
>> Publish instructions on how to apply LSM hooks for access control
>> to perf_event_open() syscall on Fedora distro with Targeted SELinux
>> policy and then manage access to the syscall.
> 
> I'm fixing these up:
> 
> [acme@five perf]$ am /wb/1.patch
> Applying: perf docs: introduce security.txt file to document related issues
> .git/rebase-apply/patch:46: space before tab in indent.
>  	wake_alarm
> .git/rebase-apply/patch:47: space before tab in indent.
>  	block_suspend
> .git/rebase-apply/patch:48: space before tab in indent.
>  	audit_read
> .git/rebase-apply/patch:51: trailing whitespace.
> 
> .git/rebase-apply/patch:54: trailing whitespace.

This is output of diff utility.
Hopefully it is still applicable after fixes.
I will test this either jointly with the changes at 2/3.

Thanks,
Alexey
