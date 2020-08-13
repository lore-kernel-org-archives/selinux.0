Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CEC433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4815520716
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 16:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHMQK3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:10:29 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15302 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgHMQK3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 12:10:29 -0400
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <8386aa4a-0687-769b-235d-9e8bf34ecf90@sony.com>
Date:   Thu, 13 Aug 2020 18:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4424850-645f-5788-fb35-922c81eace6b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=-He6eWZHxituxyHJLsQA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 5:49 PM, Stephen Smalley wrote:
> On 8/13/20 11:35 AM, peter enderborg wrote:
>
>> On 8/13/20 5:05 PM, Casey Schaufler wrote:
>>> On 8/13/2020 7:48 AM, Thiébaud Weksteen wrote:
>>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>>
>>>> This patch adds further attributes to the event. These attributes are
>>>> helpful to understand the context of the message and can be used
>>>> to filter the events.
>>>>
>>>> There are three common items. Source context, target context and tclass.
>>>> There are also items from the outcome of operation performed.
>>>>
>>>> An event is similar to:
>>>>             <...>-1309  [002] ....  6346.691689: selinux_audited:
>>>>         requested=0x4000000 denied=0x4000000 audited=0x4000000
>>>>         result=-13 ssid=315 tsid=61
>>> It may not be my place to ask, but *please please please* don't
>>> externalize secids. I understand that it's easier to type "42"
>>> than "system_r:cupsd_t:s0-s0:c0.c1023", and that it's easier for
>>> your tools to parse and store the number. Once you start training
>>> people that system_r:cupsd_t:s0-s0:c0.c1023 is secid 42 you'll
>>> never be able to change it. The secid will start showing up in
>>> scripts. Bad  Things  Will  Happen.
>> Ok, it seems to mostly against having this performance options.
>> Yes, it is a kernel internal data. So is most of the kernel tracing.
>> I see it is a primary tool for kernel debugging but than can also be
>> used for user-space debugging tools.  Hiding data for debuggers
>> does not make any sense too me.
>
> To be clear, userspace tools can't use fixed secid values because secids are dynamically assigned by SELinux and thus secid 42 need not correspond to the same security context across different boots even with the same kernel and policy.  I wouldn't include them in the event unless it is common practice to include fields that can only be interpreted if you can debug the running kernel.  It would be akin to including kernel pointers in the event (albeit without the KASLR ramifications).
>
Yes of course. Trace debugging is about running kernel. Would i make more sense if the was a debugfs entry with the sid's? This filter are a reminisce  of the same filter used not only to catch denials. Doing a string compare
for all syscalls keep the cpu busy.  I will do an update without it.

