Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i62H1prT014784
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 13:01:51 -0400 (EDT)
Received: from p15107633.pureserver.info (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i62H1ndS007624
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 17:01:50 GMT
Date: Fri, 2 Jul 2004 19:01:46 +0200
From: Jan Gehring <pr0gm4@linoratix.com>
To: selinux@tycho.nsa.gov
Subject: Re: Compiling error - sysvinit
Message-Id: <20040702190146.78697fe7.pr0gm4@linoratix.com>
In-Reply-To: <20040702092526.GD3277@lkcl.net>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com>
	<20040702071544.GA3277@lkcl.net>
	<20040702092526.GD3277@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Luke,
> > under what system are you doing the compiling, if debian,
> > have you done apt-get build-dep sysvinit?
I have build my system by own. Some parts are from the linux-from-scratch project.
(http://www.linoratix.com)

> 
>  jan, you will need to install the package libselinux1-dev
>  (if debian) or equivalent for whatever-system-you-have.
well i have build und installed libselinux.

$ ls /lib/libselinux.so.1
/lib/libselinux.so.1

$ ls /usr/lib/libselinux.*
/usr/lib/libselinux.a	/usr/lib/libselinux.so

/usr/lib/libselinux.so is a symlink to /lib/libselinux.so.1

perhaps i have to add some other some other symlinks?

> > On Fri, Jul 02, 2004 at 01:48:50PM +0200, Jan Gehring wrote:
> > > Hello ml,
> > > 
> > > i tried to compile sysvinit-2.85 but i get the following error.
> > > 
> > > root@maracuja src # make LDFLAGS="-s -lselinux" CFLAGS="-D_GNU_SOURCE"
> > > cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
> > > [...]
> > > init.c:97: error: `SELINUXMNT' undeclared (first use in this function)
> > > [...]
> > > init.c:123: error: `SELINUXPOLICY' undeclared (first use in this function)
> > > make: *** [init.o] Error 1

[cut]


Thanks for any help
Jan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
