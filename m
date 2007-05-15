Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4FAFg7B012347
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 06:15:43 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4FAFUxl028062
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 10:15:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 168CF18902
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 20:15:23 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vUeMW4xeWQ7G for <selinux@tycho.nsa.gov>;
	Tue, 15 May 2007 20:15:22 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 7B57A18870
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 20:15:22 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DE6B020CD0
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 20:15:19 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: swapon => libblkid.so.1 => libdevmapper.so.1.02.1 => libselinux.so.1
Date: Tue, 15 May 2007 18:46:06 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705151846.15991.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently when you run swapon it tries to access /selinux.  This is because of 
the shared object dependency chain in the subject.

Would it be possible to replace one of those links with a call to dlopen(3) to 
save this?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
