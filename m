Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6F4R8NU005565
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2010 00:27:09 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6F4QCLu013833
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2010 04:26:13 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 254AC180FD
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2010 14:27:02 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: restorecon and chroot
Date: Thu, 15 Jul 2010 14:27:01 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007151427.01927.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that we need an option for restorecon which is similar to the -r 
option of setfiles.

This would be useful for setting up chroot environments and possibly also for 
system recovery.

Any suggestion on what command-line option should be used?  It seems that -r 
is taken...

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
