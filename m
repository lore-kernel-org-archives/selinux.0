Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Thu, 19 Dec 2002 08:02:33 -0600
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <20021218222704.GH10185@snoopy.apana.org.au> <200212191051.19213.russell@coker.com.au>
In-Reply-To: <200212191051.19213.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200212190802.33560.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 19 December 2002 03:51 am, Russell Coker wrote:
> On Wed, 18 Dec 2002 23:27, Brian May wrote:
> > On Wed, Dec 18, 2002 at 08:45:22AM +0100, Russell Coker wrote:
[-snip]
>
> One significant disadvantage is that a hacked sshd could run "newrole -r
> sysadm_r" and get that access (and this can be extended to other programs
> with a similar situation).
>
> Of course if you allow someone the ability to transition to a role with
> less capabilities than their default role, and then denied them the ability
> to run the newrole program while in that role it might have some potential.
>
> > > Also I think that in most situations where a user could be tricked into
> > > running newrole then it's game-over anyway.
> >
> > OK. I was thinking more of scripts, etc.
>
> It's the same thing.  If I can trick you into running some arbitary
> commands with your main role then I can get your ssh identity key and your
> gpg secret key.  These crypto keys are often worth more than the hardware
> that they are stored on...

Only if access is permitted to be over an unsecured channel.

The differentation between a local user and a remote user has to be provided.

Access to the secret key(s) probably should not be permitted from an
unsecured location/connection. This does require network labels to work.

Currently, as long as the Kerberos tickets have IP addresses embeded, the
TGT cannot be used on any system other than the host that generated them.
This restriction is frequently broken due to things like firwalls/NAT which do
not permit host IP identity to cross their boundary. I'm used to thinking of
these things with MLS, using multiple levels.. If the user connects over a
network, then the ticket cache should be labeled at the level of the
connection. Any lower level connection would not have access. If the user
then starts netscape, then netscape should be labeled at a lower access (or be
isolated via compartment) from the ticket cache. Any process that netscape
starts would also be created at that "lower" level. This includes things like
pgp keys. Only a trusted application should have access to them.

It does mean that the plugin for checking PGP signatures (at a minimum the
one for generating signatures) would have to be sufficiently separate from
the netscape process to be labeled separately. It could not use loadable
modules, for  instance. It also means any scripts started should not have
access either.

This is not a 100% solution - If netscape is used to download an application,
then the user proceeds to configure/compile/run then all bets are off since
the users actions are overriding the labels. It should/could prevent a trojan
from passing the files out though - it would not be authorized access to the
secret key(s) or the Kerberos ticket cache. Only trusted utilities would have
that capability.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
