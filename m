Subject: Re: [PATCH] checkpolicy: implement handling of unknown classes
	andpermissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1190636961.15178.14.camel@gorn>
References: <1189103186.3418.35.camel@localhost.localdomain>
	 <1190144886.14037.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1190395644.15178.5.camel@gorn.columbia.tresys.com>
	 <1190401736.17518.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1190636961.15178.14.camel@gorn>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 08:41:52 -0400
Message-Id: <1190637712.487.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-24 at 12:29 +0000, Christopher J. PeBenito wrote:
> On Fri, 2007-09-21 at 15:08 -0400, Stephen Smalley wrote:
> > On Fri, 2007-09-21 at 13:27 -0400, Christopher J. PeBenito wrote:
> > > On Tue, 2007-09-18 at 15:48 -0400, Stephen Smalley wrote:
> > > > On Thu, 2007-09-06 at 14:26 -0400, Eric Paris wrote:
> > > > > Add a new command line options, -U (allow,reject,deny), to
> > > > checkmodule
> > > > > and checkpolicy which sets the handle_unknown config flag.  Default
> > > > to
> > > > > deny unknowns which is how things have been in the past.  Also add
> > > > > dismod and dispol support.
> > > > >
> > > > > -Eric
> > > > 
> > > > Thanks, merged as of checkpolicy 2.0.4.
> > > > 
> > > > Chris/Dan:  we need some way to select the flag setting for the policy
> > > > build.  The -U {allow,reject,deny} setting needs to be passed to
> > > > checkmodule _only_ when building the base module, or to checkpolicy
> > > > when
> > > > building a monolithic policy.
> > > 
> > > Here is a patch for this, I haven't committed this to trunk yet, as I'd
> > > prefer to wait for the next stable release of the toolchain (when its
> > > that, btw?).
> > 
> > I was planning to do it early next week.
> > 
> > However, I only committed this change to the trunk version of
> > checkpolicy/libsepol, not the stable branch, as it certainly isn't a bug
> > fix or trivial cleanup.  So by "stable release", do you just mean a
> > release, or do you mean a release of the stable branch that includes
> > this change?
> 
> I suppose I just mean a release.  A release off trunk still isn't going
> to be considered stable?

Depends on what one means by stable ;)

In the first release made from the trunk, I explicitly warned that
interfaces were still subject to change, but that was mostly to avoid
locking sepolgen into fixed interfaces at the time.  Karl, any thoughts
on where things stand for sepolgen stability?

libsepol and checkpolicy are another matter; we'd have to increment .so
version or introduce versioned symbols in libsepol for incompatible
changes (as in the eventual merge of policyrep) and we'd have to provide
some form of backward compatibility for any checkpolicy command line
option once it has been released.  So this particular change should be
stable in the sense of preserving backward compatibility going forward.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
