Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i847morT012940
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 03:48:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i847lvAJ013987
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 07:47:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: [idea] file contexts "alternate" keyword
Date: Sat, 4 Sep 2004 17:48:38 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040903165723.GA31857@lkcl.net> <20040903205348.GA4084@lkcl.net> <1094258021.29689.32.camel@wintermute.xmldesign.de>
In-Reply-To: <1094258021.29689.32.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409041748.38442.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Sep 2004 10:33, Erich Schubert <erich@debian.org> wrote:
> But this brings me to a different issue:
> How about allowing multiple contexts for file_contexts?
> Like the first hit being the default context, subsequent hits being
> additional contexts that will not be *CHANGED* by setfiles?

The current method is that the last "hit" is the one that is applied.

> Let's say i'm running a web server, my standard http files have a non-
> executable context. When i install a cgi i chcon it manually to
> an executable context (having a different role than the web server

This sounds like a reasonable feature request.  But we need a good way of 
implementing it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
