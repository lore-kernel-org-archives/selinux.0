Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05475
	for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 07:06:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18470
	for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 12:04:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA18465 for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 12:04:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: executing a sock_file
Date: Sun, 1 Dec 2002 13:06:14 +0100
References: <200211292010.PAA23902@moss-shockers.ncsc.mil>
In-Reply-To: <200211292010.PAA23902@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212011306.14961.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Nov 2002 21:10, Stephen D. Smalley wrote:
> > Nov 28 15:50:18 lyta kernel: avc:  denied  { execute } for  pid=4084
> > exe=/usr/lib/openoffice/program/soffice.bin
> > path=/tmp/OSL_PIPE_1001_SingleOfficeIPC_-383479802 dev=03:02 ino=900
> > scontext=rjc:user_r:user_t tcontext=rjc:object_r:user_tmp_t
> > tclass=sock_file
> >
> > What does it mean by executing a sock_file?
> >
> > Star Office seems to run OK anyway...
>
> Can you reproduce this denial reliably?  For normal file execution, the
> base kernel should deny attempts to execute any non-regular file before
> LSM/SELinux is ever invoked.  Possibly a check on a mmap, but that doesn't
> make a lot of sense to me either for a sock file.

I've tried a few times to do this, under both 2.4.19 and 2.4.20, but I can't 
get it to happen again.

For the moment I've given up, if I see such a thing in future I'll have to 
make careful notes about the state of my machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
