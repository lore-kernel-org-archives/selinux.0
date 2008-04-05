Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m354AkC8018140
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2008 00:10:48 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m354AiK5003011
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2008 04:10:45 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id E5C8A18B2B
	for <selinux@tycho.nsa.gov>; Sat,  5 Apr 2008 13:48:04 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3FDIwSKRl-T for <selinux@tycho.nsa.gov>;
	Sat,  5 Apr 2008 13:48:04 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 9045318526
	for <selinux@tycho.nsa.gov>; Sat,  5 Apr 2008 13:48:04 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 888A12206F
	for <selinux@tycho.nsa.gov>; Sat,  5 Apr 2008 13:47:57 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: dpkg bug related to SE Linux
Date: Sat, 5 Apr 2008 13:47:51 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804051347.55320.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474339

When the file_contexts file has an invalid context then dpkg will crash, see 
the above bug report.

dpkg is statically linked against libselinux.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
