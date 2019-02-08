Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E43C169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 22:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3222075C
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfBHW3q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:29:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHW3q (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 8 Feb 2019 17:29:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22C0A8830F;
        Fri,  8 Feb 2019 22:29:46 +0000 (UTC)
Received: from [10.18.17.89] (dhcp-17-89.bos.redhat.com [10.18.17.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143271019633;
        Fri,  8 Feb 2019 22:29:44 +0000 (UTC)
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
To:     Paul Moore <paul@paul-moore.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
 <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
 <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
 <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com>
 <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
 <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com>
 <3c92c876-8ef7-aff9-59ab-966ee95978e6@mellanox.com>
 <CAHC9VhQoEZY3s=SjQQe+OR8A9bPN_v8u5fHxmtd=iN==iYkH3Q@mail.gmail.com>
 <12c95863-83bc-2ce8-a2c4-72199af7ed0a@redhat.com>
 <CAHC9VhSgC+x_dsV0_-YRdACm7otRVBsqwn2g6+aYOOo7OaMoEA@mail.gmail.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <0980e59f-dce1-c73d-f3d2-90080ddf56b2@redhat.com>
Date:   Fri, 8 Feb 2019 17:29:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSgC+x_dsV0_-YRdACm7otRVBsqwn2g6+aYOOo7OaMoEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 08 Feb 2019 22:29:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 02/08/2019 03:04 PM, Paul Moore wrote:
> On Fri, Feb 8, 2019 at 2:58 PM Don Dutile <ddutile@redhat.com> wrote:
>> On 02/01/2019 11:09 AM, Paul Moore wrote:
>>> On Fri, Feb 1, 2019 at 9:16 AM Daniel Jurgens <danielj@mellanox.com> wrote:
>>>> On 2/1/2019 7:57 AM, Paul Moore wrote:
>>>>> On Tue, Jan 29, 2019 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Tue, Jan 29, 2019 at 3:58 PM Daniel Jurgens <danielj@mellanox.com> wrote:
>>>>>>> On 1/29/2019 2:51 PM, Paul Moore wrote:
>>>>>>>> Okay, so let's attempt the change above where we just do the access
>>>>>>>> check directly.  Although I'm a little concerned that without a
>>>>>>>> reproducer we might not end up fixing the problem we're trying to fix.
>>>>>>>> Is anyone in touch with the person who originally reported the
>>>>>>>> problem?  It would be great if we could get that person to verify the
>>>>>>>> change ...
>>>>>>> I decided to go with maintaining a list in IB core. The notifier call is done under rcu_read_lock vs spin_lock_irq for register/unregister, so we shouldn't have any problems in that case. So only registering once basically achieves the same thing as taking it all out. I'm testing it now. I'll send it for internal review today assuming it checks out. Hopefully Leon can get it posted tomorrow, I know Don has some schedule pressure here.
>>>>>> Okay sounds good.  We're still at -rc4 so as long as we can get
>>>>>> something posted this week, or early next, I see no reason why it
>>>>>> can't make the upcoming merge window.
>>>>>>
>>>>>> I'm guessing Don's schedule pressure is more a RH deadline, and not an
>>>>>> upstream constraint.
>>>>> I just wanted to check in and see how this was progressing?  I didn't
>>>>> see anything in my inbox, but perhaps I missed it ...
>>>> It's passed internal review. Leon should send it soon (Sunday at the soonest, IL has Friday-Saturday weekends), he may be waiting for a regression run to finish.
>>>
>>> Great, thanks for the update.
>>
>> update? we're approaching the 2nd Sunday after 2/1/2019, when this email was sent ...
> 
> Leon sent out an updated patchset on February 2nd, and I sent a
> reply/ack for the SELinux relevant patch a few days later on the 6th.
> Archive link below, but it looks like you were CC'd ... ?
> 
> * https://lore.kernel.org/selinux/20190202090945.4106-1-leon@kernel.org
> 
Thanks for ptr.  I was looking for a posting from Daniel; forgot Leon was doing it.
I should have search for email from you! ;-)

Finally found it... lost in a several-thousand email stampede here. :-p
I thought I had seen something... and I viewed it while dealing with a massive head cold...
lousy meds! :-p

I guess the maintainers haven't pulled it into an rc branch yet, though,
since a pull/merge doesn't show it up in (rdma-linux's) for-rc or for-next
(or any other jgg or dl-for-* branch I dug around in).
/me needs c-p-able commit-id(s), so it's the '2nd Sunday' for me...


