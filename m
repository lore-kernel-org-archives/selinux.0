Message-ID: <5273D003.70601@tycho.nsa.gov>
Date: Fri, 01 Nov 2013 12:00:03 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, codonell@redhat.com
Subject: Re: Handling unknown permissions in userspace object managers
References: <1383319095.28218.37.camel@flatline.rdu.redhat.com>  <5273CD37.6060602@tycho.nsa.gov> <1383321297.28218.40.camel@flatline.rdu.redhat.com>
In-Reply-To: <1383321297.28218.40.camel@flatline.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/2013 11:54 AM, Eric Paris wrote:
> On Fri, 2013-11-01 at 11:48 -0400, Stephen Smalley wrote:
>> On 11/01/2013 11:18 AM, Eric Paris wrote:
>>> glibc/nscd is acting as a userspace object manager.  Today what they are
>>> doing is:
>>>
>>> static const access_vector_t perms[LASTREQ] =
>>> {
>>>   [GETPWBYNAME] = NSCD__GETPWD,
>>>   [GETPWBYUID] = NSCD__GETPWD,
>>> ...
>>>   [INNETGR] = NSCD__GETNETGRP,
>>>   [GETFDNETGR] = NSCD__SHMEMNETGRP,
>>> };
>>> ...
>>> rc = avc_has_perm (ssid, tsid, SECCLASS_NSCD, perms[req], &aeref, NULL) < 0;
>>> ...
>>>
>>> They recently ran into problems where they defined NSCD__GETNETGRP in
>>> their application but the selinux policy was never updated to support
>>> the new permission.  They found that such checks were being denied.
>>> (which surprises me actually but I haven't dug into that and probably
>>> should)
>>>
>>> I suggested glibc replace SECCLASS_NSCD with string_to_security_class()
>>> and to replace the hard coded perm values with string_to_av_perm().  It
>>> has a couple of obvious benefits.  one: they know if policy supports the
>>> class/perm in question.  two: if things change in policy glibc still
>>> works (we know that WE won't change the policy such that they would
>>> break, but that doesn't mean that someone couldn't/wouldn't)
>>
>> Use selinux_set_mapping() if you want to create a mapping of your own
>> class/perm indices to the policy values without needing to keep them
>> identical.  See XSELinux for an example.
> 
> I completely forget about that interface.  It does simplify things a
> bit, but it seems to make things worse as well.  When dealing with
> unknown perms selinux_set_mapping() is going to return EINVAL and the
> userspace object manager will be just screwed...
> 
> Any thoughts how we could better that interface for the case where
> security_deny_unknown() == 0? 

Just do what I did in the kernel code (security/selinux/ss/services.c,
changes to selinux_set_mapping, map_decision based on handle_unknown).

But selinux_check_access() is IMHO a better way to go for any new code
unless it is so performance-critical that the context, class, and perm
lookups per check are prohibitive.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
