Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HL8lRb027203
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 17:08:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4HL6NB2003936
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:06:23 GMT
Received: from moss-tarheels.epoch.ncsc.mil (moss-tarheels.epoch.ncsc.mil [144.51.25.3])
	by jazzswing.ncsc.mil  with ESMTP id i4HL6Mwi003931
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 21:06:22 GMT
Received: from moss-tarheels.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-tarheels.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i4HL8Yd8007582
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 17:08:34 -0400
Received: (from ewalsh@localhost)
	by moss-tarheels.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i4HL8YUN007581
	for selinux@tycho.nsa.gov; Mon, 17 May 2004 17:08:34 -0400
Subject: SE-X available
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1084828114.3551.52.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 17 May 2004 17:08:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The Security-Enhanced Linux support for X lives in the XACE-SELINUX
branch of the X.org CVS tree, which is hosted at freedesktop.org.

To obtain the code via anonymous CVS, use:

$ cvs -d :pserver:anoncvs@cvs.freedesktop.org:/cvs/xorg login
CVS password: <hit return>
$ cvs -d :pserver:anoncvs@cvs.freedesktop.org:/cvs/xorg co -P
-rXACE-SELINUX xc

You'll need the latest SELinux release which contains the new X security
classes, attributes, and supporting types.

When building the X server, make sure your config/cf/host.def includes
the following:

#define BuildXACE       YES
#define BuildXSELinux   YES
#define ExtraLibraries -lselinux

Note that there is no policy written yet, so nothing is allowed; you'll
need to be in permissive mode.  The denied messages should appear in the
log file, /var/log/Xorg.0.log, and on the X server's stderr also I
believe.  They don't start with the "avc:  " pattern that audit2allow
uses, so that program will have to be modified to work.

The security architecture in the X server is more or less based on the
paper, "Securing the X Window System with SELinux" that is available in
our documentation section.  There are some minor differences, notably
the property and xextension classes.  I'll try to come up with
class/access vector descriptions similar to the ones that were posted
earlier.

-- 
Eamon Walsh <ewalsh@epoch.ncsc.mil>
Information Assurance Research
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
