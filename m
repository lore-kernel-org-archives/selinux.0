Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA10591
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 07:57:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA05561
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:55:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA05557 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:55:45 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: dontaudit
Date: Mon, 28 Oct 2002 13:57:29 +0100
References: <20021028125555.A3585@lemuria.org>
In-Reply-To: <20021028125555.A3585@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210281357.29762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Oct 2002 12:55, Tom wrote:
> Is there a way to globally turn off dontaudit ?
>
> I have a very weird problem I don't understand which doesn't give any
> error messages, so I assume that some dontaudit rule suppresses them.
> However, I don't want to go through three or four policy files, disable
> all of them, recompile, find out that it must be somewhere else and
> repeat until I'm crazy.
>
> so what is the best way to globally turn off dontaudit? grep -v
> dontaudit policy.conf  ?

grep -v ^dontaudit policy.conf > p ; mv p policy.conf ; make load

I guess it might make sense to have an entry in the Makefile to allow "make 
dontaudit" for this...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
