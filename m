Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1TFDo018509
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:29:15 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1Q82eGK010987
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 08:03:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B273E61B03
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 19:02:40 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14128-03 for <selinux@tycho.nsa.gov>;
	Sat, 26 Feb 2005 19:02:40 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 424F461AFE
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 19:02:40 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-devel-list@redhat.com
Subject: writing zero bytes in bash
Date: Sat, 26 Feb 2005 18:32:13 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502261832.16337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is intentionally sent to the fedora-devel-list and the SE Linux 
list not the fedora-selinux-list.  It is not related to Fedora specific SE 
Linux functionality, but it is related to bash (a core part of Fedora) and SE 
Linux kernel code.

To unset the fscreate or exec context you have to write zero bytes 
to /proc/self/attr/fscreate or /proc/self/attr/exec respectively.

If you want to do this in a shell script you would do something like:
echo -n "" > /proc/self/attr/fscreate

However that shell command results in bash (both the version in rawhide and 
the version in RHEL4) performing the following system calls:

open("/proc/self/attr/exec", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
fcntl64(1, F_GETFD)                     = 0
fcntl64(1, F_DUPFD, 10)                 = 10
fcntl64(1, F_GETFD)                     = 0
fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
dup2(3, 1)                              = 1
close(3)                                = 0
dup2(10, 1)                             = 1
fcntl64(10, F_GETFD)                    = 0x1 (flags FD_CLOEXEC)
close(10)                               = 0

It opens the file with O_CREAT (so if you were to do `echo -n "" > /tmp/flag` 
to create a flag file then it would work as expected), but never calls the 
write(2) system call.

To unset the fscreate or exec context you have to call write(fd, X, 0) (the 
value of X doesn't seem to matter as the kernel code doesn't dereference it).

It seems likely to me that there may be other bits of kernel code exporting an 
interface under /proc where a write of 0 bytes may have a different meaning 
to merely opening a file with write access and then closing it.

So it seems reasonable to me to consider this to be a bug in bash where it's 
optimisation of shell code results in the action requested by the user not 
being performed correctly.

It took a surprising amount of time for me to realise that bash wasn't doing 
what I expected of it and ran strace to prove it.  I expect that most 
sys-admins would take even longer to work it out (if they ever did).

I expect that the bash developers may disagree with this assessment so I would 
like some more input on the lists before I file a bug report.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
