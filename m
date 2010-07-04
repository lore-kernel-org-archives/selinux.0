Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o64BffjH005627
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2010 07:41:41 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o64BhTMe019901
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2010 11:43:30 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6791618184
	for <selinux@tycho.nsa.gov>; Sun,  4 Jul 2010 21:41:35 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: deduplication and SE virtual machines
Date: Sun, 4 Jul 2010 21:41:33 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007042141.34168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Are there any good software-only (IE nothing expensive like NetApp) options 
for deduplication of SE Linux virtual machine images?

A basic LVM writable snapshot allows creating a SE Linux test image with less 
disk space used.  When LVM is used for Xen does the Dom0 do any caching?  
Ideally we would have the Dom0 do read-caching of the read-only device.

http://micolous.id.au/archives/2010/01/23/linux-iscsi-cow-images-and-windows-
integration/

Apparently dmsetup supports COW images, the man page on my system doesn't 
document it so maybe I would need a newer version.  I'm not sure what benefit 
this would give over LVM snapshots given that LVM does it's stuff on top of DM 
anyway.

http://user-mode-linux.sourceforge.net/old/UserModeLinux-HOWTO-7.html

A COW block device for User-Mode Linux does the same thing but possibly works 
better with caching, the above URL documents UML COW as giving performance 
improvements but I'm unsure of LVM.

Are there any others?


I'm thinking of setting up a Linux virtual machine server for SE Linux 
training, and with most COW setups the initial relabel of the filesystem will 
put all the meta-data into a separate copy.  So ideally there would be a way 
of deduplicating this.  Also there's no guarantee that the disk blocks used 
would be the same so a simple un-COW operation on LVM or something probably 
wouldn't be a viable option.

I believe that NetApp does this well, but there's no chance of getting that 
sort of hardware.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
