Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA29302
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 04:01:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA07260
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 08:57:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA07256
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 08:57:50 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id D39E39258D
	for <selinux@tycho.nsa.gov>; Mon,  3 Mar 2003 20:00:48 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 45EE07C62
	for <selinux@tycho.nsa.gov>; Sat,  1 Mar 2003 18:51:32 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE play machine
Date: Sat, 1 Mar 2003 18:51:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303011851.31023.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone claimed to have "0wn3d" the machine.  They wrote a perl script that 
did a "kill -9" on any process for a user that wasn't logged in from their 
machine.

That this "worked" is no great surprise, when you have several people logging 
into the same account with the same privs then there's always the risk of 
someone doing that.


Also I have noticed a couple of people trying to run X sessions from the play 
machine!  In one case the user didn't realise that their ssh client had a 
default configuration that permitted X tunneling, in another case the user 
was deliberately trying to run an xterm on the box and tried several 
different ways of doing it.

For reference, when you encounter someone who doesn't believe that X 
forwarding is a security issue then you can install imagemagick and run 
"import -window root file.jpg" to create a copy of what's on their screen to 
show one part of the problem (the other part is reading the keyboard - for 
which I have not found a conveniant demonstration program).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
