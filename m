Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3P40rRb015529
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 00:00:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3P3wdW3012219
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 03:58:40 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i3P3wcIx012175
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 03:58:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: mizu <michal@zimen.sk>
Subject: Re: sshd, devpts, unix_chkpwd
Date: Sun, 25 Apr 2004 13:59:10 +1000
Cc: selinux@tycho.nsa.gov
References: <20040418233735.GA22543@intrak.sk>
In-Reply-To: <20040418233735.GA22543@intrak.sk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404251359.10230.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Apr 2004 09:37, mizu <michal@zimen.sk> wrote:
>   I try to make debian to work with last SELinux packages (1.10)
>   with patch for 2.6.5 kernel.
>
>
>   I still have too much messages like this:
>
>   Apr 19 01:20:36 fuxo kernel: avc:  denied  { read write } for  pid=312
>   exe=/sbin/unix_chkpwd path=/dev/pts/0 dev= ino=2
>   scontext=root:staff_r:system_chkpwd_t
>   tcontext=system_u:object_r:sshd_devpts_t tclass=chr_file

That is a bug in the pam package for Debian.  Fixing it is on my to-do list, 
in the mean time putting in a dontaudit rule to stop that will be OK.

I don't know why your machine is hanging.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
