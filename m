Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88DUJrT003351
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 09:30:19 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88DTKR0028332
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 13:29:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: domains/local/*.te file_contexts/local/*.fc
Date: Wed, 8 Sep 2004 23:29:56 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1094489141.3973.40.camel@wintermute.xmldesign.de> <200409072209.43296.russell@coker.com.au> <1094561496.23173.1.camel@wintermute.xmldesign.de>
In-Reply-To: <1094561496.23173.1.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409082329.56168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Sep 2004 22:51, Erich Schubert <erich@debian.org> wrote:
> > Why not use domains/misc and file_contexts/misc?  They do everything you
> > seem to want to do.
>
> I used to, but they are loaded before the other rules. Which is a
> problem for file contexts: for example i cannot use a different context
> for something in /usr/local/sbin when i place the rule in
> file_contexts/misc/local.fc - it will be overridden by the other file
> contexts.

OK, maybe we should just change that to have file_contexts/misc/* included 
last.  What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
