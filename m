Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB52UCRb002192
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 21:30:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB52TWlU013829
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 02:29:32 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB52TRSX013826
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 02:29:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinuxfaq@crypt.gen.nz
Subject: FAQ updates
Date: Fri, 5 Dec 2003 13:30:03 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200312051330.03524.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The version of your FAQ on Sourceforge is dated 4 July, the version on your 
site is dated 17 October.  People on the IRC channel are using sourceforge, 
so it would be good if SF could be updated to the latest version.

Also the documentation on my play machine is way out of date (by about 9 
months).  Please change the FAQ to just refer to the web site as I plan to 
change the password periodically and I don't want to force you to change your 
site every time.

I suggest adding the following, I've CC'd the list to get any other input.

Should I use 2.4 or 2.6 kernel?
If you use the old SE Linux (which has a ...security directory to store the 
file types) then you have to use a 2.4 kernel, there are no plans to port the 
old SE Linux to 2.6.x kernels.  The new SE Linux uses XATTR's to store the 
file types, it was originally written for 2.5 kernels and is now in the 2.6 
tree that Linus ships.  It has been back-ported to 2.4 kernels.

It is recommended that you do not upgrade from a 2.4.x kernel without SE Linux 
to a 2.6 kernel with SE Linux.  If you do that and something goes wrong you 
won't know whether it's a kernel issue or a SE Linux issue.  If you plan to 
use SE Linux on a 2.6 kernel then I suggest that you upgrade to a 2.6 kernel 
first and contact your local Linux Users' Group if you have problems.  Then 
once you have 2.6 running well you can enable SE Linux and ask the SE Linux 
mailing list about any problems that you have.

The old SE Linux has been tested more extensively and is not changing as fast 
as the new SE Linux.  However support for the old SE Linux is being decreased 
and may cease entirely in the near future.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
