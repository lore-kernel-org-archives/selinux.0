Message-ID: <46B2524B.9060409@redhat.com>
Date: Thu, 02 Aug 2007 17:53:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, Paul Moore <paul.moore@hp.com>,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, jmorris@namei.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
 classes and perms
References: <1185983352.3673.16.camel@localhost.localdomain> <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil> <1186075512.4405.34.camel@localhost.localdomain> <200708021443.26314.paul.moore@hp.com> <46B23421.1030101@manicmethod.com> <46B23DD6.4010207@tycho.nsa.gov>
In-Reply-To: <46B23DD6.4010207@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Joshua Brindle wrote:
>> Paul Moore wrote:
>>> On Thursday, August 2 2007 1:25:12 pm Eric Paris wrote:
>>>  
>>>> Maybe instead a versioning scheme?  Every security check comes with a
>>>> 'version.'  Every time we add/change a security check we add one to 
>>>> the
>>>> 'version' for that check.  If the policy handed to the kernel has a
>>>> 'version' less than the value we get from the security hook call coded
>>>> in kernel we can just allow it?   Maybe that could be a solution to 
>>>> the
>>>> issue I am addressing now along with things like this netlabel change?
>>>> It certainly would have to touch a whole lot of stuff and might be a
>>>> pain to keep up with.  Lets say I move a security hook around in a
>>>> function, I need to decide if the version need to be bumped on that 
>>>> hook
>>>> or not.  Not impossible, but not pretty.  Also probably means a policy
>>>> version update, which in turn breaks the discussion which we have
>>>> ongoing above....
>>>>     
>>> While I'm not an expert on the policy aspects of this discussion and 
>>> how the kernel and userspace objects managers interact I think at 
>>> some point we are going to need something like what Eric proposes 
>>> above.  With the requirement that new kernels must not regress when 
>>> using old policy we are going to run into issues as we move forward 
>>> and add new permission checks.  While I don't think we've seen it 
>>> yet, it is reasonable to think that this problem will expand into 
>>> userspace as we develop more and more userspace object managers such 
>>> a X, CUPS, Postgres, etc.
>>>
>>> I know the changes aren't likely to be pretty, I'm kinda cringing at 
>>> the thought actually, but I think it's a necessary evil for the long 
>>> term survivability of SELinux.  At least that's what I took away 
>>> from Eric and Stephen's comments on this thread and I tend to agree.
>>>   
>>
>> I'd have to give a pretty hard NAK (for what it would be worth) to 
>> the versioning system, it simply doesn't scale; in the past we've 
>> used policy versions to decide how some permission checks work (see 
>> fine grained netlink discussions) and it was fairly non-ideal. I have 
>> to go back to the 'the object manager should decide how to deal with 
>> unknown permissions' argument. The object manager knows how its 
>> objects are used, and how the security system affects those objects, 
>> it is in the best position to make those decisions, the security 
>> server can only make a rough estimation on what the object manager 
>> and user want to do, which may or may not be accurate.
>
> I would suggest exporting the allow/deny bit to userspace in the same 
> manner as the enforcing mode.  The userspace AVC could then honor the 
> behavior unless the object manager overrides it (I've been meaning to 
> allow the object manager to override the enforcing mode so you could 
> for example have a permissive X server on an otherwise enforcing system).
If we could get this per domain, this would be a huge step forward.  
Customers looking to ship policy worry about putting out a policy that 
could break apps, before it got enough testing.  They want to put out 
apolicy for an application and run it for a few weeks on many different 
realworld environments and gather the avc's to make the poicy foolproof.
>
> The selinux_set_mapping() call could be modified to return details on 
> which specific classes and permissions were unknown.  Perhaps this 
> could be done through a callback which would also be called on policy 
> reload, given that class/perm values could appear or disappear at 
> these times.
>
>>
>> Here is an example, granted kernexec uses the reboot capability but 
>> suppose we wanted to make it a separate permission, I'm fairly 
>> certain that we'd want to always deny it if the policy didn't know 
>> about it, whereas SE-X is completely unusable without policy and 
>> still has OS level policy determining who can talk to the X daemon 
>> itself, SE-X would have to make a determination of whether to run at 
>> all or run with course grained permissions, chances are most people 
>> would want the latter. This means we'd actually have environments 
>> where some object managers deny by default and others allow (or even 
>> short circuit access attempts altogether). This is ideal from a 
>> scalability and dynamic system perspective and seems by far to be the 
>> best solution.
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
