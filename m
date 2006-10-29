Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T9Vv5b007213
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 04:31:57 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T9V8F5024363
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 09:31:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5C46A61B09
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 20:31:56 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyUOMG+TDztP for <selinux@tycho.nsa.gov>;
	Sun, 29 Oct 2006 20:31:56 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 270DA61AE6
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 20:31:56 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DFBDDA7F91
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 20:30:21 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: is targeted/MCS a lost cause?
Date: Sun, 29 Oct 2006 19:30:20 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610292030.21714.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

runcon -t initrc_t runcon -- -l SystemLow-SystemHigh runcon -- -t unconfined_t 
bash

If you have a session on a machine running the rawhide targeted policy (and 
presumably the FC6 policy) then the above command or some variation will give 
you all the categories that your SE Linux identity is permitted regardless of 
the current categories of the calling process or the restrictions of the 
login.

It seems to be a lost cause to try and make MCS do something useful if there 
is a requirement that a user without any categories be able to restart 
daemons.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
