Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA09077
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 11:56:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA22992
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 15:55:23 GMT
Received: from unicorn.lemuria.org (b116024.adsl.hansenet.de [62.109.116.24])
	by jazzswing.ncsc.mil  with ESMTP id PAA22988
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 15:55:22 GMT
Date: Fri, 13 Sep 2002 17:56:21 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: uml policy
Message-ID: <20020913175620.C3149@lemuria.org>
References: <20020912201240.B2594@lemuria.org> <200209130053.55563.russell@coker.com.au> <20020913073553.D2818@lemuria.org> <200209131101.18761.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209131101.18761.russell@coker.com.au>; from russell@coker.com.au on Fri, Sep 13, 2002 at 11:01:18AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 13, 2002 at 11:01:18AM +0200, Russell Coker wrote:
> > Definitely append only, but the problem is that they are created on
> > runtime, not like logfiles where you can assume that it exists when you
> > execute.
> 
> You can allow create and append access but no write or unlink...

Good, yeah. I guess I'll do that.


> > And they are always created in the uml dir. I'll look into the uml
> > source what exactly is hardcoded there. I would definitely prefer them
> > to be in their own subdir.
> 
> Is the fact that they are created in the UML directory interfering with the 
> policy you desire?  Or is it just a general UML usability issue?

Both, actually. If they had their own dir, I could define a type and
autotransition for that dir.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
