Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93613C433E1
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEDE20774
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 17:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHNRHR convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:07:17 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:3767 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgHNRHQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 13:07:16 -0400
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>
CC:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200813144914.737306-1-tweek@google.com>
 <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
 <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
 <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
Date:   Fri, 14 Aug 2020 19:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=vnrgZUeuQPK-PAqJpb0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/14/20 6:51 PM, Stephen Smalley wrote:
> On Fri, Aug 14, 2020 at 9:05 AM Thiébaud Weksteen <tweek@google.com> wrote:
>> On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>> An explanation here of how one might go about decoding audited and
>>> tclass would be helpful to users (even better would be a script to do it
>>> for them).  Again, I know how to do that but not everyone using
>>> perf/ftrace will.
>> What about something along those lines:
>>
>> The tclass value can be mapped to a class by searching
>> security/selinux/flask.h. The audited value is a bit field of the
>> permissions described in security/selinux/av_permissions.h for the
>> corresponding class.
> Sure, I guess that works.  Would be nice if we just included the class
> and permission name(s) in the event itself but I guess you viewed that
> as too heavyweight?

The class name is added in part 2. Im not sure how a proper format for permission
would look like in trace terms. It is a list, right?



