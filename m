Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1N4ZjRb015154
	for <selinux@tycho.nsa.gov>; Sun, 22 Feb 2004 23:35:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1N4ZiQQ011786
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 04:35:44 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1N4ZgP0011783 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 04:35:43 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id CB8C861BD2
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 15:35:28 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04731-03 for <selinux@tycho.nsa.gov>;
	Mon, 23 Feb 2004 15:35:28 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 6090A61BA7
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 15:35:28 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5BDE7B5870
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 15:35:27 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: identity
Date: Mon, 23 Feb 2004 15:35:26 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200402231535.26738.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One of the benefits of the SE Linux identity is that it tracks the originating 
user through all operations that they perform.

With the user_u identity the utility of the identity for logging user 
activities is reduced.

Some people are talking about ways of tracking the source IP address for a ssh 
connection or other information on the login through user sessions in a 
similar manner.

It seems to me that we would gain a benefit if we had two parts to the 
identity string, the user-name that is compiled into the policy (and checked 
in the constraints file etc), and an arbitary string set by the login program 
or other equally privileged processes to be used for logging.

The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate that 
I logged in from IP address 10.0.0.1.

Steve, what do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
