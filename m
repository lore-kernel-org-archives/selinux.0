Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA25156
	for <selinux@tycho.nsa.gov>; Tue, 24 Dec 2002 19:52:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA08859
	for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2002 00:49:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA08855
	for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2002 00:49:28 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: avc: denied
Date: Wed, 25 Dec 2002 01:51:44 +0100
References: <20021225004755.2D3BABF3E@sat.sws.net.au>
In-Reply-To: <20021225004755.2D3BABF3E@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200212250151.44553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Dec 2002 01:47, Subba Rao wrote:
> I downloaded your policy.tgz and compared the "mrtg.fc" file with the your
> file. They are the same.

OK, it's your system that is weird then.

> In the listed example, you are seeing only mrtg, but there are lot more
> than the MRTG errors (or messages).

I have just noticed that the error message below concerns crond_t which means 
that the cron job is not running in the correct context.  I guess that you 
aren't using the modified crond.

You need modified utilities to rotate log files, run cron jobs, and login.  
Without the SE Linux modified utilities things won't work.

> ======= At 2002-12-22, 16:52:00 you wrote: =======
>
> >On Sun, 22 Dec 2002 15:58, Subba Rao wrote:
> >> ===================
> >> avc:  denied  { search } for  pid=848 exe=/usr/bin/perl
> >> path=/var/www/mrtg dev=03:01 ino=272926
> >> scontext=system_u:system_r:crond_t
> >> tcontext=system_u:object_r:httpd_sys_content_t tclass=dir
> >
> >Did you install my mrtg policy?
>
> = = = = = = = = = = = = = = = = = = = =

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
