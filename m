Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19889
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 17:33:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0RMX4I07744
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 22:33:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0RMX3f07740 for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 22:33:03 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E335C92738
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 09:33:00 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7FF587AEC
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 23:32:53 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: RE: C&A
Date: Mon, 27 Jan 2003 23:32:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301272332.53014.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone wrote in a private message:
> I think there might have been a misunderstanding, when I say C&A I meant in
> terms of Common Criteria C&A.

In that case there was a misunderstanding.

The project I am aware of is about certification for individuals.  I am not 
aware of any efforts to CC certify SE Linux.

The problem is that none of the commercial distributions are currently doing 
anything officially with SE Linux.  If anyone wants to CC certify my SE 
Debian work then I'd be more than happy to work with them.  But I expect that 
the people who are interested in such certification are interested in the 
commercial distributions.

Maybe there's some option for working with LSB?  IBM seems to be funding a lot 
of the LSB work as well as a lot of work for auditing of SE policy and LSM 
hooks.

Is SE Linux even ready for such certification?  The core code is all good, but 
the supporting code and utilities need improvement.  Little things like 
getting the run_init sorted out properly, sgroupadd, and more man pages can 
really make a difference.  Also there's need for more work on ensuring that 
SE Linux works with other security systems.  I presume that if you want CC 
certification then you want SNARE or SecureAudit to work with it.  I've been 
told that Snare works but I haven't heard any reports on SecureAudit which 
will probably be of more interest.

The last time the topic of CC came up someone said that SE Linux wouldn't get 
anywhere because of lack of SecureAudit or something similar.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
