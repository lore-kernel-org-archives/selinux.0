Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02868
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 15:52:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA17989
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 20:52:46 GMT
Received: from houston.jhuapl.edu (houston.jhuapl.edu [128.244.26.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA17982
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 20:52:45 GMT
Received: from CONVERSION-DAEMON by houston.jhuapl.edu (PMDF V5.2-32 #40040)
 id <0GMG000017BZV3@houston.jhuapl.edu> for selinux@tycho.nsa.gov; Wed,
 7 Nov 2001 15:52:47 -0500 (EST)
Date: Wed, 07 Nov 2001 15:50:03 -0500 (EST)
From: Yanni Kouskoulas <Yanni.Kouskoulas@jhuapl.edu>
Subject: Re: New SELinux release???
In-reply-to: <Pine.LNX.4.21.0111061428270.1656-100000@kouskya1.jhuapl.edu>
To: "Timothy E. Kohler" <tim@odo.arl.psu.edu>
Cc: selinux@tycho.nsa.gov
Message-id: <Pine.LNX.4.21.0111071225280.2187-100000@kouskya1.jhuapl.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having now installed the latest selinux on multiple RH7.2 systems, I
should amend the information in my last e-mail. The errors varies
depending on what else has been installed.

If the RH7.2 installation gives an error saying that AM_GNU_GETTEXT is
undefined, then the response given in my previous e-mail is appropriate.
There are some other tweaks, but those are the main ones.

If the RH7.2 installation gives an error saying that AC_ISC_POSIX is
multiply defined, then the response is different: zero that file out
(isc-posix.m4) and it will subsequently complains that config.guess and
config.sub are missing. Copy these files from the sh-utils directory, and
that should get people past that part of the compile.

Hope this helps clear up more confusion than it creates.

-Yanni


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
