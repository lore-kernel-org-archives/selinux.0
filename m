Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12022
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 11:00:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA02380
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 15:00:24 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzband.ncsc.mil  with SMTP id PAA02376
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 15:00:23 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015240F8@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Gnome Display Manager
Date: Tue, 17 Apr 2001 10:00:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To All:

I have a version of the Gnome Display Manager (gdm) that work with
selinux. This is a beta port with some work to be done. Any feedback
would be a big help.

You can download this file at sourceforge.net

Anonymous CVS Access 

The selinux SourceForge CVS repository can be checked out through anonymous 
(pserver) CVS with the following instruction set. The module you wish 
to check out must be specified as the modulename. When prompted for 
a password for anonymous, simply press the Enter key. 


cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux login 

cvs -z3 -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux co
selinux/extra/gdm-2.0.98.1 

Or via web

http://prdownloads.sourceforge.net/selinux/gdm-SeLinux-2.0.98.1.tgz


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
