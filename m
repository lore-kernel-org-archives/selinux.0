Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21108
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 10:44:16 -0400 (EDT)
From: azeredo@qmc.ufsc.br
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19100
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 14:42:31 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
        by jazzband.ncsc.mil  with ESMTP id OAA19094 for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 14:42:29 GMT
Message-ID: <1031756508.3d7f5adca337f@qmc.ufsc.br>
Date: Wed, 11 Sep 2002 12:01:48 -0300
To: russel@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: Problems compiling selinux on SuSe 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



 Hi:

 I am trying to compile selinux on SuSe 7.2. I got the last package version of 
lsm-2.4-selinux-2002082308.tgz with kernel 2.4.19 and got the following error:
I have tried with kerberos 5 from mandrake distribution and also with heimdal 
that comes with suse. But the error is the same, namely

make[3]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1/openbsd-compat'
gcc -g -O2 -Wall -Wpointer-arith -Wno-uninitialized -DWITH_SELINUX -I/usr/local/
            selinux/include -I. -I.  -I/usr/kerberos/include
-DSSHDIR=\"/etc/ssh\" -D_PATH_S             SH_PROGRAM=\"/usr/bin/ssh\"
-D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/s             sh-askpass\"
-D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\" -D_PATH_SS            
H_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\" -D_PATH_SSH_PIDDIR=\"/var/run\"
             -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\"
-DSSH_RAND_HELPER=\"/usr/libexec/opens             sh/ssh-rand-helper\"
-DHAVE_CONFIG_H -c monitor_wrap.c
In file included from auth.h:42,
                 from monitor_wrap.c:36:
/usr/include/krb5.h:1930: parse error before `profile_t'
make[2]: *** [monitor_wrap.o] Error 1
make[2]: Leaving directory `/usr/src/selinux/utils/openssh-3.4p1'
make[1]: *** [xopenssh] Error 2
make[1]: Leaving directory `/usr/src/selinux/utils'
make: *** [quickinstall] Error 2

Any suggestion about getting rid of this error?

                                   Thanks

                           azeredo@qmc.ufsc.br


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
