Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8CJlFNs016009
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 15:47:15 -0400 (EDT)
Received: from smtp1-g19.free.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8CJiVl1025785
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 19:44:32 GMT
Received: from [172.16.3.24] (mail.epinetworx.com [82.224.217.20])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DC9542EA61
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 21:44:32 +0200 (CEST)
Message-ID: <4325DE1A.2000408@9online.fr>
Date: Mon, 12 Sep 2005 21:59:22 +0200
From: Pierre <pierre42d@9online.fr>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problem compiling libselinux 1.26
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

# make
make -C src
make[1]: Entering directory `/tmp/libselinux-1.26/src'
gcc -s -O3 -march=i686 -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-c -o fgetfilecon.o fgetfilecon.c
fgetfilecon.c:6:23: sys/xattr.h: No such file or directory
make[1]: *** [fgetfilecon.o] Error 1
make[1]: Leaving directory `/tmp/libselinux-1.26/src'
make: *** [all] Error 2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
