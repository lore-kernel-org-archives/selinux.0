Message-Id: <200510031348.j93DmWYs014504@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Mon, 3 Oct 2005 09:48:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 8:22 AM
> To: Ivan Gyurdiev
> Cc: selinux@tycho.nsa.gov; Daniel J Walsh; SELinux-dev@tresys.com
> Subject: Re: [RFC][PATCH] New interface for loading policy
> 
> On Thu, 2005-09-29 at 23:48 -0400, Ivan Gyurdiev wrote:
> > It doesn't belong in libselinux. I've had an implementation of this for
> > a long time, but I haven't submitted it, because we're changing the plan
> > (right). Boolean and user components will be handled by semanage, using
> > the dbase thing which I'm adding there. Genbools/genusers will be
> > deprecated. Semanage will compile a module, and put users/booleans into
> > that. Then it will re-link modules upon change, and load_policy will ...
> > load the policy.
> >
> > OTOH this may be a good way to get rid of this code from things like
> > init, which needs to happen anyway...
> 
> Yes, boolean and user components are expected to be handled by semanage
> in the future, regenerating the kernel binary policy file on each
> modification.  When that happens, selinux_mkload_policy() can drop out
> the calls to sepol_genusers and sepol_genbools, but will still
> encapsulate the logic for finding the right policy version, opening it
> and mmap'ing it, and loading it.  So this change will make it easier to
> make that transition - we won't need to re-patch sysvinit or
> load_policy, and will still encapsulate some higher level logic than the
> current security_load_policy().
> 

Agreed. How can libselinux support module and non-module installs then,
though? Seems like it needs to determine whether it is handling the adding
of users, etc or it has been handled already. If you make it an option
passed in as an arg, libsemanage can just call it correctly (either directly
or through an option to load_policy).

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
