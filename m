Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0ANKXRb006602
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 18:20:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0ANKWiV018177
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 23:20:32 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i0ANKL06018153 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 23:20:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Park Lee <parklee_2004@yahoo.com.cn>, selinux@tycho.nsa.gov
Subject: Re: Questions about install SELinux in Fedora Core
Date: Sun, 11 Jan 2004 10:18:56 +1100
References: <20040110191734.66152.qmail@web15204.mail.bjs.yahoo.com>
In-Reply-To: <20040110191734.66152.qmail@web15204.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200401111018.56582.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Jan 2004 06:17, Park Lee <parklee_2004@yahoo.com.cn> wrote:
> Core is 2.4.22-1.2115.nptl . Then I downloaded the 2.6.0-test11 kernel with

Better to get 2.6.1.

> numbers required. I found that the minimum version numbers required in the
> Changes file cann't be meet by the above Fedora Core in the following 3
> software. They are(in the style of the Changes file):
>
>  name          version      command
>  o  xfsprogs      2.1.0    # xfs_db -V
>  o  quota-tools   3.09     # quota -V
>  o  procps        3.1.13   # ps --version

quota-tools doesn't matter unless you are using quotas, are you using quotas?

For xfsprogs, last I heard XFS support for SE Linux wasn't quite ready.  So 
unless something has changed you have to use Ext3, and therefore the version 
of xfsprogs does not matter.

Red Hat uses a different procps to everyone else.  Don't worry about it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
