Message-ID: <5273E2DB.20605@tycho.nsa.gov>
Date: Fri, 01 Nov 2013 13:20:27 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Carlos O'Donell" <carlos@redhat.com>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, codonell@redhat.com
Subject: Re: Handling unknown permissions in userspace object managers
References: <1383319095.28218.37.camel@flatline.rdu.redhat.com>  <5273CD37.6060602@tycho.nsa.gov> <1383321297.28218.40.camel@flatline.rdu.redhat.com> <5273D003.70601@tycho.nsa.gov> <5273DE3D.4070402@redhat.com> <5273DEB3.5050808@tycho.nsa.gov> <5273E261.3050100@redhat.com>
In-Reply-To: <5273E261.3050100@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/2013 01:18 PM, Carlos O'Donell wrote:
> On 11/01/2013 01:02 PM, Stephen Smalley wrote:
>> On 11/01/2013 01:00 PM, Carlos O'Donell wrote:
>>> On 11/01/2013 12:00 PM, Stephen Smalley wrote:
>>>> But selinux_check_access() is IMHO a better way to go for any new code
>>>> unless it is so performance-critical that the context, class, and perm
>>>> lookups per check are prohibitive.
>>>
>>> The code in question is from glibc's nscd and used when determining if
>>> the user should or should not have access to specific cache results, and
>>> therefore it is performance sensitive. The faster we can determine if
>>> access is allowed the faster we can return a result to a client that
>>> needs an answer about a particular credential. I'm happing doing the
>>> translations at startup when the daemon is initializing, but I'm not
>>> happy to do them at every request arriving to the daemon. Unless someone
>>> says this needs to be fully dynamic I'd like to avoid any costs during
>>> the request handling phase.
>>
>> I doubt the overhead of the SID/class/perm lookup compares to the IPC
>> overhead, but I can't say that I've measured it.  But feel free to use
>> whichever interface you prefer.
> 
> I already have to pay the IPC overhead, and I try to cut costs where
> possible. However, you are correct in that we should remeasure the
> performance to see if this actually makes any difference. If it makes
> no difference then there isn't any point to all the custom code in glibc
> and we should just call selinux_check_access.
> 
> The only real point would be that nscd has custom failure logging right 
> now by basically reimplementing a selinux_check_access, but that's a 
> very very weak reason since SELinux's own logging is far superior.
> 
> In that case the question of RW pages with permission values goes away
> because we do the translation each time we make a permission check using
> the constant strings in rodata for `nscd' and the various perms.
> 
> Does that make sense?

Yes, the RW page issue goes away whichever interface you use - if you
use selinux_set_mapping(), then you get to use constant values for your
own permission definitions and libselinux will internally map your
values to the policy values at runtime, while if you use
selinux_check_access(), then libselinux will internally look up the
strings at runtime.  Either way avoids the problem of the RW page.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
