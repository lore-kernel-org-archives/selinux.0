Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: Make errors from newrole in utils
Date: Mon, 8 Jul 2002 01:16:57 -0500
MIME-Version: 1.0
Message-Id: <200207080116.57947.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


When I run make in utils I get errors in newrole.c about security/pam_appl.h security/pam_misc.h missing:

ccs001:/usr/src/selinux/utils # whoami
root
ccs001:/usr/src/selinux/utils # pwd
/usr/src/selinux/utils
ccs001:/usr/src/selinux/utils # make
make -C newrole
make[1]: Entering directory `/usr/src/selinux/utils/newrole'
cc -L/usr/local/selinux/lib -Wall -I/usr/local/selinux/include -DUSE_PAM -O3 -o newrole newrole.c -ldl -lpam -lpam_misc -lsecure
newrole.c:132: security/pam_appl.h: No such file or directory
newrole.c:133: security/pam_misc.h: No such file or directory
make[1]: *** [newrole] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/newrole'
make: *** [xnewrole] Error 2`
ccs001:/usr/src/selinux/utils # ls
.          fileutils-4.1      newrole        run_init         tar-1.13.19
..         findutils-4.1.7    openssh-3.4p1  sh-utils-2.0.11  util-linux-2.11f
Makefile   logrotate-3.5.4-1  procps-2.0.7   spasswd          vixie-cron-3.0.1
appconfig  logrotate-3.5.9    psmisc-20.1    stat-2.5
ccs001:/usr/src/selinux/utils # ls ..
.   ChangeLog  Makefile  README.MLS  doc        module  scripts  setfiles
..  INDEX      README    devfsd      libsecure  policy  selopt   utils
ccs001:/usr/src/selinux/utils # uname -a
Linux ccs001 2.4.18-64GB-SMP #1 SMP Wed Mar 27 13:58:12 UTC 2002 i686 unknown
ccs001:/usr/src/selinux/utils #

What is missing? THis is the current download from the SE Linux website as of this evening (Sunday)

Thanks
- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KS5ZQ5u80xXOLBcRAqNUAJ998z2hdC7eBbTYwOjZ+NFCMTqBAQCfaAGM
wHKIS3XIq5DeCYq/ZsXpCrM=
=pLNH
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
