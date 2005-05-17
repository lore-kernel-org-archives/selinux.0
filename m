Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4HEe3gA028418
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2005 10:40:05 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4HEaH2C019617
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2005 14:36:17 GMT
Message-Id: <200505171436.j4HEaV8R004145@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Roger Brunell'" <rog_brunell@yahoo.com>
Cc: "'SELinux'" <selinux@tycho.nsa.gov>
Subject: RE: policy directory structure - Debian and Tresys tools
Date: Tue, 17 May 2005 10:36:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050517133852.9344.qmail@web60422.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Roger Brunell [mailto:rog_brunell@yahoo.com]
> Sent: Tuesday, May 17, 2005 9:39 AM
> To: Karl MacMillan
> Cc: SELinux
> Subject: RE: policy directory structure - Debian and Tresys tools
> 
> 
> --- Karl MacMillan <kmacmillan@tresys.com> wrote:
> 
> > Looks like you are missing the development packages for libxml-2 - that will
> > add
> > the pkg-config file (libxml-2.0.pc). Not certain the package name on a
> debian
> > system, but I did find this
> > http://packages.debian.org/stable/devel/libxml2-dev.
> > Hope this helps.
> >
> > Karl
> >
> > ---
> > Karl MacMillan
> > Tresys Technology
> > http://www.tresys.com
> > (410) 290-1411 ext 134
> >
>  <<snip>>  bandwidth reduction act
> 
> I managed to build your package on a Debian derived system, with the following
> steps or mods. The base system is a fresh install with selinux and synaptic
> added.
> 
>   apt-get install libxml2-dev
>   apt-get install tcl8.4-dev
>   apt-get install tk8.4-dev
>   apt-get install libglade2-dev
> 
>  Makefile: uncomment  TCL_INCLUDE and set to
>                       TCL_INCLUDE = -I/usr/include/tcl8.4
> 
> Thanks for the help. Now I can finally start learning about policy....
> 
> 

Great - glad to help.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> 
> Roger Brunell
> 
> Infosec Engineer (retired)
> "Born 20 years too early"
> 
> 
> 
> Yahoo! Mail
> Stay connected, organized, and protected. Take the tour:
> http://tour.mail.yahoo.com/mailtour.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
