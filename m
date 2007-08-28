Message-ID: <46D44D99.9020405@redhat.com>
Date: Tue, 28 Aug 2007 12:30:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
        Joshua Brindle <method@manicmethod.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Looks like we have a 64 bit problem on Rawhide.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

libsepol.module_package_read_offsets: offsets are not increasing (at 2,
offset 61226322186831055 -> 0

rpm -q libsepol
libsepol-2.0.7-1.fc8

Can't update policy on x86_64 machines.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG1E2ZrlYvE4MpobMRAmIQAJ0dMEFV0P/nx90C9BJu2bo0EcNqcACgvz8S
dTmjmsch2NXl5I8MnEoxlJI=
=vrTF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
