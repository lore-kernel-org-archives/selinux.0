Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: russell@coker.com.au, Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <f73f7ab80909281622r3c63436gf80bc99852ab7f43@mail.gmail.com>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <200909271734.23340.russell@coker.com.au>
	 <1254145079.2257.115.camel@moss-pluto.epoch.ncsc.mil>
	 <f73f7ab80909281622r3c63436gf80bc99852ab7f43@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 08:21:44 -0400
Message-Id: <1254226904.2252.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-28 at 19:22 -0400, Kyle Moffett wrote:
> On Mon, Sep 28, 2009 at 09:37, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Sun, 2009-09-27 at 17:34 +1000, Russell Coker wrote:
> >> On Wed, 9 Sep 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> I think it is just lack of support in sshd due to lack of interest in
> >>> supporting it for MLS.  You could add it, but you'd need to make sure
> >>> that it doesn't break the MLS behavior, as that is the one people care
> >>> about.
> >>
> >> If a user has a default range of A and they request a range of B then the same
> >> checks could be applied as for a runcon -l B operation when the source range
> >> was A.
> >>
> >> How could that break anything?
> >
> > 1.  You can't switch levels via runcon under MLS policy - runcon runs in
> > the caller's domain.
> >
> > 2.  newrole -l is prohibited on an "insecure" tty under MLS policy,
> > which means any ptys at all due to the potential for downgrading data
> > through the pty.  Same issue applies for a ssh connection.
> >
> > LSPP requires level preservation.
> 
> Hmm, I've been thinking about a way to resolve this for a while now...
>  The company I work for builds trusted guards, and people keep asking
> us about allowing some amount of secure remote management.
> 
> I wonder if it is possible to build some kind of automatic IPsec
> negotiation based on the SELinux MLS label.  Currently you can
> manually create IPsec tunnels and associate a different *type* with
> each tunnel, however I can find no way to do a different tunnel per
> MLS level (on-demand).

Doesn't this get done via labeled IPSEC already? It should request a
separate SA for each unique sending socket security context.
http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/


> I'm thinking of a user-interface along the lines of:
> 
> Put this in your auto-IPsec-aware program:
>     one = 1;
>     setsockopt(fd, SOL_SOCKET, SO_AUTOIPSEC, &one, sizeof(one));
> 
> Then you would put some special configuration in your ipsec-tools.conf
> to indicate some traffic should be "auto-ctx" negotiated.  The kernel
> would then pass the security label to the racoon daemon (running at
> the same MLS level as the wire).  Racoon would negotiate an SA, and
> then install it with a level-specific match.
> 
> The end result would be that your program (say, SSH) running at s4:c3
> would make an automatically-IPsec-protected connection to the SSHD
> running on another computer.  That SystemLow-SystemHigh SSHD would
> fork a child with the socket, which would run "getpeercon()" and
> switch to the appropriate level before trying to use it.
> 
> There are still other issues, but that would at least make it possible.
> 
> Cheers,
> Kyle Moffett
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
