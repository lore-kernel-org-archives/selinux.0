Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ADrLrT027440
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 09:53:22 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ADrFP2026888
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 09:53:16 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Park Lee <parklee_sel@yahoo.com>
Subject: Re: What is dnl
Date: Thu, 10 Jun 2004 23:54:10 +1000
Cc: selinux@tycho.nsa.gov
References: <20040610131223.35208.qmail@web51505.mail.yahoo.com>
In-Reply-To: <20040610131223.35208.qmail@web51505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406102354.10417.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 23:12, Park Lee <parklee_sel@yahoo.com> wrote:
> In 'selinux-usr\policy\tunable.te', there is something like:
>
> # uncomment to allow mozilla to read files in the user home directory
> dnl define(`readhome')
> ... ...
>
> Then, what is the meaning of 'dnl'?

dnl is a M4 comment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
