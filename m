Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47HqEI4011358
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 13:52:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h47HpxVf022113
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 17:51:59 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h47Hpr4D022105
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 17:51:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Christopher J. PeBenito" <pebenito@ieee.org>, selinux@tycho.nsa.gov
Subject: Re: /dev/pts/* denials w/devfs
Date: Thu, 8 May 2003 03:51:01 +1000
References: <1052326645.13937.23.camel@chris.pebenito.net>
In-Reply-To: <1052326645.13937.23.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305080351.01132.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 May 2003 02:57, Christopher J. PeBenito wrote:
> problems.  The problem surrounds /dev/pts/* denials.  Gentoo uses devfs,
> so I have a feeling that it might be causing some problems.  For
> example, the following are the denials I get when logging in via ssh.
> The ssh.te is still the stock from selinux-small, and openssh is
> patched.  I also have the devfsd-se.so devfsd module running.
> Suggestions?
>
> avc:  denied  { getattr } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
> dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:devpts_t tclass=chr_file

REGISTER ^pts/.*        IGNORE

Try putting the above line near the start of the devfsd.conf file.

I suspect that your problem is that devfsd is accessing the /dev/pts/* file 
first and then the type_transition rule doesn't apply.

The problem with this solution is that you then can't have the /dev/pts/* 
nodes default to being writable by group "tty" as one of the Unix specs 
requires.  But then SE Linux can enable other solutions to this (EG a SETUID 
version of wall isn't a big deal).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
