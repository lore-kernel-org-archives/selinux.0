Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6DGEDrT010547
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 12:14:13 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6DGDn5V020130
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 16:13:50 GMT
Date: Tue, 13 Jul 2004 14:47:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: 254153@bugs.debian.org
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#254153 acknowledged by developer (Bug#254153: fixed in cupsys 1.1.20final+rc1-1)
Message-ID: <20040713134706.GH3732@lkcl.net>
References: <E1BkMvA-0004g1-00@newraff.debian.org> <E1BZS5b-0006MZ-FE@lkcl.net> <handler.254153.D254153.108972409929464.notifdone@bugs.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <handler.254153.D254153.108972409929464.notifdone@bugs.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

thank you!

On Tue, Jul 13, 2004 at 06:18:10AM -0700, Debian Bug Tracking System wrote:

> Source: cupsys
> Source-Version: 1.1.20final+rc1-1
> 
> We believe that the bug you reported is fixed in the latest version of
> cupsys, which is due to be installed in the Debian FTP archive:
> 
> cupsys-bsd_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/cupsys-bsd_1.1.20final+rc1-1_i386.deb
> cupsys-client_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/cupsys-client_1.1.20final+rc1-1_i386.deb
> cupsys_1.1.20final+rc1-1.diff.gz
>   to pool/main/c/cupsys/cupsys_1.1.20final+rc1-1.diff.gz
> cupsys_1.1.20final+rc1-1.dsc
>   to pool/main/c/cupsys/cupsys_1.1.20final+rc1-1.dsc
> cupsys_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/cupsys_1.1.20final+rc1-1_i386.deb
> cupsys_1.1.20final+rc1.orig.tar.gz
>   to pool/main/c/cupsys/cupsys_1.1.20final+rc1.orig.tar.gz
> libcupsimage2-dev_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/libcupsimage2-dev_1.1.20final+rc1-1_i386.deb
> libcupsimage2_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/libcupsimage2_1.1.20final+rc1-1_i386.deb
> libcupsys2-dev_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/libcupsys2-dev_1.1.20final+rc1-1_i386.deb
> libcupsys2-gnutls10_1.1.20final+rc1-1_i386.deb
>   to pool/main/c/cupsys/libcupsys2-gnutls10_1.1.20final+rc1-1_i386.deb

> Closes: 250883 254153
> Changes: 
>  cupsys (1.1.20final+rc1-1) unstable; urgency=low
>  .
>    * Apply a patch for fixing typo in DE templates. (Closes: Bug#250883)
>    * New upstream source, 2004-07-03 CVS.
>    * Add netbase dependency for cupsys-bsd.
>    * Move certs files to /var/lib/cups/certs. (Closes: Bug#254153)

                            ^^^^^^^^^^^^^^^^^^
	modification will be required to debian selinux package to take
	into account new directory, which will require user-read permission
	to access files in that directory (Certifications for printer
	access).

	l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
