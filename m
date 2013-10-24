Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODSc4Z022114
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:28:38 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODSWLB011305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:28:33 -0400
Received: from redsox.boston.devel.redhat.com (unused-10-19-63-246.boston.devel.redhat.com [10.19.63.246] (may be forged))
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r9ODSTiJ021309
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:28:31 -0400
Message-ID: <5269207C.4090809@redhat.com>
Date: Thu, 24 Oct 2013 09:28:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Allow audit2allow to return constraint information from policy
Content-Type: multipart/mixed;
 boundary="------------070300050804020208030706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070300050804020208030706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

At the end of last year I was complaining about audit2allow and the SELinux
tools chain not being able to give better information about what constraint is
being violated, so a admin or policy writer could have a clue on how to fix
the problem.

A fairly common problem is domains trying to change the role or user component
of the label.  Or in the MCS and MLS world, what attribute do I need to add to
my policy to allow the AVC.

Richard Haines wrote some nice patches to add the constraint information to
the kernel and to change user space to reveal this information.

Sadly we thought these discussions had happened on the list, but I guess we
had taken it private.  Here is the userspace patch to reveal this information.

The kernel team will be posting the kernel patch hopefully soon.  We believe
that even though the kernel does not need the additional information about the
constraint, the limited space required to carry this information makes sense.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpIHwACgkQrlYvE4MpobM6vgCg3IoQr5tlM8NVgT/pId2QpKrz
E5gAoInxyCNAOQuXA1M6Z1YX36U9y31u
=3Ern
-----END PGP SIGNATURE-----

--------------070300050804020208030706
Content-Type: text/x-patch;
 name="0001-Richard-Haines-patch-that-allows-us-discover-constra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Richard-Haines-patch-that-allows-us-discover-constra.pa";
 filename*1="tch"


--------------070300050804020208030706--
