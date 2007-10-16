Subject: Re: checkmodule and MLS/MCS support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: russell@coker.com.au, Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1192538623.3645.14.camel@localhost.localdomain>
References: <200710142206.29369.russell@coker.com.au>
	 <200710160827.06055.russell@coker.com.au> <4713F56E.50002@manicmethod.com>
	 <200710161039.50870.russell@coker.com.au>
	 <1192536630.8702.12.camel@moss-spartans.epoch.ncsc.mil>
	 <1192538623.3645.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 08:51:33 -0400
Message-Id: <1192539093.8702.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 08:43 -0400, Karl MacMillan wrote:
> On Tue, 2007-10-16 at 08:10 -0400, Stephen Smalley wrote:
> > On Tue, 2007-10-16 at 10:39 +1000, Russell Coker wrote:
> > > On Tuesday 16 October 2007 09:19, Joshua Brindle <method@manicmethod.com> 
> > > wrote:
> > > > > If we have some new users who decide that this is difficult enough that
> > > > > selinux=0 is the solution then solving the problem has some real
> > > > > benefits. 
> > > >
> > > > This is pretty extreme, its just a flag.
> > > 
> > > Yes, it is extreme, but it's what we are up against.
> > 
> > Do you have a specific suggestion on how to make checkmodule auto-detect
> > the right mode that wouldn't cause breakage for existing policies/users?
> >   
> 
> What about a config file with defaults? For most systems the policy type
> never changes.

That's what the refpolicy build infrastructure uses - it installs a copy
of build.conf under /usr/share/selinux/devel/include and its Makefile
extracts information from it, checking for a -mcs or -mls component in
the TYPE value.  But if we are going to depend on that, then we might as
well just use the refpolicy Makefile in the first place and we don't
need anything in checkmodule itself.

Separate from that, there is /selinux/mls aka is_selinux_mls_enabled()
in libselinux, but that assumes one is building policy on a host with
the same kind of policy as the target host.  Dan's
top-level /usr/share/selinux/devel/Makefile actually uses that.
I don't think though that we want checkmodule to assume anything about
the build host, not even that it is running selinux at all.  checkmodule
and checkpolicy today work fine on non-selinux or selinux with
completely different policy.

So to do the above, we'd end up creating yet another config file that
duplicates what already exists in refpolicy, and we still couldn't
change the default within checkmodule since existing systems won't have
that new config file at all.  So I'm not sure what we'd buy there.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
