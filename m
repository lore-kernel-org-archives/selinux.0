Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAH0UeRb003744
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 19:30:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAH0UBBb003150
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 00:30:11 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAH0UA4o003147
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 00:30:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: policy bug
Date: Mon, 17 Nov 2003 11:30:28 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031116133109.GE17041@vnl.com> <20031116221752.GB20445@vnl.com>
In-Reply-To: <20031116221752.GB20445@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311171130.28499.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Nov 2003 09:17, Dale Amon <amon@vnl.com> wrote:
> I think you need to put a few conditionals in later.

later.te is a file containing things I'll sort out later.  I put it in to 
allow Dan to get things working as a temporary measure.  If you run Fedora in 
a somewhat default config then later.te would work (apart from the 
double-define issue).  If you don't use Fedora then you don't want later.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
