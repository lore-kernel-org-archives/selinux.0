Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02838
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 15:30:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA13314
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 20:30:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id UAA13299
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 20:30:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Mon, 17 Dec 2001 21:30:47 +0100
Cc: selinux@tycho.nsa.gov
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil> <20011130200644.BDF4535FC98@lyta.coker.com.au> <20011217164827.GA2628@vnl.com>
In-Reply-To: <20011217164827.GA2628@vnl.com>
MIME-Version: 1.0
Message-Id: <20011217203048.0C1CA9E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Dec 2001 17:48, Dale Amon wrote:
> I'm sort of on hold until I figure out the best way
> to work around this problem with libwrap not exising
> in sid.

It does exist though.

> In case you didn't read the earlier posting, in the
> selinux utils install ssh is looking for libwrap during
> a .configure and dying. sid dist has libwrap0 which
> I already have installed.

What about libwrap0-dev?  libwrap0-dev is what you need to compile programs 
that use TCP wrappers.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
