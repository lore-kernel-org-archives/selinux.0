Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OK68FX028994
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:06:08 -0500 (EST)
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OK675j014600
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 20:06:10 GMT
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CtATI-0000l6-00
	for selinux@tycho.nsa.gov; Mon, 24 Jan 2005 21:06:00 +0100
Received: from [217.234.0.254] (helo=xp-workstation)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CtATI-0008Ib-00
	for selinux@tycho.nsa.gov; Mon, 24 Jan 2005 21:06:00 +0100
From: Jochen Schmitt <Jochen@herr-schmitt.de>
To: selinux@tycho.nsa.gov
Subject: Sugg. for SELinux enabled Interpreters
Date: Mon, 24 Jan 2005 21:05:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E1CtATI-0008Ib-00@mrelayng.kundenserver.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hallo,

I have bought a book about SELinux form O'Reilly. In this book it
was discussed, that some applications, like KDE have issues with
SELinux.

On KDE the problem is the kdeinit process, which coused, that
SELinux can not distlinguish the diffent programms started by
kdeinit.

So, I have the following idea:

1.) Determinate the filecontext of a file based on the file name.

2.) Calculate the destination transition based of the context of
the file.

3.) Make the transition.

I have create a patch for libselinux, which offers a function to
determinate the destination context and an other function to make
the transition.

I have uploaded the patch on:

http://www.herr-schmitt.de/pub/selinux/libselinux-getdestcon.patch

For testing, I have wrote a test programm, which you may find at:

http://www.herr-schmitt.de/pub/selinux/setest.c

But unfortunately, I have trouble with the third test, so I have
put the audit log, which I have got on

http://www.herr-schmitt.de/pub/selinux/audit.txt

It will be happy for any comments and helps, becouse I am not
very familar with SELinux.

Best Regards:

Jochen Schmitt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
