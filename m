Message-Id: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Mon, 3 Oct 2005 10:40:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128349326.26285.62.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Monday, October 03, 2005 10:22 AM
> To: Karl MacMillan
> Cc: 'Ivan Gyurdiev'; selinux@tycho.nsa.gov; 'Daniel J Walsh'; SELinux-
> dev@tresys.com
> Subject: RE: [RFC][PATCH] New interface for loading policy
> 
> On Mon, 2005-10-03 at 09:48 -0400, Karl MacMillan wrote:
> > Agreed. How can libselinux support module and non-module installs then,
> > though? Seems like it needs to determine whether it is handling the
> adding
> > of users, etc or it has been handled already. If you make it an option
> > passed in as an arg, libsemanage can just call it correctly (either
> directly
> > or through an option to load_policy).
> 
> I assumed that even with a non-module install, libsemanage (or policy
> server) would handle regeneration of the kernel binary policy file with
> all local settings (users, saved/persistent booleans) so that libselinux
> can just load that file unmodified except possibly for preserving the
> current boolean settings in the preservebools case.  So I didn't think
> we needed to retain the sepol_genusers/sepol_genbools support in the
> libselinux function at all once we have converted over to the new
> approach.
> 

I guess I meant backwards compatibility - are you suggesting to drop that?

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
