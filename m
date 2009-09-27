From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS and default labels
Date: Sun, 27 Sep 2009 17:34:21 +1000
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <20090909100647.GE24297@myhost.felk.cvut.cz> <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200909271734.23340.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Sep 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > Secondly I don't see why a user is not able to discretionarily
> > > > specify his range outright when going via ssh just as he can with
> > > > roles.
> > >
> > > That's another artifact of the MLS model (label preservation /
> > > confinement).
> >
> > Unfortunately here I have no idea on what code should I look to remove
> > that artifact.
>
> I think it is just lack of support in sshd due to lack of interest in
> supporting it for MLS.  You could add it, but you'd need to make sure
> that it doesn't break the MLS behavior, as that is the one people care
> about.

If a user has a default range of A and they request a range of B then the same 
checks could be applied as for a runcon -l B operation when the source range 
was A.

How could that break anything?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
