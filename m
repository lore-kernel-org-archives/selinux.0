Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h454l4I4025211
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 00:47:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h454kpVf025768
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 04:46:51 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h454kj4D025762
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 04:46:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: strange avc messages on oom
Date: Mon, 5 May 2003 14:45:40 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200305042131.30060.russell@coker.com.au> <20030504233121.GA31478@snoopy.apana.org.au>
In-Reply-To: <20030504233121.GA31478@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305051445.40070.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 May 2003 09:31, Brian May wrote:
> Do you have nscd loaded?

Yes, but it is not doing anything out of the ordinary.

> Just a guess: maybe the kernel is trying to swap code to/from the swap
> paritions, but for some reason in out-of-memory conditions cannot get
> the correct context, so just uses the existing context instead?

Maybe, if so it's a bug.

> When the kernel reads/writes the swap parition, are these accesses
> checked by SE-Linux first?

I don't know.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
