Subject: Re: install vs. matchpathcon(8) [Re: justifying --context=CTX (-Z)
	...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <meyering@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <87d5ay72in.fsf_-_@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
	 <87irkzfcgr.fsf@rho.meyering.net> <44DE134A.3030104@redhat.com>
	 <87d5ay72in.fsf_-_@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 15:14:52 -0400
Message-Id: <1156792492.22210.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-18 at 12:37 +0200, Jim Meyering wrote:
> Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Jim Meyering wrote:
> >>>> BTW, what makes install so special that it needs to call matchpathcon?
> >>>> Can it accomplish the same goal via "chcon ...;
> >>>> install --preserve-context ..."?
> ...
> >> Thanks for explaining.
> >> If install really needs -Z, I'd prefer to drop its internal
> >> use of matchpathcon.
> >>
> > -Z implies that the builder of the application knows the security
> > context for all possible environemnts.  Matchpatchcon asks the system
> > how a file in a certain path should be labeled.  They are very different
> > things.
> >
> > Two different machines running the same install could/should have
> > different end file context.  For example a strict policy machine might
> > label firefox, mozilla_exec_t, while a targeted might label it bin_t.
> 
> [Oh!  I see I never send this reply. ]
> 
> I'm inclined to keep upstream GNU install minimalist.  So if there's
> a way to accomplish this task without embedding the specialized
> matchpathcon-related code, I have to ask "why embed?".  If by adding
> only -Z (or providing an fscon program), I don't absolutely need to
> include the matchpathcon-calling code in install.c, then I'd rather not.
> 
> For example, can't one use the matchpathcon _program_ like this?
> 
>   install -Z $(matchpathcon -n $bindir/SOME_EXECUTABLE) SOME_EXECUTABLE $bindir
> 
> This seems better, since it'd work any version of install:
> 
>   fscon -Z $(matchpathcon -n $bindir/SOME_EXECUTABLE) \
>     install SOME_EXECUTABLE $bindir
> 
> Obviously, that's more verbose than we'd prefer, but an
> selinux-specific wrapper script could do the job transparently.
> Then, the only change would be to build via "make INSTALL=install-con".

This breaks down when you are installing multiple files that should have
different contexts to a single destination directory via a single
install command.  And the point of the install modification to use
matchpathcon was to provide transparency for users, so that when a
typical admin does a 'make install' of his favorite third party software
that is not packaged as an rpm, the installed files are labeled
correctly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
