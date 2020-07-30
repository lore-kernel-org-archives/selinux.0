Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF5C433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6E20838
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgG3PrZ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:47:25 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:9285 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729091AbgG3PrY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 11:47:24 -0400
Subject: Re: [PATCH] RFC: selinux avc trace
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200724091520.880211-1-tweek@google.com>
 <20200724095232.5f9d3f17@oasis.local.home>
 <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
 <CAEjxPJ5tu=R20snbetzv+CCZMd-yD+obbkbf6MYVqQx3oZLkqA@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <b2bde77e-98cf-2c62-79ed-ca7d58b10bca@sony.com>
Date:   Thu, 30 Jul 2020 17:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5tu=R20snbetzv+CCZMd-yD+obbkbf6MYVqQx3oZLkqA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DrAoB13+ c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=z6gsHLkEAAAA:8 a=t2xpVXhOPp6f4VaANuYA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/20 4:50 PM, Stephen Smalley wrote:
> On Thu, Jul 30, 2020 at 10:29 AM peter enderborg
> <peter.enderborg@sony.com> wrote:
>> I did manage to rebase it but this is about my approach.
>>
>> Compared to Thiébaud Weksteen patch this adds:
>>
>> 1 Filtering. Types goes to trace so we can put up a filter for contexts or type etc.
>>
>> 2 It tries also to cover non denies.  And upon that you should be able to do coverage tools.
>> I think many systems have a lot more rules that what is needed, but there is good way
>> to find out what.  A other way us to make a stat page for the rules, but this way connect to
>> userspace and can be used for test cases.
>>
>> This code need a lot more work, but it shows how the filter should work (extra info is not right)
>> and there are  memory leaks, extra debug info and nonsense variable etc.
> Perhaps the two of you could work together to come up with a common
> tracepoint that addresses both needs.

Sounds good to me.

> On the one hand, we don't need/want to duplicate the avc message
> itself; we just need enough to be able to correlate them.
> With respect to non-denials, SELinux auditallow statements can be used
> to generate avc: granted messages that can be used to support coverage
> tools although you can easily flood the logs that way.  One other

That is one reason to use trace. I can be used for things that
generate a lot of data. Like memory allocations and scheduler etc,
and it is a developer tool so you should not have to worry about DOS etc.

Both netlink and android logging are too happy to throw away data for
developers to be happy.

> limitation of the other patch is that it doesn't support generating
> trace information for denials silenced by dontaudit rules, which might
> be challenging to debug especially on Android where you can't just run
> semodule -DB to strip all dontaudits.

I think that only work for rooted devices. Many application developers
run on commercial devices that are locked, but they do have access
to trace. But I have no idea if they (google) have intended the selinux traces to
available there.

