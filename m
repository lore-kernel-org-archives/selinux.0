Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I3dEHa009961
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 23:39:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7I3dDj6001515
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:39:13 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7I3dBNN001497 for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:39:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Timmy Jones" <zapperlink@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: 2.6 error
Date: Mon, 18 Aug 2003 13:39:01 +1000
References: <BAY8-F54UJvBfqI1kJG0000bb40@hotmail.com>
In-Reply-To: <BAY8-F54UJvBfqI1kJG0000bb40@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308181339.01278.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Aug 2003 12:43, Timmy Jones wrote:
> Im having issues fixing this error. Wondering if any of you might know of a
> solution.

Does the same problem occur when compiling without SE Linux support?

There are many problems with drivers not compiling in 2.6.0 as interfaces 
inside the kernel have changed and not all drivers have been updated.  The 
best thing to do is to read the linux-kernel mailing list archives and the 
web site http://www.kernelnewbies.org/ will probably be helpful too.

If you just want to get SE Linux going then it's probably best to just turn 
off the paride support and any other drivers that don't compile.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
