From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS and default labels
Date: Tue, 29 Sep 2009 06:57:09 +1000
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <200909271734.23340.russell@coker.com.au> <1254145079.2257.115.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254145079.2257.115.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200909290657.13214.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Sep 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > I think it is just lack of support in sshd due to lack of interest in
> > > supporting it for MLS.  You could add it, but you'd need to make sure
> > > that it doesn't break the MLS behavior, as that is the one people care
> > > about.
> >
> > If a user has a default range of A and they request a range of B then the
> > same checks could be applied as for a runcon -l B operation when the
> > source range was A.
> >
> > How could that break anything?
>
> 1.  You can't switch levels via runcon under MLS policy - runcon runs in
> the caller's domain.
>
> 2.  newrole -l is prohibited on an "insecure" tty under MLS policy,
> which means any ptys at all due to the potential for downgrading data
> through the pty.  Same issue applies for a ssh connection.

So it doesn't break anything for MLS.  ;)

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
