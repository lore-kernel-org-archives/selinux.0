Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: SELinux <SELinux@tycho.nsa.gov>
Subject: krb.h vs krb5.h
Date: Mon, 8 Jul 2002 18:02:05 -0500
MIME-Version: 1.0
Message-Id: <200207081802.05378.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Presumably] due to some differnces in packaging between  RedHat and SuSE, I do not have a krb.h
I made a symlink by that name to krb5.h and make seemed to like that, but I'm wondering if that's ok?
Because krb5.h is called explicitly in some cases, and krb.h in this other place:

gcc -g -O2 -Wall -Wpointer-arith -Wno-uninitialized -DWITH_SELINUX -I/usr/local/selinux/include -I. -I.  -I/usr/kerberos/include -DSSHDIR=\"/etc/ssh\" -D_PATH_SSH_PROGRAM=\"/usr/bin/ssh\" -D_PATH_SSH_ASKPASS_DEFAULT=\"/usr/libexec/openssh/ssh-askpass\" -D_PATH_SFTP_SERVER=\"/usr/libexec/openssh/sftp-server\" -D_PATH_SSH_KEY_SIGN=\"/usr/libexec/openssh/ssh-keysign\" -D_PATH_SSH_PIDDIR=\"/var/run\" -D_PATH_PRIVSEP_CHROOT_DIR=\"/var/empty\" -DSSH_RAND_HELPER=\"/usr/libexec/openssh/ssh-rand-helper\" -DHAVE_CONFIG_H -c servconf.c
servconf.c:20: krb.h: No such file or directory


- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KhntQ5u80xXOLBcRArGmAJ4iLg0thBLkEkYvRWrUaT8FXMdIIwCgtONd
YqgjzDPaUNR9OfDyfvkuB4M=
=xD89
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
