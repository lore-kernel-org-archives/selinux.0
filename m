From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: some policy feedback
Date: Tue, 3 Jun 2003 10:22:03 +1000
Cc: SELinux@tycho.nsa.gov
References: <20030601222359.D31891@lemuria.org> <200306021037.21050.russell@coker.com.au> <20030602182422.D2944@lemuria.org>
In-Reply-To: <20030602182422.D2944@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306031022.03152.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Jun 2003 02:24, Tom wrote:
> > > Someone (whose name I unfortunately forgot to get) did exploit this
> > > problem and modified my .bashrc in a non-malicious way. I discussed the
> > > issue with him and we both felt that it would probably be possible to
> > > exploit it.
> >
> > Peter Palfreder has just demonstrated this on Method's SE-Gentoo system
> > (see the IRC channel).
>
> Sorry, I'm drowning in work today. Could someone please post a 2-line
> summary (like "oops, this is evil" or "not really serious") ?

If you grant root access to untrusted users then yes it is serious.  Also 
regarding our recent discussions of ssh, if someone cracks sshd then they can 
get access to an account with low SE privs and then change the .login file 
etc to subvert newrole (Peter wrote a newrole program in shell script which 
sent the password off-site).

Creating a new type for the .login files etc is easy enough, I'm playing with 
this on my play machine.

> > > 3) user macros
> > > I've been digging through the user macros, because I wanted to set up
> > > an additional unpriviledge (guest) user. Is there any documentation on
> > > why the macros were laid out the way they were?
> >
> > They have just evolved like that.  They need to be sorted out more,
> > documented, etc.
>
> Is anyone working on that? I would like to give that a try because I
> would like to have a better role structure for my own systems.

Nothing serious is being done at this time.  In the last two years it seems 
that I'm the only person to work in this area, and all I have wanted to do 
was get multiple user roles working properly (which is 99% done).

Go for it!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
