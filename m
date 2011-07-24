Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6OBQROJ031826
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 07:26:30 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6OBQPAp020192
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 11:26:26 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 711C3180D2
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 21:25:17 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: apol and active modules
Date: Sun, 24 Jul 2011 21:26:18 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107242126.19144.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why can't apol (at least version 3.3.6.ds) parse the files in 
/etc/selinux/$SELINUXTYPE/modules/active/modules?  Is this considered a bug or 
a wontfix thing?
-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
