Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAT6x0Rb029439
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 01:59:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAT6wNp5019468
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 06:58:23 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAT6wLt0019465
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 06:58:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: uCLinux &/or Snapgear Linux
Date: Sat, 29 Nov 2003 17:58:45 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <3FC7AA3E.5030500@travelersdiary.com> <200311290845.30914.russell@coker.com.au> <1070067932.26190.2.camel@chris.pebenito.net>
In-Reply-To: <1070067932.26190.2.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311291758.45036.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Nov 2003 12:05, Chris PeBenito <pebenito@gentoo.org> wrote:
> > I have got it working on the Familiar distribution for iPaQ PDAs (ARM
> > CPU, 64M of RAM, 48M of flash).
>
> I just revived the Embedded Gentoo team, and SELinux on a embedded
> systems has been in the back of my mind.  But its still a ways off for
> us.

Now might not be the ideal time for this.  The old SE Linux is on the way out, 
but JFFS2 does not yet support xattr's so the new SE Linux won't work on many 
embedded devices.  If someone adds xattr support to jffs2 then I'll get the 
new SE Linux going on iPaQ's.  But for the moment there aren't any good 
options for support of flash based devices such as iPaQ's.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
