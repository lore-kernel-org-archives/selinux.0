Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8A1sIg1002916
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 21:54:18 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8A1rXHH011605
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 01:53:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id B4110180EA
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:54:15 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2cePcvq6Tc6 for <selinux@tycho.nsa.gov>;
	Wed, 10 Sep 2008 11:54:15 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 6833B180DC
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:54:15 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 3336220F93
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:54:13 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: dpkg bug related to SE Linux
Date: Wed, 10 Sep 2008 11:54:07 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809101154.12520.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=498438

This may interest someone here.

dpkg can in some situations fail to reset the default file create context and 
create files with the wrong context.  It doesn't appear to be a security 
issue though.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
