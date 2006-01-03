Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k033BMXf013708
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 22:11:23 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k033ALYl013452
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 03:10:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7FB8F61B0E
	for <selinux@tycho.nsa.gov>; Tue,  3 Jan 2006 14:11:17 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25978-02 for <selinux@tycho.nsa.gov>;
	Tue, 3 Jan 2006 14:11:17 +1100 (EST)
Received: from temp.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1D7B961B04
	for <selinux@tycho.nsa.gov>; Tue,  3 Jan 2006 14:11:17 +1100 (EST)
Received: from temp (temp [127.0.0.1])
	by temp.coker.com.au (Postfix) with ESMTP id E6E22C7E5D
	for <selinux@tycho.nsa.gov>; Tue,  3 Jan 2006 14:11:15 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsetrans and libselinux
Date: Tue, 3 Jan 2006 14:11:01 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601031411.13500.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does it make sense to have two separate libraries for these functions?

It seems that they are both maintained by much the same group of people, will 
in many cases need updating at the same time, and will mostly be linked to by 
all the same programs, very few programs need libselinux but not libsetrans 
and that number is constantly decreasing and it's impossible to use 
libsetrans without using libselinux.

If we have a single library then there are some small optimisations that will 
occur, reducing load time and reducing the resident set size by a couple of 
pages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
