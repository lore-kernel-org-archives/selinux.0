Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S8MYrT008192
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 04:22:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6S8M1AN026998
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:22:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: SeLinux packages compiled smoothly on ppc (after some help ..)
Date: Wed, 28 Jul 2004 17:09:04 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1090967773.7271.2017.camel@debby>
In-Reply-To: <1090967773.7271.2017.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407281709.04431.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Jul 2004 08:36, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> dpkg_1.10.22_powerpc.deb
> ssh_3.8.1p1-7_powerpc.deb

Looks like you got the wrong version of these two.

> fakeroot apt-get source --compile dpkg=1.10.22-se1
>
> works not with 2.95, but with 3.4.
> The build with 2.95 ended with:
> ______________________________________
> checking for initscr in -lncurses... yes
> checking if TIOCNOTTY is defined in sys/ioctl.h... yes
> checking for va_copy... no
> checking for va_list assignment copy... configure: error: no
> make: *** [/home/shorty/testone/dpkg-1.10.22/build/configure-stamp] Error 1
> Build command 'cd dpkg-1.10.22 && dpkg-buildpackage -b -uc' failed.
> E: Child process failed
> ______________________________________

File a FTBFS bug against dpkg in the Debian BTS.

> And this:
> I patched the openssh sources only with the openssh-selinux.patch.gz
> and *not* with the
> ssh.diff.gz
> that can be found in the same directory on
> http://www.coker.com.au/newselinux/

Then you need to run "autoconf" before building it, otherwise you don't get SE 
Linux support.

> And please let me know in case someone would like to upload ppc packages
> like the ones above. With detailed guidance on how exactly to build them
> I'd enjoy to help here, and make them available for others, too ...

Please make them available for the benefit of other people.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
