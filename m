Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9TDG3OT011195
	for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2009 09:16:04 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9TDHqsH003756
	for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2009 13:17:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 320BB18123
	for <selinux@tycho.nsa.gov>; Fri, 30 Oct 2009 00:15:57 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: assigning context to disk on Debian/Lenny
Date: Fri, 30 Oct 2009 00:15:54 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200910300015.55817.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a Debian/Lenny system with the latest updates running kernel 
2.6.26-2-xen-686 with the Ext3 filesystem I have discovered a problem with 
assigning the context to files.

If I create a file with "cat /dev/zero > /tmp/foo" then the file on disk 
doesn't seem to get it's label written before umount.  So I can create the 
file, run "sync" a couple of times, then mount an LVM snapshot of the 
filesystem and discover it labelled as file_t.  Or if I reboot the system (EG 
by triggering a watchdog timer) then the system will boot up with the file 
unlabelled.

So someone who can fill a filesystem and trigger then a reboot (through a 
watchdog timer or through a DoS attack that causes someone to press reset) 
can cause an unlabelled file to appear.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
