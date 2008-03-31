Subject: Re: file(1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1206968234.5610.7.camel@moss-spartans.epoch.ncsc.mil>
References: <200803272349.32854.russell@coker.com.au>
	 <1206711214.3302.442.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B0158801CD1E16@exchange.columbia.tresys.com>
	 <200803291219.12623.russell@coker.com.au>
	 <1206968234.5610.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 10:12:58 -0400
Message-Id: <1206972778.5610.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-31 at 08:57 -0400, Stephen Smalley wrote:
> On Sat, 2008-03-29 at 12:19 +1100, Russell Coker wrote:
> > On Saturday 29 March 2008 02:10, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> > > >> # file qmail.pp  base.pp  /tmp/loadkeys.pp
> > > >> qmail.pp:         SE Linux modular policy version 1, 2 sections, mod
> > > >> version 7, Not MLS, module name qmail\005
> > >
> > > Also I think SELinux policy package, this magic number is for packages,
> > > modules have their own magic number.
> > 
> > # file /etc/selinux/refpolicy-mls/policy/policy.22
> > /etc/selinux/refpolicy-mls/policy/policy.22: SE Linux policy v22 MLS 8 symbols 
> > 7 ocons
> > 
> > Yes, I've got that.
> 
> Wait - I think there might be some confusion here.
> 
> There are three or four formats depending on how you are counting:
> - the kernel binary policy file (policy.N),
> - the module policy package file (.pp files),
> - the binary module file (.mod files, and these come in two flavors -
> base and non-base).
> 
> base.pp is a module policy package file containing a binary module
> (.mod) file, a file contexts (.fc) file, and potentially other
> components (e.g. seusers, users_extra).
> 
> So don't confuse the module policy package file with a module file - the
> module policy package file has its own header before the module file.

So, to be precise, we've got the following format for the module policy
package file:
module package magic number (different from the module magic number)
module package format version (different from the module format version)
number of sections
offset array, indexed by section number
binary module (with its own header)
any other sections (file contexts, etc)

Note that the offset array is variable length - it will be the number of
sections * sizeof uint32.

And note that the order of sections isn't necessarily fixed, although
the current module package writing code always puts the binary module
first.  But the read code doesn't make any assumptions about ordering
and just determines what each section is as it encounters it.

At present, we require each .pp file to at least contain a .mod file,
but we've talked before about lifting that requirement so that a .pp
file can just carry a .fc file or other data without requiring a module.
Although today people favor using semanage fcontext instead since it
provides safer ordering guarantees.

One other fun tidbit - in libsepol 2.0.23, I changed the policy reading
code to accept either "Flask" or "SE Linux" as the string identifier as
other projects, like Solaris FMAC, are using "Flask" as the string
identifier as a more general specifier.  So it would be nice if file(1)
ultimately accepted either as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
