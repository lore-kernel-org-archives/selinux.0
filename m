Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B1C433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AB22075E
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgHUNjQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:39:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:1973 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbgHUNjP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:39:15 -0400
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
 <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home>
 <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
 <20200820223136.162850ce@oasis.local.home>
 <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
 <CAHC9VhTLOWsD9LbVGBj=o3N3SPe-uJDvrdQAySy6MmE4uyuzng@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <5a545bde-0158-b7f8-94d7-525591db23a1@sony.com>
Date:   Fri, 21 Aug 2020 15:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTLOWsD9LbVGBj=o3N3SPe-uJDvrdQAySy6MmE4uyuzng@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=pGLkceISAAAA:8 a=meVymXHHAAAA:8 a=ibUXxvZku06OJSsJHzUA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/21/20 3:19 PM, Paul Moore wrote:
> On Fri, Aug 21, 2020 at 8:29 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Thu, Aug 20, 2020 at 10:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>> On Wed, 19 Aug 2020 09:11:08 -0400
>>> Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>>>
>>>> So we'll need to update this plugin whenever we modify
>>>> security/selinux/include/classmap.h to keep them in sync.  Is that a
>>>> concern?  I don't suppose the plugin could directly include classmap.h?
>>>> I guess we'd have to export it as a public header. It isn't considered
>>>> to be part of the kernel API/ABI and can change anytime (but in practice
>>>> changes are not that frequent, and usually just additive in nature).
>>> Yes, it would require some stability between userspace and the plugin.
>>> If the value indexes don't change then that would work fine. If you add
>>> new ones, that too should be OK, just have a way to state "unknown" in
>>> the plugin.
>> Since we introduced the dynamic class/perm mapping support, it has
>> been possible for the values of existing classes/permissions to
>> change, and that has happened at time, e.g. when we added watch
>> permissions to the common file perms, that shifted the values of the
>> class file perms like entrypoint, when we added the process2 class
>> right after the process class, it shifted the values of all the
>> subsequent classes in the classmap.h.  So you can't rely on those
>> values remaining stable across kernel versions.
> I think it is becoming increasingly clear that generating the
> permission set string in userspace isn't really workable without
> breaking the dynamic class/permission mapping to some degree.
> Unfortunately I don't see these perf changes as a big enough "win" to
> offset the loss of the dynamic mapping loss.
>
> I'm okay with merging patches 1/3 and 2/3 wth the changes Stephen
> suggested, but I think we will need to leave patch 3/3 out of this for
> now.
>
Ok.

