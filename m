Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SDsgrT026016
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 09:54:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SDscdb014818
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 13:54:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Date: Sat, 28 Aug 2004 23:54:35 +1000
Cc: selinux@tycho.nsa.gov
References: <20040823214228.GA13677@lkcl.net> <200408252140.41362.russell@coker.com.au> <1093453663.5092.84.camel@nexus.verbum.private>
In-Reply-To: <1093453663.5092.84.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408282354.35395.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Aug 2004 03:07, Colin Walters <walters@verbum.org> wrote:
> I guess genhomedircon is a precendent here, but: I don't think this
> makes sense, because then the policy is dependent on the machine where
> you build the policy, which may be different from the machine to which
> the policy is ultimately installed.
>
> This kind of calculation should probably be done in the policy post-
> installation step.

We could do that.

Another possibility may be to have udev do this and create a /dev/cdroms 
directory or something similar.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
