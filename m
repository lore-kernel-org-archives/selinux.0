Message-Id: <200208051530.PAA26262@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Special directories and links
Date: Mon, 5 Aug 2002 17:30:23 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

on / I have 3 links and 2 directories without a correct security context.
The first direcory /mnt is for temporary mounted filesystems ( see FHS 
too). It could be labelling also as root_t I guess. I don't see any 
disadvantage if all people can read this directory. 
And now a SuSE and newer Red Hat specific question:
On the root are follow links (/floppy, /cdrom and /cdrecorder) to 
/media/(floppy|cdrom|cdrecorder). /media is the second directory.
In my oppinion, root_t is also a usable type to label this entries.

What are you think?

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
