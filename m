Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9IJwIi024638
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 13:19:58 -0500 (EST)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9IK0si014242
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 18:20:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id D9C84C4C084
	for <selinux@tycho.nsa.gov>; Tue,  9 Nov 2004 19:19:55 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 01600-03 for <selinux@tycho.nsa.gov>;
	Tue, 9 Nov 2004 19:19:52 +0100 (CET)
Received: from wintermute.xmldesign.de (smaug.cdtm.de [129.187.150.81])
	by legolas.drinsama.de (Postfix) with ESMTP id 93177C4C08D
	for <selinux@tycho.nsa.gov>; Tue,  9 Nov 2004 19:19:52 +0100 (CET)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id BC035234053
	for <selinux@tycho.nsa.gov>; Tue,  9 Nov 2004 19:19:34 +0100 (CET)
Subject: tty files, console login on debian
From: Erich Schubert <erich@debian.org>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 19:19:34 +0100
Message-Id: <1100024374.18347.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russel,
I just updated my system to your lates debian policy package.
Afterwards I could no longer login on the console, ssh worked.
I believe i found the problem in types/file.te:
I solved it by adding the following:

allow { dev_fs ttyfile } fs_t:filesystem associate;

Since the type of the staff/user ttys is "ttyfile", but no longer
"device_type". Maybe you'll prefer a different fix, though.
It is also possible that the mountpoint or so needs to be relabeled?
(redhat appears to have tmpfs_t there, not fs_t)

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
            There are only 10 types of people in the world:           //\
            Those who understand binary and those who don't           V_/_
  In unseren Freunden suchen wir, was uns fehlt. --- Thornton Wilder


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
