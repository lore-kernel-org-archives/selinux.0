Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC2C433E1
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BC9206C3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHFRxQ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 6 Aug 2020 13:53:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:8047 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728389AbgHFQbQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 12:31:16 -0400
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
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
References: <20200806080358.3124505-1-tweek@google.com>
 <20200806080358.3124505-2-tweek@google.com>
 <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
Date:   Thu, 6 Aug 2020 14:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=6V6ZJp-5uwDIHVc_4FwA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 2:11 PM, Stephen Smalley wrote:
> On 8/6/20 4:03 AM, Thiébaud Weksteen wrote:
>
>> From: Peter Enderborg <peter.enderborg@sony.com>
>>
>> Add further attributes to filter the trace events from AVC.
>
> Please include sample usage and output in the description.
>
>
Im not sure where you want it to be.

In the commit message or in a Documentation/trace/events-avc.rst ?

