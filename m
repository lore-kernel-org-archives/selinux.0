Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13355
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 12:24:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA03328
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 17:24:26 GMT
Received: from csoc-fire05.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with SMTP id RAA03324
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 17:24:18 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524239@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Red Phoenix'" <redph0enix@hotmail.com>, selinux@tycho.nsa.gov
Subject: RE: Linux auditing subsystem
Date: Fri, 9 Nov 2001 11:11:03 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RE:  Linux auditing subsystem


I have perfromed some initial test wiht selinux kernel version 2.4.12.
I had to modify the Makefile with  the following changes 


Additions


MYSRCINC=   point to the location of the selinux lsm include directory
MCFLAGS=-g -O6 -I$(MYSRCINC) -DMODVERSIONS -include
$(MYSRCINC)/linux/modversions.h -Iinclude

change

auditmodule:
	$(CC) -c $(MCFLAGS) -DMODULE -D__KERNEL__ -DLINUX auditmodule.c



I am running RedHat Linux 7.1 with the selinux kernel. The
snare-0.8-1.i386.rpm
install and works find with the compiled module.

This look real promising for the work I am doing at NASA.
good work. This is much needed.

Thanks
Mark Westerman

PS:
will start working on the selinux policy rules for this work.

 




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
