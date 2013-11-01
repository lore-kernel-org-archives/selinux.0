Message-ID: <5273CD37.6060602@tycho.nsa.gov>
Date: Fri, 01 Nov 2013 11:48:07 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, codonell@redhat.com
Subject: Re: Handling unknown permissions in userspace object managers
References: <1383319095.28218.37.camel@flatline.rdu.redhat.com>
In-Reply-To: <1383319095.28218.37.camel@flatline.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/2013 11:18 AM, Eric Paris wrote:
> glibc/nscd is acting as a userspace object manager.  Today what they are
> doing is:
> 
> static const access_vector_t perms[LASTREQ] =
> {
>   [GETPWBYNAME] = NSCD__GETPWD,
>   [GETPWBYUID] = NSCD__GETPWD,
> ...
>   [INNETGR] = NSCD__GETNETGRP,
>   [GETFDNETGR] = NSCD__SHMEMNETGRP,
> };
> ...
> rc = avc_has_perm (ssid, tsid, SECCLASS_NSCD, perms[req], &aeref, NULL) < 0;
> ...
> 
> They recently ran into problems where they defined NSCD__GETNETGRP in
> their application but the selinux policy was never updated to support
> the new permission.  They found that such checks were being denied.
> (which surprises me actually but I haven't dug into that and probably
> should)
> 
> I suggested glibc replace SECCLASS_NSCD with string_to_security_class()
> and to replace the hard coded perm values with string_to_av_perm().  It
> has a couple of obvious benefits.  one: they know if policy supports the
> class/perm in question.  two: if things change in policy glibc still
> works (we know that WE won't change the policy such that they would
> break, but that doesn't mean that someone couldn't/wouldn't)

Use selinux_set_mapping() if you want to create a mapping of your own
class/perm indices to the policy values without needing to keep them
identical.  See XSELinux for an example.

Use selinux_check_access() instead if you want to push all the handling
of the AVC, class/perm string mapping, etc to libselinux and not deal
with it inside your application.  That's by far the easiest interface.
It does however impose the overhead of looking up the SIDs, class, and
perm value on each check, but I doubt this path is performance-critical.
 It also handles security_deny_unknown() checking so handle_unknown is
dealt with properly.
> 
> Carlos and I had a question come out of this.  How do we recommend he
> handle the perms[] array?  Before the switch to string_to_av_perm() it
> was on a read only data page.  Now since it has to be updated at run
> time he has an array of strings on a read only data page but the AV
> values are on a rw page.  Do we have a suggestion how this could be
> improved?  Is it worth map-ing a page for this tiny array so it can be
> marked RO after it is filled in?
> 
> -Eric
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
