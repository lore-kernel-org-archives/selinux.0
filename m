Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87C9mrT025526
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:09:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87C9jll006926
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:09:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: domains/local/*.te file_contexts/local/*.fc
Date: Tue, 7 Sep 2004 22:09:43 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1094489141.3973.40.camel@wintermute.xmldesign.de>
In-Reply-To: <1094489141.3973.40.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409072209.43296.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Sep 2004 02:45, Erich Schubert <erich@debian.org> wrote:
> Hi,
> the patch below adds support for domains/local/*.te and
> file_contexts/local/*.fc to the Makefile.
>
> I prefer having my local policy modifications in there, instead of
> cluttering the "programs" part.

Why not use domains/misc and file_contexts/misc?  They do everything you seem 
to want to do.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
