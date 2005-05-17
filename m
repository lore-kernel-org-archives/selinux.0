Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4HDgNgA027904
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2005 09:42:23 -0400 (EDT)
Received: from web60422.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4HDcb2C013689
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2005 13:38:37 GMT
Message-ID: <20050517133852.9344.qmail@web60422.mail.yahoo.com>
Date: Tue, 17 May 2005 06:38:52 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: RE: policy directory structure - Debian and Tresys tools
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200505162044.j4GKi68R026275@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Karl MacMillan <kmacmillan@tresys.com> wrote:

> Looks like you are missing the development packages for libxml-2 - that will
> add
> the pkg-config file (libxml-2.0.pc). Not certain the package name on a debian
> system, but I did find this
> http://packages.debian.org/stable/devel/libxml2-dev.
> Hope this helps.
> 
> Karl
> 
> ---
> Karl MacMillan
> Tresys Technology
> http://www.tresys.com
> (410) 290-1411 ext 134 
> 
 <<snip>>  bandwidth reduction act

I managed to build your package on a Debian derived system, with the following
steps or mods. The base system is a fresh install with selinux and synaptic
added.

  apt-get install libxml2-dev
  apt-get install tcl8.4-dev
  apt-get install tk8.4-dev
  apt-get install libglade2-dev

 Makefile: uncomment  TCL_INCLUDE and set to 
                      TCL_INCLUDE = -I/usr/include/tcl8.4

Thanks for the help. Now I can finally start learning about policy....




Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
