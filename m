Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IEUnRb001969
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:30:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IEUjAR023542
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:30:46 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IEUiHn023430 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:30:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Date: Wed, 19 May 2004 00:29:31 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040518104026.GC24333@lkcl.net> <20040518125633.GA24917@lkcl.net>
In-Reply-To: <20040518125633.GA24917@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190029.31893.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 22:56, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> domains/programs/localstuff.te

Use domains/misc/localstuff.te .  Anything in domains/programs needs a 
matching .fc file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
