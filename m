Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1A26Rb005617
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 05:02:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1A26qY028029
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 10:02:06 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB1A240o028026 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 10:02:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 584FF61BE9
	for <selinux@tycho.nsa.gov>; Mon,  1 Dec 2003 21:02:04 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28130-06 for <selinux@tycho.nsa.gov>;
	Mon, 1 Dec 2003 21:02:03 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id E481661BDA
	for <selinux@tycho.nsa.gov>; Mon,  1 Dec 2003 21:02:03 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id BDB469265F
	for <selinux@tycho.nsa.gov>; Mon,  1 Dec 2003 21:02:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 33A597F26F
	for <selinux@tycho.nsa.gov>; Mon,  1 Dec 2003 21:02:01 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles and non-SE systems
Date: Mon, 1 Dec 2003 21:02:00 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200312012102.00554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

lstat64("/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lgetxattr("/", "security.selinux", 0x84789a0, 255) = -1 EOPNOTSUPP (Operation 
no
t supported)
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0
x4001a000
_llseek(3, 0, 0xbfffe640, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(3, "/: Operation not supported\n", 27) = 27
close(3)                                = 0
munmap(0x4001a000, 4096)                = 0
write(2, "setfiles:  unable to obtain attr"..., 49) = 49

Above is part of the strace output from trying to run setfiles on a non-SE 
system (kernel 2.4.22 with the ACL patch but no SE patch).

It appears that if we had a kernel patch to provide the security.selinux name 
space as a regular xattr on non-SE systems then we could label the file 
system before installing a SE Linux kernel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
