Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0T8nZXf022761
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 03:49:38 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0T8nV0a008391
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 08:49:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DEC7E61B08
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 19:49:28 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21911-07 for <selinux@tycho.nsa.gov>;
	Sun, 29 Jan 2006 19:49:28 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A55EF61B0A
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 19:49:27 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id DD275A80AA
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 12:17:14 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <selinux@tycho.nsa.gov>
Subject: labeling of compilers etc
Date: Sun, 29 Jan 2006 11:56:05 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601291156.13076.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In many discussions about hardening systems the idea is suggested that 
machines should not have compilers unless they are development machines.

It would not be difficult to label compilers as compiler_exec_t and only 
permit user domains the ability to execute files of such type (daemons don't 
need to compile software).  What do you think of this idea?  Maybe we would 
want to have a more generic type such as devel_exec_t and label programs such 
as gdb with it as well.

Also interpreters could be modified to provide similar benefits.  Currently 
many (most?) shell interpreters try to detect and prevent setuid operation 
with code roughly equivalent to if(getuid() != geteuid()) seteuid(getuid).  
Bash currently has such code (just done a quick test) and other shells had 
such cost in place last time I tested them.  I believe that this establishes 
a precedent for shell interpreters to check for and prevent insecure modes of 
operation.

A logical extension of this precedent to SE Linux would be to have it check 
the type of a file to be executed and confirm that the current domain is 
permitted to execute scripts of the type in question, for a regular file it 
would get the context (after opening it) and ask SE Linux whether the current 
context has execute access for the file class.  For a character device node 
(IE stdin but let's not assume that's the only device to be used) it would 
check for execute access of class chr_file for the context in question.  Does 
it even make sense to execute a block device node as a shell script?

In some mailing lists related to SE Linux it's been mentioned that people 
desire these features.  I believe that I have come up with a reasonable 
design to solve the problems in question.  If it's considered worth-while 
then I'm willing to write a policy patch for the first one and a bash patch 
for the second one.

Also it should be noted that if the perl interpreter is setuid then it'll 
happily do things as the EUID, this means that we have no good precedent to 
rely on in this case.  This doesn't stop us, just means that the chance of 
getting code accepted upstream is dramatically reduced.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
