Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12119
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 10:22:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA12532
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 14:20:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA12520 for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 14:20:35 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2DCB592467
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 00:22:10 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A62EA794D
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 16:22:02 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: limiting types on a file system
Date: Wed, 25 Sep 2002 16:22:02 +0200
MIME-Version: 1.0
Message-Id: <200209251622.02323.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have mount options nosuid and nodev that make it safe to use an ext2 file 
system on removable media with automount.

With SE Linux we can't allow automount of ext2 etc file systems, as we can't 
allow arbitary type selection by the user who is in posession of the floppy 
disk or cd-rom.  Also this means that we can't allow -fstype=auto...

Before someone says "but that's a security issue", well if you have access to 
the floppy drive you're probably fairly trusted anyway, and there are degrees 
of security (no point totally wiping out security on machines that need 
access to floppy disks).

I was thinking, that if we could specify a limited range of types for a file 
system based on the domain of the process that is mounting it, and the type 
(if any) of the device that is being mounted then we would be able to 
adequately control this.

Maybe something like the following:
type_transition user_mount_t removable_device_t:filesystem { user_home_dir_t 
user_home_t };

Then any types other than those two would appear as unlabelled_t.  Of course 
the problem with this is that if you use chsid to change the type of a file 
(or create a file with Netscape) then it'll effectively disappear at the next 
mount!  Unless the domain used to mount the file system is tracked right 
through (which is ugly).

Also something to be concerned about is that if the constraints allow some 
identity on the file to have greater rights than the user in question (IE if 
I'm logged in as identity "rjc" then I get greater rights to a file with 
identity "foo" than a file with identity "rjc") then the user can gain that - 
but surely no-one would be crazy enough to do this?!?!

Maybe just being able to force a single type (similar to the uid= and gid= 
options for mounting some file systems) would be the easiest solution.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
