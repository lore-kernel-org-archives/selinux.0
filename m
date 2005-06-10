Message-Id: <200506101859.j5AIx45F001812@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Ivan Gyurdiev'" <gyurdiev@redhat.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 14:59:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118426683.3774.159.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, June 10, 2005 2:05 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; Ivan Gyurdiev; 'Daniel J Walsh'; 'SELinux'; selinux-
> dev@tresys.com
> Subject: RE: Restorecon script
> 
> IMHO, you shouldn't be putting it into ~/public_html until you are ready
> for it to be exported; that doesn't seem to be different from current
> usage.
> 

Weak example, I agree, but I think that the concept holds.

> A larger concern might be that you don't want the restorecon to clobber
> local customization, e.g. to distinguish read-only content under
> ~/public_html from content that can be modified by a user CGI.  I think
> that the customizable types support would actually prevent that, as
> restorecon won't touch those types by default.
> 
> One advantage of relabeling on login (similar to relabeling from
> rc.sysinit that is presently done for certain files) is that it helps
> counter type lossage that may occur over time due to direct user
> manipulation (e.g. moving aside your public_html and dropping in a new
> tree, but failing to restorecon it manually) or under targeted policy.
> Obviously it is better to proactively preserve the types in the first
> place, but we aren't there yet.
> 

I don't disagree, but having the problems magically fixed by logging in seems
strange and potentially confusing to users. This is all trying to make
everything transparent to the user. I hate to say it, but I think that it will
ultimately not be transparent and in that case maybe the best option is the
least number of implicit operations and user involvement.

Karl 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
