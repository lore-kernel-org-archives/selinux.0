Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9TFSOWt007391
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 10:28:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9TFS7Uf012375
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:28:07 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
	by jazzswing.ncsc.mil  with ESMTP id h9TFS5tU012372
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:28:07 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C653A7F01D
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 02:27:27 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Diamond Rio 500 and other device nodes
Date: Thu, 30 Oct 2003 02:27:27 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310300227.27364.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What do you think is the correct type for the device node for the "Diamond Rio 
500" (/dev/usb/rio500)?

It's a portable MP3 player and storage device with a USB interface, so I think 
that removable_device_t is appropriate, in concept it's similar to a floppy 
disk drive.

Also I've used scanner_device_t for USB digital cameras, I think of a camera 
as a portable scanner.  ;)  But I guess a case could be made for considering 
digital cameras to be removable storage.


I have been considering whether I should merge the v4l_device_t device nodes 
with those for scanners.  However I think that although the concept is the 
same the likely use is different.  Having one program to use v4l to control a 
security system while another program acts as a scanner server is likely, 
while it's likely that a program which is authorised for accessing a scanner 
will also be authorised for digital cameras.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
