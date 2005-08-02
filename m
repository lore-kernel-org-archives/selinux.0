Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j722MegA022913
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2005 22:22:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j722FDVk018970
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 02:15:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jason Tang <jtang@tresys.com>
Subject: Re: [RFC] selinux management API
Date: Tue, 2 Aug 2005 12:15:49 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, gyurdiev@redhat.com,
   selinux@tycho.nsa.gov
References: <42D7CC53.9030803@tresys.com> <200507281836.06447.russell@coker.com.au> <1122919952.5842.3.camel@localhost.localdomain>
In-Reply-To: <1122919952.5842.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508021215.54459.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 August 2005 04:12, Jason Tang <jtang@tresys.com> wrote:
> > Is the plan to support binary or text modules for these operations?  If
> > binary modules then module_data should have type void *.
>
> libsemanage will handle only binary modules.  The caller is assumed to
> have invoked checkmodule beforehand.
>
> The reason why these pointers are 'char' is that we want
> byte-addressible memory.  It is true that using 'char' can be
> misleading, but alas C is deficient here.

In what situations is void * not byte addressable?

System calls such as send(2) use void * on Linux (char * on Solaris), are you 
saying that you can't send arbitrary data down a socket?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
