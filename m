Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i996MErT027324
	for <selinux@tycho.nsa.gov>; Sat, 9 Oct 2004 02:22:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i996L2xf006089
	for <selinux@tycho.nsa.gov>; Sat, 9 Oct 2004 06:21:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: More SELinux fixes.
Date: Sat, 9 Oct 2004 16:22:08 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <4165B9AA.8090803@redhat.com> <1097258770.13326.14.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1097258770.13326.14.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410091622.08531.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 9 Oct 2004 04:06, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> Merged, with the exception of the sendmail part.
>
> The sendmail.te part is a revision of Russell's patch from Oct 1st, is
> this intentional?  Should these rules be added back?

If sendmail is started with file handle 0 being /dev/console then it wants to 
access /var/run/utmp.  If file handle 0 refers to /dev/null then it doesn't.

I'm currently looking into this, I suspect that a minor change to sendmail or 
it's startup scripts might be the most appropriate thing.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
