Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02114
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 17:52:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA28793
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 22:51:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id WAA28789
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 22:51:38 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4B7F092746
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 09:52:25 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B2B9E35A0BD
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 23:52:15 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: policydb
Date: Wed, 16 Jan 2002 23:52:15 +0100
MIME-Version: 1.0
Message-Id: <20020116225215.B2B9E35A0BD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have just noticed that there is no magic number in the policy database!  
This means that if something goes slightly wrong (say a file system error 
replaces the file with some other file but keeps the same inode) then you 
won't easily be able to tell (especially if it happens to start with 
0x00080000 for 2.4.17 or 0x00070000 for 2.4.16).

Could we have a magic number for the next version?

We could make the file start with the string "@SeLiNuX*PoLiCy@", as an 
example (there are billions of strings which are easily identifiable even by 
strings(1) which are also uniquely identifiable by file(1) and which are 
extremely unlikely to occur by accident which would do just as well).  Then 
we could have a magic entry for it which would allow easy display of the 
version number, the number of items in the object context array, etc.

Basically this would allow us to save lots of people all the effort of 
reading through source code that I just went through before realising that I 
was compiling against the old header file.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
