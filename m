Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6PDbLHa006345
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 09:37:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6PDbKDW029866
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 13:37:20 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6PDbCeN029856 for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 13:37:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Paul L. Allen" <paul.l.allen@boeing.com>, selinux@tycho.nsa.gov
Subject: Re: 2003071106 on RH 7.2
Date: Fri, 25 Jul 2003 09:37:30 -0400
References: <3F209F03.60900@boeing.com>
In-Reply-To: <3F209F03.60900@boeing.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307250937.30020.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jul 2003 23:07, Paul L. Allen wrote:
> It went a bit farther, but then stopped with this complaint:
>
> ERROR 'unknown type system_mail_t' at token ';' on line 28350

I tried to reproduce this and it seemed to work fine.

Please gzip the policy.conf file and put it on a web server where I can get a 
copy.  Also tell me about any changes you may have made.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
