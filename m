Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1TKlpQb030497
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 15:47:51 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1TKlSeF027182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 15:47:29 -0500
Received: from dhcp-189-250.bos.redhat.com (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q1TKlSnU018485
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 15:47:28 -0500
Message-ID: <4F4E8EDF.1030405@redhat.com>
Date: Wed, 29 Feb 2012 15:47:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Suggestion on fixing a old libselinux problem.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One of the oldest bugs/wacki things about SELinux is what happens when
a login program can not calculate a login context.

Right now we have an open bug on confined users.  Basically if you
setup a confined user guest_u and attempt to login to that user via
xdm_t, you get a context of guest_u:guest_r:oddjob_mkhomedir_t:s0

selinuxdefcon pwalsh system_u:system_r:xdm_t:s0
guest_u:guest_r:oddjob_mkhomedir_t:s0

Yech.

This could be considered a security hole, but it is definitely broken.
 I have been looking at the libselinux code but this is actually
expected behavior, and I am not eager to fix it, since it might break
peoples expectations.

Eric suggested that we might want to move the problem out of
libselinux and make this a login program problem.  Make the login
programs pam_selinux a userspace manager.

After libselinux returns a context to pam_selinux it would check for
the following allow rule.

allow logindomain userdomain:login entrypoint;

Then pam_namespace would check if xdm_t is allowed a login entry point
into oddjob_mkhomedir_t, if no, blow up the login.

Comments?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAk9Ojt8ACgkQrlYvE4MpobO3qQCXUS4MjJWZf1BFDWN6U7SssAL6
3gCgtKYcOb9+9A/A+GW1cwiKaR58CZY=
=Cm5O
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
