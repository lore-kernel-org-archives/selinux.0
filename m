Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CAAC12002
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA086120A
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhGUMcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 08:32:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12232 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhGUMcS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 08:32:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GVG7r277vz1CMGb;
        Wed, 21 Jul 2021 21:07:04 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 21:12:51 +0800
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 21:12:50 +0800
Subject: Re: issues about selinux namespace
To:     Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        <jamorris@linux.microsoft.com>,
        "Likun(OSLab)" <hw.likun@huawei.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
References: <22c0d7a1-b658-64ce-f099-0b3617ef8e38@huawei.com>
 <CAEjxPJ5-w83HMRGuDHHqMthkju3bxT0gZ-EiiTE=t5UhQqQ_ug@mail.gmail.com>
 <ec36e53f-5a6d-b86e-790c-d58b7b503aae@huawei.com>
 <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <55cef216-315b-df0d-8ddb-42a250f86a8b@huawei.com>
Date:   Wed, 21 Jul 2021 21:12:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


在 2021/7/20 10:56, Paul Moore 写道:
> On Mon, Jul 19, 2021 at 9:55 AM xiujianfeng <xiujianfeng@huawei.com> wrote:
>> thanks stepthen,  I've found James's patch in
>> https://lwn.net/Articles/737949/,
>>
>> but it seems can't resolve my questions, so any futher discussion would
>> be helpfull and welcome.
>>
>> 在 2021/7/14 20:11, Stephen Smalley 写道:
>>> Please take your email to the selinux@vger.kernel.org. You are the
>>> second person to ask about selinux namespaces within the past week or
>>> so. I did upstream the refactoring and encapsulation of the data
>>> structures and code via the selinux_state patches, so those are in the
>>> mainline kernel these days, and Paul Moore and I have periodically
>>> re-based the remaining patches on top of upstream over in the
>>> https://github.com/SELinuxProject/selinux-kernel/tree/working-selinuxns
>>> branch. However, I had to drop the inode and superblock per-ns patches
>>> temporarily because of changes to LSM (inode blob management moved to
>>> the LSM framework out of the security modules), so that would need to
>>> be revisited. There was a separate patch from James Morris to support
>>> per-namespace security.selinux extended attributes; you can dig that
>>> out from the history or mailing lists if you want to revive that. I
>>> won't be able to look at it again until October at the earliest.
>>>
>>> On Wed, Jul 14, 2021 at 6:54 AM xiujianfeng <xiujianfeng@huawei.com> wrote:
>>>> Hi Stephen,
>>>>
>>>> I am writing to discuss about selinux namespace because I found your
>>>> previous work on github and I think selinux namespace is helpful to
>>>> harden container security. So I try to do further work but there are
>>>> some issues mentioned in the commit message and I have no idea how to
>>>> fix them, it would be great if I can get help from you.
>>>> First is about selinux hook functions, we need to update each hook to
>>>> perform its processing on current namespace and all of its ancestors,
>>>> for object, we can have different sid/tag in different namespace based
>>>> on inode namespace support, but for task, do we need to maintain each
>>>> security context generated in the corresponding namespace?
>>>> Second is the lifecycle management of on-disk inode labels. it's not
>>>> easy to handle this, should we clean all corresponding labels on disk
>>>> when namespace exit? if we do this, it may cost long time to iterate
>>>> inode on disk and must relabel files when container restart, if not, the
>>>> inode xattr space maybe full and cannot write label again when new
>>>> namespace starts.
>>>> BTW, do you have plan to finish the work?
>>>>
>>>> I look forward to receiving your reply.
>>>>
>>>> Best wishes.
> I understand that many mail clients do not encourage inline/bottom
> replies, but when posting to the various Linux Kernel mailing lists
> please make the effort to reply inline, or at the bottom, as
> appropriate.
>
> Namespacing the SELinux kernel code is a rather tricky thing, both
> with respect to the design and the mechanics of the implementation.  I
> don't think we have a concrete idea yet on how we want to proceed in
> all of the areas mentioned; designs - and implementations - have been
> offered, but I think we are missing someone to drive the topic forward
> with demonstrations, sample implementations, etc.  It is never a bad
> idea to ask how you can help a project, but in this case I think the
> answer is to step back for a moment, describe your use-case/problem,
> explain how you envision a namespaced SELinux helping you resolve
> this, and finally how you would want the namespaced SELinux
> implementation to work (how would you interact with it both via policy
> and runtime management).

thanks for you reply, I digged the history disscussion from 
https://marc.info/?l=selinux&m=150696042210126&w=2

and find one use-case: Running multiple android instances on a single 
host, this is the same as mine.

Anyway, I'll make a try.

>
> On a personal note, the regular rebasing of the SELinux namespace work
> has suffered lately due to other time commitments at work.  I have
> recently (today) started a new position which should allow me to
> dedicate much more of my working hours to upstream development; it may
> take me a couple of weeks to get settled in, but you can expect the
> regular rebasing of selinux/working-selinuxns to resume in the future.
>
