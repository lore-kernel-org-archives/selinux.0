Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0M6u44U002916
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 01:56:05 -0500
Received: from athena.localnet (unknown [10.10.10.1])
 by smtp.sws.net.au (Postfix) with ESMTP id B819420818
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 17:55:58 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: runcon and setsid()
Date: Wed, 22 Jan 2014 17:55:57 +1100
Message-ID: <3472773.GEUBITOd3I@russell.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Reply-To: russell@coker.com.au
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://lists.debian.org/debian-devel/2014/01/msg00164.html

Above is the URL for a post to debian-devel about su and exploits involving 
TIOCSTI ioctl.  They mention runcon, should we be calling setsid() in there?

I haven't inspected the runcon source recently, but a quick strace run on 
Debian/Unstable shows that setsid() isn't being called.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
