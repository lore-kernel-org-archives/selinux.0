Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06578
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 15:45:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1CKjbI10937
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 20:45:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1CKjaf10927 for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 20:45:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Simple question
Date: Wed, 12 Feb 2003 21:45:25 +0100
References: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302122145.25437.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Feb 2003 19:32, j.logsdon@lancaster.ac.uk wrote:
> In general terms, what does SEL do that I can't do (even if more
> complicated) by Access Control Lists?  If I can control the users and
> groups that can access files (and these are all properly set) what
> advantage do I have in running SEL?

Jesse's answer is a good one.

Here's a practical example.  BIND needs root access to bind() to port 53 and 
dhcpd needs root access to get raw network access.  On a default Linux system 
either of those programs can read and write every file on the system if they 
are compromised, and both of them have been compromised in the past...

With SE Linux dhcpd runs in domain dhcpd_t and BIND runs in named_t, these 
domains offer very limited access to the system, they can't kill user 
processes, they can't access home directories, they can't read /etc/shadow, 
etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
