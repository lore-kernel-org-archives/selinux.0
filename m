Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD026C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C230C20829
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMSS7 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:18:59 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:17520 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMSS7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 14:18:59 -0400
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
References: <20200813144914.737306-1-tweek@google.com>
 <20200813144914.737306-2-tweek@google.com>
 <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
 <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
 <c4424850-645f-5788-fb35-922c81eace6b@gmail.com>
 <1b40226f-d182-7ba7-a6f6-15520c3e3516@sony.com>
 <20200813133842.655aff65@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <c1f8c9a9-d123-df96-4918-890355db0301@sony.com>
Date:   Thu, 13 Aug 2020 20:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813133842.655aff65@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=2Xgm7kxpWWB7vV7sCCAA:9 a=jdrQNCl8WPiarg2q:21 a=WUXUPrc1PcCH_Irx:21 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 7:38 PM, Steven Rostedt wrote:
> On Thu, 13 Aug 2020 19:14:10 +0200
> peter enderborg <peter.enderborg@sony.com> wrote:
>
>>> To be clear, userspace tools can't use fixed secid values because
>>> secids are dynamically assigned by SELinux and thus secid 42 need
>>> not correspond to the same security context across different boots
>>> even with the same kernel and policy.  I wouldn't include them in
>>> the event unless it is common practice to include fields that can
>>> only be interpreted if you can debug the running kernel.  It would
>>> be akin to including kernel pointers in the event (albeit without
>>> the KASLR ramifications).
>>>
>>>  
>> Just as a reference on my fedora system; out of 1808 events 244 as a
>> pointer print. I don't see that there is any obfuscating aka "%pK" as
>> there is for logs.
> Which is a reason why tracefs is root only.
>
> The "%p" gets obfuscated when printed from the trace file by default
> now. But they are consistent (where the same pointer shows up as the
> same hash).
>
> It's used mainly to map together events. For example, if you print the
> address of a skb in the networking events, it's good to know what
> events reference the same skb, and the pointer is used for that.

So what is your opinion on ssid? I dont mind removing them
now since people dont like it and the strong use-case is not
strong (yet). Is there any problem to put getting them back
later if useful? And then before the strings so the evaluation
of filter first come on number before stings Or is there already
some mechanism that optimize for that?


> -- Steve


