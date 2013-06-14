Message-ID: <51BB7C50.6000601@tycho.nsa.gov>
Date: Fri, 14 Jun 2013 16:25:52 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <brindle@quarksecurity.com>
CC: Paul Moore <pmoore@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Deprecating policy capabilities
References: <5219244.VNyImXJjQb@sifl> <CADjGSjj7c9w9bPqunJjdBUohgwd8qJfvL=iovrZNHZ1Kwom+Nw@mail.gmail.com> <51BB7A6C.3010307@tycho.nsa.gov> <CADjGSjjz0TX_H7LyLmR1WS_2kpVP8Xau3eRZkAkO4h0yna5Y=Q@mail.gmail.com>
In-Reply-To: <CADjGSjjz0TX_H7LyLmR1WS_2kpVP8Xau3eRZkAkO4h0yna5Y=Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/14/2013 04:20 PM, Joshua Brindle wrote:
> On Fri, Jun 14, 2013 at 4:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 06/14/2013 04:03 PM, Joshua Brindle wrote:
>>>
>>> On Fri, Jun 14, 2013 at 3:46 PM, Paul Moore <pmoore@redhat.com> wrote:
>>>> I just took a closer look at this and as much as I would like to require
>>>> policies to enable the netpeer capability so we could remove a bunch of
>>>> old
>>>> code, I don't think we can do this anytime soon.
>>>>
>>>> The problem is that the kernel still supports old policy versions, back
>>>> to
>>>> v15, and the policy capability support wasn't added until policy v22.
>>>> For
>>>> obvious reasons, we can't really deprecate a policy capability (at least
>>>> not
>>>> the netpeer capability) until our minimum supported policy version is v22
>>>> or
>>>> higher.  I'm not sure that is something we can really do at this point -
>>>> thoughts?
>>>>
>>>
>>> I doubt that anyone has tested a < v22 policy on a modern system in
>>> quite some time... I would wonder if it still works correctly. If it
>>> hasn't been it seems like a good idea to deprecate unused, untested
>>> configurations for stability and security. There isn't much of a
>>> reason to use old policies on new kernels since 1) pre-existing binary
>>> policies are unlikely to work on new distros and 2) the toolchain can
>>> build new policies from old source.
>>
>>
>> I thought the requirement was that new kernels cannot break old userspace
>> (including policies), i.e. we have to be able to boot latest kernel with
>> ancient Fedora or RHEL and not have anything break.  RHEL4 used policy.18
>> IIRC.  At the moment booting a new kernel with an old distro usually works
>> due to a combination of handle_unknown=allow and policy capabilities not
>> being enabled in the old policy.
>>
>
> Oh right, I forgot that there are people that boot new kernels on
> ancient distros. How far back does the backward support have to go?

I think the view of the kernel developers was forever; new kernel is 
never supposed to break old userspace.  Of course there have been a few 
examples of that being broken by others in other subsystems, but that is 
frowned upon.

Even if we were to limit it to currently-supported enterprise 
distributions, I think we'd have to wait until RHEL-5 (policy.20?) is 
EOL'd.  Don't know about Debian or Ubuntu LTS.   Might as well be 
forever as we likely won't remember this conversation then.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
