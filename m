Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA22478
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 05:14:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA20918
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 10:13:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA20914 for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 10:12:59 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: wakkerma@debian.org
Subject: straceing SE Linux
Date: Wed, 27 Feb 2002 10:47:02 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020227101339.9FAA5F8E3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm working on hacking strace to trace LSM system calls as used by SE Linux.

Firstly what name should I use to refer to this syscall?  lsm() as the 
library code uses or security() after the sys_security() definition in the 
kernel?

The next issue is that there is one system call defined for LSM (number 223 
on Intel).  The first parameter of this call is the id of the security 
service to manage.  I would like to display selinux() for a SE system call 
lids() for a LIDS call, etc.  However it seems that this would require a 
change to the strace structure.

Should I do so, or am I on the wrong track by wanting to display these as 
different function calls depending on the id parameter?

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
