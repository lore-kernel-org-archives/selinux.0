Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i164dHRb020754
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 23:39:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i164btQk009243
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 04:37:55 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i164bcYo009193
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 04:37:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris Wright <chrisw@osdl.org>, Torben Krause <torben.krause@gmx.de>
Subject: Re: Trouble with installation of lsm kernel patch and SE linux Packages on Debian
Date: Fri, 6 Feb 2004 15:37:30 +1100
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
References: <40214589.5090702@gmx.de> <20040205100656.B17935@osdlab.pdx.osdl.net>
In-Reply-To: <20040205100656.B17935@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402061537.30621.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Feb 2004 05:06, Chris Wright <chrisw@osdl.org> wrote:
> [ Cc: to selinux list, which is a better place to ask these question ]
>
> * Torben Krause (torben.krause@gmx.de) wrote:
> > Here my Questions:
> >
> > Which kernel patch must i use for lsm, kernel-patch-2.4-oldlsm or
> > kernel-patch-2.4-lsm ? And is there a for 2.4.23/woody ?
> >
> > Furthermore, i want to know whether i've understood the information on
> > russel cokers webpage  right: new SE Linux is only available to 2.4 as
> > unstable (beside 2.6 kernel). Old SE Linux is available as unstable and
> > stable to 2.4.
> >
> > Is that right ?!?
>
> Russell is the best person to answer this.  Similar questions have been
> asked on the selinux mailing list.  I believe there is a current selinux
> that is backported to 2.4 and available on Woody.  According to Russell,
> update /etc/apt/sources.list with:
> deb http://www.microcomaustralia.com.au/debian/ stable selinux main

Brian is in the process of making that apt line work for new SE Linux, it used 
to have the old SE Linux while the new SE Linux could be obtained with the 
following APT line:
deb http://www.microcomaustralia.com.au/debian/ stable selinux main

Also for kernel patches you can go to 
http://www.coker.com.au/newselinux/kern/ , however that requires the ACL 
patch package and the Debian kernel patch from Debian/unstable.  This is OK 
as running a kernel compiled from the latest Debian kernel source on 
Debian/woody works fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
