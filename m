Message-Id: <200504282038.j3SKc48R030556@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "=?iso-8859-1?Q?'Lorenzo_Hern=E1ndez_Garc=EDa-Hierro'?=" <lorenzo@gnu.org>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Davide Bolcioni'" <dbolcioni@3di.it>, <fedora-selinux-list@redhat.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Is there a SELinux tutorial for ISVs ?
Date: Thu, 28 Apr 2005 16:38:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1114710693.6708.237.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Thursday, April 28, 2005 1:52 PM
> To: Lorenzo Hernández García-Hierro
> Cc: Daniel J Walsh; Davide Bolcioni; fedora-selinux-list@redhat.com; SELinux
> Subject: Re: Is there a SELinux tutorial for ISVs ?
> 
> On Thu, 2005-04-28 at 19:32 +0200, Lorenzo Hernández García-Hierro
> wrote:
> > I've been thinking on it when working on the SELinux deployment within
> > Ubuntu Linux, and binary policies are something pretty handy for binary
> > packages-based distributions, among the general benefit they provide.
> >
> > I might be able to work on something, but I would like to know first how
> > many people is interested in this and how many of them would be able to
> > contribute to it in the long term.
> 
> Tresys Technology already has a working implementation of binary policy
> modules, including a module abstraction with a dependency model, a
> compiler for generating such modules, and a linker for linking them
> together with a "base module".  Planned for upstreaming after FC4.  See
> their prior posts to the selinux list or their web site for info.
> 

This and the reference policy work I just mentioned in another email. As we work
on upstreaming the binary modules we are going to need feedback / testing - if
you are interested in this area I would greatly appreciate any help you can
give.

Thanks,

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley <sds@tycho.nsa.gov>
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
