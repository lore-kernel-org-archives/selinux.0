Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26316
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 15:14:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA14971
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 20:13:29 GMT
Received: from houston.jhuapl.edu (houston.jhuapl.edu [128.244.26.10])
	by jazzband.ncsc.mil  with ESMTP id UAA14967
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 20:13:29 GMT
Received: from CONVERSION-DAEMON by houston.jhuapl.edu (PMDF V5.2-32 #40040)
 id <0GME00301AVC91@houston.jhuapl.edu> for selinux@tycho.nsa.gov; Tue,
 6 Nov 2001 15:14:00 -0500 (EST)
Date: Tue, 06 Nov 2001 15:11:21 -0500 (EST)
From: Yanni Kouskoulas <Yanni.Kouskoulas@jhuapl.edu>
Subject: Re: New SELinux release???
In-reply-to: <3BE810A9.EAA3B410@odo.arl.psu.edu>
To: "Timothy E. Kohler" <tim@odo.arl.psu.edu>
Cc: selinux@tycho.nsa.gov
Message-id: <Pine.LNX.4.21.0111061428270.1656-100000@kouskya1.jhuapl.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 6 Nov 2001, Timothy E. Kohler wrote:

> Been trying to work with SELinux under RedHat 7.2.  I've
> had compile problems with utils/fileutils-4.0.  Everything
> worked fine under 7.1.  Get the following error:
> 
> make[1]: Entering directory `/usr/src/selinux/utils/fileutils-4.0'
> cd . && aclocal -I m4
> aclocal: m4/isc-posix.m4: 11: duplicated macro `AC_ISC_POSIX'
> make[1]: *** [aclocal.m4] Error 1
> make[1]: Leaving directory `/usr/src/selinux/utils/fileutils-4.0'

It takes some effort to get the utils directory compiled under 7.2, but it
is doable. If I remember correctly, there are some zero length files in
/usr/src/selinux/utils/fileutils-4.0/m4 and these causing some errors.
Copy the equivalent non-zero length .m4 files from
/usr/src/selinux/utils/sh-utils-2.0/m4 and the make goes further.

There were also some modifications that to be made to the Makefile in
psmisc (I think pstree was having trouble building, so for now just remove
it).

-Yanni




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
