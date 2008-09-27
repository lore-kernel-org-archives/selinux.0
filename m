Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8RGncwS014309
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 12:49:38 -0400
Received: from yx-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8RGmc8U024569
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 16:48:38 GMT
Received: by yx-out-1718.google.com with SMTP id 3so244104yxi.84
        for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 09:49:36 -0700 (PDT)
Message-ID: <48DE640B.10104@gmail.com>
Date: Sat, 27 Sep 2008 12:49:15 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: Jason Tang <jtang@tresys.com>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [autotools] libselinux build system comments
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Jason Tang wrote:
> 4. libselinux is being installed to $(LIBDIR).  In this case, it should default to the system library.
>
>   

What does that mean?

> 5. The SWIG and Python detection routines in configure.ac do not seem to work for my system (Debian/stable).
>   

Could you pastebin your config.log from that box

>
> 7. There is no definition for the variable abs_top_srcdir in src/Makefile.am.
>   

Thats built in. You dont need to define it. Have a look at the resulting 
Makefile

> 8. By default, the libselinux configuration file is written to $(SYSCONFDIR), but selinux_config.c has the path /etc/selinux hardcoded.  (N.b. the missing "selinux" subdirectory for the former path.)
>
>   

How is that a problem? I have voiced my concerns over these hard coded 
paths on many occasions. I personally feel the SELinux userspace is a 
complete disaster and needs to be rewritten, and that is my motivation 
for doing the first step, ie build system.

Just build with ./configure --sysconfdir=/etc/selinux

> For issues one through four, see my related notes on libsepol.
>
> For issue five, why not use the swig_python (and related) package at http://autoconf-archive.cryp.to/swig_python.html?  It seems to work well for SETools.
>   

will check it out.




Thanks Jason for the thorough look at the autotools branch. I'll hack 
away at it slowly.

Vikram



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
