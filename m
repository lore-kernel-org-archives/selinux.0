Message-ID: <51BB7A6C.3010307@tycho.nsa.gov>
Date: Fri, 14 Jun 2013 16:17:48 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <brindle@quarksecurity.com>
CC: Paul Moore <pmoore@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Deprecating policy capabilities (was: Clarification of labeled
 IPsec checks)
References: <5219244.VNyImXJjQb@sifl> <CADjGSjj7c9w9bPqunJjdBUohgwd8qJfvL=iovrZNHZ1Kwom+Nw@mail.gmail.com>
In-Reply-To: <CADjGSjj7c9w9bPqunJjdBUohgwd8qJfvL=iovrZNHZ1Kwom+Nw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/14/2013 04:03 PM, Joshua Brindle wrote:
> On Fri, Jun 14, 2013 at 3:46 PM, Paul Moore <pmoore@redhat.com> wrote:
>> On Tuesday, May 07, 2013 09:05:30 AM Paul Moore wrote:
>>> On Monday, May 06, 2013 09:50:04 AM Christopher J. PeBenito wrote:
>>>> On 05/03/13 15:20, Paul Moore wrote:
>>>>> It has been a while since we introduced the netpeer policy capability so
>>>>> I imagine we could start a process of deprecating policies that don't
>>>>> enable it. We could dump a warning message if someone loads a policy
>>>>> with the netpeer capability disabled and then after a few releases (how
>>>>> many?) we could remove the legacy bits from the kernel and reject
>>>>> policies which don't have the netpeer capability set.
>>>>
>>>> The common case obviously is no labeling, and in that case, there wouldn't
>>>> be checks.  So I suspect this wouldn't have any real problems.  My guess
>>>> is systems that use this wouldn't be changing their OS very often, and
>>>> when they do, it would be major jumps (e.g. RHEL6 to RHEL7), so they'd be
>>>> anticipating changes like this.
>>>
>>> Yeah, I agree.  I'll throw together a deprecation patch and toss it out so
>>> we can have a bit more of a discussion on this.
>>
>> I just took a closer look at this and as much as I would like to require
>> policies to enable the netpeer capability so we could remove a bunch of old
>> code, I don't think we can do this anytime soon.
>>
>> The problem is that the kernel still supports old policy versions, back to
>> v15, and the policy capability support wasn't added until policy v22.  For
>> obvious reasons, we can't really deprecate a policy capability (at least not
>> the netpeer capability) until our minimum supported policy version is v22 or
>> higher.  I'm not sure that is something we can really do at this point -
>> thoughts?
>>
>
> I doubt that anyone has tested a < v22 policy on a modern system in
> quite some time... I would wonder if it still works correctly. If it
> hasn't been it seems like a good idea to deprecate unused, untested
> configurations for stability and security. There isn't much of a
> reason to use old policies on new kernels since 1) pre-existing binary
> policies are unlikely to work on new distros and 2) the toolchain can
> build new policies from old source.

I thought the requirement was that new kernels cannot break old 
userspace (including policies), i.e. we have to be able to boot latest 
kernel with ancient Fedora or RHEL and not have anything break.  RHEL4 
used policy.18 IIRC.  At the moment booting a new kernel with an old 
distro usually works due to a combination of handle_unknown=allow and 
policy capabilities not being enabled in the old policy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
