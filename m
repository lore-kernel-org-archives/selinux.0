Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10905
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 08:38:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA07552
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:37:02 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id NAA07548 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:37:01 GMT
Date: Mon, 28 Oct 2002 14:38:55 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: dontaudit
Message-ID: <20021028143854.A5399@lemuria.org>
References: <20021028125555.A3585@lemuria.org> <200210281357.29762.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210281357.29762.russell@coker.com.au>; from russell@coker.com.au on Mon, Oct 28, 2002 at 01:57:29PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 28, 2002 at 01:57:29PM +0100, Russell Coker wrote:
> > so what is the best way to globally turn off dontaudit? grep -v
> > dontaudit policy.conf  ?
> 
> grep -v ^dontaudit policy.conf > p ; mv p policy.conf ; make load
> 
> I guess it might make sense to have an entry in the Makefile to allow "make 
> dontaudit" for this...

Actually, the more I work with policies the more I want various
policies, i.e. "create a new one but keep the old". Should be possible
right now with some manual work, but something like Lilo where you can
also boot from a choice of kernels would be better.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
