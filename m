Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Wed, 18 Dec 2002 08:45:22 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <20021217192856.427b5d68.fw@fwsystems.com> <20021218012830.GC31462@snoopy.apana.org.au>
In-Reply-To: <20021218012830.GC31462@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212180845.22750.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Dec 2002 02:28, Brian May wrote:
> On Tue, Dec 17, 2002 at 07:28:56PM -0500, forrest whitcher wrote:
> > I'll look into adding kerberos auth to newrole(1) to save retypings of
> > password next.
>
> Interesting idea, it would be good not to have to type in your password
> each time.

Which is something you could easily achieve through PAM configuration if that 
is what you desire, without any kerberos issues etc.

> However, I have to wonder if this is such a good idea...
>
> At the very least you would need to have a strict policy that only
> allows very trusted programs to access the ticket or to run a program
> (eg. newrole) that has access to this ticket.

As newrole can't be ptraced etc it should be safe to be trusted with the 
ticket.  But it doesn't make sense IMHO to be doing such things.

> If there is any weakness in this strict policy, and for instance program
> X finds it can run newrole indirectly via, say bash, and automatically
> get sysadm_r priviliges, you loose any benifit SE-Linux could provide.

No.

Programs in domains such as user_netscape_t and user_irc_t will not be allowed 
to run newrole at all.

Newrole will still only allow transitions to roles that are permitted (so if a 
user is not permitted sysadm_r then they still can't get it).

Daemons will still run in separate domains to protect against each other and 
against regular system users.

Allowing role transitions without password loses you some of the benefits of 
SE Linux, but not even most of them.

Also I think that in most situations where a user could be tricked into 
running newrole then it's game-over anyway.

> Some sort of tool for analysing policy might be good here, for instance
> so you can ask questions like "Can Mozilla access the Kerberos ticket
> either directly or indirectly by loading another program first?".

I think that Trent is working on such tools.  But this is a simple case that 
can be addressed by grep:
grep allow.*netscape.*process.transition policy.conf
Shows that user_netscape_t can only transition to user_lpr_t (and similar 
transitions for sysadm_netscape_t and httpd_admin_netscape_t).

grep allow.*_lpr_t.*process.transition policy.conf
Shows that user_lpr_t etc can't transition to any domain.

So netscape is safe in this regard.

> I am not yet sure how good SE-Linux will be at solving this type of
> problem, without duplicating a lot of domains, for instance
> a set of domains for programs with Kerberos ticket access, and
> a duplicate set for programs without Kerberos ticket access).

What exactly is "ticket access" and how does it conceptually differ from read 
access to /etc/shadow?  Couldn't we just treat ticket access in the same way 
as access to /etc/shadow?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
