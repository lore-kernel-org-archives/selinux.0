Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KDZIsJ002941
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 09:35:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8KDZI2R017340
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:35:18 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8KDZH1A017337 for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:35:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Boot time avc messages
Date: Sat, 20 Sep 2003 23:35:09 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <200309201632.59282.russell@coker.com.au> <20030920131340.GH12158@vnl.com>
In-Reply-To: <20030920131340.GH12158@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309202335.09944.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Sep 2003 23:13, Dale Amon wrote:
> To tell the truth, now that I've gotten back up the learning
> curve again, I've half a mind to just swap your policy tree for
> Colin's, sans package.

> Can you see any potential gotcha's in swapping your
> policy/current and policy/default for his on 2.6.0 test5
> kernel with sid packages?

It should work.  I already have a couple of 2.6 machines running with my 
policy tree.  If it doesn't work then let me know and I'll fix my policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
