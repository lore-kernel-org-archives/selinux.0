Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14271
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 09:06:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA08750
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:03:44 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
	by jazzswing.ncsc.mil  with ESMTP id OAA08746
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:03:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Subba Rao" <sailorn@attglobal.net>, Russell Coker <russell@coker.com.au>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux compile errors
Date: Mon, 2 Dec 2002 08:04:16 -0600
References: <200211301704.RAA19613@jazzband.ncsc.mil>
In-Reply-To: <200211301704.RAA19613@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212020804.16595.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 30 November 2002 11:03 am, Subba Rao wrote:
> I will first try the SSH without the kerberos option.  If it works then I
> will  file a bug report for Slackware.

It's not exactly a Slackware problem. They accept the configuration as defined 
by  the person making the submission.

Since you are doing a raw rebuild, you have to specify the "without-kerberos5"
and possibly "without-kerberos4" as well.

This is a leftover ? from adding kerberos support to OpenSSH by the OpenSSH
project. This was added only within the last 2/3 months, and the people using
it/developing it MUST have Kerberos included (Major Shared Resource Center
as part of the DoD HPC modernization program - me incuded as a user). I don't
know why it is on by default since it is useless without the path to the
Kerberos libraries. It may actually be a bug in the "configure" phase and not
a bug in the code.

> ======= At 2002-11-30, 17:58:00 you wrote: =======
>
> >On Sat, 30 Nov 2002 17:45, Subba Rao wrote:
> >> /usr/include/bits/string2.h:446: warning: pointer of type `void *' used
> >> in arithmetic /usr/include/bits/string2.h:448: warning: pointer of type
> >> `void *' used in arithmetic /usr/include/bits/string2.h:453: warning:
> >> pointer of type `void *' used in arithmetic
> >
> >That looks like a bug in the string2.h file, but it might be a bug in
> >something else that it depends on.
> >
> >Does Slackware have a bug tracking system?  If so file a bug report about
> >this.
> >
> >> gcc -g -O2 -Wall -Wpointer-arith
> >> -Wno-uninitialized -DWITH_SELINUX -I/usr/local/selinux/include -I. -I.
> >> -I/usr/kerberos/include -DSSHDIR=\"/etc/ssh\"
> >> -D_PATH_SSH_PROGRAM=\"/usr/bin/ssh\"
> >> -D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/ssh-askpass\"
> >> -D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\"
> >> -D_PATH_SSH_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\"
> >> -D_PATH_SSH_PIDDIR=\"/var/run\"
> >> -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\"
> >> -DSSH_RAND_HELPER=\"/usr/libexec/openssh/ssh-rand-helper\"
> >> -DHAVE_CONFIG_H -c monitor_wrap.c In file included from
> >> monitor_wrap.c:36:
> >> auth.h:42: krb5.h: No such file or directory
> >> make[1]: *** [monitor_wrap.o] Error 1
> >> make[1]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1'
> >> make: *** [xopenssh] Error 2
> >>  --------------------------------------
> >
> >Have you tried adding --without-kerberos5 to the ./configure for ssh?
>
> = = = = = = = = = = = = = = = = = = = =

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
