Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4M0ZIY2002981
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 20:35:18 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4M0ZF7l021689
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 00:35:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Subject: Re: Which filesystem is the best for SELinux
Date: Sun, 21 May 2006 23:30:20 +1000
Cc: selinux@tycho.nsa.gov
References: <446E02CE.7050007@gmail.com>
In-Reply-To: <446E02CE.7050007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605212330.23218.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 20 May 2006 03:39, Tetsuji Maverick Rai 
<tetsuji.maverick.rai@gmail.com> wrote:
> I'm now considering installing SELinux on my Gentoo (I have a little
> experience with old redhat 8 or 9 with ext3).  However, I'm wondering
> which filesystem to use.  I want journaling filesystem, and stability
> comes first, then speed.
>
> Now I'm considering jfs. Next xfs.  Any pros and cons?   There may be a
> controversy.

Why don't you like ext3?  It's working well for almost everyone who is using 
SE Linux.

JFS seems to have no future, there seems little controversy over recommending 
against JFS on this basis.

If you don't like ext3 then it seems that XFS is your only option for running 
SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
