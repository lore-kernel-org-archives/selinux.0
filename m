Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16072
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 08:50:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA24785
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:47:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA24780
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:47:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Apache/mysql policy status ?
Date: Mon, 20 Jan 2003 14:49:58 +0100
References: <20030120121252.B28086@lemuria.org>
In-Reply-To: <20030120121252.B28086@lemuria.org>
Cc: bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301201449.58572.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Jan 2003 12:12, Tom wrote:
> I'm a bit confused about the current state of the two policies I've
> worked on. Are they merged with
> a) the CVS tree

Yes.

> b) the Debian default policy?
>
> I'm asking because I just noticed that the woody default policy doesn't
> seem to use them. Was it only merged with sid?

The policy for woody as packaged by Brian should be the same as my policy.  
Brian has been sending patches to me which I include in my policy.  Brian 
periodically updates his policy package to my latest package.

Incidentally I've already packaged the new NSA release, Brian, have you 
back-ported it yet?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
