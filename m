Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71EiIrT007277
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:44:18 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71Ehi52022749
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 14:43:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: udev, tmp_t (on tmpfs on /dev), and matchpathcon failing
Date: Mon, 2 Aug 2004 00:44:08 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040801135209.GC15205@lkcl.net>
In-Reply-To: <20040801135209.GC15205@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408020044.08954.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 23:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> russell (someone?), the debian 1.14 (or greater) selinux-policy-default
> package could uhm, do with um, updating to match what the rpm spec
> does :)

No, it does not.

The needs of Debian are different from the needs of Red Hat.  I don't think 
that Debian has any need for the targeted policy, but if someone does wish to 
produce such a policy then they can make a selinux-policy-targeted package to 
provide it which would conflict with selinux-policy-default.  I planned it 
this way YEARS ago.

The design of Debian has some significant differences from the Red Hat design.  
One such difference is that packages which provide conflicting ways of 
performing the same task can not be installed at the same time in Debian.  In 
Debian it is impossible to install Sendmail and Postfix at the same time.  If 
there is a selinux-policy-targeted package for Debian then it will conflict 
with selinux-policy-default for the same reason.

The upgrade path from the older version of the SE Linux packages 
(before /etc/selinux/config) is extremely painful.  But once you get there it 
will all work fine.

If you start rm'ing trees of files that my packages install and then replacing 
them with trees taken from other places then you can expect difficulty.  In 
fact you will probably end up repeating some of the work I did in 2001 when I 
first started working on SE Linux.

Also when you have problems please report the first error that occurs.  Not 
the error that occurs after you have tried ten different methods of working 
around the first error.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
