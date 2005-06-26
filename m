Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QGcqgA018731
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 12:38:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QGbrqP010648
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 16:37:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 02:38:21 +1000
Cc: selinux@tycho.nsa.gov
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com> <42BD7A43.909@tresys.com> <1119728228.13078.34.camel@localhost.localdomain>
In-Reply-To: <1119728228.13078.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506270238.24851.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 26 June 2005 05:37, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > The biggest challenge after this is labeling, how to label home
> > directories
>
> How to label the home directories?
> Will directories keep their role-dependent contexts?

Yes.  Only the identity of the home directories will have to change.  This 
means of course that genhomedircon needs to be updated to know how to map 
Unix account names to SE Linux identities, that shouldn't be difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
