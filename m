Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SE0dgA021179
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 10:00:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SDrwcq006982
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 13:53:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [RFC] selinux management API
Date: Thu, 28 Jul 2005 23:54:44 +1000
Cc: gyurdiev@redhat.com, selinux@tycho.nsa.gov
References: <42D7CC53.9030803@tresys.com> <200507281836.06447.russell@coker.com.au> <42E8E10C.70205@tresys.com>
In-Reply-To: <42E8E10C.70205@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200507282354.49190.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 July 2005 23:43, Joshua Brindle <jbrindle@tresys.com> wrote:
> >Also more liberal use of const would be good.  I expect that the above
> >functions will not change the module data so const void * would probably
> > be the correct type.  I realise that this is still in the design phase,
> > but I think that we are ready to design which data gets modified by the
> > library code and which doesn't.
>
> sure but only if it doesn't ripple throughout the rest of the library

It would only ripple throughout the rest of the library if necessary.

If a function has a const parameter and then passes that parameter to another 
function then either the second function needs a const parameter or the data 
must be copied.  This is a feature not a bug!

When my code passes data to a library function via a const pointer then I know 
that (as long as there are no bugs in the library) the data will not be 
modified.  If the pointer is not const then it may be modified and my program 
has to correctly manage the situation where it is changed.

If the code is designed well then using const in all the places that the 
design suggests it will not be difficult or complex.  If the code is badly 
designed then it needs a better design.  In either case there is no reason 
for not using const!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
