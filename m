Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4J36HRb007238
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 23:06:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4J33qB2016429
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 03:03:52 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4J33pwi016389
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 03:03:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: audit2allow successfully got rid of the avc errors
Date: Wed, 19 May 2004 13:04:55 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040518203646.GD7348@lkcl.net>
In-Reply-To: <20040518203646.GD7348@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405191304.55099.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 06:36, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> ... is there any way of adding in version detection, to throw up a
> really blatant and repetitive in-yer-face warning, say, on every
> single avc message, that says something along the lines of
> "your policy version is 17, this kernel supports version 15;
> your userspace tools were built with kernel version 2.6.4, this
> is kernel version 2.6.6; you can expect some things to fail.
> go away and rebuild".

That is not required.  I think that I have tested all viable combinations of 
kernel and policy version and never had a problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
