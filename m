Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA18498
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 17:42:22 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 23:42:11 +0200
Cc: Tracy R Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
References: <20021001153638.J5416@ultraviolet.org> <200210021054.16283.russell@coker.com.au> <20021002213137.GC30007@snoopy.apana.org.au>
In-Reply-To: <20021002213137.GC30007@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200210022342.11159.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 23:31, Brian May wrote:
> On Wed, Oct 02, 2002 at 10:54:16AM +0200, Russell Coker wrote:
> > That was removed in the last NSA release (over a month ago).  Check the
> > list archives, it was discussed on the list at the time.
>
> Why is domains/program/devfsd.te still using it then?

It isn't.

The package selinux-policy-default_2002082308-3_all.deb that I released didn't 
have it, neither did selinux-policy-default_2002082308-1_all.deb , and it's 
not in the CVS.

Maybe there's another bug in the Debian diff generation?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
