Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0L8b8Rb000090
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 03:37:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0L8Zvxr006844
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 08:35:57 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0L8ZtYc006747
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 08:35:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Chris Babcock" <cbabcock@luthresearch.com>, selinux@tycho.nsa.gov
Subject: Re: Debian and 2.6 selinux
Date: Wed, 21 Jan 2004 19:35:42 +1100
References: <1988.68.6.187.64.1074664098.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <1988.68.6.187.64.1074664098.squirrel@mxlx1.surveysavvy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401211935.42235.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jan 2004 16:48, "Chris Babcock" <cbabcock@luthresearch.com> wrote:
> Does the 2.6 version of SE work well on Debian Potato (r2) or do I need to
> run Sid to get good results with the 2.6 version?

Potato has never been supported by SE Linux.

Woody now works for the "new SE Linux" which is back-ported to 2.4.x from 
2.6.x with the following /etc/apt/sources.list line:
deb http://www.microcomaustralia.com.au/debian/ stable selinux main

However I have not tried woody with a 2.6.x kernel.  I don't know why you 
would want to run Debian/stable with a 2.6.x kernel though, as 2.6.x kernels 
are not stable in my experience!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
