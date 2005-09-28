Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43398EB2.1050100@redhat.com>
References: <43398EB2.1050100@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 12:39:52 -0400
Message-Id: <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 14:25 -0400, Daniel J Walsh wrote:
> Currently applied to libsetrans, since we have come to no conclusion on 
> where this should go.

I still view that as a mistake; libsetrans is about translating between
kernel security contexts and human-readable security labels,
particularly for MCS/MLS where we expect them to differ, is completely
unnecessary in the non-MCS/MLS case, and is brought in by all libselinux
users when context translations are enabled.  Mapping Linux users to
SELinux users (and, in the MCS/MLS case, a MLS range) is something we
want regardless of whether context translations are performed, and needs
to be done by login-type apps only.

> Currently takes a file of the format
> cat /etc/selinux/seusers.conf
> dwalsh:staff_u:s0-s0:c1,c5
> pwalsh:user_u::   #This is an error
> rwalsh:user_u:s4
> root:staff_u:s0-s0-s0:c0,c127

Isn't this an error too?

> default:user_u:s0
> 
> Currently I placed the flat file in /etc/selinux/ directory, but might 
> be better off in the policy directory, since s4 or staff_u might not be 
> defined for MCS policy.

Right, it contains policy-specific data.  On the other hand, we expect
to offload it to an LDAP directory, so it will ultimately live entirely
outside of the policy-specific directory.

> Eventually this function will call out to LDAP also, so not a good 
> candidate for libselinux, unless we want the ls command linking against 
> LDAP.

Putting it into libsetrans yields the same effect, because ls depends on
libselinux which dlopen's libsetrans whenever it exists, right?  The
best option would be to create yet another library for it.  However, if
that is strongly disliked, I'd say just put it directly into libselinux.
libselinux can certainly defer dlopen/dlsym of ldap or any other backend
library until it actually needs the backend, so that we don't pick them
up for ls.

> I want to add this function to login programs (Pam, gdm) in order to 
> limit MCS users.

More generally, to let us authorize Linux users for SELinux role sets
(via the indirection of SELinux users) and (in the MCS/MLS case)
particular ranges without needing to add them individually to the
policy.

> Need to figure out what to do if no entries are returned.  (I guess 
> allow policy to decide.)  Maybe we should eliminate default entry?

The issue there is that if your config provides no default user and
range, and you pass the Linux username along to libselinux, it will try
that user but then fallback internally to user_u and whatever the kernel
provides for a range.  And user_u will likely be authorized for the full
range in the kernel policy since you are now using this new
configuration to restrict what categories are accessible to individual
Linux users.

> Function returns structure containing
> 
> username
> seusername
> sensitivity (Could be a range)
> Categories.(Can be null).
> 
> When you call selinux functions you will need to create a level by 
> appending Sensitivity + ":" + Categories

No, you just want to take the Linux username as the input parameter, and
return the SELinux username and the entire range string as a whole, then
pass that to libselinux.  The low level can have a category set too,
e.g. s0:c1-s0:c1,c2.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
