Date: Thu, 18 Jan 2007 11:28:11 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Crispin Cowan <crispin@novell.com>, casey@schaufler-ca.com,
        Tom Fortmann <tfortmann@xcapesolutions.net>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
Message-ID: <20070118172811.GG16585@sergelap.austin.ibm.com>
References: <20070116184620.75850.qmail@web36608.mail.mud.yahoo.com> <45AF5539.2020608@novell.com> <1169124606.22731.202.camel@moss-spartans.epoch.ncsc.mil> <45AF7643.3080200@novell.com> <1169128425.22731.232.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169128425.22731.232.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Fri, 2007-01-19 at 00:29 +1100, Crispin Cowan wrote:
> > Stephen Smalley wrote:
> > > On Thu, 2007-01-18 at 22:08 +1100, Crispin Cowan wrote:
> > >
> > >> There is a module waiting in the wings called Stacker
> > >> <http://sourceforge.net/projects/lsm-stacker> that is designed to
> > >> automatically stack multiple modules. Considerable design,
> > >> implementation, and measurement has gone into Stacker. The main thing
> > >> stalling the upstreaming of Stacker is for some modules other than
> > >> SELinux to be accepted upstream. With the number of modules vying for
> > >> that, it seems just a matter of time.
> > >>
> > > Except that at the last kernel summit, the topic came up during the LSM
> > > panel, and everyone on the panel, including the AppArmor person, agreed
> > > that stacking wasn't necessary or desirable.
> > >
> > Hmmm, that is surprising. I have to assume you meant " ... at this
> > time."
> 
> That wasn't my impression - the question raised was along the lines of
> "even if we can't settle the LSM issue once for all, can we at least
> settle the issue of LSM stacking."  And the consensus view seemed to be
> that generic stacking of security modules is not the way to go; security

Yup, that was the conclusion at kernel summit.

> modules need to be aware of the composition and its implications, as in
> the existing manual stacking of SELinux with capabilities or AppArmor
> with capabilities.

That's always been one of the cons to stacker, but I think at kernel
summit the main reason for the decision was simply the lack of users.
Now it's possible that if we end up with legitimate users, the issue
will be revisited, but even I understand the meaning of the word
'futility' and have stopped maintaining stacker.

> >  With relatively few modules around, a full blown stacking
> > architecture is excessive. But as the number and variety of modules
> > grows, the need for Stacker will increase. That stacking was given such
> > limited support in the LSM design was precisely because I saw it as a
> > "later" kind of thing, and we could avoid the initial complexity.
> 
> I only know of one other security module that is under consideration for
> upstream, slim.
> 
> > Clearly stacking AppArmor and SELinux together is pointless, but if
> > Stacker was upstream, then perhaps the LSPP work going on could be done
> > as a pure LSM module that can stack with something else, so it could
> > compose with SELinux, AppArmor, LIDS, etc. instead of just with SELinux.
> > By now, of course, all sorts of SELinux-specific assumptions are built
> > into the work, but I doubt that they are fundamental.
> 
> To the contrary, the LSPP work significantly leverages the work already
> done to integrate SELinux and makes use of the SELinux interfaces for
> applications.  It also leverages SELinux TE to address aspects such as
> MLS overrides.  By doing it within the context of SELinux, it gained the
> benefit of a unified security model and interface.  Which one doesn't
> get from LSM.

Yup, and in addition to pre-existing userspace and kernel pieces, the
selinux community was very helpful in development during the lspp work.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
