Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UJrcrT029765
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 15:53:38 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6UJrZAP021309
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 19:53:36 GMT
Subject: Re: Building SE-ssh. Result: fakeroot: Permission denied
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Colin Walters <walters@verbum.org>, Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040730131510.GB7025@legolas.drinsama.de>
References: <1091187766.18595.153.camel@debby>
	 <1091188128.18595.158.camel@debby>
	 <20040730131510.GB7025@legolas.drinsama.de>
Content-Type: text/plain
Message-Id: <1091217211.19256.227.camel@debby>
Mime-Version: 1.0
Date: Fri, 30 Jul 2004 21:53:31 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters, Erich Schubert:

Thanks.

On Fri, 2004-07-30 at 15:15, Erich Schubert wrote:
> Hi,
> 
> > > /usr/bin/fakeroot: line 146: debian/rules: Permission denied
> 
> Try "chmod +x debian/rules"

               [ .... ]

This worked ... Thanks .. :)

Result:
openssh-client-udeb_3.8.1p1-7.se1_powerpc.udeb
openssh-server-udeb_3.8.1p1-7.se1_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7.se1_powerpc.deb
ssh_3.8.1p1-7.se1_powerpc.deb

But there was another obstacle before the package(s ?) finally built:

At the end of a build:
---------------------------
In file included from /usr/include/unistd.h:195,
                 from ../includes.h:69,
                 from ../ssh-dss.c:25:
/usr/lib/gcc-lib/powerpc-linux/2.95.4/include/stddef.h:28: machine/ansi.h: No such file or directory
make[1]: *** [ssh-dss.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory `/home/shorty/test/openssh-3.8.1p1/build-udeb'
make: *** [build-udeb-stamp] Error 2
-----------------------------

I could solve the issue (Thank you, 
"apt-file search ansi.h | grep machine/ansi.h")
above by installing the Debian packages 
ecos, ecosconfig, libwxgtk2.4:

$ apt-file search ansi.h | grep machine/ansi.h
ecos: usr/src/ecos/packages/net/common/v2_0/include/machine/ansi.h
newlib-m68hc1x: usr/m68hc11/include/machine/ansi.h

Thank you, "apt-file" ...

But this dependency (ansi.h etc.) is nowhere declared in the ssh
sources, or at least i didn't find something about it: Is this something
one should be worried about? gcc-bug?

Please remember that I intend to upload the packages above for downloads
as soon as I have a place on www somewhere for them ... So I'd like to
make sure not to ruin other folks' systems by building and providing 
messed up stuff ...


I'll try to to rebuild
ssh, dpkg, cron, sysvinit, logrotate, and pam
for SE-Linux/ppc  this weekend.
All of them with gcc-2.95, running "autoconf" only on the dpkg and ssh
packages.

IINM only the sources for the the packages I can't download and compile
via a

fakeroot apt-get source --compile <somepackage>=<someversion>

might need a "autoconf"
Please let me know if someone thinks the rest of the packages might like
an "autoconf" kiss, too ..

Nice weekend

And thanks to everyone for sharing knowledge ... 

Regards
Wolfgang
-- 
Profile: http://profiles.yahoo.com/wolfgangpfeiffer

and 3 more reasons for Linux:
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.whitehouse.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.fbi.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.defenselink.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
