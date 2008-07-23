Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6N0Hdif002103
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 20:17:39 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6N0HaHP028837
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 00:17:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 19FA118CB8
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 10:17:32 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4w+2YqiZazw for <selinux@tycho.nsa.gov>;
	Wed, 23 Jul 2008 10:17:31 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id A218018378
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 10:17:31 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id ABCE820E81
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 10:17:30 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: what is the point of semodule -u?
Date: Wed, 23 Jul 2008 10:17:28 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807231017.30237.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

semodule supports options "-i" for install and "-u" for upgrade.  It seems 
that "semodule -i" will upgrade a module, so what is the point 
of "semodule -u"?  Are we assuming that a user or script that calls semodule 
doesn't know what it is doing and relies on the "-u" option refusing to 
install the same (or an older) version for correct results?

If so then I doubt that it will work well as I don't think that versions can 
be tracked accurately with the way the code is developed (EG a new release 
from a distribution vendor might have a higher version number than your local 
customisation even though your local changes are more relevant for your 
environment).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
