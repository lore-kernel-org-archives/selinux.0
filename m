Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1GoDs018271
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:17:21 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QLxklw015305
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 22:01:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 588BA61AF8
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 09:02:05 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04488-01 for <selinux@tycho.nsa.gov>;
	Sun, 27 Feb 2005 09:02:05 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D842461AE1
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 09:02:04 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tim Waugh <twaugh@redhat.com>
Subject: Re: writing zero bytes in bash
Date: Sun, 27 Feb 2005 09:01:35 +1100
Cc: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <200502261832.16337.russell@coker.com.au> <20050226175426.GJ3626@redhat.com>
In-Reply-To: <20050226175426.GJ3626@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502270901.39429.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 27 February 2005 04:54, Tim Waugh <twaugh@redhat.com> wrote:
> On Sat, Feb 26, 2005 at 06:32:13PM +1100, Russell Coker wrote:
> > To unset the fscreate or exec context you have to write zero bytes
> > to /proc/self/attr/fscreate or /proc/self/attr/exec respectively.
>
> Oh dear, really?  How badly designed.  The man page for write() says
> that writing no bytes causes write() to return 0 "without causing any
> other effect".

Is an entry under /proc a "regular file" or a "special file"?

Sym-links under /proc/*/fd are not regular sym-links, which seems to imply 
that files under /proc are not "regular files".  That seems to indicate that 
the section "the results are not portable" applies.

Alexandre has a good point though, so it seems that changing the interface 
would be a good idea.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
