Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OBxFI4007429
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 07:59:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3OBx9Vf016354
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 11:59:09 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3OBx64D016351
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 11:59:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: grin@tolna.net, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: several wee things about exim and macros (was: please offer your good advices...)
Date: Thu, 24 Apr 2003 21:59:00 +1000
References: <20030423111231.GV3993@narya.grin.hu> <200304241329.03351.russell@coker.com.au> <20030424110015.GJ2556@narya.grin.hu>
In-Reply-To: <20030424110015.GJ2556@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304242159.00745.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Apr 2003 21:00, Peter Gervai wrote:
> > For port 53, I think that having the name always be named_port_t is the
> > correct thing to do.  It allows the possibility of running two different
> > DNS servers on different IP addresses, and also allows having the policy
> > for multiple DNS servers to be loaded at the same time to allow an easy
> > transition between server programs.  I suggest doing what was done for
> > the POP port.
>
> Sounds logical, I'll change the policy as time permits. However I'd like to
> note that port 53 is called 'domain' by /etc/services, and not 'named'.

Sounds reasonable.  Maybe we should change it to domain_port_t or something 
similar, and change the other things to match /etc/services in some way.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
