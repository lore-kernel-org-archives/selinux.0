Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97FC5Wt012045
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 11:12:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97FC30p006332
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:12:03 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h97FC2r7006313
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:12:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: init
Date: Wed, 8 Oct 2003 01:11:50 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310080111.50210.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have been having a discussion of initrd etc.  There is some great 
opposition to modifying the initrd because it's something that no-one wants 
changed much (for a variety of support reasons).  Also some systems do not 
support initrd's (EG the Sun/Cobalt Qube/RaQ hardware which has a Linux 
kernel in the BIOS which can read an Ext2/Ext3 file system and load a kernel 
- they never wrote code for loading an initrd).

An idea that came up was to modify init so that it would do the following:
1) Check if /selinux is mounted.  If yes then go to 5.
2) mount /selinux, if mount fails then go to 5.
3) Load the policy from /etc/selinux/policy.xx.  If load fails then umount
/selinux, display a message, and go to 5.
4) Exec itself to change domain from kernel_t to init_t.
5) Perform usual init functions.

This seems to work well.  I have very similar things implemented in shell 
scripts working on a Qube and on a UML virtual machine.

Steve, do you think that this is an acceptable change for a distribution?  Or 
are there some potential problems that we should consider?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
