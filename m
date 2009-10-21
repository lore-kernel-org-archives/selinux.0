Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9L4qtmZ015313
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 00:52:55 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9L4pxmt015056
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 04:52:00 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4C0B418245
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 15:52:51 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: useradd
Date: Wed, 21 Oct 2009 15:52:48 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200910211552.49980.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems impossible to have policy that allows useradd to always get the right 
context for the new home directory.

I am thinking of patching useradd such that if the -m option is given then it 
will spawn the command "restorecon -R /home/$USER" - or alternately putting 
in SE Linux code to match the context for each file or directory that is 
copied from /etc/skel .

What do you think?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
