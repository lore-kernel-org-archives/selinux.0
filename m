Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FCdjI4017436
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 08:39:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FCdPl5003525
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:39:25 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4FCd7Nc003510
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:39:23 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 4EC22BF54
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 22:39:09 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 20980-07
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 22:39:08 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 21906BF53
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 22:39:08 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E5251924A3
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 22:39:06 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C28031B8F
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 22:37:44 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: memory used by SE Linux
Date: Thu, 15 May 2003 22:37:44 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305152237.44225.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is some raw data about SE Linux memory use on ARM.  I haven't previously 
done any checks on i386 because my i386 machines are so big that it doesn't 
matter.  Eventually I'll probably look into i386 memory usage to compare.

All tests were done on a machine with kernel module loading disabled and 
minimal functionality.  The proceedure was to login on a serial terminal and 
run free as soon as the machine was functional.

Non-SE kernel 2.4.19-rmk6-pxa1-hh11 (just for a quick test - the differences 
between hh11 and hh12 aren't great, but I'll have to compile them both with 
the same compiler etc for a proper test).

              total         used         free       shared      buffers
  Mem:        63404        18408        44996            0            0
 Swap:            0            0            0
Total:        63404        18408        44996

Memory with SE Linux kernel 2.4.19-rmk6-pxa1-hh12-se2 but no policy:

              total         used         free       shared      buffers
  Mem:        63284        20784        42500            0            0
 Swap:            0            0            0
Total:        63284        20784        42500

So apart from the issue of different memory use by the minor kernel revision 
and the potential for different compiler having different memory use (which I 
will test tomorrow) it appears that 2376K of data may be used for SE Linux.  
This can't be right, I'll have to recompile both kernels with exactly the 
same options to re-test this.

Memory with same SE Linux kernel and 85837byte compressed (583771 byte 
uncompressed) policy:
              total         used         free       shared      buffers
  Mem:        63284        22084        41200            0            0
 Swap:            0            0            0
Total:        63284        22084        41200

It seems that 1300K is used by the active policy.  Would I be correct in 
assuming that the AVC cache would also consume more memory once the machine 
is in full operation and more domain-type combinations are in the cache?

Apart from making the policy smaller (which I am working on), is there any 
easy way of reducing the kernel memory use of SE Linux?  5% of RAM seems like 
a lot when there's no swap.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
