Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2EFC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46110218AC
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 14:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfBAOVK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:21:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAOVJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Feb 2019 09:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18965C8DB6;
        Fri,  1 Feb 2019 14:21:09 +0000 (UTC)
Received: from [10.3.117.194] (ovpn-117-194.phx2.redhat.com [10.3.117.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A95A01057068;
        Fri,  1 Feb 2019 14:21:07 +0000 (UTC)
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
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <0ef02f27-0e16-bcf0-3c30-7c7939cc9731@redhat.com>
Date:   Fri, 1 Feb 2019 09:21:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 01 Feb 2019 14:21:09 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 01/29/2019 12:30 PM, Paul Moore wrote:
> On Mon, Jan 28, 2019 at 9:57 PM Don Dutile <ddutile@redhat.com> wrote:
>> On 01/28/2019 06:03 PM, Paul Moore wrote:
>>> On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.com> wrote:
>>>> On 1/28/2019 10:37 AM, Paul Moore wrote:
>>>>> On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> wrote:
>>>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>>>
>>>>>> ---
>>>>>>    drivers/infiniband/core/security.c | 34 ++++--------------------------
>>>>>>    include/rdma/ib_mad.h              |  3 ---
>>>>>>    2 files changed, 4 insertions(+), 33 deletions(-)
>>>>> Perhaps predictably, I'm not very excited about this change.  Have you
>>>>> looked closer into the slowdown to see where the cycles are being
>>>>> spent?  I'm wondering if the issue is that a large number of notifiers
>>>>> are being registered with the same priority causing the while loop in
>>>>> notifier_chain_register() to take a significant amount of time.
>>>>
>>>> That's what's happening, each MAD agent is registering it's own notifier. The bug reporter was creating hundreds or thousands of  short lived MAD agents. With IRQs disabled too long it resulted in timeouts.
>>>>
>>>> When I initially added the notifier mechanism I thought it was you that said it wasn't really needed, since access wasn't generally revoked in these types of scenarios. Given that I didn't think this would be especially controversial. It was nice to have, unfortunately it causes problems even for users that don't enable SELinux.
>>>
>>> Revoking permission is difficult, and in some cases likely impossible,
>>> but that doesn't mean we shouldn't try to make it possible when we
>>> can.  I'd like to see if we can sort this out before we give up and
>>> rip it out.
>>
>> Agree that it'd be nice to see it work, but since few (no other?) subsys registered
>> with selinux/security is doing this, can we 'release' the IB mad agents from this
>> 'imprisonment' and figure out a general solution that resolves this issue, and
>> then it can be implemented not only for ib mad packet access, but for other
>> subsys using selinux/security, and wanting the same revocation support.
> 
> If you scroll up, ever so slightly to my last reply (it's just a few
> lines, I'll wait), you'll see where I said "I'd like to see if we can
> sort this out before we give up and rip it out."
> 
> I don't recall at the moment why the notifier approach was taken with
> the IB hooks back when Daniel wrote the code, and I'm definitely not
> sure what other subsystems you are using for your comparisons here,
> but I can tell you that I am beyond sick and tired of hearing people
> immediately jump to "rip out this security code" because of some
> performance glitch.  I care about performance too, okay?  We've got a
I didn't advocate for ripping out the security code; I advocated to eliminating
the notifier callback, not setup by many other subsystem selinux consumers,
so the notifier performance issue could be resolved.
I see this as a notifier perf issue, not a security issue.

> bunch of clever people here, let's spend some time and see if we can
> improve what we've got before we make some knee jerk reaction and just
> rip out the access controls.
> 
It's not knee jerk.  I spent hours hacking away at the RHEL implementation
to skip notification registration if selinux is disabled... the short-term 'hack'
for the impacted user(s), since the users weren't enabling selinux. :(
*but*, I'm looking for a long-term, selinux-enabled solution.

>>> I'm trying to quickly understand the MAD agent lifecycle, and it looks
>>> like you have your own register/unregister routines, with locking, so
>>> is it reasonable to assume that it would be possible to iterate over
>>> the MAD agents in the IB code?  I wonder if it would be possible to
>>> group MAD agents (per-port grouping, does that make sense?) such that
>>> several agents would share a single LSM notifier registration?
>>>
>> one can have numerous MAD agents.  it isn't just one.
> 
> Clearly.  Daniel already mentioned hundreds of thousands of MAD agents.
> 
>> Think: you can have any number of apps scanning the fabric for various stats
>>          to draw node/graph pics, gather per-port packet counts, gather bw numbers,
>>          etc.  For IB, scanning the fabric involves 'mad pkts'.
>>          In addition to scanning, one could do 'less then nice things' to switches,
>>          not just read stats but set parameters... like routing table entries.
>>          and thus, the security level addition.
>>         One is highly unlikely to grant access to an app to do mad pkt generation/use,
>>         then change your mind (semi-?)randomly to enable/disable it.... generally always enabled,
>>         or always disabled.
>>
>> Let's take this case as a catalyst to resolve a previously unknown perf issue,
>> and not hold it up to a higher functional requirement then other apps that want to be secured.
> 
> See my comment above.  I don't even know what you are talking about
> regarding "higher functional arguments", what other subsystems?
> Seriously Don, language like this causes an extreme allergic reaction.
> 
You have to read more carefully.  As I stated above, I'm looking to remove
a unique method in the ib-selinux setup, not remove selinux support entirely.
I wasn't advocating for a full-revert.

> Anyway, let's move on to something a bit more constructive, shall we?
> 
Agree.
Looking fwd to Daniel's patches of his proposed work-around... which is
effectively to reduce the notifier use.

>  From what I've gathered from this thread the issue stems from the
> ib_mad_agent_security_setup() where we register the
> ib_mad_agent_security_change() callback with the LSM notification
> mechanism.  Looking at the ib_mad_agent_security_change() function,
> all it seems to do is perform a LSM permission check
> (security_ib_endport_manage_subnet()) and store the result in
> ib_mad_agent->smp_allowed; quickly grep'ing through the code, the only
> place where I see that value used is in ib_mad_enforce_security().
> 
> Looking at ib_mad_enforce_security(), it seems to have access to the
> necessary MAD agent information, via ib_mad_agent_private->agent, to
> perform the LSM permission check directly in this function.  Could we
> not get rid of the MAD agent LSM notification callback and simply do
> the LSM access check directly in ib_mad_enforce_security()?  What am I
> missing?
> 
> I do see that the SELinux implementation of the
> security_ib_endport_manage_subnet() LSM hook doesn't seem to cache the
> IB endport labels.  If that proves to be a performance issue we can
> create a cache for that (like we do for the pkeys and a few other
> objects).
> 
> I barely understand IB, so it is very possible there is a fundamental
> flaw in the logic above, but let's try to work together and figure
> something out.  The above may not be it, but I'm not ready to throw in
> the towel.
> 
Thanks for your time & review.
--dd

