Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BGK6rT025016
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 12:20:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BGK46V005224
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 16:20:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: at last: info regarding boot problems on multiple partitions
Date: Sun, 12 Sep 2004 02:20:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040908224949.GK7717@lkcl.net> <20040909183823.GJ10046@lkcl.net> <20040909234320.GA7328@lkcl.net>
In-Reply-To: <20040909234320.GA7328@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409120220.02379.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Sep 2004 09:43, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> consequently, the test fails, and only if the test _succeeds_ does
> mountvirtfs.sh delete /etc/mtab. (with :> $MTAB_PATH)
>
> so, as a temporary hack, i removed the "if dir_writable ${MTAB_PATH%/*}"
> check.
>
> result?
>
>  /etc/mtab gets deleted.
>
> bugreporting time.

Good work!  Let me know if you need help convincing the package maintainer.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
