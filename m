Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m09G1qF5021082
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 11:01:52 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m09G1qxW009750
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 16:01:52 GMT
Message-ID: <4784EFE8.9050106@redhat.com>
Date: Wed, 09 Jan 2008 11:01:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Sudo Changes for SELinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a working demonstration of  My version of RBAC in Rawhide/FC8.
In my view of the world, users have two roles.  User Role and Admin Role.

So I might login as a staff_t user and be able to transition to
webadm_r:webadm_r.

In Rawhide right now staff_t can only run sudo to become root.
Staff_t is not allowed to execute su.  staff_t users should not know the
root password. I have hacked up a script /usr/bin/webadm which executes
newrole -r webadm_r -t webadm_t and newrole's pam has pam_rootok.

Now I edit the /etc/sudoers and allow

dwalsh ALL=(ALL) /usr/bin/webadm

This allows me to use sudo to become webadm_t as root.  (Policy
obviously has to be correct.  But this is very cumbersome for the
administrator and does not scale.

I think we need to add SELinux support to sudo, so the administrator
could easily add something to /etc/sodoers like

dwalsh ALL=(ALL) ROLE=webadm_r TYPE=webadm_t /bin/sh

then sudo would execute the code that newrole does to very the
transition and

setexeccon(dwalsh:webadm_t:webadm_t)
exec(/bin/sh)

I was told that you are the upstream maintainer of sudo, so I wanted
your input/help on making sudo selinux aware.

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeE7+cACgkQrlYvE4MpobMFuACghnhJJpGMkCN5nZE5vlb/O+2H
auIAoOXNJ0rWvALJAt8Y8kLPBwkVQD8f
=OnRG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
