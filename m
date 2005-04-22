Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MNPagA019980
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 19:25:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MNHXrf003588
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 23:17:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: ssh problems when no pty allocated
Date: Sat, 23 Apr 2005 08:29:15 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20050216210227.GD5431@jmh.mhn.de>
In-Reply-To: <20050216210227.GD5431@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504230829.18031.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 February 2005 08:02, Thomas Bleher 
<bleher@informatik.uni-muenchen.de> wrote:
> I am having some problems with ssh:
> ssh works fine as long as I just call a shell. However, when ssh is
> called like "ssh host command" it doesn't allocate a pty. See the
> comment in domains/program/ssh.te:

I think it would be good to have a sshd configuration option for this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
