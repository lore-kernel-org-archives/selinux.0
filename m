Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26757
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 10:22:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14124
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:22:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id OAA14120
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:22:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "James Bishop" <james.bishop@jrc.it>, selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
Date: Thu, 4 Oct 2001 14:47:28 +0200
References: <3BBB0FF1.6060309@jrc.it>
In-Reply-To: <3BBB0FF1.6060309@jrc.it>
MIME-Version: 1.0
Message-Id: <20011004142208.9F02B364450@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Oct 2001 15:17, James Bishop wrote:
> Compilation of the modified applications in the selinux/utils
> sub-directory required commenting out the contents of the
> fileutils-4.0/m4/isc-posix.m4 file (I don't know m4); and changing the
> Makefile in psmisc to link pstree with the ncurses library instead of
> the termcap library.

SuSE should have a suitable set of package files that contain this already.  
If you get the source to the SuSE package of the same version and run
"diff -ru" on the source trees then you should be able to see which things 
SuSE has changed and which things are SE-Linux changes.

Ideally you would have an original upstream copy of fileutils, the SuSE 
version, and the SE-Linux version.  Then you could make a patch of the 
difference beterrn upstream and SuSE and apply it to the SELinux tree.

> Now I'm up against the differences between the RedHat 7.1 and SuSE 7.2
> distributions. The MCONFIG files of the util-linux package are different
> (also SuSE 7.2 uses util-linux-2.11). I know from past experience that
> getting things wrong with util-linux is "a bit of a bore".

Debian also uses util-linux 2.11 (actually 2.11h).  Hopefully I'll soon have 
the SELinux changes merged into the Debian package which may make an easier 
starting point for you, especially if you want to use the SE-Linux patches on 
2.11.

However 2.10 should be OK, I don't think that there have been any serious 
changes that your machine may be relying on, so downgrading should be 
unlikely to cause problems.

> If I proceed to install the utils package as is, can anyone tell me
> whether login will still work? Or could / should I modify the MCONFIG
> file of SELinux to bring it closer into line with the SuSE 7.2 version?

I suggest keeping a copy of the original RPM you used to install that package 
handy (maybe have the CD mounted).  Then have a few spare login sessions 
running at the time of the install.  If it seems to not work then you can 
re-install the old one.

For such things they generally either work or not work, so it's easy to have 
a couple of sessions logged in while making changes to /bin/login, pam, 
libc6, or other things that can seriously break your system.

> I see that the SELinux Makefile moves the original /bin/login to
> /bin/login.old and then installs the new /bin/login. If I could ensure
> that /bin/login.old was used (perhaps on the basis of the result of the
> uname command - SuSE 7.2 is kernel version 2.4.4)I would feel better.
> How could I do this?

You could write a shell script that checks the kernel version and then exec's 
the matching login program.

> Should I remove shadow passwords from the SuSE 7.2 system before
> proceeding, or can I leave them in place?

Removing shadow passwords would defeat the purpose of the exercise...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
