Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11747
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 18:05:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA20918
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 23:02:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA20914
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 23:02:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 66A0492666
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 10:05:00 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A60003659
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 00:04:52 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: propolice and other stack-smashing protections
Date: Mon, 27 Jan 2003 00:04:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301270004.51912.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.trl.ibm.com/projects/security/ssp/
Is anyone using stack-protection mechanisms such as propolice (URL above) in 
conjunction with SE Linux?

Propolice should work as well with SE Linux as it does with any other code of 
course.  But it will be interesting to know whether it is actually being 
used.

Also I would be interested in a comment from one of the NSA people regarding 
the worth of stack-protection tools on SE Linux.  The issues of course are 
that "defence in depth" is always a good thing, and that SE Linux controls 
the access of programs so much that the need for such tools is vastly 
reduced.  I am not expecting a clear yes/no answer.  ;)

Another issue is that I recall that one of the stack smashing routines was 
based on the process sending a "kill -9" to itself.  If such things are 
common then we should consider auditing the sample policy to ensure that 
every process is able to "kill -9" itself.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
