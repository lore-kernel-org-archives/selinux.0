Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P5UUrT003207
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 01:30:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P5TgLV019953
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 05:29:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: constraints and subtraction
Date: Wed, 25 Aug 2004 15:30:25 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux <selinux@tycho.nsa.gov>
References: <412A5BD0.8050606@tresys.com> <1093355682.1800.111.camel@moss-spartans.epoch.ncsc.mil> <200408241847.i7OIlgRp001380@turing-police.cc.vt.edu>
In-Reply-To: <200408241847.i7OIlgRp001380@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408251530.25216.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Aug 2004 04:47, Valdis.Kletnieks@vt.edu wrote:
> Given two sets F1 = {A, B, C} and F2 = {B, D}, it's unclear to me
> what The Right Thing to do for (F1-F2) is.  Should the attempt to subtract
> D throw an error, or fail silently and create {A, C}, or create the set {A,
> C, ~D}?

F1 - F2 = { A C }

~D == { A B C }, so the set { A C ~A } would not make sense.

The subtraction operator just removes things if they happen to be there.  
Items which didn't already exist mean that the removal operation is a noop.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
