Subject: Re: file(1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200804022202.35412.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au>
	 <1206968234.5610.7.camel@moss-spartans.epoch.ncsc.mil>
	 <1206972778.5610.25.camel@moss-spartans.epoch.ncsc.mil>
	 <200804022202.35412.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 08:10:06 -0400
Message-Id: <1207138206.27710.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-02 at 22:02 +1100, Russell Coker wrote:
> On Tuesday 01 April 2008 01:12, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > There are three or four formats depending on how you are counting:
> > > - the kernel binary policy file (policy.N),
> > > - the module policy package file (.pp files),
> > > - the binary module file (.mod files, and these come in two flavors -
> > > base and non-base).
> > >
> > > base.pp is a module policy package file containing a binary module
> > > (.mod) file, a file contexts (.fc) file, and potentially other
> > > components (e.g. seusers, users_extra).
> > >
> > > So don't confuse the module policy package file with a module file - the
> > > module policy package file has its own header before the module file.
> >
> > So, to be precise, we've got the following format for the module policy
> > package file:
> > module package magic number (different from the module magic number)
> > module package format version (different from the module format version)
> > number of sections
> > offset array, indexed by section number
> > binary module (with its own header)
> > any other sections (file contexts, etc)
> >
> > Note that the offset array is variable length - it will be the number of
> > sections * sizeof uint32.
> 
> This is where things start to become tricky, magic(5) doesn't support arrays.  
> I could probably handle this with nested if statements for a reasonable 
> number (it seems that we generally don't have that many).

Yes, in general you're likely to only encounter three situations:
- base.pp file with all of the sections present (or at least the ones
that we actually use these days),
- foo.pp file with only a module section,
- bar.pp file with a module section and a file contexts section.

> > And note that the order of sections isn't necessarily fixed, although
> > the current module package writing code always puts the binary module
> > first.  But the read code doesn't make any assumptions about ordering
> > and just determines what each section is as it encounters it.
> 
> My current effort just gives information on the first one, the binary seems to 
> be the most interesting one (if for example qmail.pp 
> becomes /lost+found/#1234 then having the string "qmail\5" be displayed would 
> be helpful).

Yes - I was just saying that the format doesn't actually guarantee that
the binary module will always be first.  That's just an artifact of the
current implementation.

> > One other fun tidbit - in libsepol 2.0.23, I changed the policy reading
> > code to accept either "Flask" or "SE Linux" as the string identifier as
> > other projects, like Solaris FMAC, are using "Flask" as the string
> > identifier as a more general specifier.  So it would be nice if file(1)
> > ultimately accepted either as well.
> 
> Given that we already have hex magic numbers to recognise the various 
> structures and that the most desirable way for humans to recognise file types 
> is via file(1), what is the benefit of having either "SE Linux" or "Flask" in 
> there?

Possibly none, but the string identifier is well entrenched there.

> Would it be possible to just accept that for the current version of the file 
> format "SE Linux" will be contained in there and not bother about this?  It's 
> no secret that the Flask code was not originally developed for Solaris.

The Flask code wasn't originally developed for Linux either ;)
It would be confusing to use "SE Linux" there on other platforms.  The
change to accept either string identifier in libsepol is so that higher
level policy tools like setools can read and analyze either kind of
policy, as they don't really care whether the underlying platform is
Linux or some other OS.  Possibly not so important for file(1).

> Eventually we just have to lose some data from file(1) output when these 
> situations arise, I suspect that we have already reached the stage where we 
> exceed the flexibility of the magic(5) configuration language.  It may be 
> that on the Linux platform we just get the wrong data from other platforms.
> 
> It seems that there are ongoing plans for new file formats.  Could we agree 
> that getting things to work with file(1) will be a pre-requisite for future 
> file formats?

The only new format I'm aware of is for the policyrep work, and that is
mostly a reversion to source text format for policy modules and policy
packages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
