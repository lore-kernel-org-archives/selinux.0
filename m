Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01036
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 11:42:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00900
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 16:41:22 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzband.ncsc.mil  with ESMTP id QAA00896
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2001 16:41:21 GMT
Date: Mon, 17 Dec 2001 16:48:27 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Message-ID: <20011217164827.GA2628@vnl.com>
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil> <20011130200644.BDF4535FC98@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011130200644.BDF4535FC98@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm sort of on hold until I figure out the best way
to work around this problem with libwrap not exising
in sid.

Rich: have you seen this? I'd rather match my solution
to yours rather than go reinventing wheels.

In case you didn't read the earlier posting, in the
selinux utils install ssh is looking for libwrap during
a .configure and dying. sid dist has libwrap0 which
I already have installed.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
