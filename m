Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA04854
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 07:57:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19737
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 12:54:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA19733
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 12:54:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Accounting ...
Date: Wed, 22 Jan 2003 13:57:16 +0100
References: <Pine.LNX.4.10.10301221218030.8352-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10301221218030.8352-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301221357.16037.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Jan 2003 13:31, j.logsdon@lancaster.ac.uk wrote:
> It strikes me that SE Linux can also answer another question re
> accounting.  Since each program can have it's domain, when it is executed
> it should be possible to calculate the usage as opposed to the usual Unix
> acct approach which considers all programs to be the same.  Thus use of
> individual programs can be monitored.

Last time such issues were discussed the NSA people didn't seem to be 
interested in controlling or monitoring resource usage through SE Linux.

You could easily monitor which processes are executed by using auditallow 
rules, but that won't tell you how much elapsed time and CPU time is 
involved.

The Secure Auditing for Linux project may interest you.  I haven't looked at 
it closely due to lack of time, but I think that it extends the range of 
things that the kernel logs as well as using encryption to make sure that the 
logs can not be easily faked.
http://secureaudit.sourceforge.net/

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
