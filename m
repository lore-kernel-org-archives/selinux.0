Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OJgYHa003328
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 15:42:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OJgXDW007365
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:42:33 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6OJgVeN007358 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:42:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Date: Thu, 24 Jul 2003 15:42:49 -0400
References: <200307231934.PAA18920@nerd-xing.mit.edu> <1059068428.1698.14.camel@columbia>
In-Reply-To: <1059068428.1698.14.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307241542.49511.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jul 2003 13:40, Colin Walters wrote:
> The thing is though that to do any kind of "useful" damage (e.g. send
> passwords back to the author), at some point the trojan is going to have

The theoretical trojan in question had one aim, to give a certain person root 
access without log entries.

You are correct that some other things could be caught by network analysis, 
but that is more difficult than it seems.  Also in SE Linux the login process 
is not permitted network access in a default config which helps.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
