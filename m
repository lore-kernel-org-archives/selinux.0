Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA2EAhWt026415
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 09:10:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA2EAgKl005907
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 14:10:42 GMT
Received: from seacomsystems.com (rrcs-nys-24-97-227-52.biz.rr.com [24.97.227.52])
        by jazzband.ncsc.mil  with ESMTP id hA2EAZ5m005904 for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 14:10:41 GMT
Received: from lyta.coker.com.au ([12.46.108.98])
	by seacomsystems.com (seacomsystems.com [24.97.227.53])
	(MDaemon.PRO.v6.8.5.R)
	with ESMTP id 30-md50000000001.tmp
	for <selinux@tycho.nsa.gov>; Sun, 02 Nov 2003 09:05:50 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils
Date: Sun, 2 Nov 2003 13:04:31 +1100
References: <20031031145133.GA16818@vnl.com> <20031101180452.GC4790@vnl.com>
In-Reply-To: <20031101180452.GC4790@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311021304.31932.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2 Nov 2003 05:04, Dale Amon wrote:
> > E: Package policycoreutils has no installation candidate
> >
> > Any idea what's up?
>
> I don't know is Russ got the above question, and in any case he might
> just be too busy to think about it. Does anyone else have a suggestion?

Sorry for the delay.  You have to add the following to your sources.list, it's 
one package that hasn't yet been put into my repository or Debian, so Colin's 
repository is the only place for it.

deb http://web.verbum.org/debian/ ./experimental/


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
