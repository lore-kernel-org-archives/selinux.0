Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8A1oVSQ002398
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 21:50:31 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8A1niHH010984
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 01:49:46 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 84648180EA
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:50:20 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XwOpvMqf0nI for <selinux@tycho.nsa.gov>;
	Wed, 10 Sep 2008 11:50:20 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 33614180DC
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:50:20 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id E1D7520F93
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 11:50:15 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: semodule memory use
Date: Wed, 10 Sep 2008 11:50:13 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809101150.15440.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495786

I've received the above bug report against the Debian policy packages.  The 
operation in question is "semodule -b" followed by "semodule -i".

I haven't had time to work on this (and won't until well after Lenny is 
released).  But if anyone has any quick ideas of how to reduce memory use by 
semodule then I would be interested to hear them.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
