Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GDpGrT012482
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 09:51:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GDo2i9012877
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 13:50:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy compile fixes
Date: Sat, 16 Oct 2004 23:51:11 +1000
Cc: James Carter <jwcart2@epoch.ncsc.mil>, SELinux ML <selinux@tycho.nsa.gov>
References: <20041014113536.GC2540@jmh.mhn.de> <1097785396.32077.92.camel@moss-lions.epoch.ncsc.mil> <20041014232413.GJ2540@jmh.mhn.de>
In-Reply-To: <20041014232413.GJ2540@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410162351.11178.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Oct 2004 09:24, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > Currently, the policy Makefile is not set up so that the fc files can
> > use an ifdef(`somefile.te',
> >
> > If there is interest in adding that support though, it can be done.
>
> It just seemed easiest this way.

I agree, it's something that should be done.

Putting tmp/program_used_flags.te as the first entry for the FCFILES 
declaration should be all that's needed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
