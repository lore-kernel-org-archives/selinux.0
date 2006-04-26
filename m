Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3Q8SSNh010843
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 04:28:29 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3Q8SPvp016480
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 08:28:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6142961B09
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 18:28:23 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16736-05 for <selinux@tycho.nsa.gov>;
	Wed, 26 Apr 2006 18:28:23 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8C11B61B03
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 18:28:22 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 14B61A7E9A
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 18:28:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: getfscreatecon(3)
Date: Wed, 26 Apr 2006 13:37:47 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604261337.50730.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RETURN VALUE
       On error -1 is returned.

       On success getfscreatecon  returns  the  length  of  the  context  (not
       including  the  trailing zero byte).  On success setfscreatecon returns
       0.


Currently getfscreatecon() returns 0 on success.  Should we change the man 
page or change the library?

I think that it would be best to change the library.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
