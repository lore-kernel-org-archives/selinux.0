Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4CHvZI4003872
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 13:57:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4CHvGjN023911
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 17:57:18 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4CHuvTU023889
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 17:57:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Chris Babcock" <cbabcock@luthresearch.com>,
   "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: kernel patches
Date: Tue, 13 May 2003 03:55:33 +1000
References: <54829.63.108.92.34.1052760393.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <54829.63.108.92.34.1052760393.squirrel@mxlx1.surveysavvy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305130355.33147.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 May 2003 03:26, Chris Babcock wrote:
> Since the selinux project doesn't apply any patches to the distributed
> kernel, what kernel patches have those who have been having good success
> with selinux been using?

I have (with some work) got SE Linux running on ARM machines and UML.

Patches that have worked without effort include the speedtouch ADSL driver, 
ipvs, Cobalt Qube and RaQ patch, crypto-loopback device, and SKAS for UML.

Generally small patches just work, but big patches often don't apply cleanly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
