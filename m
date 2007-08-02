Message-ID: <46B1F5D1.3020804@manicmethod.com>
Date: Thu, 02 Aug 2007 11:18:41 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
 classes and perms
References: <1185983352.3673.16.camel@localhost.localdomain> <1186065564.2434.12.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1186065564.2434.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-08-01 at 11:49 -0400, Eric Paris wrote:
>   
>> Allow policy to select, in much the same way as it selects MLS support,
>> how the kernel should handle access decisions which contain either
>> unknown classes or unknown permissions in unknown classes.  The three
>> choices are (from a kernel perspective)
>>
>> 0 - Deny unknown security access. (default)
>> 2 - reject loading policy if it does not contain all definitions
>> 4 - allow unknown security access
>>     
>
> If we leave the default as the current behavior (i.e. deny access if
> checking an unknown class or permission), then what exactly have we
> achieved with this patch?  The next time we introduce a new permission
> check in the kernel, anyone who installs that kernel on an existing
> distribution release will still encounter breakage.  It will only start
> providing benefit for newer distribution releases with policies built to
> have the non-default setting.
>
>   
I don't think we should change the default behavior of the policy, this 
could have some very unintended consequences to people building policies 
for security oriented systems that may not be aware of the build 
infrastructure changes necessary to keep the old behavior.

> Other points to ponder:
> - Would this have helped with the recent netlabel breakage?  I don't
> think so, as that was introducing a further check for an existing
> class/perm in the unlabeled case, not a new class/perm.
> - Does this help with letting us fix the ioctl hook?  Problem there is
> again that we are more likely to start mapping ioctls to read/write or
> getattr/setattr instead of the generic "ioctl" fallback rather than
> introducing new perms.
>   
How many policies give ioctl without giving read/write or 
getattr/setattr? Is this really an issue?

> - We still can't easily add new perms to common definitions (displaces
> class-specific ones).
>   
I'm not sure we are going to be able to handle this one until we extend 
object class/perm discovery to the kernel object managers, its a 
completely different problem from what this is attempting to solve.

> - Does this help us with secmark at all, e.g. can we eliminate
> compat_net?  Do we want to eliminate compat_net yet?  Fedora still seems
> to have compat_net=1.
> - We still can't purge obsolete classes/perms or reorganize the existing
> ones safely with this change.
>   
Ditto.

> So...is it worth it by itself?
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
