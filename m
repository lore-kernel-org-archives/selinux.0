From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Joy Latten'" <latten@austin.ibm.com>, <selinux@tycho.nsa.gov>,
   <dvelarde@us.ibm.com>, <selinux-dev@tresys.com>
Subject: RE: writing refpolicy modules...
Date: Mon, 6 Feb 2006 16:35:16 -0500
Message-ID: <099701c62b65$395a0550$6c0d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <43E7A17C.4050708@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Monday, February 06, 2006 2:20 PM
> To: Stephen Smalley
> Cc: Joy Latten; selinux@tycho.nsa.gov; dvelarde@us.ibm.com; selinux-
> dev@tresys.com
> Subject: Re: writing refpolicy modules...
> 
> Stephen Smalley wrote:
> > On Mon, 2006-02-06 at 13:49 -0500, Stephen Smalley wrote:
> >
> >> On Mon, 2006-02-06 at 12:09 -0600, Joy Latten wrote:
> >>
> >>> We (Deb and I) have a few questions in regards to creating new modules
> >>> within refpolicy architecture. We have installed FC5-Test2 and we
> >>> are converting old policy to the new refpolicy format.
> >>>
> >>> Is it ok to use the selinux-policy source rpm from rawhide as
> >>> a source tree to build a refpolicy module? I understand that the
> >>> necessary headers to build independent of source are not yet
> available.
> >>>
> >> Looks like there is a selinux-policy-devel in rawhide.  Installs
> >> under /usr/share/selinux/refpolicy.  So it might be worth updating to
> >> the rawhide selinux-policy and installing selinux-policy-devel to try
> it
> >> out.
> >>
> >
> > Looks like there is a simple policygentool script
> > under /usr/share/selinux/refpolicy that can be used to generate a
> > stub .te, .fc, and .if file for a new module/domain (although I assume
> > that it is a mistake that the module name is left as TEMPLATE in the
> > generated file), and then you can run make on the Makefile in that
> > directory to generate a policy module package.  At which point you can
> > insert it via semodule -i.
> >
> >
> http://fedoraproject.org/wiki/SELinux/FAQ/ProposedAdditions
> 
> Has a description of how to use selinux-policy-devel  The TEMPLATE
> should be TEMPLATETYPE,
> which will be in RawHide tonight.
> 
> Now I would like to write a audit2allow extension to look for matches in
> /usr/share/selinux/refpolicy and use these macros rather then straight
> audit rules.
> 

We are working on this (sort of like audit2interface) for setools. It turns
out to be a _very_ hard problem if you want to propose a minimal set of
interfaces to cover a set of audit messages (it is similar to many packing
problems). We have a solution using some simple heuristics that keeps the
problem from exploding computational. Should be available in some future
setools release, but probably not for a while.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> 
> Dan




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
