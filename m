Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6CLC7ZY015767
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 17:12:07 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6CLC6uD011849
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 21:12:06 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6CLC6Ad008104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 17:12:06 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p6CLC5PA013674
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 17:12:05 -0400
Message-ID: <4E1CB8A5.2010707@redhat.com>
Date: Tue, 12 Jul 2011 17:12:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: As we move to systemd, we are loosing some functionality from init
 scripts.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently we can setup certain domains to be allowed to execute labeled
init scripts.  If we go away from init scripts we will need a mechanism
for init to look at the calling program label to figure out if it is
allowed to start/stop certain domains.

Can webadm_t start/stop mysqld_t?  Can webadm_t start/stop httpd_t?

# id -Z
staff_u:webadm_r:webadm_t:s0-s0:c0.c1023
# systemctl start httpd.service
# systemctl stop httpd.service

Another option would be just whether label
/lib/systemd/system/mysqld.service something that webadm_t is not
allowed to read.

Ideas?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cuKUACgkQrlYvE4MpobMOygCg5fegKSSt82AuW6DtrS6GphDH
OPwAn0S6Y0+q4XFyqSBs2hIyrfgWlZ8o
=InWv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
