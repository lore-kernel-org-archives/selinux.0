Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED26C433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375CB2075F
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 08:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgG3IXw convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:23:52 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:18121 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbgG3IXw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 04:23:52 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2020 04:23:51 EDT
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
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
 <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
 <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
 <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <def030b4-91c3-4aa1-e8ad-e3797688d18d@sony.com>
Date:   Thu, 30 Jul 2020 10:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DrAoB13+ c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=xVhDTqbCAAAA:8 a=kSkFpLqy8y9c_-cfnwsA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/28/20 6:02 PM, Thiébaud Weksteen wrote:
> On Tue, Jul 28, 2020 at 5:12 PM Paul Moore <paul@paul-moore.com> wrote:
>> Perhaps it would be helpful if you provided an example of how one
>> would be expected to use this new tracepoint?  That would help put
>> things in the proper perspective.
> The best example is the one I provided in the commit message, that is
> using perf (or a perf equivalent), to hook onto that tracepoint.
>
>> Well, to be honest, the very nature of this tracepoint is duplicating
>> the AVC audit record with a focus on using perf to establish a full
>> backtrace at the expense of reduced information.  At least that is how
>> it appears to me.
> I see both methods as complementary. By default, the kernel itself can
> do some reporting (i.e avc message) on which process triggered the
> denial, what was the context, etc. This is useful even in production
> and doesn't require any extra tooling.
> The case for adding this tracepoint can be seen as advanced debugging.
> That is, once an avc denial has been confirmed, a developer can use
> this tracepoint to surface the userland stacktrace. It requires more
> userland tools and symbols on the userland binaries.

I think from development view you would like to have a better
way to trap this events in userspace. One idea that I have is
is to have more outcomes from a rule. We have today allow,
dontaudit, auditallow i think it would be good to have signal sent too.
"signal-xxx-allow" for some set of signals. SIGBUS, SIGSEGV, SIGABRT maybe.

That will be a good way to pickup the problem with a debugger or generate a
a core file.

I have also done some selinux trace functions. I think they collide with this set,
but I think I can rebase them upon yours and see if they give some more functionality.

I see this functionality very much needed in some form.


