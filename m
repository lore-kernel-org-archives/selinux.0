Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h827KCLa013361
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 03:20:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h827IepQ024391
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 07:18:40 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h827IdQX024380
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 07:18:40 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 3559ABF3C
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:20:02 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24622-01 for <selinux@tycho.nsa.gov>;
 Tue,  2 Sep 2003 17:20:00 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 200F5BF29
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:20:00 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 12A6A926F8
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:19:58 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 83D197F002
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:20:04 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new SE Linux and avc messages
Date: Tue, 2 Sep 2003 17:20:04 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309021720.04027.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that the new SE Linux on 2.4.21 has less informative AVC messages 
from the kernel than old-style SE Linux.  It seems that the name of the file 
that is related to the AVC message is almost never included in the message.

Steve, is there any chance of getting this changed?  Doing a "find / -inum" to 
track down the file in question is rather time consuming with ~200,000 files 
in the file system (this is something I do all the time when writing policy).

Also for production environments, having several million files in a file 
system is quite common, in some cases running find on such a system is 
operationally impossible as it drags performance down so much that the server 
is effectively off-line for the duration (which may be a really long time).

Also with the kernel watchdog (which should be installed on all servers IMHO) 
and software RAID things get even more difficult as high disk latency can 
trigger a reboot.

My point is that even if there are reasons for not wanting to do this (such as 
performance) the issues with not doing it are considerable and will likely 
out-weigh them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
