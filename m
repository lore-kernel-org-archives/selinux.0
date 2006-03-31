Subject: Re: The sort algorithm is broken by the second rule,
	We	need	a	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442D809D.8050105@tresys.com>
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>
	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>
	 <442D5A3F.9090409@cornell.edu>
	 <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>
	 <442D7CFC.8060704@cornell.edu>
	 <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil>
	 <442D809D.8050105@tresys.com>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 14:32:50 -0500
Message-Id: <1143833570.17469.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 14:18 -0500, Joshua Brindle wrote:
> I think libsemanage should just put the .local file out for libselinux 
> to read. There is no guarantee that none of the entries on .local won't 
> be preceded by something in the normal file context if it is merged in 
> libsemanage.

Last matching entry takes precedence, so as long as they are merged to
the end of file_contexts (as they presently are), the local entries will
always take precedence over any earlier matching entry.

>  This is the same thing we do for file_contexts.homedirs so 
> why not do it with .local? (Also, if we merge .local into the normal fc 
> file then the .local can't override .homedirs)

.homedirs is a bit different in that it is generated via genhomedircon
from a policy-provided template.  The last point is true - that does
yield a difference between ordering of entries added via semanage
fcontext -a vs. manually put into file_contexts.local.

However, changing libsemanage to install file_contexts.local instead of
merging it now is a behavioral change that could clobber an existing
file_contexts.local, so we'd have to be very careful about the "upgrade"
situation and we'd likely want to push that to FC5 ASAP so that users
there don't get used to being able to manually tinker with
file_contexts.local separately.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
