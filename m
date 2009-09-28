Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
In-Reply-To: <200909271734.23340.russell@coker.com.au>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <200909271734.23340.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 09:37:59 -0400
Message-Id: <1254145079.2257.115.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-09-27 at 17:34 +1000, Russell Coker wrote:
> On Wed, 9 Sep 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > > Secondly I don't see why a user is not able to discretionarily
> > > > > specify his range outright when going via ssh just as he can with
> > > > > roles.
> > > >
> > > > That's another artifact of the MLS model (label preservation /
> > > > confinement).
> > >
> > > Unfortunately here I have no idea on what code should I look to remove
> > > that artifact.
> >
> > I think it is just lack of support in sshd due to lack of interest in
> > supporting it for MLS.  You could add it, but you'd need to make sure
> > that it doesn't break the MLS behavior, as that is the one people care
> > about.
> 
> If a user has a default range of A and they request a range of B then the same 
> checks could be applied as for a runcon -l B operation when the source range 
> was A.
> 
> How could that break anything?

1.  You can't switch levels via runcon under MLS policy - runcon runs in
the caller's domain.

2.  newrole -l is prohibited on an "insecure" tty under MLS policy,
which means any ptys at all due to the potential for downgrading data
through the pty.  Same issue applies for a ssh connection.

LSPP requires level preservation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
