Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA05822
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 16:52:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA29053
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 20:50:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA29049 for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 20:50:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CB27F92724
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2002 07:52:38 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 064CA784
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 22:52:31 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: expect
Date: Sat, 26 Oct 2002 22:52:30 +0200
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200210262252.30567.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I want to run an expect script as:
script program param1 param2 ...

Then have the script spawn "program param1 param2" (sort of like "$@" in a 
bash script).  How do I do this?  Expect wants to combine all the parameters 
into a single parameter that contains spaces. How can I solve this?

Also I want to do it for a varying number of parameters (so having an entry 
for each parameter isn't going to work).

The aim of this is to provide the open_init_pty functionality.  The version I 
posted to the list before will work for the basic SE functionality (IE 
Slackware type support).  But for Debian support (and for full RPM support 
when someone implements it) we need to have open_init_pty run dpkg to install 
packages (and we can install multiple packages at the same time).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
