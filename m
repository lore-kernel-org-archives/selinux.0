Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I0jCRb028239
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 20:45:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4I0gmB2014368
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 00:42:48 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4I0glwi014301
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 00:42:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Date: Tue, 18 May 2004 10:43:43 +1000
Cc: selinux@tycho.nsa.gov
References: <20040515232606.GA9378@lkcl.net> <200405180510.40047.russell@coker.com.au> <20040517220232.GX9378@lkcl.net>
In-Reply-To: <20040517220232.GX9378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405181043.43572.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 08:02, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > Of course that doesn't require changing libselinux, we could just call
> > dlsym() for every function we want to use.
>
> ah, you then need to check every pointer to every function
> for not being NULL.

That's easy to do.  Most of the programs that might be re-written in that way 
don't use many of the libselinux functions anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
