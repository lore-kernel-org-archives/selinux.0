Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GB9TWt001799
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 07:09:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9GB9L0p002777
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 11:09:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9GB9Jr7002774
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 11:09:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 05DF6924F3
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 21:09:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9DB537F07C
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 21:09:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genfscon and /boot
Date: Thu, 16 Oct 2003 21:09:25 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310162109.25021.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the Red Hat kernels are compiled with Ext2 having no support for 
XATTR or ACLs.  This is convenient when dealing with boot loaders that don't 
support XATTR (such as the old Cobalt boot ROMs) as you can make /boot an 
ext2 file system and not risk making the machine unbootable.

The Sun/Cobalt people are aware of this issue and it will hopefully be 
resolved soon, but we still want a solution to this as probably not all 
hardware will get the bugs fixed soon enough.  Also some people who own 
Cobalt hardware may not desire a ROM upgrade.

Now for /boot to have appropriate labels we need genfs entries for it.  
Currently the genfs does not seem to support giving a different label to 
System.map* files (needed for ps to display the wchan and for kogd) and the 
other files (which need restricted access).  I tried the following genfs 
lines to no avail:

genfscon ext2 /                        system_u:object_r:boot_t
genfscon ext2 /System.map-             system_u:object_r:system_map_t

To get this working as desired we need to either change genfs to support 
appropriate labeling, or to change distributions to have System.map in 
another file system.  Having the System.map in a different file system may 
make sense anyway as we would probably prefer not to have /boot mounted in 
normal operation, but we do want to have System.map available all the time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
