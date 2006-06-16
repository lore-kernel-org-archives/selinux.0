Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GDXrYC027460
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 09:33:53 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5GDXpjX010871
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 13:33:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casey@schaufler-ca.com
Subject: Re: polyinstantiating /tmp and gdm
Date: Fri, 16 Jun 2006 23:33:47 +1000
Cc: janak@us.ibm.com, selinux@tycho.nsa.gov
References: <20060613181112.24452.qmail@web36615.mail.mud.yahoo.com>
In-Reply-To: <20060613181112.24452.qmail@web36615.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606162333.47419.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 14 June 2006 04:11, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
> > Maybe a better option is to have the socket created
> > under /var/run/.X11-unix
>
> Each of that daemons is going to have to
> enforce (at least) MLS if you do this. While
> this does make sense for the more sophisticated
> programs (MLS X11 has been done, but my

You seem to be confusing separate issues here.

Changing the directory used as the parent of the directory containing the 
socket makes no difference.  In either case the directory needs to have a low 
enough level that all the X programs can read it, and for both /tmp 
and /var/tmp there's a range of SystemLow-SystemHigh so there's no issue in 
that regard.

As for the issue of making the X server enforce MLS, isn't that part of the 
plan for security enhanced X?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
