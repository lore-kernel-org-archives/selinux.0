Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0RMlAOR003292
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 17:47:10 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0RMl3uq011889
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 22:47:03 GMT
Message-Id: <201001272247.o0RMl6hD014615@vivaldi26.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Subject: Allowing MLS->non-MLS and vice versa upon policy reload (Was: Re: Building MLS/MCS policy)
Date: Wed, 27 Jan 2010 23:47:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen !

On Tue, 2010-01-26 at 12:52 -0500, Stephen Smalley wrote:
>> Alternatively to spending time on documenting the current limitation, it
>> might be more interesting to try removing the restriction from the
>> SELinux kernel code and investigating what needs to be done within the
>> kernel to enable it to be done safely.  Primarily this would mean:
>> - pushing the selinux_mls_enabled flag inside the policydb so that it
>> could be per-policydb (this is already the case in libsepol),
>> - in the non-MLS to MLS case, ensuring that the MLS fields of the
>> context for all existing entries in the sidtab are filled in with a
>> suitable default value, likely taken from one of the initial SIDs,
>> - in the MLS to non-MLS case, freeing any storage used by the MLS fields
>> in the context for all existing entries in the sidtab.

> FYI, both of the latter two items would be handled inside
> of ss/services.c:convert_context().

First of all, I am sorry for the late reply.

The idea seems very attractive: allowing the transition between MLS/MCS and non-MLS/non-MCS policies (and viceversa) at the kernel level can be considered a new feature and it is certainly better than writing piece of documentation about current limitation of the code.

I am not very familiar with the kernel code, but before discussing it further, I have noticed that the code at lines 1740-1744 of policydb.c (in the latest released kernel, within policydb_read()) never gets executed, even though the switch from MLS/MCS to standard policy does not take place. It's a minor issue, but it's probably worth of consideration because there must be some wrong assumption in the if statements there. Similarly I don't understand why at line 1730 selinux_mls_enabled is set to 1, even though we don't have a MLS/MCS policy loaded and we are not switching to a MLS/MCS policy either...

And at the moment I am also not able to get lines 1725-1729 executed, by trying to switch from a non-MLS/MCS policy to a MLS/MCS policy.

To do the switch I am just using "make load" in the two respective policies that I have compiled (and installed in different stores) beforehand. I believe "make load" just executes semodule (without "-n").

What do you say ? I must admit, when a few days ago I was trying to install the MCS policy with the same name of the currently loaded standard policy, lines 1725-1729 were getting executed and I use to get the error message from the kernel...

Have you had any other idea about a possible implementation of this new feature ? I will try to look at the kernel code more closely...

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
