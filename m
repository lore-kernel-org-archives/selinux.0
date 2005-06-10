Message-Id: <200506101744.j5AHi55F008714@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: "'Ivan Gyurdiev'" <gyurdiev@redhat.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 13:44:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118419871.3774.128.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Friday, June 10, 2005 12:11 PM
> To: Joshua Brindle
> Cc: Ivan Gyurdiev; Daniel J Walsh; SELinux; selinux-dev@tresys.com
> Subject: Re: Restorecon script
> 
> On Fri, 2005-06-10 at 12:05 -0400, Joshua Brindle wrote:
> > scripts that install stuff to skel maybe should be responsible for
> > adding them to user dirs and labeling properly. This would be a trusted
> > app (rpm or whatever) instead of a user shell script
> 
> You have to be careful in that case, as that trusted app becomes an
> obvious target for attack and it is acting on paths into user-writable
> directories.  One benefit of running it in the user's context (via the
> shell script or when the app is first run by the user and initially
> creates these files) is that the relabeling can be confined to the
> user's types and there is no risk of misuse of privilege.
> 

It would probably still be better practice to execute the script in the user's
domain or a limited version of that domain from the trusted domain (e.g. rpm) -
if nothing else that means that the relabeling happens less often. Of course, if
the user's domain has this relabel privilege anyway, having the privileged
domain doing the relabeling, either directly or indirectly, doesn't really help
at all. The user can just install / write the script themselves. Removing the
relabeling privilege from the user is probably difficult and they can just copy
files into the appropriate directories and get the same result (assuming type
transition rules are in place).

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
