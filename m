Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B4DnrT004160
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 00:13:49 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B4Di1j004762
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 00:13:45 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: SELinux on Debian (Sid)
Date: Fri, 11 Jun 2004 14:13:40 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <20040610120344.GM5477@philips.com> <20040610215418.GR2861@lkcl.net>
In-Reply-To: <20040610215418.GR2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111413.40262.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 07:54, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > The selinux-default-policy came from the apt-repository mentioned above.
>
>  ah, there _isn't_ one in newselinux, you mean the one from
>  ftp.uk.debian.org.

Or whichever Debian mirror is most convenient.

>  check that you have 1.12-1

1.12-2 has been out for a while, and yesterday I uploaded 1.12-3 which fixes 
some issues discussed in this thread.

>  tell y'what, here's a list of packages i have installed:
>
>  sez:/boot# dpkg -l | grep selinux
>  ii  bsdutils       2.11z-4.selinu Basic utilities from 4.4BSD-Lite

Why do you need a patched bsdutils?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
