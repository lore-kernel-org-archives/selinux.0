Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEEDC282CD
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26192177E
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 02:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfA2C5n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:57:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfA2C5n (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 28 Jan 2019 21:57:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DEC958E4B;
        Tue, 29 Jan 2019 02:57:42 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327BE104810C;
        Tue, 29 Jan 2019 02:57:41 +0000 (UTC)
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
To:     Paul Moore <paul@paul-moore.com>,
        Daniel Jurgens <danielj@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
Date:   Mon, 28 Jan 2019 21:57:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 02:57:42 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 01/28/2019 06:03 PM, Paul Moore wrote:
> On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.com> wrote:
>> On 1/28/2019 10:37 AM, Paul Moore wrote:
>>> On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> ---
>>>>   drivers/infiniband/core/security.c | 34 ++++--------------------------
>>>>   include/rdma/ib_mad.h              |  3 ---
>>>>   2 files changed, 4 insertions(+), 33 deletions(-)
>>> Perhaps predictably, I'm not very excited about this change.  Have you
>>> looked closer into the slowdown to see where the cycles are being
>>> spent?  I'm wondering if the issue is that a large number of notifiers
>>> are being registered with the same priority causing the while loop in
>>> notifier_chain_register() to take a significant amount of time.
>>
>> That's what's happening, each MAD agent is registering it's own notifier. The bug reporter was creating hundreds or thousands of  short lived MAD agents. With IRQs disabled too long it resulted in timeouts.
>>
>> When I initially added the notifier mechanism I thought it was you that said it wasn't really needed, since access wasn't generally revoked in these types of scenarios. Given that I didn't think this would be especially controversial. It was nice to have, unfortunately it causes problems even for users that don't enable SELinux.
> 
> Revoking permission is difficult, and in some cases likely impossible,
> but that doesn't mean we shouldn't try to make it possible when we
> can.  I'd like to see if we can sort this out before we give up and
> rip it out.
> 
Agree that it'd be nice to see it work, but since few (no other?) subsys registered
with selinux/security is doing this, can we 'release' the IB mad agents from this
'imprisonment' and figure out a general solution that resolves this issue, and
then it can be implemented not only for ib mad packet access, but for other
subsys using selinux/security, and wanting the same revocation support.

> We might be able to modify notifier_chain_register() such that if the
> notifier being registered has the same priority as the current node it
> is inserted before the current node.  It looks like all of the IB
> notifiers have the same priority so that should speed up registration
> significantly in this case, unfortunately that doesn't help
> unregistering.  I think we would need to move to convert
> notifier_block to use list_head if we want to handle removal in a
> timely manner.
> 
> However, there is also a concern that delivering notifications to
> hundreds of thousands of registered notifiers is going to be
> problematic.  None of the above is going to fix that.
> 
sooo....

> I'm trying to quickly understand the MAD agent lifecycle, and it looks
> like you have your own register/unregister routines, with locking, so
> is it reasonable to assume that it would be possible to iterate over
> the MAD agents in the IB code?  I wonder if it would be possible to
> group MAD agents (per-port grouping, does that make sense?) such that
> several agents would share a single LSM notifier registration?
> 
one can have numerous MAD agents.  it isn't just one.
Think: you can have any number of apps scanning the fabric for various stats
        to draw node/graph pics, gather per-port packet counts, gather bw numbers,
        etc.  For IB, scanning the fabric involves 'mad pkts'.
        In addition to scanning, one could do 'less then nice things' to switches,
        not just read stats but set parameters... like routing table entries.
        and thus, the security level addition.
       One is highly unlikely to grant access to an app to do mad pkt generation/use,
       then change your mind (semi-?)randomly to enable/disable it.... generally always enabled,
       or always disabled.

Let's take this case as a catalyst to resolve a previously unknown perf issue,
and not hold it up to a higher functional requirement then other apps that want to be secured.

thanks...

-dd

