Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01369
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 12:06:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA19617
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 17:04:52 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
        by jazzband.ncsc.mil  with ESMTP id RAA19613 for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 17:04:51 GMT
Message-Id: <200211301704.RAA19613@jazzband.ncsc.mil>
Date: Sat, 30 Nov 2002 12:3:14 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux compile errors
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I will first try the SSH without the kerberos option.  If it works then I will  file a bug report for Slackware.

Thank you.

Subba Rao
sailorn@attglobal.net
2002-11-30


======= At 2002-11-30, 17:58:00 you wrote: =======

>On Sat, 30 Nov 2002 17:45, Subba Rao wrote:
>> /usr/include/bits/string2.h:446: warning: pointer of type `void *' used in
>> arithmetic /usr/include/bits/string2.h:448: warning: pointer of type `void
>> *' used in arithmetic /usr/include/bits/string2.h:453: warning: pointer of
>> type `void *' used in arithmetic
>
>That looks like a bug in the string2.h file, but it might be a bug in 
>something else that it depends on.
>
>Does Slackware have a bug tracking system?  If so file a bug report about 
>this.
>
>> gcc -g -O2 -Wall -Wpointer-arith
>> -Wno-uninitialized -DWITH_SELINUX -I/usr/local/selinux/include -I. -I. 
>> -I/usr/kerberos/include -DSSHDIR=\"/etc/ssh\"
>> -D_PATH_SSH_PROGRAM=\"/usr/bin/ssh\"
>> -D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/ssh-askpass\"
>> -D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\"
>> -D_PATH_SSH_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\"
>> -D_PATH_SSH_PIDDIR=\"/var/run\" -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\"
>> -DSSH_RAND_HELPER=\"/usr/libexec/openssh/ssh-rand-helper\" -DHAVE_CONFIG_H
>> -c monitor_wrap.c In file included from monitor_wrap.c:36:
>> auth.h:42: krb5.h: No such file or directory
>> make[1]: *** [monitor_wrap.o] Error 1
>> make[1]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1'
>> make: *** [xopenssh] Error 2
>>  --------------------------------------
>
>Have you tried adding --without-kerberos5 to the ./configure for ssh?
>
= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
