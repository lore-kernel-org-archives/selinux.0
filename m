Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBN2aLRb025132
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 21:36:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBN2aKpn003580
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 02:36:20 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBN2a8ab003554 for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 02:36:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Sun/Cobalt SE Linux support
Date: Tue, 23 Dec 2003 13:34:42 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200312231334.42654.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://sourceforge.net/project/showfiles.php?group_id=83123&release_id=203159
The above URL contains boot ROM images for Sun/Cobalt machines (Qube and RaQ 
server appliances).  The ROM images contain a Linux kernel which will be used 
for booting if a kernel can not be loaded from the hard disk (for system 
recovery usually), the ones with "SE" in the name contain a SE Linux kernel.

Unfortunately they don't work on my system (Qube 3), but they apparently work 
on RaQ machines.

http://cobalt.iceblink.org/debian/binary
The above URL contains Debian packages of kernels for Cobalt machines.  This 
includes a kernel with SE Linux (but the capability module is not compiled 
in).

Thanks to Duncan L. of Sun for his good work on this.  Hopefully with the next 
revision of his packages I will be able to rely on his kernel images for my 
SE Linux Qube and RaQ machines.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
