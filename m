Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FExvI4018540
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 10:59:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FExbl5010345
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 14:59:37 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4FExYNc010341
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 14:59:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: memory used by SE Linux
Date: Fri, 16 May 2003 00:58:15 +1000
References: <FD2221F5E1A8184DB61AFCE064C395F1C920C2@torexch1.mykotronx.com>
In-Reply-To: <FD2221F5E1A8184DB61AFCE064C395F1C920C2@torexch1.mykotronx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305160058.15251.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

BCC'd to you and sent to the list for general reference.

On Fri, 16 May 2003 00:52, anonymous wrote:
> Can we use this ARM SELinux port on Xscale processors?

Absolutely.  I do all my work on Xscale machines, the price/performance ratio 
of other ARM machines doesn't seem to be nearly as good so Xscale is the one 
to go for.

I expect my code not to operate on all ARM platforms, but as I haven't tested 
it on anything other than Xscale I can't be certain.

Also whenever I produce binaries they will be for Xscale, I don't think it's 
beneficial for me to produce binaries that I can't properly test.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
