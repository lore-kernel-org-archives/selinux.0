Message-Id: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Ivan Gyurdiev'" <gyurdiev@redhat.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 14:06:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118425292.3774.137.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, June 10, 2005 1:42 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; Ivan Gyurdiev; 'Daniel J Walsh'; 'SELinux'; selinux-
> dev@tresys.com
> Subject: RE: Restorecon script
> 
> On Fri, 2005-06-10 at 13:44 -0400, Karl MacMillan wrote:
> > It would probably still be better practice to execute the script in the
> user's
> > domain or a limited version of that domain from the trusted domain (e.g.
> rpm) -
> > if nothing else that means that the relabeling happens less often. Of
> course, if
> > the user's domain has this relabel privilege anyway, having the privileged
> > domain doing the relabeling, either directly or indirectly, doesn't really
> help
> > at all. The user can just install / write the script themselves. Removing
> the
> > relabeling privilege from the user is probably difficult and they can just
> copy
> > files into the appropriate directories and get the same result (assuming
> type
> > transition rules are in place).
> 
> These files are under the user's control anyway; the purpose of labeling
> them with their own type is to allow particular user apps to access them
> without allowing those apps to access all of the user's files.
> 

Or only giving the read access I assume. So we are not trying to protect from
malicious code running in the user's domain disclosing data by relabeling to
httpd_user_content_t, for example? If that is the case the user domain is
trusted to manage these files at their discretion. One point I was trying to
make is that this probably has to be the case as removing relabel permission
from the user domain has no impact.

Relabeling on every login still seems excessive and based on what this policy is
trying to accomplish perhaps not a good idea. If the files are under the user's
control then they should be fully under their control. What if I am waiting to
relabel my ~/public_html until I am done with the content and this administrator
controlled script does it for me?

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
