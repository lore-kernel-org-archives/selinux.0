Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1GoDu018271
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:17:21 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QLl5lw015067
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 21:48:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 96E1C61AF8
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 08:49:23 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02987-08 for <selinux@tycho.nsa.gov>;
	Sun, 27 Feb 2005 08:49:23 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 37B2561AE1
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 08:49:23 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: writing zero bytes in bash
Date: Sun, 27 Feb 2005 08:48:57 +1100
Cc: fedora-devel-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
References: <200502261832.16337.russell@coker.com.au> <200502262139.45861.russell@coker.com.au> <or7jkvp1cm.fsf@livre.redhat.lsd.ic.unicamp.br>
In-Reply-To: <or7jkvp1cm.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502270849.01464.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 27 February 2005 06:28, Alexandre Oliva <aoliva@redhat.com> wrote:
> On Feb 26, 2005, Russell Coker <russell@coker.com.au> wrote:
> > Actually I am not asking for a feature to be added, but for a feature to
> > be removed.  There is special-case code in bash if(size >0) write() and I
> > am merely suggesting that the if statement be removed.
>
> Have you considered that it might just be writing to a FILE*, and that
> it's the stdio subsystem that's deciding it doesn't need to write
> anything at close() time because nothing was actually written?

Good point.  A quick test program shows that fwrite() doesn't support writing 
zero bytes.

In that case we have a choice between having a change in the interface (such 
as supporting the writing of "\n" for an empty setting), or just leaving such 
operations as being impossible in shell scripts.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
