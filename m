Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA29021
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 16:49:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA06319
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 21:47:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA06315
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 21:47:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: can_network()
Date: Thu, 7 Nov 2002 22:48:59 +0100
References: <200211072005.PAA07338@moss-shockers.ncsc.mil>
In-Reply-To: <200211072005.PAA07338@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211072248.59253.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Nov 2002 21:05, Stephen D. Smalley wrote:
> > speaking of that, shouldn't there be an every_domain_except_network
> > domain? I'd love to use every_domain instead of all the lower macros,
> > but it includes can_network(), which I don't want.
>
> The goal is to largely eliminate the use of coarse-grained macros like
> every_domain() [and even its immediate "children"], replacing them with
> much finer-grained macros and/or individual rules to provide true least
> privilege.  Naturally, this will have a cost in terms of maintaining the
> policy.

So do you think that can_network() needs to be broken up?

I guess this means you don't like my idea for adding an allow resolv_conf_t to 
it then...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
