Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20737
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 09:52:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA24012
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 14:51:45 GMT
Received: from mercury.Sun.COM (mercury.Sun.COM [192.9.25.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA24000
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 14:51:44 GMT
Message-Id: <200111191451.fAJEpsE26751@zurich-mail1.Swiss.Sun.COM>
Date: Mon, 19 Nov 2001 15:51:54 +0100 (MET)
From: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@sun.com>
Reply-To: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@sun.com>
Subject: SELinux and non-ext[23] file systems
To: sds@tislabs.com
Cc: selinux@tycho.nsa.gov, Harald.Von-Fellenberg@sun.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First the good news. Last week I gave a presentation about secure operating 
systems, running the slides on Staroffice 6.0 beta on SELinux 20011016. It ran 
smoothly like a humming bee. Great! It shows that this stuff is usable on a 
laptop.

This said, I would like to re-raise the importance of non-ext2 file system 
support, notably ReiserFS. It has been pointed out before, by Stephen Smalley, 
that this should in principle be easy to integrate (the per-node sec context 
needs to be stored in a file rather than in an unused field of the on-disk inode 
structure). However, I am not aware of anyone tackling this implementation.

Now, if someone could give me a few hints of where the additional code goes, I 
would like to volunteer some of my spare brain cycles to tackle this problem.
ReiserFS support on SELinux would certainly not only make my day.

Regards

Harald

**********************************************************
 Dr. Harald von Fellenberg  
 Chief Technologist        Global Sales Organisation
 Tel:    +41 1 908 9230    Sun Microsystems (Schweiz) AG
 Fax:    +41 1 908 9001    Javastr. 2 
 Mobile: +41 79 349 0393   CH-8604 Volketswil
 mailto:harald.von-fellenberg@sun.com
**********************************************************


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
