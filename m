Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01303
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 11:58:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA25701
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 16:56:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA25697
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 16:56:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Re: SELinux compile errors
Date: Sat, 30 Nov 2002 17:58:36 +0100
References: <20021130164856.6E368BF78@sat.sws.net.au>
In-Reply-To: <20021130164856.6E368BF78@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200211301758.36486.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 30 Nov 2002 17:45, Subba Rao wrote:
> /usr/include/bits/string2.h:446: warning: pointer of type `void *' used in
> arithmetic /usr/include/bits/string2.h:448: warning: pointer of type `void
> *' used in arithmetic /usr/include/bits/string2.h:453: warning: pointer of
> type `void *' used in arithmetic

That looks like a bug in the string2.h file, but it might be a bug in 
something else that it depends on.

Does Slackware have a bug tracking system?  If so file a bug report about 
this.

> gcc -g -O2 -Wall -Wpointer-arith
> -Wno-uninitialized -DWITH_SELINUX -I/usr/local/selinux/include -I. -I. 
> -I/usr/kerberos/include -DSSHDIR=\"/etc/ssh\"
> -D_PATH_SSH_PROGRAM=\"/usr/bin/ssh\"
> -D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/ssh-askpass\"
> -D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\"
> -D_PATH_SSH_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\"
> -D_PATH_SSH_PIDDIR=\"/var/run\" -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\"
> -DSSH_RAND_HELPER=\"/usr/libexec/openssh/ssh-rand-helper\" -DHAVE_CONFIG_H
> -c monitor_wrap.c In file included from monitor_wrap.c:36:
> auth.h:42: krb5.h: No such file or directory
> make[1]: *** [monitor_wrap.o] Error 1
> make[1]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1'
> make: *** [xopenssh] Error 2
>  --------------------------------------

Have you tried adding --without-kerberos5 to the ./configure for ssh?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
