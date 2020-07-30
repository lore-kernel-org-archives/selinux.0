Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBEC433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C7520829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgG3Tu4 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:50:56 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14318 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730377AbgG3Tu4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 15:50:56 -0400
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
 <6f1262fc-21ad-f872-5460-e78d4685c9c4@sony.com>
 <20200730120200.1367e1cd@oasis.local.home>
 <15fcdc87-5e9b-8144-5a6b-34594d1e52ef@sony.com>
 <20200730131659.7f1d21e8@oasis.local.home>
 <38053623-2cc0-882d-8578-977ff3f43908@sony.com>
 <20200730152923.5101346c@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <79e9971c-2a51-c180-d938-72932bd4d67d@sony.com>
Date:   Thu, 30 Jul 2020 21:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730152923.5101346c@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DrAoB13+ c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=z6gsHLkEAAAA:8 a=dadijopU3UlrZyO6t4sA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/20 9:29 PM, Steven Rostedt wrote:
> On Thu, 30 Jul 2020 21:12:39 +0200
> peter enderborg <peter.enderborg@sony.com> wrote:
>
>>>> avc:  denied  { find } for interface=vendor.qti.hardware.perf::IPerf sid=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 pid=9164 scontext=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 tcontext=u:object_r:vendor_hal_perf_hwservice:s0 tclass=hwservice_manager permissive=0
>>>>  avc:  denied  { execute } for  pid=13914 comm="ScionFrontendAp" path="/data/user_de/0/com.google.android.gms/app_chimera/m/00000002/oat/arm64/DynamiteLoader.odex" dev="sda77" ino=204967 scontext=u:r:platform_app:s0:c512,c768 tcontext=u:object_r:privapp_data_file:s0:c512,c768 tclass=file permissive=0 ppid=788 pcomm="main" pgid=13914 pgcomm="on.updatecenter"
>>>>
>>>> It omit the fields that are not used. Some parts are common some are not. So a correct format specification for trace will be problematic if there is no "optional" field indicator.  
>>> That's all quite noisy. What is the object of these changes? What
>>> exactly are you trying to trace and why?  
>> It is noisy, and it have to be. it covers a lot of different areas.  One common problem is
>> to debug userspace applications regarding violations. You get the violation from the logs
>> and try to figure out what you did to cause it. With a trace point you can do much better
>> when combine with other traces. Having a the userspace stack is a very good way,
>> unfortunately  it does not work on that many architectures within trace.
>>
>> What exactly are you doing with any trace? You collect data to analyse what's
>> going on. This is not different. Selinux do a specific thing, but is has lots of parameters.
> Have you thought of adding multiple trace events with if statements
> around them to decode each specific type of event?

Yes. And I think class is good split point. But I think it will require
a few layers, but a is mostly data driven so I think it might be hard
to do it compile time.  I think a hybrid might be possible,
but it then we need some ugly part with a other separator than =,
or some escape seq to separate.

sort of "generc1=X generic2=Y variable1^x variable2^y" or

"generc1=X generic2=Y leftover=[variable1=x variable2=y]"

If there was a formal parameter tree we could maybe do some
generated printer. I don't think there are one, maybe Paul Moore or Stephen Smalley
can verify that.

 

> Note, you can have a generic event that gets enabled by all the other
> events via the "reg" and "unreg" part of TRACE_EVENT_FN(). Say its
> called trace_avc, make a dummy trace_avc() call hat doesn't even need
> to be called anywhere, it just needs to exist to get to the other trace
> events.
>
> Then have:
>
> 	if (trace_avc_enabled()) {
> 		if (event1)
> 			trace_avc_req_event1();
> 		if (event2)
> 			trace_avc_req_event2();
> 		[..]
> 	}
>
> The reason for the trace_avc_enabled() is because that's a static
> branch, which is a nop when not enabled. When enabled, it is a jump to
> the out of band if condition block that has all the other trace events.
>
> -- Steve


