Subject: Re: file(1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200803291219.12623.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au>
	 <1206711214.3302.442.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B0158801CD1E16@exchange.columbia.tresys.com>
	 <200803291219.12623.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 08:57:14 -0400
Message-Id: <1206968234.5610.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 2008-03-29 at 12:19 +1100, Russell Coker wrote:
> On Saturday 29 March 2008 02:10, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> > >> # file qmail.pp  base.pp  /tmp/loadkeys.pp
> > >> qmail.pp:         SE Linux modular policy version 1, 2 sections, mod
> > >> version 7, Not MLS, module name qmail\005
> >
> > Also I think SELinux policy package, this magic number is for packages,
> > modules have their own magic number.
> 
> # file /etc/selinux/refpolicy-mls/policy/policy.22
> /etc/selinux/refpolicy-mls/policy/policy.22: SE Linux policy v22 MLS 8 symbols 
> 7 ocons
> 
> Yes, I've got that.

Wait - I think there might be some confusion here.

There are three or four formats depending on how you are counting:
- the kernel binary policy file (policy.N),
- the module policy package file (.pp files),
- the binary module file (.mod files, and these come in two flavors -
base and non-base).

base.pp is a module policy package file containing a binary module
(.mod) file, a file contexts (.fc) file, and potentially other
components (e.g. seusers, users_extra).

So don't confuse the module policy package file with a module file - the
module policy package file has its own header before the module file.

> 
> > >> base.pp:          SE Linux modular policy version 1, 4 sections, mod
> > >> version 7, Not MLS, base /tmp/loadkeys.pp: SE Linux modular policy
> > >> version 1, 2 sections, mod version 6, MLS, module name loadkeys\005
> > >>
> > >> Please let me know what you think of this, in terms of text
> > >> formatting, information displayed, and use of file(1) features.
> > >
> > > "policy version 1" ought to be "policy type 1", or more
> > > simply, "base module" (1) or "non-base module" (2).
> 
> But non-base modules have a 1 in that field too!

Right - I mistakenly thought you were dealing with .mod files there
rather than .pp files.  So that value reflects the version of the
modular policy package format, which is independent of the module type
or the module version.

> > > Just for comparison with the existing support in file for
> > > kernel policies, "file policy.21" displays:
> > > policy.21: SE Linux policy v21 8 symbols 7 ocons
> > >
> > > Not sure though that the symbols and ocons info is helpful
> > > there to users, and it should always be implicit from the version.
> 
> Probably not.  But that was a mistake I made long ago.  Hopefully this 
> discussion will help avoid such things this time.
> 
> > > Note btw that this format is expected to be obsoleted by the
> > > policyrep work.
> 
> Which format?  The module format or the policy binary format?
> 
> In either case we still need file(1) support.  When someone gives me a disk 
> containing a Debian/Etch or Fedora Core 5 filesystem in 2012 which has most 
> files in /lost+found and asks me to recover data then the presence of magic 
> entries will really help.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
