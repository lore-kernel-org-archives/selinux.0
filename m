Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA05931
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 13:13:01 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04151
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 18:10:08 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
	by jazzswing.ncsc.mil  with SMTP id SAA04147
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 18:10:07 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id SAA14372
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 18:17:25 GMT
Date: Sat, 25 Jan 2003 18:17:25 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: relabel ...
Message-ID: <Pine.LNX.4.10.10301251812410.17667-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

At last a successful compilation and rebooting of the NSA version -
although I had to retro to the i386 version on my (nominally) i586
machine.  RH8, gcc-3.2 version.

At the end of compiling the NSA version, it says to 'make relabel' after
rebooting to reset the files created during shutdown/boot.  However I
can't find the Makefile that includes this target so from whereever I
'make relabel' it understandably objects and I keep getting avc denials.

What is the (hopefully) last stage to complete this process?

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
