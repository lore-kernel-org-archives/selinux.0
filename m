Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E797C433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435AB2082E
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3PbV convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:31:21 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:8915 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbgG3PbV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 11:31:21 -0400
Subject: Re: [PATCH] RFC: selinux avc trace
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <selinux@vger.kernel.org>
References: <20200724091520.880211-1-tweek@google.com>
 <20200724095232.5f9d3f17@oasis.local.home>
 <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
 <20200730110459.5bf0b0df@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <6f1262fc-21ad-f872-5460-e78d4685c9c4@sony.com>
Date:   Thu, 30 Jul 2020 17:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730110459.5bf0b0df@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DrAoB13+ c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=z6gsHLkEAAAA:8 a=5h1WKlBXYhE9TN685y0A:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/20 5:04 PM, Steven Rostedt wrote:
> On Thu, 30 Jul 2020 16:29:12 +0200
> peter enderborg <peter.enderborg@sony.com> wrote:
>
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM avc
>> +
>> +#if !defined(_TRACE_AVC_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_AVC_H
>> +
>> +#include <linux/tracepoint.h>
>> +TRACE_EVENT(avc_data,
>> +        TP_PROTO(u32 requested,
>> +             u32 denied,
>> +             u32 audited,
>> +             int result,
>> +             const char *msg
>> +             ),
>> +
>> +        TP_ARGS(requested, denied, audited, result,msg),
>> +
>> +        TP_STRUCT__entry(
>> +             __field(u32, requested)
>> +             __field(u32, denied)
>> +             __field(u32, audited)
>> +             __field(int, result)
>> +             __array(char, msg, 255)
> You want to use __string() here, otherwise you are wasting a lot of
> buffer space.
>
> 		__string( msg, msg)
It should be a full structure with a lot of sub strings.  But that make is even more relevant.
>
>> +                 ),
>> +
>> +        TP_fast_assign(
>> +               __entry->requested    = requested;
>> +               __entry->denied    = denied;
>> +               __entry->audited    = audited;
>> +               __entry->result    = result;
>> +               memcpy(__entry->msg, msg, 255);
> Not to mention, the above is a bug. As the msg being passed in, is
> highly unlikely to be 255 bytes. You just leaked all that memory after
> the sting to user space.
>
> Where you want here:
>
> 		__assign_str( msg, msg );

Directly in to the code. Was more in to get in to discussion on how complex we should have
the trace data. There is a lot of fields. Not all is always present. Is there any good way
to handle that? Like "something= somethingelse=42" or "something=nil somthingelse=42"


>
> -- Steve
>
>
>
>> +    ),
>> +
>> +        TP_printk("requested=0x%x denied=%d audited=%d result=%d
>> msg=%s",
>> +              __entry->requested, __entry->denied, __entry->audited,
>> __entry->result, __entry->msg
>> +              )


