Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13651
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 16:11:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2DLB5PC016574
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:11:05 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2DLB35x016565 for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:11:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 81607BF3D
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 08:10:51 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 1DA72BF37
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 08:10:50 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B78779247D
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2003 08:10:50 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 752BF747B
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 22:10:41 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: logging messages
Date: Thu, 13 Mar 2003 22:10:40 +0100
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303132210.40371.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

People have been asking how to turn off the SE Linux console messages (it gets 
annoying having thousands of messages scrolling by while you're trying to fix 
a problem).

The following command will direct all messages of default priority away from 
the console.  The default is "7 4 1 7".  The second number is the priority of 
default messages, setting it to 7 makes default messages of too low a 
priority to be on the console.
echo "7 7 1 7" > /proc/sys/kernel/printk

It would be good if we had a tunable option in SE Linux to specify the
priority of the messages.

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
