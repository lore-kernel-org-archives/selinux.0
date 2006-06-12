Message-ID: <448D7AD0.4010607@hp.com>
Date: Mon, 12 Jun 2006 10:31:44 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: Proposal for increasing the granularity of "setopt"
References: <44887DF6.8010000@hp.com> <1150121349.8086.41.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1150121349.8086.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-06-08 at 15:43 -0400, Paul Moore wrote:
> 
>>Before I go ahead and write any code I was wondering if there would be
>>any objections to increasing the granularity of the "setopt" permission
>>for sockets.  Right now it is not possible to differentiate between a
>>domain wanting to adjust the TCP socket options and a domain wanting to
>>adjust the IP socket options.  Probably not a big deal but this is a bit
>>of a concern for the CIPSO/NetLabel code as it relies heavily on socket
>>options.
>>
>>I would like to propose introducing a new permission "setopt_ip" which
>>would allow domains to set IP level socket options.  This could also be
>>extended with "setopt_ipv6", "setopt_tcp", "setopt_udp", etc.  All calls
>>to setsockopt() with levels not protected by unique permissions would be
>>protected by the existing "setopt" permission.  Does that sound reasonable?
> 
> Is that sufficiently granular for your purpose with CIPSO/NetLabel?
> Don't you want a specific check for that specific option?
> 

In a perfect world (or at least the one in my head) you would be able to
restrict individual options, but I figured that might be too large of a
request considering the existing granularity.  Regardless, you are
right, all I really need to restrict is the SOL_IP/IP_OPTION
setsockopt() call.  Restricting all of SOL_IP is a bit heavy handed, but
it would work and it is still better than what we have now.

> Adding permissions to a class is delicate, because the definitions are
> generated to headers upon updates and compiled into the SELinux module's
> enforcement code rather than being dynamically looked up from string
> symbol during initialization from the policy, so disturbing the existing
> mappings is unsafe (changing that might be an interesting experiment
> itself).  Hence, you can only append to the existing set of permissions,
> and since the class-specific permissions begin immediately after the
> inherited common definition, you can't add to a common definition at all
> without disturbing the values of the class-specific permissions.
> Further, each access vector is limited to 32 permissions total, and the
> socket classes are rather tight already.  So you may want to consider
> introducing a new class for this purpose rather than putting it into the
> existing socket classes.

Sigh.  Okay, thanks for the lesson.  If I add a new class for this would
it be acceptable to have to permission checks for setsockopt()?  I ask
because I assume I would need to leave the existing check in place and
add the new check to be evaluated if the existing check passed, yes?

> You also have to contend with compatibility concerns when introducing
> new checks.

Ah yes, "compatibility", the really long four letter word ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
