Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75211C433E3
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6D20791
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHNSuu convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:50:50 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5528 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgHNSuu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 14:50:50 -0400
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
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
 <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
 <CAEjxPJ67G24T1a5WitmMqL4RUpjOgQFwpQ8unO1-OXSS=35V4Q@mail.gmail.com>
 <3518887d-9083-2836-a8db-c7c27a70c990@sony.com>
 <20200814134653.0ba7f64e@oasis.local.home>
 <6e36d3ca-ba2b-d80d-dffd-205521f39573@sony.com>
 <20200814143050.2bda2830@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <96ee2444-56c9-5e74-7bb6-0a0d5541216b@sony.com>
Date:   Fri, 14 Aug 2020 20:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814143050.2bda2830@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=hWcZFhq7V7ubGIIZ06cA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/14/20 8:30 PM, Steven Rostedt wrote:
> On Fri, 14 Aug 2020 20:06:34 +0200
> peter enderborg <peter.enderborg@sony.com> wrote:
>
>> Im find with that, but then you  can not do filtering? I would be
>> pretty neat with a filter saying tclass=file permission=write.
>>
> Well, if the mapping is stable, you could do:
>
> 	(tclass == 6) && (audited & 0x4)

It does not happen to exist a hook for translate strings to numeric values when inserting filter?


> -- Steve


