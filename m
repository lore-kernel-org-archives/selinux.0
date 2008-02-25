Message-ID: <47C2CC18.6080801@redhat.com>
Date: Mon, 25 Feb 2008 09:09:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Permissive mode for xace is broken.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If I turn on xserver_object_manager in rawhide and log in as staff_t in
permissive mode, I get all sorts of things failing, which makes writing
policy for it very difficult.  And is very broken.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfCzBgACgkQrlYvE4MpobNniwCgnj1slFGDRupI/ljcDwC5b/Hc
lDIAnREcNwgXgfwBRwWtUY1VZt902IZ+
=WuKh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
