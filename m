Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA06642
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:00:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA22446
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 01:59:54 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil  with ESMTP id BAA22442
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 01:59:53 GMT
Date: Tue, 24 Jul 2001 22:02:59 -0400 (EDT)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Steve Eckmann <eckmann@computer.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: 8.3 filenames
In-Reply-To: <4.3.2.7.2.20010724165057.00a965d0@mail1.abac.com>
Message-ID: <Pine.LNX.4.30.0107242201140.16596-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Jul 2001, Steve Eckmann wrote:

> My selinux kernel displays only 8.3 filenames for floppy and cdrom
> drives, but non-selinux kernels display "longnames". I've encountered
> this anomaly with every selinux installation that I've tried, over
> RH6.2 and RH7.1. I've built a lot of linux kernels and haven't seen
> this problem before. I guess I'm doing something wrong with filesystem
> configuration, but what?

cat /proc/filesystems. you probably want vfat, iso9660, and such ... those
are built based on kernel configurations. you can build them as modules
now if you still have your kernel config lying around. make xconfig and in
filesystems chose 'module' for each of those, then make modules_install
for your kernel .. then insmod 'em.

should be relatively easy.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
