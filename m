Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01257
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 11:48:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA19157
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 16:46:51 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
        by jazzband.ncsc.mil  with ESMTP id QAA19153 for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 16:46:51 GMT
Message-Id: <200211301646.QAA19153@jazzband.ncsc.mil>
Date: Sat, 30 Nov 2002 11:45:12 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Re: SELinux compile errors
Mime-Version: 1.0
Content-Type: multipart/mixed;
      boundary="=====000_Dragon378143725660_====="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--=====000_Dragon378143725660_=====
Content-Type: text/plain;
      charset="us-ascii"
Content-Transfer-Encoding: 7bit

Russ,

 --------------------------------------
/usr/include/bits/string2.h:446: warning: pointer of type `void *' used in arithmetic
/usr/include/bits/string2.h:448: warning: pointer of type `void *' used in arithmetic
/usr/include/bits/string2.h:453: warning: pointer of type `void *' used in arithmetic
gcc -g -O2 -Wall -Wpointer-arith -Wno-uninitialized -DWITH_SELINUX -I/usr/local/selinux/include -I. -I.  -I/usr/kerberos/include -DSSHDIR=\"/etc/ssh\" -D_PATH_SSH_PROGRAM=\"/usr/bin/ssh\" -D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/ssh-askpass\" -D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\" -D_PATH_SSH_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\" -D_PATH_SSH_PIDDIR=\"/var/run\" -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\" -DSSH_RAND_HELPER=\"/usr/libexec/openssh/ssh-rand-helper\" -DHAVE_CONFIG_H -c monitor_wrap.c
In file included from monitor_wrap.c:36:
auth.h:42: krb5.h: No such file or directory
make[1]: *** [monitor_wrap.o] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1'
make: *** [xopenssh] Error 2
 --------------------------------------

The above messages are the tail end of "make" in the "utils" directory.
I have added compressed error log during compilation for the utils directory.  It will list all the warning messages I was seeing yesterday.
If it is too much of a work around for now,  I  will switch to other distros.  I would like to know what is incomplete (as far as the libraries are concerned) in Slackware to support SELinux.

Thank you.

Subba Rao
sailorn@attglobal.net
2002-11-30

======= At 2002-11-30, 15:53:00 you wrote: =======

>On Fri, 29 Nov 2002 22:21, Subba Rao wrote:
>> This is where I have stopped since I get the following error message:
>>
>> --------------------------------------
>> make -C newrole
>> make[1]: Entering directory `/usr/src/selinux/utils/newrole'
>> cc -L/usr/local/selinux/lib -Wall -I/usr/local/selinux/include -DUSE_PAM
>> -O3 -o newrole newrole.c -ldl -lpam -lpam_misc -lsecure newrole.c:132:
>> security/pam_appl.h: No such file or directory
>> newrole.c:133: security/pam_misc.h: No such file or directory
>> make[1]: *** [newrole] Error 1
>> make[1]: Leaving directory `/usr/src/selinux/utils/newrole'
>> make: *** [xnewrole] Error 2
>> --------------------------------------
>>
>> It looks like it is looking for PAM library.
>>
>> Can someone please let me know how to get over this error.  Yesterday after
>> I installed PAM, this message went away, but then I was prompted for
>
>You need PAM support and therefore you need the PAM header files and libraries 
>installed.
>
>> Kerberos and later for BSD library.  Russell did mention that there is no
>> need for Kerberos, so this time I am stopping before having to install PAM.
>>  I am using Slackware 8.1 distro.
>
>Install PAM, then show us the error messages.
>
= = = = = = = = = = = = = = = = = = = =
			



--=====000_Dragon378143725660_=====
Content-Type: application/octet-stream;
      name="lsm-utils-err.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="lsm-utils-err.gz"

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
9FG7/d7A119KhMTIXXIphTc6/wd5rpuJAUoDAA==

--=====000_Dragon378143725660_=====--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
