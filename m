Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m11F1nBS027993
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2008 10:01:49 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m11F1mjK027071
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2008 15:01:49 GMT
Message-ID: <47A33458.505@redhat.com>
Date: Fri, 01 Feb 2008 10:01:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: I have spit out my current diffs in policy on fedoraproject.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/Policy/

Patch is now up to 28000 lines.

I have it split into 147 patches.

Kernel patches should be fairly easy to merge,
System patches other than userdomain should not be difficult.

Then we get to service/apps ...


Going forward this is going to get more difficult.  I think we need more
people with the ability to update the reference policy.  Even if they
just cherry pick through the differences in my patches and upstream.  I
don't believe one person can keep up with the volume of changes.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkejNFcACgkQrlYvE4MpobMoQACfVxHA3wlf/bZA0hQSE6bLI8bm
yzEAoOZczbxPVGnI+uC6s5p2i6N5CpRs
=ylKl
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
