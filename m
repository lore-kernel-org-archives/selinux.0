Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16CasRb022193
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 07:36:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16CZWQk019035
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 12:35:33 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i16CZGYo018930
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 12:35:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ignacio Tripodi <ignaciot@unt.edu>, selinux@tycho.nsa.gov
Subject: Re: Issues relabeling filesystems
Date: Fri, 6 Feb 2004 23:35:12 +1100
References: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
In-Reply-To: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402062335.12533.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Feb 2004 16:46, Ignacio Tripodi <ignaciot@unt.edu> wrote:
> /usr/sbin/setfiles: relocation error: /usr/sbin/setfiles: symbol
> nftw64, version GLIBC_2.3.3 not defined in file libc.so.6 with link
> time reference

I recall that there were some errors similar to that with some of Dan's 
earlier packages.  The problem in question was solved quite a while ago.

How recent were the rpms you used to create the file system image?  If they 
were not recent then I recommend updating to the latest stuff and the problem 
should disappear.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
