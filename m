Content-Type: text/plain;
  charset="iso-8859-1"
From: JW <jw@centraltexasit.com>(by way of JW <jw@centraltexasit.com>)
Reply-To: jw@centraltexasit.com
Subject: Oops, solved  Re: Make errors from newrole in utils
Date: Mon, 8 Jul 2002 01:36:23 -0500
To: "SELinux" <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200207080136.24240.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Sorry, these files are part of pam-devel, which I did not have installed.

JW >When I run make in utils I get errors in newrole.c about security/pam_appl.h security/pam_misc.h missing:
JW >
JW >make[1]: Entering directory `/usr/src/selinux/utils/newrole'
JW >cc -L/usr/local/selinux/lib -Wall -I/usr/local/selinux/include -DUSE_PAM -O3 -o newrole newrole.c -ldl -lpam -lpam_misc -lsecure
JW >newrole.c:132: security/pam_appl.h: No such file or directory
JW >newrole.c:133: security/pam_misc.h: No such file or directory

- - -- 

- - ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KTLoQ5u80xXOLBcRAjMsAKDfCsM3UkurWei9UWT0U+om2BEE1QCg1u4+
97QgDPBRnp9DyDp2smn97i0=
=Dgoy
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
